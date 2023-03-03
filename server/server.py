from flask import Flask, request
from flask_restful import Resource, Api
import requests
import json
from datetime import datetime
import wave
import base64
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return 'Hi I am Semblance, Your realistic AI personal assistant. Are you ready to begin our journey!'

@app.route('/api', methods=['POST'])
def api():
    data = request.get_json()
    response = requests.post('https://jsonplaceholder.typicode.com/posts', json=data)
    return jsonify(response.json())


class Session(Resource):
    def post(self):
        # initialize session with user
        return {
            "message": "Hi I am Semblance, Your realistic AI personal assistant. Are you ready to begin our journey!. Please activate your microphone to begin."
        }


class Audio(Resource):
    def post(self):
        # capture audio from user
        audio = request.get_data()

        # save audio to file
        filename = datetime.now().strftime("%Y%m%d_%H%M%S") + ".wav"
        with wave.open(filename, "wb") as f:
            f.setnchannels(1)
            f.setsampwidth(2)
            f.setframerate(16000)
            f.writeframes(audio)

        # convert audio to base64 encoded string
        with open(filename, "rb") as f:
            audio_bytes = f.read()
        audio_str = base64.b64encode(audio_bytes).decode("utf-8")

        # send audio to whisper ai endpoint
        whisper_url = "https://whisper.lablab.ai/asr"
        headers = {"Content-Type": "application/json"}
        data = {"audio": audio_str}
        response = requests.post(whisper_url, headers=headers, data=json.dumps(data))
        text = response.json()["text"]

        # send text to GPT-3
        gpt_url = "https://api.openai.com/v1/engines/davinci-codex/completions"
        headers = {
            "Content-Type": "application/json",
            "Authorization": "Bearer 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",
        }
        data = {"prompt": text, "max_tokens": 100, "n": 1, "stop": "\n"}
        response = requests.post(gpt_url, headers=headers, data=json.dumps(data))
        result = response.json()["choices"][0]["text"]

        # return result
        return {"result": result}


api.add_resource(Session, "/session")
api.add_resource(Audio, "/audio")

if __name__ == "__main__":
    app.run(debug=True)
