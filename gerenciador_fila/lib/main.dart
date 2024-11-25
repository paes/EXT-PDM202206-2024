import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'transaction_form.dart';
import 'notes_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _items = []; // Lista de visitantes
  final List<String> _notes = []; // Lista de anotações

  void _addItem(String itemName) {
    setState(() {
      _items.add(itemName); // Adiciona novo visitante
    });
  }

  void _addNote(String note) {
    setState(() {
      _notes.add(note); // Salva nova anotação
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index); // Remove visitante pelo índice
    });
  }

  void _addYourTurn() {
    setState(() {
      _items.add("Sua vez"); // Adiciona "Sua vez" à lista
    });
  }

  void _openAddItemModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addItem); // Formulário para visitantes
      },
    );
  }

  void _openNotesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return NotesScreen(_addNote); // Tela para anotações
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fila da Sala: '),
      ),
      body: TransactionList(_items, _removeItem), // Lista de visitantes
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => _openAddItemModal(context),
              icon: Icon(Icons.add),
              label: Text('Visitante'),
            ),
            ElevatedButton.icon(
              onPressed: () => _openNotesScreen(context),
              icon: Icon(Icons.note_add),
              label: Text('Anotações'),
            ),
            ElevatedButton.icon(
              onPressed: _addYourTurn,
              icon: Icon(Icons.pan_tool), // Substituído por um ícone válido
              label: Text('Levantar a Mão'),
            ),
          ],
        ),
      ),
    );
  }
}
