// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animations_2/floor_database/db/floor_app_database.dart';
// import 'package:flutter_animations_2/floor_database/models/person_floor_db_model.dart';
// import 'package:flutter_animations_2/getit/locator.dart';
//
// class FloorDatabasePage extends StatefulWidget {
//   const FloorDatabasePage({super.key});
//
//   @override
//   State<FloorDatabasePage> createState() => _FloorDatabasePageState();
// }
//
// class _FloorDatabasePageState extends State<FloorDatabasePage> {
//   List<PersonFloorDbModel> persons = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getAllDatabasePersons();
//   }
//
//   void getAllDatabasePersons() async {
//     persons = await locator.get<FloorAppDatabase>().personDao.getAllPersons();
//     setState(() {});
//   }
//
//   void add() async {
//     var person = PersonFloorDbModel(name: Faker().person.name());
//     await locator.get<FloorAppDatabase>().personDao.insertToDb(person);
//     getAllDatabasePersons();
//   }
//
//   void remove(int id) async {
//     await locator.get<FloorAppDatabase>().personDao.delete(id);
//     getAllDatabasePersons();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         title: const Text("Floor database"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => add(),
//         child: const Icon(Icons.add),
//       ),
//       body: ListView.separated(
//           padding: const EdgeInsets.only(left: 10),
//           separatorBuilder: (context, index) => const SizedBox(height: 10),
//           itemCount: persons.length,
//           itemBuilder: (context, index) {
//             return Row(
//               children: [
//                 const Icon(Icons.person),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("ID: ${persons[index].id}"),
//                       Text("Name: ${persons[index].name}")
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () => remove(persons[index].id ?? 0), icon: const Icon(Icons.delete))
//               ],
//             );
//           }),
//     );
//   }
// }
