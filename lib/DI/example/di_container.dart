import 'package:flutter/material.dart';
import 'package:flutter_animations_2/DI/example/calc_service.dart';
import 'package:flutter_animations_2/DI/example/example_view_model.dart';


/*
IoC Инверсия управления. Позволяет изменить направление зависмостей.

DI - внедрение зависимостей. Когда класс получает зависмость из вне.
 И не контролирует этот процесс

DI container - это класс который создает зависимости и внедряет их.

Плюсы:
* Полная незвисимость классов
* Ясность. При вызове или просмотре конструктора видно,
что необходимо для работы класса
* Позволяет использовать инверсию зависмостей
* МОжно расставлять const конструкторы
---

Service locator - это класс которые создает зависмости и используется
 для получения этих зависмостей.

 Плюс:
 * Меньше кода
 * Позволяет использовать инверсию зависмостей
*/

//
/* translation:

// IoC - Inversion of Control. It allows changing the direction of dependencies.

DI - Dependency Injection. When a class receives dependencies from outside
and does not control this process.

DI container - A class that creates dependencies and injects them.

Advantages:
* Complete independence of classes
* Clarity. When calling or reviewing the constructor,
  you can clearly see what is needed for the class to function
* Allows for the use of dependency inversion
* You can use `const` constructors

---

Service locator - A class that creates dependencies and is used
to retrieve those dependencies.

Advantages:
* Less code
* Allows for the use of dependency inversion

*/

// DI container is something that has every necessary dependency in it
// and you don't have init every of them separately. Just get DIContainer and use it with it's dependencies
class DIContainer {
  //
  DIContainer({
    required this.calcService,
    required this.exampleViewModel,
    required this.exampleWidget,
  });

  final CalcService calcService;

  final ExampleViewModel exampleViewModel;

  final Widget exampleWidget;

// CalcService calcService() => FirstCalc();
//
// ExampleViewModel exampleCalcModel() => ExampleCalcModel(calcService());
//
// Widget exampleWidget() => DiPage(model: exampleCalcModel());
}
