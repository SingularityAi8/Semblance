from flask import Flask, request, jsonify
from flask_cors import CORS
import openai_secret_manager
import openai
import json

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


# Fetching the api_key from the secrets manager
assert "openai" in openai_secret_manager.get_services()
secrets = openai_secret_manager.get_secret("openai")

# Apply the api_key
openai.api_key = secrets["api_key"]

# Test API key and retrieve models
models = openai.Model.list()
assert len(models['data']) > 0, "No models available under this account"

# Define a function to generate text using GPT-3
def generate_text(prompt, model, max_length):
    prompt = (prompt.strip() + "\n").encode("utf-8")
    response = openai.Completion.create(
        engine=model,
        prompt=prompt,
        max_tokens=max_length,
        n=1,
        stop=None,
        temperature=0.5,
    )
    message = response.choices[0].text.strip()
    return message

# Define a home route
@app.route("/")
def home():
    return "Welcome to the GPT-3 API!"

# Define a route to generate text
@app.route("/generate", methods=["POST"])
def generate():
    data = request.get_json()
    prompt = data["prompt"]
    model = data["model"]
    max_length = data["max_length"]
    text = generate_text(prompt, model, max_length)
    return jsonify({"text": text})

if __name__ == "__main__":
    app.run()
