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
    final changeNot = ChangeNotProvider.watch<FilePageProvider>(context);
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ChangeNotProvider.read<FilePageProvider>(context)?.readFile();
              },
              child: const Text("Read file"),
            ),
            ElevatedButton(
              onPressed: () {
                ChangeNotProvider.read<FilePageProvider>(context)?.downloadImageIntoDownloads();
              },
              child: const Text("Download файл"),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    ChangeNotProvider.read<FilePageProvider>(context)?.getFiles(),
                child: ListView.builder(
                  itemCount: changeNot!.files.length,
                  itemBuilder: (context, index) {
                    return Image.file(changeNot.files[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
