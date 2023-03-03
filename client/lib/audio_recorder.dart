import 'package:flutter_sound/flutter_sound.dart';

final soundRecorder = FlutterSoundRecorder();
final Directory appDirectory = await getApplicationDocumentsDirectory();
final String filePath = '${appDirectory.path}/recording.wav';

await soundRecorder.openAudioSession();
await soundRecorder.startRecorder(toFile: filePath);
// recording is now in progress

await soundRecorder.stopRecorder();
await soundRecorder.closeAudioSession();

