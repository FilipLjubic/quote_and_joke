import 'package:get_it/get_it.dart';
import 'package:quote_and_joke/services/joke_service.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/services/visibility_service.dart';

GetIt getIt = GetIt.instance;

// get data by getIt<QuoteService>().getQuotes();
setupLocator() {
  getIt.registerSingleton<VisibilityService>(VisibilityService());
  getIt.registerSingleton<QuoteService>(QuoteService());
  getIt.registerSingleton<JokeService>(JokeService());
}
