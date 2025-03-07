class DodoPizzaModel {
  int? id;
  String? name;
  String? image;

  DodoPizzaModel({required this.id, required this.name, required this.image});

  static List<DodoPizzaModel> get list => [
        DodoPizzaModel(
            id: 1,
            name: "Pizza 1",
            image: "assets/dodo_pizza_often_order_pictures/img_1884.jpg"),
        DodoPizzaModel(
            id: 2,
            name: "Pizza 2",
            image: "assets/dodo_pizza_often_order_pictures/img_1885.jpg"),
        DodoPizzaModel(
            id: 3,
            name: "Pizza 3",
            image: "assets/dodo_pizza_often_order_pictures/img_1888.jpg"),
        DodoPizzaModel(
            id: 4,
            name: "Pizza 4",
            image: "assets/dodo_pizza_often_order_pictures/img_1937.jpg"),
        DodoPizzaModel(
            id: 5,
            name: "Pizza 5",
            image: "assets/dodo_pizza_often_order_pictures/img_1955.jpg"),
      ];
}
