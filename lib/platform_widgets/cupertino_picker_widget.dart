import 'package:flutter/cupertino.dart';

class CupertinoPickerWidget extends StatefulWidget {
  const CupertinoPickerWidget({super.key});

  @override
  State<CupertinoPickerWidget> createState() => _CupertinoPickerWidgetState();
}

class _CupertinoPickerWidgetState extends State<CupertinoPickerWidget> {
  int _selectedFruit = 0;
  final double _kItemExtent = 32.0;
  final List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: CupertinoColors.label.resolveFrom(context),
        fontSize: 22.0,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Selected fruit: '),
            CupertinoButton(
              padding: EdgeInsets.zero,
              // Display a CupertinoPicker with list of fruits.
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return _CupertinoPickerPopupHelper(
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedFruit,
                      ),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedFruit = selectedItem;
                        });
                      },
                      children: List<Widget>.generate(_fruitNames.length,
                          (int index) {
                        return Center(child: Text(_fruitNames[index]));
                      }),
                    ),
                  );
                },
              ),
              // This displays the selected fruit name.
              child: Text(
                _fruitNames[_selectedFruit],
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CupertinoPickerPopupHelper extends StatelessWidget {
  final Widget child;

  const _CupertinoPickerPopupHelper({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      // The Bottom margin is provided to align the popup above the system navigation bar.
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // Provide a background color for the popup.
      color: CupertinoColors.systemBackground.resolveFrom(context),
      // Use a SafeArea widget to avoid system overlaps.
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}
