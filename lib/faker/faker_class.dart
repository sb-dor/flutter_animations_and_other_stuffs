import 'package:faker/faker.dart';

class FakerClass {
  static Faker faker = Faker();

  static String fakeEmail() {
    return faker.internet.email();
  }

  static String fakeIpv6Address() {
    return faker.internet.ipv6Address();
  }

  static String fakeUserInternetName() {
    return faker.internet.userName();
  }

  static String fakeUserPersonName() {
    return faker.person.name();
  }

  static String fakeSentencesLorem() {
    return faker.lorem.sentence();
  }
}
