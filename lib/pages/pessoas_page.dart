import 'package:calculadora_imc_tres/model/pessoa.dart';
import 'package:calculadora_imc_tres/pages/pessoa_page.dart';
import 'package:calculadora_imc_tres/repository/pessoas_repository.dart';
import 'package:flutter/material.dart';

class PessoasPage extends StatefulWidget {
  const PessoasPage({Key? key}) : super(key: key);

  @override
  State<PessoasPage> createState() => _PessoasPageState();
}

class _PessoasPageState extends State<PessoasPage> {
  PessoasRepository pessoasRepository = PessoasRepository();
  List<Pessoa> pessoas = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    pessoas = await pessoasRepository.obterPessoas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoas'),
      ),
      body: ListView.builder(
        itemCount: pessoas.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PessoaPage(pessoa: pessoas[index])));
            },
            leading: const Icon(Icons.person_rounded),
            title: Text(pessoas[index].nome),
            trailing: const Icon(Icons.list),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add_alt_rounded),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              TextEditingController nomeController =
                  TextEditingController(text: "");
              TextEditingController alturaController =
                  TextEditingController(text: "");
              return AlertDialog(
                title: const Text("Dados"),
                content: SizedBox(
                  height: 165,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Nome"),
                      TextField(
                        controller: nomeController,
                      ),
                      const SizedBox(height: 15),
                      const Text("Altura"),
                      TextField(
                        controller: alturaController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await pessoasRepository.salvarPessoa(Pessoa(
                          0,
                          nomeController.text,
                          double.parse(alturaController.text
                              .replaceAll("-", "")
                              .replaceAll(",", ".".trim())),
                          []));
                      carregarDados();
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
