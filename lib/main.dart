
import 'package:flutter/material.dart';
import 'cadastro_ensaio_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final List<Map<String, String>> ensaios = [
  {
    'ensaio': 'Retrato',
    'cliente': 'Julia',
    'local': 'Estúdio A'
  },
];

class EstudioPage extends StatefulWidget {
  const EstudioPage({super.key});

  @override
  State<EstudioPage> createState() {
    return _EstudioPageState();
  }
}

class _EstudioPageState extends State<EstudioPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Estúdio Fotográfico'),
      ),

      body: ListView.builder(
        itemCount: ensaios.length,
        itemBuilder: (context, index) {
          return ListTile(

            // Editar ensaio
            onTap: () async {
              final ensaioEditado =
              await Navigator.push<Map<String, String>>(
                navigatorKey.currentContext!,
                MaterialPageRoute(
                  builder: (context) => CadastroEnsaioPage(
                    ensaio: ensaios[index],
                  ),
                ),
              );

              if (ensaioEditado != null && mounted) {
                setState(() {
                  ensaios[index] = ensaioEditado;
                });
              }
            },

            // Exibir dados do ensaio
            leading: const Icon(Icons.camera_alt),

            title: Text(ensaios[index]['ensaio']!),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ensaios[index]['cliente']!),
                Text(ensaios[index]['local']!),
              ],
            ),

            // Excluir ensaio
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Excluir Ensaio'),
                    content: Text(
                        'Deseja excluir o ensaio ${ensaios[index]['ensaio']!}?'
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            ensaios.removeAt(index);
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),

      // Cadastrar novo ensaio
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoEnsaio =
          await Navigator.push<Map<String, String>>(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => CadastroEnsaioPage(),
            ),
          );

          debugPrint('Ensaio recebido $novoEnsaio');

          if (novoEnsaio != null && mounted) {
            setState(() {
              ensaios.add(novoEnsaio);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const EstudioPage(),
    ),
  );
}

