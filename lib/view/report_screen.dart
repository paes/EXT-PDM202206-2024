import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RelatorioScreen extends StatefulWidget {
  const RelatorioScreen({Key? key}) : super(key: key);

  @override
  _RelatorioScreenState createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen> {
  final List<Map<String, dynamic>> dadosReuniao = [
    {'nome': 'Participante 1', 'tempo': '12 min', 'interacoes': 5},
    {'nome': 'Participante 2', 'tempo': '8 min', 'interacoes': 3},
  ];

  Future<void> gerarPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Relatório da Reunião', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              headers: ['Nome', 'Tempo de Fala', 'Interações'],
              data: dadosReuniao.map((d) => [d['nome'], d['tempo'], d['interacoes'].toString()]).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Relatório gerado automaticamente', style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic)),
          ],
        ),
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/relatorio.pdf");
    await file.writeAsBytes(await pdf.save());
    
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'relatorio.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatório de Reunião')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dadosReuniao.length,
              itemBuilder: (context, index) {
                final item = dadosReuniao[index];
                return ListTile(
                  title: Text(item['nome']),
                  subtitle: Text('Tempo: ${item['tempo']} | Interações: ${item['interacoes']}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: gerarPDF,
            child: const Text('Exportar PDF'),
          ),
        ],
      ),
    );
  }
}
