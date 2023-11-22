import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopUpWidget extends StatelessWidget {
  final Widget child;

  const PopUpWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    color: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          GestureDetector(
                              onTap: () => [],
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: child))
                        ]))))));
  }
}
