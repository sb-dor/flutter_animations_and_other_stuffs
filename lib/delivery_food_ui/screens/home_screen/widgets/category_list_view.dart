import 'package:flutter/material.dart';
import 'package:flutter_animations_2/delivery_food_ui/core/utils/ui_helper.dart';
import 'package:flutter_animations_2/delivery_food_ui/data.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: rh(120),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: space2x),
        scrollDirection: Axis.horizontal,
        itemCount: categoryIconList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: CategoryItem(
              name: name[index],
              backgroundColor: _selectedIndex == index ? Colors.white : const Color(0xfff2e3db),
              icon: Image.asset(
                categoryIconList[index],
                width: rw(35),
                height: rh(25),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key, required this.icon, required this.name, required this.backgroundColor});

  final Widget icon;
  final String name;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space2x),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: rf(30),
            backgroundColor: backgroundColor,
            child: icon,
          ),
          SizedBox(
            height: rf(space1x),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: rf(12),
                ),
          ),
        ],
      ),
    );
  }
}
