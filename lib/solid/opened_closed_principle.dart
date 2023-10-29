// the main principe of open_close_principe is that classes should be protected from changes but opened for
// extensions

// in short, class's should just show what kind of job they will do, but their realization is hidden
import 'package:flutter/cupertino.dart';

abstract class OpenClosedPrinciple {
  void hello();
}

class English implements OpenClosedPrinciple {
  @override
  void hello() {
    debugPrint("hello");
  }
}

class Russian implements OpenClosedPrinciple {
  @override
  void hello() {
    debugPrint("привет");
  }
}
