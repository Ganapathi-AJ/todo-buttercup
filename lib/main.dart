import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/todo_model.dart';
import 'models/category_model.dart';
import 'providers/todo_provider.dart';
import 'providers/category_provider.dart';
import 'providers/theme_provider.dart';
import 'services/database_service.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';
import 'constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  final databaseService = DatabaseService();
  await databaseService.initializeHive();

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(databaseService: databaseService));
}

class MyApp extends StatelessWidget {
  final DatabaseService databaseService;

  const MyApp({Key? key, required this.databaseService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(databaseService),
        ),
        ChangeNotifierProvider(
          create: (_) => TodoProvider(databaseService),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Todo - Buttercup',
            theme: themeProvider.themeData,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

// Method to generate Hive adapters code
// This will be run with build_runner to generate adapter classes
// Run: flutter pub run build_runner build
class Adapters {
  // This class is not used, it's just here to trigger code generation
  void generate() {
    Todo? todo;
    Category? category;
    print('$todo $category'); // To avoid unused variable warning
  }
}
