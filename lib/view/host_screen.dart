import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _roomNameController = TextEditingController();
    final _roomDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Host Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _roomNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome da Sala',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome da sala.';
                      }
                      return null;
                    },
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  TextFormField(
                    controller: _roomDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição da Sala',
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final roomId = await _createRoom(
                          _roomNameController.text,
                          _roomDescriptionController.text,
                        );
                        if (roomId != null) {
                          Navigator.pushNamed(
                            context,
                            '/room',
                            arguments: {'roomId': roomId},
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Erro ao criar a sala. Tente novamente.'),
                            ),
                          );
                        }
                        _roomNameController.clear();
                        _roomDescriptionController.clear();
                      }
                    },
                    child: const Text('Criar Sala'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _createRoom(String name, String description) async {
    try {
      final roomRef = await FirebaseFirestore.instance.collection('rooms').add({
        'name': name,
        'description': description,
        'created_at': Timestamp.now(),
      });
      print(roomRef.id);
      return roomRef.id; // Retorna o ID da sala criada
    } catch (e) {
      print('Erro ao criar sala: $e');
      return null; // Retorna null em caso de erro
    }
  }
}
