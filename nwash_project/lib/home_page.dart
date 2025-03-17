import 'package:flutter/material.dart';
import 'audio_recorder.dart';
import 'file_manager.dart';
import 'gps_service.dart';
import 'photo_capture.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GPSService gpsService = GPSService();
  PhotoCaptureService photoCaptureService = PhotoCaptureService();
  AudioRecorderService audioRecorderService = AudioRecorderService();
  FileManager fileManager = FileManager();

  Position? _currentPosition;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _initializeRecorder();
  }

  // Initialize the audio recorder
  Future<void> _initializeRecorder() async {
    await audioRecorderService.init();
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    Position? position = await gpsService.getCurrentLocation();
    setState(() {
      _currentPosition = position;
    });
  }

  // Capture photo and save metadata
  Future<void> _capturePhoto() async {
    final XFile? image = await photoCaptureService.capturePhoto();
    if (image != null) {
      setState(() {
        _image = image;
      });

      // Save photo metadata
      String datetime = fileManager.getCurrentDatetime();
      double latitude = _currentPosition?.latitude ?? 0.0;
      double longitude = _currentPosition?.longitude ?? 0.0;
      fileManager.savePhotoMetadata(datetime, latitude, longitude);
    }
  }

  // Start or stop recording audio
  Future<void> _toggleRecording() async {
    if (audioRecorderService.isRecording) {
      await audioRecorderService.stopRecording();
    } else {
      await audioRecorderService.startRecording();
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    audioRecorderService.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NWASH Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Current Location'),
            ),
            SizedBox(height: 20),
            Text(
              _currentPosition != null
                  ? 'Lat: ${_currentPosition!.latitude}, Long: ${_currentPosition!.longitude}'
                  : 'Location not available',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _capturePhoto,
              child: Text('Capture Photo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleRecording,
              child: Text(audioRecorderService.isRecording
                  ? 'Stop Recording'
                  : 'Start Recording'),
            ),
            if (_image != null) ...[
              SizedBox(height: 20),
              Image.file(File(_image!.path)),
            ],
          ],
        ),
      ),
    );
  }
}
