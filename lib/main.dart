import 'package:biznet_workforce_activity/utils/navigation/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Biznet Workforce Activity",
      initialRoute: MainPage.INITIAL,
      getPages: MainPage.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}