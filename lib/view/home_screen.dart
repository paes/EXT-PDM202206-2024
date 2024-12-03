import 'package:flutter/material.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela: '),
      ),
      body: const Center(
        child: ElevatedButton(
          onPressed: exemploMetodoController,
          child: Text('click aqui'),
        ),
      )
    );
  }
}
