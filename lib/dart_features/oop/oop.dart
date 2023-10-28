abstract class AbstractClass {
  // abstract function in dart can have method body and also can not have method body for functions
  // for ex:
  void function1();

  void function2() {}

  // but whenever you create function without realization in it (without method body), your class
  // that extending your abstract class should implement you func() too
  // for ex like in line 21

  // they can also cal have fields
  String? name;

// you can create construct for abstract class
// but remember that you can not use object of abstract classes
// if you create construct and whenever you extends that class you should pass data from your class
// to your abstract class through "super"
}

class ThatExtendsAbstractClass extends AbstractClass {
  @override
  void function1() {}
}

//interface -> you can't extend but can implement from another file
interface class InterfaceClass {
  /// functions can not be created as without method body [ {} ]. like this code below
  /// [void function();]
  // that is why you should create them with method body
  void function() {}

  // also they can have fields
  String? name;

  // also they can have constructors
  InterfaceClass({this.name});
}

/// simple class can not implement, extend [base] classes
/// any class that will implement or extend it should be class modifier of [base], [final] or [sealed] class
/// they can be used from another files
/// you can create object of base classes
base class BaseClass {}

// gives an error:
/// [class Any extends BaseClass {}]

// sealed classes can not be used from another file
/// also you can not create object of [sealed] classes
/// they can be [implemented] and [extended]
sealed class SealedClass {
  String? name;

  SealedClass({this.name});
}

abstract interface class Haha extends SealedClass {
  void func1();

  void any() {}
}

class ForUse {
  void func1() {
    // SealedClass sealedClass = SealedClass; //can not create an object

    BaseClass baseClass = BaseClass();
  }
}
