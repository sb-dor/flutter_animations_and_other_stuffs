import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/auto_route_package_navigation/helper/auto_route_helper.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/auto_route_package_navigation/second_screen/auto_route_second_screen.dart';

@RoutePage()
class AutoRouteFirstScreen extends StatefulWidget {
  const AutoRouteFirstScreen({super.key});

  @override
  State<AutoRouteFirstScreen> createState() => _AutoRouteFirstScreenState();
}

class _AutoRouteFirstScreenState extends State<AutoRouteFirstScreen> {
  final TextEditingController _textEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auto route first screen"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(hintText: "Number"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textEditingController.text.trim().isEmpty) return;
                AutoRouter.of(context).push(
                  AutoRouteSecondRoute(
                    id: int.parse(
                      _textEditingController.text.trim(),
                    ),
                  ),
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}
