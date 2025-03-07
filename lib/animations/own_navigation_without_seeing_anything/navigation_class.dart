import 'package:flutter/cupertino.dart';

enum NavigationClassTypes { fromLeft, fromRight, fromTop, fromBottom, fadeIn, withRotate, none }

//need to create a class that will extend a class which will help us to create route with some animation

//then through Navigator.push(context, NavigationClass()) - will go to another page
class NavigationClass extends PageRouteBuilder {
  final Widget child;
  final NavigationClassTypes type;
  final Duration? duration;
  final Curve? curve;
  final Alignment? alignment;

  NavigationClass(
      {required this.child, required this.type, this.duration, this.curve, this.alignment})
      : super(
            pageBuilder: (context, anim, secondaryAnim) => child,
            transitionDuration: duration ?? const Duration(milliseconds: 600),
            transitionsBuilder: (context, animDoubleFirst, animDoubleSecond, widget) {
              final curvedAnimation = CurvedAnimation(
                  parent: animDoubleFirst,
                  //we should to put only first double anim from transitionBuilder
                  curve: curve ?? Curves.fastOutSlowIn);
              switch (type) {
                case NavigationClassTypes.fromLeft:
                  return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                          .animate(curvedAnimation),
                      child: child);
                case NavigationClassTypes.fromRight:
                  return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                          .animate(curvedAnimation),
                      child: child);
                case NavigationClassTypes.fromTop:
                  return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                          .animate(curvedAnimation),
                      child: child);

                case NavigationClassTypes.fromBottom:
                  return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                          .animate(curvedAnimation),
                      child: child);
                case NavigationClassTypes.fadeIn:
                  return FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(curvedAnimation),
                      child: child);
                case NavigationClassTypes.withRotate:
                  if (alignment != null) {
                    //if you want to navigate page with rotate
                    //you need to alignment, default value is Alignment(2, 0)
                    return RotationTransition(
                        turns: curvedAnimation,
                        alignment: alignment,
                        child: ScaleTransition(
                            alignment: alignment, scale: curvedAnimation, child: child));
                  } else {
                    return SlideTransition(
                        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                            .animate(curvedAnimation),
                        child: child);
                  }
                case NavigationClassTypes.none:
                  return child;
                default:
                  return child;
              }
            });
}
