import json
import datetime

class SessionManager:
    def __init__(self, redis):
        self.redis = redis
    
    def create_session(self, device_name, device_model, phone_number, email):
        session_id = str(datetime.datetime.now().timestamp())
        session_data = {
            "device_name": device_name,
            "device_model": device_model,
            "phone_number": phone_number,
            "email": email,
            "transcripts": []
        }
        self.redis.set(session_id, json.dumps(session_data))
        return session_id
    
    def add_transcript(self, session_id, transcript):
        session_data = json.loads(self.redis.get(session_id))
        session_data["transcripts"].append(transcript)
        self.redis.set(session_id, json.dumps(session_data))
    
    def get_session_data(self, session_id):
        session_data = self.redis.get(session_id)
        if session_data:
            return json.loads(session_data)
        return None
