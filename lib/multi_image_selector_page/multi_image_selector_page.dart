import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter_animations_2/multi_image_selector_page/helper/multi_selector_helper.dart';
import 'package:image_picker/image_picker.dart';

class MultiImageSelectorPage extends StatefulWidget {
  const MultiImageSelectorPage({Key? key}) : super(key: key);

  @override
  State<MultiImageSelectorPage> createState() => _MultiImageSelectorPageState();
}

class _MultiImageSelectorPageState extends State<MultiImageSelectorPage> {
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Multi Image Picker"),
          actions: [
            IconButton(onPressed: () => throw Exception(), icon: Icon(Icons.bug_report)),
            IconButton(
                onPressed: () => MultiSelectorHelper.pickMultipleMediaFunc(),
                icon: Icon(Icons.send))
          ],
        ),
        body: Column(children: [
          TextButton(
              onPressed: () async {
                images.clear();

                images = await MultiSelectorHelper.multiImageSelector();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 5),
                          Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
                        ])));
                await MultiSelectorHelper.sendImages(images);
                Navigator.pop(context);
                setState(() {});
              },
              onLongPress: () {},
              child: const Text("Pick images")),
          Expanded(
              child: ListView(children: [
            ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: images.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                    width: 300,
                    height: 200,
                    alignment: Alignment.center,
                    child: Image.file(File(images[index].path), fit: BoxFit.cover)))
          ])),
          const SizedBox(height: 10)
        ]));
  }
}
