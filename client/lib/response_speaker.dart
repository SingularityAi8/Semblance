import 'package:flutter_tts/flutter_tts.dart';

final flutterTts = FlutterTts();
await flutterTts.setLanguage('en-US');
await flutterTts.speak(generatedResponse);

