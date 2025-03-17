import 'package:intl/intl.dart';

class FileManager {
  // Example method to save photo metadata
  void savePhotoMetadata(String datetime, double latitude, double longitude) {
    // Save the metadata to a file, database, or any other storage
    print('Photo Metadata: $datetime, $latitude, $longitude');
  }

  // Method to get current date and time in a specific format
  String getCurrentDatetime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }
}
