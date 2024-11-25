import 'package:flutter/material.dart';

/// Tela para adicionar uma nova anotação.
class NotesScreen extends StatelessWidget {
  final void Function(String) onAddNote;

  const NotesScreen(this.onAddNote, {super.key});

  @override
  Widget build(BuildContext context) {
    // Controlador para o campo de texto
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Anotação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto para digitar a anotação
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Digite sua anotação aqui...',
                border: OutlineInputBorder(),
                labelText: 'Anotação',
              ),
            ),
            const SizedBox(height: 20),
            // Botão para salvar a anotação
            ElevatedButton(
              onPressed: () {
                // Verifica se o texto não está vazio
                if (controller.text.isNotEmpty) {
                  onAddNote(controller.text); // Adiciona a anotação
                  Navigator.of(context).pop(); // Fecha a tela
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
