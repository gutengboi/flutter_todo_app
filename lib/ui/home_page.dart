import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/notification_services.dart';
import 'package:flutter_todo_app/services/theme_services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: const [
          Text(
            "Hello World",
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme changed",
            body:Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
          );
          notifyHelper.scheduledNotification();
        },
        child: Icon(Icons.nightlight_round,
        size: 20,),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/person.png"
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}
