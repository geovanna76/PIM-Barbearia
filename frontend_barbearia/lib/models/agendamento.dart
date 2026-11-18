import 'barbeiro.dart';
import 'cliente.dart';

class Agendamento {
  final int _id;
  final Barbeiro _profissional;
  final Cliente _cliente;
  final String _corte;
  final String _data;
  final String _horario;

  Agendamento({
    required int id,
    required Barbeiro profissional,
    required Cliente cliente,
    required String corte,
    required String data,
    required String horario,
  })  : _id = id,
        _profissional = profissional,
        _cliente = cliente,
        _corte = corte,
        _data = data,
        _horario = horario;

  int get id => _id;
  Barbeiro get profissional => _profissional;
  Cliente get cliente => _cliente;
  String get corte => _corte;
  String get data => _data;
  String get horario => _horario;
}
