from flask import Flask, request, jsonify
import cv2
import numpy as np
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os
from dotenv import load_dotenv
from flask_cors import CORS


load_dotenv()  # Load environment variables from .env file


# Initialize Flask App
app = Flask(__name__)
CORS(app) 

# Database Configuration
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db = SQLAlchemy(app)

# Database Model
class WaterQualityAnalysis(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String(100), nullable=False)  # Store user ID
    timestamp = db.Column(db.DateTime, default=datetime.now)
    colony_count = db.Column(db.Integer, nullable=False)
    risk_level = db.Column(db.String(10), nullable=False)

# Function to Process Image
def process_image(image):
    try:
        # Define cropping area
        crop_h, crop_w = 330, 50
        image = image[crop_h:, crop_w:-crop_w]  # Crop image

        # Convert to HSV color space
        hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

        # Get unique colors & identify bacterial colony color
        unique_colors = np.unique(hsv_image.reshape(-1, hsv_image.shape[2]), axis=0)
        if len(unique_colors) == 0:
            target_color = np.array([100, 50, 50])  # Default color
        else:
            target_color = unique_colors[np.argmin(np.abs(unique_colors[:, 0] - 100))]

        # Define HSV color thresholds
        hue_tolerance = 65
        saturation_reduction = 30
        lower_target = np.array([
            np.clip(target_color[0] - hue_tolerance, 0, 180),  # Hue lower bound
            np.clip(target_color[1] - saturation_reduction, 0, 255),  # Saturation lower bound
            np.clip(target_color[2] - 50, 0, 255)  # Brightness lower bound
        ])

        upper_target = np.array([
            np.clip(target_color[0] + hue_tolerance, 0, 180),  # Hue upper bound
            np.clip(target_color[1] + saturation_reduction, 0, 255),  # Saturation upper bound
            np.clip(target_color[2] + 50, 0, 255)  # Brightness upper bound
        ])

        # Create mask & find bacterial colonies
        blue_mask = cv2.inRange(hsv_image, lower_target, upper_target)
        contours, _ = cv2.findContours(blue_mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        # Count colonies
        colony_count = sum(1 for c in contours if cv2.contourArea(c) > 5) if contours else 0

        # Determine Risk Level
        if colony_count == 0:
            risk_level = "SAFE"
        elif 1 <= colony_count <= 10:
            risk_level = "LOW"
        elif 10 < colony_count <= 100:
            risk_level = "MEDIUM"
        else:
            risk_level = "HIGH"

        return colony_count, risk_level

    except Exception as e:
        return None, str(e)  # Return error if processing fails

# Endpoint: Upload Image and Analyze
@app.route("/analyze", methods=["POST"])
def analyze_image():
    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    user_id = request.form.get("user_id")  # Get user_id from the request
    if not user_id:
        return jsonify({"error": "User ID is required"}), 400

    file = request.files["file"]
    nparr = np.frombuffer(file.read(), np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    if image is None:
        return jsonify({"error": "Invalid or corrupted image"}), 400

    colony_count, risk_level = process_image(image)

    if colony_count is None:
        return jsonify({"error": risk_level}), 500  # Return processing error
    
    # Save results to the database
    new_analysis = WaterQualityAnalysis(user_id=user_id, colony_count=colony_count, risk_level=risk_level)
    db.session.add(new_analysis)
    db.session.commit()

    return jsonify({
        "user_id": user_id,
        "colony_count": colony_count,
        "risk_level": risk_level,
        "message": "Analysis complete."
    })

# Endpoint: Get Full Analysis History
@app.route("/results", methods=["GET"])
def get_all_results():
    """ Retrieve all past water quality analysis results """
    analyses = WaterQualityAnalysis.query.order_by(WaterQualityAnalysis.timestamp.desc()).all()
    results = [
        {"id": a.id, "user_id": a.user_id, "timestamp": a.timestamp.strftime("%Y-%m-%d %H:%M:%S"), 
         "colony_count": a.colony_count, "risk_level": a.risk_level}
        for a in analyses
    ]
    return jsonify(results)

# Endpoint: Get Specific User's Analysis History
@app.route("/results/<user_id>", methods=["GET"])
def get_user_history(user_id):
    """ Retrieve all past results for a specific user """
    analyses = WaterQualityAnalysis.query.filter_by(user_id=user_id).order_by(WaterQualityAnalysis.timestamp.desc()).all()
    
    if not analyses:
        return jsonify({"message": "No history found for this user."}), 404

    results = [
        {"id": a.id, "timestamp": a.timestamp.strftime("%Y-%m-%d %H:%M:%S"), 
         "colony_count": a.colony_count, "risk_level": a.risk_level}
        for a in analyses
    ]
    return jsonify(results)

if __name__ == "__main__":
    # Ensure database is created before running the app
    with app.app_context():
        db.create_all()
    app.run(port=5000, debug=True)
