import json
from flask import jsonify

class ResponseHandler:
    def __init__(self):
        pass
    
    def create_response(self, session_data):
        transcripts = session_data["transcripts"]
        response = {
            "device_name": session_data["device_name"],
            "device_model": session_data["device_model"],
            "phone_number": session_data["phone_number"],
            "email": session_data["email"],
            "transcripts": transcripts
        }
        return jsonify(response)
