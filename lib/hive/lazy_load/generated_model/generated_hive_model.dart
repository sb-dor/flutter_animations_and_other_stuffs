import 'package:hive/hive.dart';

part 'generated_hive_model.g.dart';

// NOTE: READ THE DOC

/// `GeneratedHiveModel` is a Hive model class with the following fields:
/// - `id`: a unique identifier for the object.
/// - `name`: the name associated with the object.
/// - `age`: the age associated with the object.
///
/// ### Modifying the Model:
///
/// 1. **Adding a New Field**:
///    - When adding a new field, you must:
///      - Assign the new field a unique `HiveField` number (greater than the largest existing field index, e.g., 3 for the next field).
///      - Update the constructor to include the new field.
///      - Optionally provide a default value for the new field, especially if you are migrating from a previous version without that field.
///
///    ```dart
///    @HiveField(3)
///    final String? newField; // Example of adding a new field
///    ```
///
///    - **Important**: Hive will not automatically add values for the new field in previously saved objects.
///      If needed, create a migration script to populate or handle this field for old records.
///
/// 2. **Removing an Existing Field**:
///    - If you need to remove a field:
///      - Keep the field annotation (`@HiveField(n)`) in the class, but you can mark the field as deprecated or unused.
///      - **Do not remove the field number (`@HiveField`) from the class**, as this will cause Hive to misinterpret existing data.
///
///    ```dart
///    @HiveField(2)
///    @deprecated // Example of deprecating a field
///    final int? age;
///    ```
///
///    - **Important**: Removing a field entirely will cause issues with data deserialization from the Hive database, leading to crashes.
///      The field must be kept in the model for backward compatibility, even if it is no longer in use.
///
/// ### Example of Adding a New Field:
/// ```dart
/// @HiveField(3)
/// final String? newField;
/// ```
///

// about adapters:
// https://youtu.be/2caSU_2kGc4?list=PLrnbjo4fMQwYxZMrbyweTFaOTmMbZEx1z&t=1702
// https://youtu.be/2caSU_2kGc4?list=PLrnbjo4fMQwYxZMrbyweTFaOTmMbZEx1z&t=4210


// HiveObject will provide methods like:
// save(), delete(),
@HiveType(typeId: 1) // because we have already created that
class GeneratedHiveModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? changeName;

  // instead of deleting
  @Deprecated("Message")
  @HiveField(2)
  final int? age;

  GeneratedHiveModel({
    required this.id,
    required this.changeName,
    @Deprecated("Message") // instead of deleting
    required this.age,
  });

  @override
  String toString() {
    return "id: $id | name: $changeName | age: $age";
  }
}
