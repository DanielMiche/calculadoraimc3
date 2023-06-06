import 'package:calculadora_imc_tres/model/pessoa.dart';
import 'package:calculadora_imc_tres/repository/database.dart';

class PessoasRepository {
  Future<List<Pessoa>> obterPessoas() async {
    List<Pessoa> pessoas = [];
    var db = await SqliteDatabase().obterDatabase();
    var resultados = await db.rawQuery('Select id, nome, altura from pessoa');
    for (var pessoa in resultados) {
      pessoas.add(Pessoa(
        int.parse(pessoa['id'].toString()),
        pessoa['nome'].toString(),
        double.parse(pessoa['altura'].toString()),
        await _obterInformacoes(int.parse(pessoa['id'].toString())),
      ));
    }
    return pessoas;
  }

  Future<Pessoa> obterPessoa(int id) async {
    Pessoa pessoa = Pessoa(0, "", 0, []);
    var db = await SqliteDatabase().obterDatabase();
    var resultados = await db
        .rawQuery('Select id, nome, altura from pessoa where id = ?', [id]);
    for (var pessoaR in resultados) {
      pessoa = Pessoa(
        int.parse(pessoaR['id'].toString()),
        pessoaR['nome'].toString(),
        double.parse(pessoaR['altura'].toString()),
        await _obterInformacoes(int.parse(pessoaR['id'].toString())),
      );
    }
    return pessoa;
  }

  Future<List<Informacao>> _obterInformacoes(int id) async {
    List<Informacao> informacoes = [];
    var db = await SqliteDatabase().obterDatabase();
    var resultados = await db
        .rawQuery('Select id, peso from informacao where idpessoa = $id');
    for (var informacao in resultados) {
      informacoes.add(Informacao(int.parse(informacao['id'].toString()),
          double.parse(informacao['peso'].toString())));
    }
    return informacoes;
  }

  Future<void> salvarPessoa(Pessoa pessoa) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert("INSERT INTO pessoa (nome, altura) VALUES (?, ?)",
        [pessoa.nome, pessoa.altura]);
  }

  Future<void> removerPessoa(Pessoa pessoa) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert("Delete FROM pessoa where id = ?", [pessoa.id]);
  }

  Future<void> salvarInformacao(Pessoa pessoa, Informacao informacao) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert("INSERT INTO informacao (peso, idpessoa) VALUES (?, ?)",
        [informacao.peso, pessoa.id]);
  }

  Future<void> removerInformacao(Informacao informacao) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert("Delete FROM informacao where id = ?", [informacao.id]);
  }
}
