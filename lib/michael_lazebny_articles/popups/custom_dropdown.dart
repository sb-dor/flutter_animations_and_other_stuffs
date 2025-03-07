import 'package:flutter/material.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/popups/widgets/popup.dart';
import 'package:flutter_animations_2/models/cars/bmw.dart';
import 'package:flutter_animations_2/models/cars/helpers/transmission.dart';

class CustomDropdownImpl extends StatefulWidget {
  const CustomDropdownImpl({super.key});

  @override
  State<CustomDropdownImpl> createState() => _CustomDropdownImplState();
}

class _CustomDropdownImplState extends State<CustomDropdownImpl> {
  CustomDropdownEntry<Bmw>? _tempEntry;

  final List<CustomDropdownEntry<Bmw>> _items = [
    CustomDropdownEntry(Bmw(transmission: Transmission(type: "t1")), "BMW1"),
    CustomDropdownEntry(Bmw(transmission: Transmission(type: "t2")), "BMW2"),
    CustomDropdownEntry(Bmw(transmission: Transmission(type: "t3")), "BMW3"),
    CustomDropdownEntry(Bmw(transmission: Transmission(type: "t4")), "BMW4"),
    CustomDropdownEntry(Bmw(transmission: Transmission(type: "t5")), "BMW5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ML article about popups",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CustomDropdown<Bmw>(
              items: _items,
              activeItem: _tempEntry,
              onChanged: (entry) {
                setState(() {
                  _tempEntry = entry;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//
//
//
final class CustomDropdownEntry<T> {
  final T value;
  final String label;

  const CustomDropdownEntry(this.value, this.label);
}

/// dropdown impl using [Popup]
class _CustomDropdown<T> extends StatelessWidget {
  final List<CustomDropdownEntry<T>> items;
  final CustomDropdownEntry? activeItem;
  final ValueChanged<CustomDropdownEntry<T>>? onChanged;

  const _CustomDropdown({
    super.key,
    required this.items,
    required this.activeItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      follower: (context, controller) => PopupFollower(
          child: IntrinsicWidth(
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...items.map(
                  (element) => ListTile(
                    title: Text(element.label),
                    onTap: () {
                      onChanged?.call(element);
                      controller.hide();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
      child: (context, controller) => TapRegion(
        debugLabel: "Custom Dropdown",
        groupId: controller,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onChanged == null
                ? null
                : () {
                    controller.isShowing ? controller.hide() : controller.show();
                  },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: activeItem == null ? const Text('Select an item') : Text(activeItem!.label),
            ),
          ),
        ),
      ),
    );
  }
}
