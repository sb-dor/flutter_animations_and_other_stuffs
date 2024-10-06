import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isCupertino()
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
