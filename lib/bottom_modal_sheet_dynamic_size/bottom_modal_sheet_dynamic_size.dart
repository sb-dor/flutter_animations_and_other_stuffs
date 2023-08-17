import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class BottomModalSheetDynamicSize {
  static bottomSheet({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            SizedBox(
                width: double.maxFinite,
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const SizedBox(height: 10),
                  Container(
                      width: 50,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500, borderRadius: BorderRadius.circular(8))),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child:
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const SizedBox(height: 15),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "≪",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).textTheme.displayLarge?.color,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: " ${Faker().lorem.sentence()} ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context).textTheme.displayLarge?.color,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "≫",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).textTheme.displayLarge?.color,
                                          fontWeight: FontWeight.bold))
                                ])),
                                const SizedBox(height: 10),
                                Text(Faker().lorem.sentence(),
                                    style: TextStyle(fontSize: 16), maxLines: 11),
                                const SizedBox(height: 15)
                              ]))))
                ]))
          ]);
        });
  }
}
