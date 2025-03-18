import numpy as np
import cv2 as cv
import base64
import io
import plotly.express as px

def identify_target_color(color_list, target_hue):
    hue_diff = np.abs(color_list[:, 0] - target_hue)
    target_index = np.argmin(hue_diff)
    return color_list[target_index]

def BlueMask(image, hue_tolerance=75):
    hsv_image = cv.cvtColor(image, cv.COLOR_BGR2HSV)
    unique_colors = np.unique(hsv_image.reshape(-1, hsv_image.shape[2]), axis=0)
    target_color = identify_target_color(unique_colors, 100)
    hue = int(target_color[0])
    sat = int(target_color[1])
    lower_hue = max(0, hue - hue_tolerance)
    upper_hue = min(179, hue + int(hue_tolerance * 0.2))
    lower_target = np.array([lower_hue, abs(sat - 50), 0])
    upper_target = np.array([upper_hue, 230, 235])
    blue_mask = cv.inRange(hsv_image, lower_target, upper_target)
    return blue_mask

# --- Colony Counting Functions ---
def Confirmed_Blue_Colonies(image, hue_tolerance=75, contour_threshold=2):
    blue_mask = BlueMask(image, hue_tolerance=hue_tolerance)
    contours, _ = cv.findContours(blue_mask, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
    counter = 0
    areas = []
    marked_img = image.copy()
    for contour in contours:
        area = cv.contourArea(contour)
        perimeter = cv.arcLength(contour, True)
        circularity = 4 * np.pi * (area / (perimeter * perimeter)) if perimeter > 0 else 0
        if area > contour_threshold and circularity > 0.32:
            x, y, w, h = cv.boundingRect(contour)
            cv.rectangle(marked_img, (x-1, y-1), (x+w+1, y+h+1), (10, 0, 255), 1)
            counter += 1
            areas.append(area)
    return counter, areas, marked_img

def Other_Blob_Count(image, th_param, bounds, hue_tolerance=75):
    blue_mask = BlueMask(image, hue_tolerance=hue_tolerance)
    gray = cv.cvtColor(image, cv.COLOR_BGR2GRAY)
    clahe = cv.createCLAHE(clipLimit=3, tileGridSize=(3, 3))
    gray_cl = clahe.apply(gray)
    inverted_blue_mask = cv.bitwise_not(blue_mask)
    final_mask = cv.bitwise_and(gray_cl, gray_cl, mask=inverted_blue_mask)
    blur = cv.GaussianBlur(final_mask, (5, 5), 0)
    kernel_size = (5, 5)
    eroded = cv.erode(blur, np.ones(kernel_size, np.uint8))
    _ , _ = cv.threshold(eroded, th_param[0], th_param[1], cv.THRESH_BINARY_INV | cv.THRESH_OTSU)
    th2 = cv.adaptiveThreshold(blur, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C,
                               cv.THRESH_BINARY_INV, 15, 11)
    contours, _ = cv.findContours(th2, cv.RETR_LIST, cv.CHAIN_APPROX_SIMPLE)
    filtered_contours = []
    areas = []
    marked_img = image.copy()
    for cnt in contours:
        area = cv.contourArea(cnt)
        for bound in bounds:
            if area >= bound[0] and area <= bound[1]:
                perimeter = cv.arcLength(cnt, True)
                circularity = (4 * np.pi * area) / (perimeter * perimeter) if perimeter > 0 else 0
                if circularity >= 0.32:
                    filtered_contours.append(cnt)
                    # Draw yellow rectangle for bound [2, 20]
                    if bound[0] == 2 and bound[1] == 20:
                        x, y, w, h = cv.boundingRect(cnt)
                        cv.rectangle(marked_img, (x, y), (x + w, y + h), (0, 165, 255), 1)
                        areas.append(area)
    count = int(np.mean([len(filtered_contours)]))
    return count, areas, marked_img

# --- Image Processing ---
def process_image_from_image(img, selected_option, resize, target_height=800):
    if resize:
        width = int(img.shape[1] * (target_height / img.shape[0]))
        image = cv.resize(img, (width, target_height), interpolation=cv.INTER_AREA)
    else:
        image = img.copy()

    h, w, _ = image.shape
    crop_fraction = 0.8
    side_length = int(min(w, h) * crop_fraction)
    x = (w - side_length) // 2
    y = (h - side_length) // 2
    cropped = image[y:y + side_length, x:x + side_length]

    if selected_option == 'Confirmed_Blue_Colonies':
        count, areas, output_img = Confirmed_Blue_Colonies(cropped)
        return cropped, output_img, count, areas

    elif selected_option == 'Other_Blob_Count':
        count, areas, output_img = Other_Blob_Count(cropped, [175, 255], [[2, 20]])
        return cropped, output_img, count, areas

    else:  # BOTH
        count_CBC, areas_CBC, output_CBC = Confirmed_Blue_Colonies(cropped)
        count_OBC, areas_OBC, output_OBC = Other_Blob_Count(cropped, [175, 255], [[2, 20]])
        total_count = count_CBC + count_OBC
        total_areas = areas_CBC + areas_OBC
        return cropped, output_CBC, output_OBC, total_count, total_areas

def generate_histogram_image(areas):
    fig = px.histogram(areas)
    # Increase margins so text isn't cut off and the histogram is "zoomed out"
    fig.update_layout(
        width=300,
        height=300,
        plot_bgcolor='white',
        xaxis_title='Colony Size (in Pixels)',
        yaxis_title='Number of colonies',
        xaxis_range=[min(areas) - 1, max(areas) + 1],
        margin=dict(l=50, r=50, t=50, b=50),
        showlegend=False,
        title="Distribution of colonies"
    )
    fig.update_traces(marker_color='palevioletred', name='Colonies')
    img_bytes = io.BytesIO()
    fig.write_image(img_bytes, format='png')
    img_bytes.seek(0)
    encoded_img = base64.b64encode(img_bytes.read()).decode('utf-8')
    return encoded_img

def analyze_image_from_bytes(image_bytes, selected_option="Both", resize=False, target_height=800):
    nparr = np.frombuffer(image_bytes, np.uint8)
    img = cv.imdecode(nparr, cv.IMREAD_COLOR)

    if selected_option == "Both":
        cropped, output_cbc, output_obc, colony_count, areas = process_image_from_image(
            img, selected_option, resize, target_height
        )
    else:
        cropped, output_img, colony_count, areas = process_image_from_image(
            img, selected_option, resize, target_height
        )

    def encode_image(image):
        _, buffer = cv.imencode('.png', image)
        return base64.b64encode(buffer).decode('utf-8')

    if selected_option == "Both":
        cropped_encoded = encode_image(cropped)
        cbc_encoded = encode_image(output_cbc)
        obc_encoded = encode_image(output_obc)
        histogram_encoded = generate_histogram_image(areas)

        images_list = [cropped_encoded, cbc_encoded, histogram_encoded, obc_encoded]
    else:
        cropped_encoded = encode_image(cropped)
        output_encoded = encode_image(output_img)
        histogram_encoded = generate_histogram_image(areas)
        images_list = [cropped_encoded, output_encoded, histogram_encoded]

    return {
        "colony_count": colony_count,
        "risk_level": "SAFE" if colony_count == 0 else (
            "LOW RISK" if colony_count == 1 else (
                "MODERATE RISK" if 2 <= colony_count <= 9 else "HIGH RISK"
            )
        ),
        "areas": areas,
        "images": images_list
    }

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("Usage: python water_analysis.py <image_path>")
        sys.exit(1)
    image_path = sys.argv[1]
    img = cv.imread(image_path, cv.IMREAD_COLOR)
    cropped, output_img, colony_count, areas = process_image_from_image(img, "Both", resize=False, target_height=800)
    print("Colony count:", colony_count)
    cv.imwrite("output.png", output_img)
