import 'dart:io';

class FileUtils {
  static const _downloadDirectory = "/storage/emulated/0/Download";

  /// return the file directory path

  static String createFilePath({required String fileName}) {
    return "$_downloadDirectory/$fileName";
  }

  /// return `true` if file size less or equalt to `5 MB`
  static bool checkFileSize(File file) {
    int sizeInBytes = file.lengthSync();

    double sizeInMb = sizeInBytes / (1024 * 1024);

    if (sizeInMb <= 5) {
      return true;
    } else {
      return false;
    }
  }

  /// Return [File] created at [path]
  static File createFile({required String path}) {
    return File(path);
  }
}
