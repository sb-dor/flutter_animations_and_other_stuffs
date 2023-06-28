import 'package:flutter/material.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () async {
                final pdf = await PdfGenerator.generate();

                await PdfGenerator.openFile(pdf);
              },
              child: Text("Generate pdf invoice",
                  style: TextStyle(color: Colors.amber)))),
    );
  }
}
