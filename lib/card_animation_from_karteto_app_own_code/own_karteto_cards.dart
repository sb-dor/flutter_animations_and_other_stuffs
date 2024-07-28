import 'package:uuid/uuid.dart';

class OwnKartetoCards {
  final String name;
  final id;

  OwnKartetoCards(this.name) : id = Uuid().v4();

  static List<OwnKartetoCards> cards = [
    OwnKartetoCards("Hippo"),
    OwnKartetoCards("Lion"),
    OwnKartetoCards("Giraffe"),
    OwnKartetoCards("Crocodile")
  ];
}
