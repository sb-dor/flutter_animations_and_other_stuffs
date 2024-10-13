import 'package:flutter/material.dart';
import 'package:flutter_animations_2/files/change_not_provider.dart';

import 'provider/file_page_provider.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  final _fileProvider = FilePageProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotProvider(
      model: _fileProvider,
      child: const _FilesPageHelper(),
    );
  }
}

class _FilesPageHelper extends StatefulWidget {
  const _FilesPageHelper();

  @override
  State<_FilesPageHelper> createState() => _FilesPageHelperState();
}

class _FilesPageHelperState extends State<_FilesPageHelper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ChangeNotProvider.read<FilePageProvider>(context)?.readFile();
          },
          child: const Text("Прочитать файл"),
        ),
      ),
    );
  }
}
