from flask import Flask, request, jsonify
from flask_cors import CORS
from backend.water_analysis import analyze_image_from_bytes

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)

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

@app.route("/health", methods=["GET"])
def health_check():
    return "OK", 200

if __name__ == "__main__":
    app.run(debug=True)
