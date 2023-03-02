from flask import request
from flask_restful import Resource
import json

class RequestHandler(Resource):
    def __init__(self, session_manager):
        self.session_manager = session_manager
        
    def post(self):
        json_data = request.get_json(force=True)
        session_id = json_data["session_id"]
        transcript = json_data["transcript"]
        self.session_manager.add_transcript(session_id, transcript)
        return "", 200
