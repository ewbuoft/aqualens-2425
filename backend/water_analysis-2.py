# Import Libraries

#!pip install tqdm
from tqdm import tqdm
import time
import cv2
import numpy as np
# from google.colab.patches import cv2_imshow
import matplotlib.pyplot as plt


# Prompt the user for data
# The filename is as such [SOURCE: Tlaloque (TLQ), Tank (TNK), Tap (TAP), Filter (FTR)]_[CLIENT ID]_[DATE],
# i.e., TLQ_0001_180823 means: Client ID: 0001, Water Source: Tlaloque, and Filename: TLQ_0001_180823.jpg
client_ID = "01"
water_source = "Tlaloque"
# filename = input("Please enter file name (with .jpg): ")
# filename = "TAP_0001_180823.jpg"
# filename = "TLQ_0001_180823.jpg"
filename = "TNK_0001_180823.jpg"

# Load the image
original_image = cv2.imread(filename)
# Optional (Required in this case)
crop_h = 330
crop_w = 50
image = original_image[crop_h:, crop_w:-crop_w]
#image = original_image.copy()
# Convert the image to the HSV color space (Hue, Saturation, Value)
hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
# Display Pairwise
plt.figure(figsize=(12,6))
plt.subplot(1,2,1), plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB)), plt.title('Original'), plt.axis('off')
plt.subplot(1,2,2), plt.imshow(cv2.cvtColor(hsv_image, cv2.COLOR_BGR2RGB)), plt.title('HSV'), plt.axis('off')
plt.show()

# Identifying Bacterial Colony Color

def identify_target_color(color_list, target_hue):
    # Calculate the difference in hue for each color in the list
    hue_diff = np.abs(color_list[:, 0] - target_hue)
    # Find the index of the color with the smallest hue difference
    target_index = np.argmin(hue_diff)

    return color_list[target_index]

# Get all colors in the hsv image
unique_colors = np.unique(hsv_image.reshape(-1, hsv_image.shape[2]), axis=0)

# Automatically choose the target color from the list
target_color = identify_target_color(unique_colors, 100)

# Define the upper and lower bounds for the chosen blue color
hue_tolerance = 65  # Tolerance for hue variation
lower_target = np.array([target_color[0] - hue_tolerance, np.absolute(target_color[1] - 50), 0])
upper_target = np.array([target_color[0] + int(hue_tolerance*0.2), 230, 235])
print(lower_target)
print(upper_target)

# Define the lower and upper HSV threshold values for blue color
# Adjust these values based on your specific shade of blue
# lower_blue = np.array([34, 20, 25])
# upper_blue = np.array([130, 215, 235])

# lower_blue = np.array([30, 25, 40])
# upper_blue = np.array([150, 235, 235])

# Create a mask to extract blue regions since we know that the bacterial colonies will be blue
blue_mask = cv2.inRange(hsv_image, lower_target, upper_target)

# Find contours in the mask
contours, _ = cv2.findContours(blue_mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
counter = 0
marked_img = image.copy()
# Iterate through the detected contours
for contour in tqdm(contours, desc = 'Processing ...'):
  # Calculate the area of each contour
  area = cv2.contourArea(contour)
  # Set a minimum threshold for contour area to filter out noise
  if area > 5:  # Adjust this threshold as needed
    # Draw a bounding box around the detected blue region
    x, y, w, h = cv2.boundingRect(contour)
    cv2.rectangle(marked_img, (x-2, y-2), (x + w+2, y + h+2), (10, 0, 255), 6)
    counter = counter+1
  time.sleep(0.01)
print(f'\nThe total number of colonies is:', counter)

# Display the original image with blue regions highlighted
plt.figure(figsize=(12,6))
plt.subplot(1,2,1), plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB)), plt.title('Original'), plt.axis('off')
plt.subplot(1,2,2), plt.imshow(cv2.cvtColor(marked_img, cv2.COLOR_BGR2RGB)), plt.title('Colonies Identified'), plt.axis('off')
plt.show()

# Display the original image with bacterial colonies highlighted and number of colonies marked
# Define the text with the variable
cntext = f'Total E. Coli Colonies Found: {counter}'  # Use an f-string to insert the variable
rsktext1 = 'Risk Factor:'
if counter == 0:
  rsktext2 = f'SAFE'
  rsktext_color = (0, 255, 0)  # Green color in BGR format
elif 1<=counter<=10:
  rsktext2 = f'LOW'
  rsktext_color = (0, 220, 200)
elif 10<counter<=100:
  rsktext2 = f'MEDIUM'
  rsktext_color = (0, 100, 200)
elif 100<counter:
  rsktext2 = f'HIGH'
  rsktext_color = (0, 0, 255)  # Green color in BGR format

# Define the position, font, font scale, text color, and thickness
idposition = (50,100)
cntposition = (50, 170)
rskposition = (50,240)
rskposition2 = (500,240)
font = cv2.FONT_HERSHEY_SIMPLEX
font_scale = 2
text_color = (255, 0, 0)  # Blue color in BGR format
thickness = 2
rskthickness = 7

# Get the size of the text to draw a background rectangle
text_size, _ = cv2.getTextSize(rsktext2, font, font_scale, thickness)
text_width, text_height = text_size

# Calculate the coordinates for the background rectangle
background_x1 = rskposition2[0] -10
background_y1 = rskposition2[1] - text_height -10  # Adjusted for the text height
background_x2 = rskposition2[0] + text_width +10
background_y2 = rskposition[1] + 10

# Create a copy of the image to overlay the rectangle
image_with_rectangle = marked_img.copy()

# Draw a semi-transparent rectangle as the background for the text
alpha = 0.3  # Adjust transparency here (0.0 - fully transparent, 1.0 - fully opaque)
rectangle_color = (10, 10, 10)
cv2.rectangle(image_with_rectangle, (background_x1, background_y1), (background_x2, background_y2), rectangle_color, -1)  # Negative thickness creates a filled rectangle

# Blend the image with the rectangle onto the original image
image_with_highlighted_text = cv2.addWeighted(marked_img, 1 - alpha, image_with_rectangle, alpha, 0)


# Use cv2.putText() to write text with the variable on the image
image_with_id = cv2.putText(image_with_highlighted_text, client_ID + '--' + water_source, idposition, font, font_scale, text_color, thickness)
image_with_cnt = cv2.putText(image_with_id, cntext, cntposition, font, font_scale, text_color, thickness)
image_with_rsk1 = cv2.putText(image_with_cnt, rsktext1, rskposition, font, font_scale, text_color, thickness)
image_with_rsk = cv2.putText(image_with_rsk1, rsktext2, rskposition2, font, font_scale, rsktext_color, rskthickness)

# Display the image with text
plt.figure(figsize=(12,6))
plt.subplot(1,2,1), plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB)), plt.title('Original'), plt.axis('off')
plt.subplot(1,2,2), plt.imshow(cv2.cvtColor(image_with_rsk, cv2.COLOR_BGR2RGB)), plt.title('Colonies Identified'), plt.axis('off')
plt.show()




