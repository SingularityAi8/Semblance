import 'package:http/http.dart' as http;

final request = http.MultipartRequest('POST', Uri.parse('https://whisper.lablab.ai/asr'));
request.files.add(await http.MultipartFile.fromPath('audio_file', filePath));

final response = await request.send();
final transcription = await response.stream.bytesToString();

