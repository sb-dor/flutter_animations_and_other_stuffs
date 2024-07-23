import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AutoRouteSecondScreen extends StatefulWidget {
  final int id;

  const AutoRouteSecondScreen({
    super.key,
    @PathParam("id") required this.id,
  });

  @override
  State<AutoRouteSecondScreen> createState() => _AutoRouteSecondScreenState();
}

class _AutoRouteSecondScreenState extends State<AutoRouteSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen -> ${widget.id}"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (AutoRouter.of(context).canPop()) {
              AutoRouter.of(context).popForced();
            }
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}
