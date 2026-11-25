
import 'package:flutter/material.dart';

class CadastroEnsaioPage extends StatefulWidget {
  final Map<String, String>? ensaio;

  const CadastroEnsaioPage({super.key, this.ensaio});

  @override
  State<CadastroEnsaioPage> createState() {
    return _CadastroEnsaioPageState();
  }
}

class _CadastroEnsaioPageState
    extends State<CadastroEnsaioPage> {

  final ensaioController = TextEditingController();
  final clienteController = TextEditingController();
  final localController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.ensaio != null) {
      ensaioController.text = widget.ensaio!['ensaio'] ?? '';
      clienteController.text = widget.ensaio!['cliente'] ?? '';
      localController.text = widget.ensaio!['local'] ?? '';
    }
  }

  @override
  void dispose() {
    ensaioController.dispose();
    clienteController.dispose();
    localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de Ensaio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextField(
              controller: ensaioController,
              decoration: InputDecoration(
                labelText: 'Ensaio',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            TextField(
              controller: clienteController,
              decoration: InputDecoration(
                labelText: 'Cliente',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            TextField(
              controller: localController,
              decoration: InputDecoration(
                labelText: 'Local',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {

                String ensaio = ensaioController.text;
                String cliente = clienteController.text;
                String local = localController.text;

                if (ensaio.trim().isEmpty ||
                    cliente.trim().isEmpty ||
                    local.trim().isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Atenção! Todos os campos são obrigatórios!'
                      ),
                    ),
                  );

                  return;
                }

                Navigator.pop(context, {
                  'ensaio': ensaio.trim(),
                  'cliente': cliente.trim(),
                  'local': local.trim(),
                });

              },
              child: const Text('Salvar'),
            ),

          ],
        ),
      ),
    );
  }
}
