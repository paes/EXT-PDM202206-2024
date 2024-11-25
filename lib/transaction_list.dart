import 'package:flutter/material.dart';

/// Lista ordenada para exibir a fila.
class TransactionList extends StatelessWidget {
  final List<String> items; // Lista de nomes
  final void Function(int) onRemove; // Função para remover itens

  const TransactionList(this.items, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(
            child: Text(
              'Nenhuma pessoa na fila',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: Text('${index + 1}'), // Ordem numérica
                title: Text(items[index]), // Nome do item
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => onRemove(index), // Remove pelo índice
                ),
              );
            },
          );
  }
}
