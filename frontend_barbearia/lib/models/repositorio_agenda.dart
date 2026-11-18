import 'agendamento.dart';
import 'barbeiro.dart';
import 'cliente.dart';

class RepositorioAgenda {
  final List<Agendamento> _agendamentos = [
    Agendamento(
      id: 1,
      profissional: Barbeiro(nome: 'Carlos Silva', telefone: '11977776666', especialidade: 'Degradê', cargo: 'Master Barber'),
      cliente: Cliente(nome: 'Juninho Play', telefone: '11988887777', email: 'juninho@email.com', dataNascimento: '12/05/1995'),
      corte: 'Corte Degradê - R\$ 45,00',
      data: '20/11/2026',
      horario: '14:00',
    )
  ];

  List<Agendamento> obterTodos() => _agendamentos;

  bool verificarHorarioOcupado(String nomeBarbeiro, String data, String horario) {
    return _agendamentos.any((a) =>
        a.profissional.nome.toLowerCase() == nomeBarbeiro.toLowerCase() &&
        a.data == data &&
        a.horario == horario);
  }

  bool adicionarAgendamento(Agendamento novoAgendamento) {
    if (verificarHorarioOcupado(novoAgendamento.profissional.nome, novoAgendamento.data, novoAgendamento.horario)) {
      return false;
    }
    _agendamentos.add(novoAgendamento);
    return true;
  }
}
