import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/theme_services.dart';
import 'package:flutter_todo_app/ui/home_page.dart';
import 'package:flutter_todo_app/ui/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Todo App',
      debugShowCheckedModeBanner: false,
     theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,

      home: const HomePage(),
    );
  }
}
