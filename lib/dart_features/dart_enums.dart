// I learned it from -> https://medium.com/@ethiel97/enums-on-steroids-with-dart-best-enum-features-ever-ff7ba7996b87
// and I thing that especially this implementation is not good idea to implement
enum Status {
  initial,
  loading,
  failure,
  success; // remember to use this symbol in the of enum if you want to use other things

  // Dart also allows to define getters even on simple enums,
  // giving us the flexibility to do some computations based on the enum value.

  bool get isInitial => this == Status.initial;

  bool get isLoading => this == Status.loading;

  bool get isFailure => this == Status.failure;

  bool get isSuccess => this == Status.success;
}

// another impl that not relates to above one

// if you want to use enums with constructor
enum AccountStatus {
  // remember to use this kind of thing in order remove all errors
  admin(value: "admin", desc: "user is admin"),
  guest(value: "guest", desc: "user is guest"),
  user(value: "user", desc: "user");

  final String value;
  final String desc;

  // the constructor will not be used anywhere
  // because you already have created
  // enums at the top
  // - admin
  // - guest
  // - user
  const AccountStatus({required this.value, required this.desc});
}
