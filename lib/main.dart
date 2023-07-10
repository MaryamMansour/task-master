import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/my_provider.dart';
import 'package:to_do/screens/create_account/create_account.dart';
import 'package:to_do/screens/edit_screen.dart';
import 'package:to_do/screens/login/login.dart';
import 'firebase_options.dart';
import 'home_layout/home_layout.dart';
import 'shared/styles/my_theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // FirebaseFirestore.instance.disableNetwork();//Data local
  runApp(ChangeNotifierProvider(
    create:(context) =>  MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return MaterialApp(
      darkTheme: MyThemeData.darkTheme,
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute:
      provider.firebaseUser!=null?
      HomeLayout.routeName:
      LoginScreen.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        EditScreen.routeName: (context) => EditScreen(),
        LoginScreen.routeName: (context)=>LoginScreen(),
        CreateAcoount.routeName: (context)=>CreateAcoount(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}