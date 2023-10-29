import 'package:shared_preferences/shared_preferences.dart';

//single responsibility means that you should just separate function or logic from main logic
//and every class should do their own job
class SingleResponsibilityPrinciple {
  int? id;
  String? name;

  SingleResponsibilityPrinciple({this.id, this.name});
}

class SaveSingleResponsibility extends SingleResponsibilityPrinciple {
  void saveToDB() async {
    //save to db
  }

  void saveToLocalDb() async {
    var instance = await SharedPreferences.getInstance();
    await instance.setString("save_to_db", "name is $name id is $id");
  }
}
