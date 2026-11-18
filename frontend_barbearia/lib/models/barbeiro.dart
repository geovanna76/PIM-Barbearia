import 'pessoa.dart';

class Barbeiro extends Pessoa {
  String _especialidade;
  String _cargo;

  Barbeiro({
    required String nome,
    required String telefone,
    required String especialidade,
    required String cargo,
  })  : _especialidade = especialidade,
        _cargo = cargo,
        super(nome: nome, telefone: telefone);

  String get especialidade => _especialidade;
  String get cargo => _cargo;

  @override
  String obterDetalhes() => 'Barbeiro: $nome ($_cargo - $_especialidade)';
}
