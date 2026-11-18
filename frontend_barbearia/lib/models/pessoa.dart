abstract class Pessoa {
  String _nome;
  String _telefone;

  Pessoa({required String nome, required String telefone})
      : _nome = nome,
        _telefone = telefone;

  String get nome => _nome;
  String get telefone => _telefone;

  String obterDetalhes();
}
