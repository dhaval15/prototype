import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';

class FileUtils {
  Future<String> load() async {
    // final path = await FilePickerCross.importFromStorage(fileExtension: 'json')
    //     .then((file) => file);
    // final file = File(path);
    // return file();
  }

  Future<void> save(String path, String data) async {
    final file = FilePickerCross(
      Uint8List.fromList(data.codeUnits),
      path: path,
      fileExtension: 'json',
    );
    await file.exportToStorage();
  }
}
