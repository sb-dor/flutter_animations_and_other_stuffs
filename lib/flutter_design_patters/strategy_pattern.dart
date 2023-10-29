// the main concept of strategy patters is that you separate you code with classes
// that implemented with interface (you can create interface with simple classes or abstract classes in dart)
// and interface class will be like mediator. And whenever you put your implemented class it will do it own func
// it little bit similar to factory design patter but instead of creating factory we pass data through functions

class Worker {
  void buildMyHouse(DoJob? doJob) {
    if (doJob != null) {
      doJob.doSomeJob();
    }
  }

//and you can call you function giving any data of class
  void test() {
    buildMyHouse(DestroyHouse());
    buildMyHouse(BuildHouse());
  }
}

//will be mediator through classes
abstract class DoJob {
  void doSomeJob();
}

//
class DestroyHouse implements DoJob {
  @override
  void doSomeJob() {
    // TODO: implement doSomeJob
  }
}

class BuildHouse implements DoJob {
  @override
  void doSomeJob() {
    // TODO: implement doSomeJob
  }
}
