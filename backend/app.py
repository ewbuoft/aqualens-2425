from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os
from dotenv import load_dotenv
from flask_cors import CORS
from backend.water_analysis import analyze_image_from_bytes

load_dotenv()  # Load environment variables from .env file

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db = SQLAlchemy(app)

class WaterQualityAnalysis(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String(100), nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.now)
    colony_count = db.Column(db.Integer, nullable=False)
    risk_level = db.Column(db.String(10), nullable=False)

@app.route("/analyze", methods=["POST"])
def analyze_image():
    try:
        if "file" not in request.files:
            return jsonify({"error": "No file uploaded"}), 400

        user_id = request.form.get("user_id")
        if not user_id:
            return jsonify({"error": "User ID is required"}), 400

        file = request.files["file"]
        image_bytes = file.read()

        # Ensure the function returns a dictionary
        result = analyze_image_from_bytes(image_bytes, selected_option="Both", resize=False, target_height=800)

        if not isinstance(result, dict):  # Check for tuple or unexpected return type
            return jsonify({"error": "Unexpected response format from analysis function"}), 500

        if "error" in result:
            return jsonify({"error": result["error"]}), 500

        # Safely get values with defaults
        colony_count = result.get("colony_count", 0)
        risk_level = result.get("risk_level", "ERROR")
        images = result.get("images", [])  # Ensure this is a list
        histogram = result.get("histogram")

        # Debugging log
        print(f"Analysis Result: {result}")

        return jsonify({
            "user_id": user_id,
            "colony_count": colony_count,
            "risk_level": risk_level,
            "images": images,
            "histogram": histogram,
            "message": "Analysis complete."
        })
    except Exception as e:
        print(f"Error during analysis: {e}")
        return jsonify({"error": str(e)}), 500

@app.route("/results", methods=["GET"])
def get_all_results():
    analyses = WaterQualityAnalysis.query.order_by(WaterQualityAnalysis.timestamp.desc()).all()
    results = [
        {"id": a.id, "user_id": a.user_id, "timestamp": a.timestamp.strftime("%Y-%m-%d %H:%M:%S"),
         "colony_count": a.colony_count, "risk_level": a.risk_level}
        for a in analyses
    ]
    return jsonify(results)

@app.route("/results/<user_id>", methods=["GET"])
def get_user_history(user_id):
    analyses = WaterQualityAnalysis.query.filter_by(user_id=user_id).order_by(WaterQualityAnalysis.timestamp.desc()).all()

    if not analyses:
        return jsonify({"message": "No history found for this user."}), 404

    results = [
        {"id": a.id, "timestamp": a.timestamp.strftime("%Y-%m-%d %H:%M:%S"),
         "colony_count": a.colony_count, "risk_level": a.risk_level}
        for a in analyses
    ]
    return jsonify(results)

@app.route("/health", methods=["GET"])
def health_check():
    return "OK", 200


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
