import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderService {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _audioPath;

  bool get isRecording => _isRecording;
  String? get audioPath => _audioPath;

  AudioRecorderService() {
    _audioRecorder = FlutterSoundRecorder();
  }

  // Initialize the recorder
  Future<void> init() async {
    // await _audioRecorder!.openAudioSession();
    await _requestPermissions();
  }

  // Request necessary permissions
  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    if (await Permission.microphone.isDenied) {
      throw 'Microphone permission is required';
    }
  }

  // Start recording audio
  Future<void> startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = join(
        directory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.aac');
    await _audioRecorder!.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );
    _isRecording = true;
    _audioPath = filePath;
  }

  // Stop recording audio
  Future<void> stopRecording() async {
    await _audioRecorder!.stopRecorder();
    _isRecording = false;
  }

  // Release the audio recorder
  Future<void> release() async {
    // await _audioRecorder!.closeAudioSession();
  }
}
