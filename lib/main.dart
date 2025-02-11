import 'package:flutter/material.dart';
import 'package:gerenciador_fila/view/signup_screen.dart';

import 'view/home_screen.dart';
import 'view/login_screen.dart';
import 'view/host_screen.dart';
import 'view/user_screen.dart';
import 'view/report_screen.dart';
import 'view/guest_screen.dart';
import 'view/room_screen.dart';
import 'view/room_list_screen.dart';
import 'view/report_screen.dart' as report;


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/host': (context) => const HostScreen(),
        '/user': (context) => const UserScreen(),
        '/report': (context) => const report.RelatorioScreen(),
        '/signup': (context) => SignupScreen(),
        '/guest': (context) => GuestScreen(),
        '/room': (context) => const RoomScreen(),
        '/list': (context) => const RoomListScreen(),
      }
      //home: HomeScreen(),
    );
  }
}
