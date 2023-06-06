import 'package:calculadora_imc_tres/model/pessoa.dart';
import 'package:calculadora_imc_tres/repository/pessoas_repository.dart';
import 'package:flutter/material.dart';

class PessoaPage extends StatefulWidget {
  final Pessoa pessoa;
  const PessoaPage({Key? key, required this.pessoa}) : super(key: key);

  @override
  State<PessoaPage> createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {
  PessoasRepository pessoasRepository = PessoasRepository();

  @override
  void initState() {
    super.initState();
    atualizarPessoa();
  }

  atualizarPessoa() async {
    Pessoa pessoa = await pessoasRepository.obterPessoa(widget.pessoa.id);
    widget.pessoa.id = pessoa.id;
    widget.pessoa.altura = pessoa.altura;
    widget.pessoa.informacoes = pessoa.informacoes;
    widget.pessoa.nome = pessoa.nome;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pessoa.nome),
      ),
      body: ListView.builder(
        itemCount: widget.pessoa.informacoes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget.pessoa.informacoes[index].toString()),
            onDismissed: (direction) {
              pessoasRepository
                  .removerInformacao(widget.pessoa.informacoes[index]);
            },
            child: ListTile(
              title: Text(widget.pessoa.informacoes[index]
                  .resultadoIMC(widget.pessoa.altura)),
              subtitle: Text(widget.pessoa.informacoes[index]
                  .calcularIMC(widget.pessoa.altura)
                  .toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_comment),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController pesoController = TextEditingController();
              return AlertDialog(
                title: const Text("Peso (em kg):"),
                content: TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar")),
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await pessoasRepository.salvarInformacao(
                            widget.pessoa,
                            Informacao(
                                0,
                                double.parse(pesoController.text
                                    .replaceAll("-", "")
                                    .replaceAll(",", ".".trim()))));
                        atualizarPessoa();
                      },
                      child: const Text("Salvar"))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
