import 'package:flutter/material.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final roomId = arguments['roomId'];

    return Scaffold(
      appBar: AppBar(title: Text('Sala: $roomId')),
      body: Center(child: Text('Bem-vindo à sala $roomId!')),
    );
  }
}
