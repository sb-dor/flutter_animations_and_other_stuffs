import 'package:flutter/material.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

class AnimatedCartWithBottomNavbar extends StatefulWidget {
  const AnimatedCartWithBottomNavbar({super.key});

  @override
  State<AnimatedCartWithBottomNavbar> createState() => _AnimatedCartWithBottomNavbarState();
}

class _AnimatedCartWithBottomNavbarState extends State<AnimatedCartWithBottomNavbar> {
  // We can detect the location of the cart by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
        // To send the library the location of the Cart icon
        cartKey: cartKey,
        height: 30,
        width: 30,
        opacity: 0.85,
        dragAnimation: const DragToCartAnimationOptions(rotation: true),
        jumpAnimation: const JumpAnimationOptions(),
        createAddToCartAnimation: (runAddToCartAnimation) {
          // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
          this.runAddToCartAnimation = runAddToCartAnimation;
        },
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(items: [
              const BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
              BottomNavigationBarItem(
                  icon: AddToCartIcon(
                      key: cartKey,
                      icon: const Icon(Icons.shopping_cart),
                      badgeOptions: const BadgeOptions(active: true, backgroundColor: Colors.red)),
                  label: 'cart'),
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home')
            ]),
            body: ListView(
                children: List.generate(15, (index) {
              var widgetKey = GlobalKey();
              return InkWell(
                  onTap: () => listClick(widgetKey),
                  child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.transparent,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            key: widgetKey,
                            child: Image.network(
                                "https://cdn.jsdelivr.net/gh/omerbyrk/"
                                "add_to_cart_animation/example/assets/apple.png",
                                width: 60,
                                height: 60)),
                        const SizedBox(width: 10),
                        Text("Widget number ${index + 1}")
                      ])));
            }))));
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    // await cartKey.currentState!.runCartAnimation((++_cartQuantityItems).toString());
  }
}
