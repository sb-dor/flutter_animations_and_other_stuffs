import 'package:flutter/material.dart';
import 'package:flutter_animations_2/generated/l10n.dart';

class IntlLocalizationScreen extends StatefulWidget {
  const IntlLocalizationScreen({super.key});

  @override
  State<IntlLocalizationScreen> createState() => _IntlLocalizationScreenState();
}

class _IntlLocalizationScreenState extends State<IntlLocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).Hello,
            ),
            Text(
              S.of(context).points_info(50),
            ),
          ],
        ),
      ),
    );
  }
}
