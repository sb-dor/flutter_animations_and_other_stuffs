import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/surf_sync_scroll/screen/surf_catalog_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SurfCatalogScreen());
  }
}
