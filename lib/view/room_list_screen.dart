import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Salas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar salas.'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Nenhuma sala disponível.'),
            );
          }

          final rooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              final roomId = room.id;
              final roomName = room['name'] ?? 'Sala sem nome';
              //  final roomDescription = room['description'] ?? '';

              return ListTile(
                title: Text(roomName),
                //  subtitle: Text(roomDescription),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/room',
                    arguments: {'roomId': roomId},
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
