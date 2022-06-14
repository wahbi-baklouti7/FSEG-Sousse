import 'dart:io';

class FileUtils {

  
  static const _downloadDirectory = "/storage/emulated/0/Download/";

  // Checks if the directory exists, if it does, it returns the path to the directory, if it
  // doesn't, it creates the directory and returns the path to the directory

  static Future<String> createFilePath({required String fileName}) async {
    final bool directoryExist = await Directory(_downloadDirectory).exists();
    if (directoryExist) {
      return _downloadDirectory;
    } else {
      final newDirectory = await Directory(_downloadDirectory).create();
      return newDirectory.path;
    }
  }

  // return `true` if file size less or equal to `5 MB`
  static Future<bool> checkFileSize(File file) async {
    int sizeInBytes = await file.length();

    double sizeInMb = sizeInBytes / (1024 * 1024);

    if (sizeInMb <= 5) {
      return true;
    } else {
      return false;
    }
  }

  static File createFile({required String path}) {
    return File(path);
  }
}
