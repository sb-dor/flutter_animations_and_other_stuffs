import 'package:flutter_animations_2/getit/domain/models/meme_model.dart';

abstract class MemeRepository {
  Future<MemeModel> getMeme();
}
