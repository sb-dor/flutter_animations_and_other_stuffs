class ListViewModel {
  final String imageUrl;
  final String title;
  final String price;
  final String mileage;
  final String condition;
  final String color;
  final bool isCustomsCleared;
  final String engineVolume;
  final String engineType;
  final String power;

  ListViewModel({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.mileage,
    required this.condition,
    required this.color,
    required this.isCustomsCleared,
    required this.engineVolume,
    required this.engineType,
    required this.power,
  });

  static final List<ListViewModel> comparisons = List.generate(
    10,
    (index) => ListViewModel(
      imageUrl: "https://via.placeholder.com/150",
      title: "Car Model $index",
      price: "${(index + 1) * 10000} c.",
      mileage: "${(index + 1) * 5000} km",
      condition: index % 2 == 0 ? "New" : "Used",
      color: index % 2 == 0 ? "Red" : "Blue",
      isCustomsCleared: index % 2 == 0,
      engineVolume: "${1.5 + index * 0.1} L",
      engineType: index % 2 == 0 ? "Petrol" : "Diesel",
      power: "${100 + index * 10} HP",
    ),
  );
}
