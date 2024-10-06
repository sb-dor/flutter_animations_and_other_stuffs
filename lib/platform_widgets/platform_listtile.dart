import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

class PlatformListTile extends StatelessWidget {
  const PlatformListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isCupertino()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // you can use tiles without CupertinoListSection¬
              CupertinoListSection(
                children: [
                  CupertinoListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      color: Colors.amber,
                    ),
                    title: const Text("Cupertino listtile"),
                    subtitle: const Text("Cupertino subtitle"),
                  ),
                  CupertinoListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                    ),
                    title: const Text("Cupertino listtile"),
                    subtitle: const Text("Cupertino subtitle"),
                  ),
                ],
              )
            ],
          )
        : Center(
            child: CupertinoListSection(
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  color: Colors.amber,
                ),
                title: const Text("Material listile"),
                subtitle: const Text("Material subtitle"),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  color: Colors.amber,
                ),
                title: const Text("Material listile"),
                subtitle: const Text("Material subtitle"),
              ),
            ],
          ));
  }
}
