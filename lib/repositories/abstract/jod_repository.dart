import 'package:quote_and_joke/models/joke_models.dart';

abstract class JodRepository {
  Future<JokeSingle> fetchJOD();
}
