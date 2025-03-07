import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/platform_widgets/platform_helper.dart';
import 'package:flutter_animations_2/platform_widgets/platform_sliver_navigation_bar.dart';

class PlatformBottomNavbar extends StatefulWidget {
  const PlatformBottomNavbar({super.key});

  @override
  State<PlatformBottomNavbar> createState() => _PlatformBottomNavbarState();
}

class _PlatformBottomNavbarState extends State<PlatformBottomNavbar> {
  // if context is coming inside CupertinoTabView
  // when you push your screen it will not navigate with your root context
  // that is why bottom navbar will always appear
  List<Widget> _screens(BuildContext context) {
    return [
      Container(
        color: Colors.green,
        child: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const PlatformSliverNavigationBar(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.arrow_right,
            ),
          ),
        ),
      ),
      Container(color: Colors.purple),
    ];
  }

  late final List<BottomNavigationBarItem> _items;

  // for android
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _items = _screens(context)
        .map(
          (e) => const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isCupertino()
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: _items),
            tabBuilder: (context, number) => CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: _screens(context)[number],
                );
              },
            ),
          )
        : Scaffold(
            body: _screens(context)[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: _items,
              currentIndex: selectedIndex,
              onTap: (int number) => setState(
                () {
                  selectedIndex = number;
                },
              ),
            ),
          );
  }
}
