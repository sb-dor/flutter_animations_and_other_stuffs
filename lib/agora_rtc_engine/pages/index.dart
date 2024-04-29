import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/agora_rtc_engine/pages/call.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final TextEditingController _channelController = TextEditingController(text: '');
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agora"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNXJ_1WHQ6XvWhER-oh1WgQEAI8FSlVPRPcm40_ZJdqw&s"),
              const SizedBox(height: 20),
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                  errorText: _validateError ? "Channel name is error" : null,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: "Channel name",
                ),
              ),
              RadioListTile<ClientRole?>(
                value: ClientRole.Broadcaster,
                groupValue: _role,
                onChanged: (ClientRole? value) {
                  setState(() {
                    _role = value;
                  });
                },
                title: const Text("Broadcast"),
              ),
              RadioListTile<ClientRole?>(
                value: ClientRole.Audience,
                groupValue: _role,
                onChanged: (ClientRole? value) {
                  setState(() {
                    _role = value;
                  });
                },
                title: const Text("Audience"),
              ),
              ElevatedButton(onPressed: onJoin, child: const Text("Join")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty ? _validateError = true : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      bool value = await _handleCameraAndMic(Permission.camera);
      if (!value) return;
      value = await _handleCameraAndMic(Permission.microphone);
      if (!value) return;
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text.trim(),
            role: _role,
          ),
        ),
      );
    }
  }

  Future<bool> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }
}
