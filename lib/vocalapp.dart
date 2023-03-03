import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:text_to_speech/text_to_speech.dart';

class VocalApp extends StatefulWidget {
  @override
  _VocalAppState createState() => _VocalAppState();
}

class _VocalAppState extends State<VocalApp> {
  stt.SpeechToText _speech = stt.SpeechToText();
  TextToSpeech tts = TextToSpeech();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  // Sends a POST request to the specified URL with the text in the request body
  void _sendPostRequest(String url, String text) async {
    // Send a POST request to the specified URL with the text in the request body
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{'text': text}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
            AssetImage('assets/space.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(

          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87,
                  Colors.black12,
                  Colors.black87,
                ]
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                onPressed: _toggleListening,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleListening() async {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
      _sendPostRequest('http://leexingyang.pythonanywhere.com/user', _text);
      final response = await http
          .get(Uri.parse("https://leexingyang.pythonanywhere.com/user"));
      final decoded = jsonDecode(response.body);
      setState(() {
        _text = decoded['text'];
        tts.speak(_text);
      });
    } else {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available)
        setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() => _text = val.recognizedWords),
      );
    }
  }

}