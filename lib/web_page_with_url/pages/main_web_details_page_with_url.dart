import 'package:flutter/material.dart';

class MainWebDetailsPageWithUrl extends StatefulWidget {
  final String name;
  final String sName;

  const MainWebDetailsPageWithUrl({
    super.key,
    required this.name,
    required this.sName,
  });

  @override
  State<MainWebDetailsPageWithUrl> createState() => _MainWebDetailsPageWithUrlState();
}

class _MainWebDetailsPageWithUrlState extends State<MainWebDetailsPageWithUrl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name} ${widget.sName}"),
      ),
    );
  }
}
