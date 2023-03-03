final apiKey = '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';
final prompt = 'The user said: $transcription';

final response = await http.post(
  Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
  headers: {'Authorization': 'Bearer $apiKey'},
  body: {'prompt': prompt, 'max_tokens': '60'},
);

final generatedResponse = json.decode(response.body)['choices'][0]['text'];

