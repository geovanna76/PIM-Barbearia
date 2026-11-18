import 'pessoa.dart';

class Cliente extends Pessoa {
  String _email;
  String _dataNascimento;

  Cliente({
    required String nome,
    required String telefone,
    required String email,
    required String dataNascimento,
  })  : _email = email,
        _dataNascimento = dataNascimento,
        super(nome: nome, telefone: telefone);

  String get email => _email;
  String get dataNascimento => _dataNascimento;

  @override
  String obterDetalhes() => 'Cliente: $nome | Tel: $telefone | E-mail: $_email';

  bool validarDados() {
    return nome.isNotEmpty && telefone.length >= 10 && _email.contains('@');
  }
}
