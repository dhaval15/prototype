import 'dart:io';

void main(List<String> args) async {
  final file = File(args[0]);
  final stat = await file.stat();
  print(stat.type)
}
