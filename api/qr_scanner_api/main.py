import os

from dotenv import load_dotenv
from flask import Flask, request, jsonify
from pymongo import MongoClient

current_directory = os.getcwd()
env_path = os.path.join(current_directory, ".env")

load_dotenv(dotenv_path=env_path)
app = Flask(__name__)

MONGO_DB_URL = os.getenv("MONGO_DB_URL")

client = MongoClient(MONGO_DB_URL)
DB_NAME = os.getenv("DB_NAME")

COLLECTION_NAME = os.getenv("COLLECTION_NAME")


@app.route('/get_user_data', methods=['GET'])
def get_user_data():
    user_id = request.args.get('idofuser')
    if not user_id:
        return jsonify({"error": "User ID is required"}), 400
    db = client.get_database(DB_NAME)
    users_collection = db.get_collection(COLLECTION_NAME)
    user_data = users_collection.find_one({"idofuser": user_id})
    if not user_data:
        return jsonify({"error": "User not found"}), 404

    # Convert ObjectId to string and remove the _id field if necessary
    user_data["_id"] = str(user_data["_id"])
    return jsonify(user_data), 200

if __name__== '__main__':
    app.run(debug=True,host="YOUR_WIFI_IP_ADDRESS", port=50162)