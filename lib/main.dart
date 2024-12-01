import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'transaction_form.dart';
import 'notes_screen.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
        title: const Text('Fila da Sala: '),
      ),
      body: TransactionList(_items, _removeItem), // Lista de visitantes
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => _openAddItemModal(context),
              icon: const Icon(Icons.add),
              label: const Text('Visitante'),
            ),
            ElevatedButton.icon(
              onPressed: () => _openNotesScreen(context),
              icon: const Icon(Icons.note_add),
              label: const Text('Anotações'),
            ),
            ElevatedButton.icon(
              onPressed: _addYourTurn,
              icon: const Icon(Icons.pan_tool), // Substituído por um ícone válido
              label: const Text('Levantar a Mão'),
            ),
          ],
        ),
      ),
    );
  }
}
