import 'package:floor/floor.dart';
import 'package:flutter_animations_2/floor_database/models/person_floor_db_model.dart';

@dao
abstract class PersonDao {
  @Query("select * from persons")
  Future<List<PersonFloorDbModel>> getAllPersons();

  @Query('select * from persons where id = :id')
  Future<PersonFloorDbModel?> getSpecificPerson(int id);

  @Query("delete from persons where id = :id")
  Future<void> delete(int id);

  @insert
  Future<void> insertToDb(PersonFloorDbModel personFloorDbModel);
}
