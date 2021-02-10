import 'dart:io';

extension FileExtension on File {
  Future<bool> get isDirectory async {
    final stat = await this.stat();
    return stat.type == FileSystemEntityType.directory;
  }
}
