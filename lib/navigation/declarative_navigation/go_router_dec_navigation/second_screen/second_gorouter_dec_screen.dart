import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondGoRouterDecScreen extends StatefulWidget {
  final int comingNumber;

  const SecondGoRouterDecScreen({
    super.key,
    required this.comingNumber,
  });

  @override
  State<SecondGoRouterDecScreen> createState() =>
      _SecondGoRouterDecScreenState();
}

class _SecondGoRouterDecScreenState extends State<SecondGoRouterDecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Second Dec Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.pop(),
              child: Text("Pop to first dec screen -> ${widget.comingNumber}"),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(
                'nameforthirdscreen',
                pathParameters: <String, String>{
                  "comingId": widget.comingNumber.toString(),
                  "comingIdd": "15",
                },
              ),
              child: Text(
                  "push to third dec screen with value -> ${widget.comingNumber}"),
            ),
          ],
        ),
      ),
    );
  }
}
