import 'package:flutter/material.dart';

/// Formulário para adicionar novos itens.
class TransactionForm extends StatefulWidget {
  final void Function(String) onAdd; // Função para adicionar um item

  const TransactionForm(this.onAdd, {super.key});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _textController = TextEditingController(); // Controle de texto

  void _submitData() {
    final enteredText = _textController.text;

    if (enteredText.isEmpty) {
      return; // Não adiciona se o campo estiver vazio
    }

    widget.onAdd(enteredText); // Adiciona o texto
    Navigator.of(context).pop(); // Fecha o modal
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Nome do Visitante'),
            onSubmitted: (_) => _submitData(),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
