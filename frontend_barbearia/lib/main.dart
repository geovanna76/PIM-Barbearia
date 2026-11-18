import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/cliente.dart';
import 'models/barbeiro.dart';
import 'models/agendamento.dart';
import 'models/repositorio_agenda.dart';

void main() {
  runApp(const BarbeariaApp());
}

class BarbeariaApp extends StatelessWidget {
  const BarbeariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alunos Tech - Barbearia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E1E24),
          primary: const Color(0xFF1E1E24),
          secondary: const Color(0xFF00B894),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
      ),
      home: const TelaAgendamento(),
    );
  }
}

class ServicoModel {
  final String nome;
  final String preco;
  final String tempo;
  ServicoModel({required this.nome, required this.preco, required this.tempo});
}

final RepositorioAgenda repositorioAgenda = RepositorioAgenda();

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key});

  @override
  State<TelaAgendamento> createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  Barbeiro? barbeiroSelecionado;
  String? corteSelecionado;
  DateTime dataSelecionada = DateTime.now();
  String? horarioSelecionado;

  // Lista instanciando a classe Barbeiro (Herança de Pessoa)
  final List<Barbeiro> listaBarbeiros = [
    Barbeiro(nome: 'Carlos Silva', telefone: '11911112222', especialidade: 'Degradê e Tesoura', cargo: 'Master Barber'),
    Barbeiro(nome: 'Marcos Souza', telefone: '11933334444', especialidade: 'Estilos Modernos', cargo: 'Barbeiro Estilista'),
    Barbeiro(nome: 'Rafael Lima', telefone: '11955556666', especialidade: 'Barba e Acabamento', cargo: 'Especialista em Barba'),
  ];

  final List<ServicoModel> listaCortes = [
    ServicoModel(nome: 'Corte Social', preco: 'R\$ 35,00', tempo: '30 min'),
    ServicoModel(nome: 'Corte Degradê', preco: 'R\$ 45,00', tempo: '40 min'),
    ServicoModel(nome: 'Barba Completa', preco: 'R\$ 30,00', tempo: '30 min'),
    ServicoModel(nome: 'Corte + Barba', preco: 'R\$ 70,00', tempo: '60 min'),
  ];

  final List<String> listaHorarios = ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00', '17:00', '18:00'];

  String formatarData(DateTime d) {
    String dia = d.day.toString().padLeft(2, '0');
    String mes = d.month.toString().padLeft(2, '0');
    return "$dia/$mes/${d.year}";
  }

  bool isOcupado(String h) {
    if (barbeiroSelecionado == null) return false;
    String dStr = formatarData(dataSelecionada);
    return repositorioAgenda.verificarHorarioOcupado(barbeiroSelecionado!.nome, dStr, h);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos Tech Barbearia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF1E1E24),
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaPainelBarbeiro()),
              ).then((_) => setState(() {}));
            },
            icon: const Icon(Icons.calendar_month, color: Color(0xFF00B894), size: 20),
            label: const Text('Área do Barbeiro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFF1E1E24),
                      child: const Icon(Icons.content_cut, color: Color(0xFF00B894), size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Alunos Tech Barbearia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                          SizedBox(height: 4),
                          Text('Agende seu horário com rapidez e estilo.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('1. Escolha o Profissional', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E1E24))),
              const SizedBox(height: 10),
              ...listaBarbeiros.map((b) {
                bool sel = barbeiroSelecionado?.nome == b.nome;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: sel ? const Color(0xFF1E1E24) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: sel ? const Color(0xFF00B894) : Colors.grey.shade200, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: CircleAvatar(
                      backgroundColor: sel ? const Color(0xFF00B894) : Colors.grey.shade100,
                      child: Icon(Icons.person, color: sel ? Colors.white : Colors.grey.shade700),
                    ),
                    title: Text(b.nome, style: TextStyle(fontWeight: FontWeight.bold, color: sel ? Colors.white : Colors.black87)),
                    subtitle: Text('${b.cargo} • ${b.especialidade}', style: TextStyle(color: sel ? Colors.white70 : Colors.grey, fontSize: 12)),
                    trailing: Icon(sel ? Icons.check_circle : Icons.radio_button_off, color: sel ? const Color(0xFF00B894) : Colors.grey),
                    onTap: () => setState(() {
                      barbeiroSelecionado = b;
                      horarioSelecionado = null;
                    }),
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text('2. Escolha o Serviço', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E1E24))),
              const SizedBox(height: 10),
              ...listaCortes.map((c) {
                String nomeCompleto = "${c.nome} - ${c.preco}";
                bool sel = corteSelecionado == nomeCompleto;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: sel ? const Color(0xFF1E1E24) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: sel ? const Color(0xFF00B894) : Colors.grey.shade200, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(c.nome, style: TextStyle(fontWeight: FontWeight.bold, color: sel ? Colors.white : Colors.black87)),
                    subtitle: Text('Duração aproximada: ${c.tempo}', style: TextStyle(color: sel ? Colors.white70 : Colors.grey, fontSize: 12)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(c.preco, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: sel ? const Color(0xFF00B894) : const Color(0xFF1E1E24))),
                        const SizedBox(width: 12),
                        Icon(sel ? Icons.check_circle : Icons.radio_button_off, color: sel ? const Color(0xFF00B894) : Colors.grey),
                      ],
                    ),
                    onTap: () => setState(() => corteSelecionado = nomeCompleto),
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text('3. Escolha a Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E1E24))),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  DateTime? escolhida = await showDatePicker(
                    context: context,
                    initialDate: dataSelecionada,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (escolhida != null) {
                    setState(() {
                      dataSelecionada = escolhida;
                      horarioSelecionado = null;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Color(0xFF00B894)),
                      const SizedBox(width: 12),
                      Text('Data selecionada: ${formatarData(dataSelecionada)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF1E1E24))),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('4. Escolha o Horário', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E1E24))),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: listaHorarios.map((h) {
                  bool ocupado = isOcupado(h);
                  bool sel = horarioSelecionado == h;
                  return ChoiceChip(
                    label: Text(ocupado ? '$h (Ocupado)' : h),
                    selected: sel,
                    selectedColor: const Color(0xFF00B894),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: sel ? Colors.white : (ocupado ? Colors.grey : Colors.black87),
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: ocupado ? null : (_) => setState(() => horarioSelecionado = h),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1E1E24),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: (barbeiroSelecionado != null && corteSelecionado != null && horarioSelecionado != null)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaCadastroCliente(
                                barbeiro: barbeiroSelecionado!,
                                corte: corteSelecionado!,
                                data: formatarData(dataSelecionada),
                                horario: horarioSelecionado!,
                              ),
                            ),
                          ).then((_) => setState(() => horarioSelecionado = null));
                        }
                      : null,
                  child: const Text('Avançar para Identificação', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaCadastroCliente extends StatefulWidget {
  final Barbeiro barbeiro;
  final String corte;
  final String data;
  final String horario;

  const TelaCadastroCliente({
    super.key,
    required this.barbeiro,
    required this.corte,
    required this.data,
    required this.horario,
  });

  @override
  State<TelaCadastroCliente> createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _nascCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      // Instanciação da classe filha Cliente (Herança de Pessoa)
      Cliente novoCliente = Cliente(
        nome: _nomeCtrl.text.trim(),
        telefone: _telCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        dataNascimento: _nascCtrl.text.trim(),
      );

      if (!novoCliente.validarDados()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Verifique os dados preenchidos.')),
        );
        return;
      }

      Agendamento novoAgendamento = Agendamento(
        id: repositorioAgenda.obterTodos().length + 1,
        profissional: widget.barbeiro,
        cliente: novoCliente,
        corte: widget.corte,
        data: widget.data,
        horario: widget.horario,
      );

      bool sucesso = repositorioAgenda.adicionarAgendamento(novoAgendamento);

      if (!sucesso) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Horário Ocupado'),
            content: const Text('Desculpe, este horário acabou de ser reservado por outro cliente.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
            ],
          ),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('🎉 Agendamento Confirmado!'),
          content: Text('Tudo pronto, ${novoCliente.nome}!\nSeu horário para ${widget.data} às ${widget.horario} com ${widget.barbeiro.nome} foi confirmado.'),
          actions: [
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00B894)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Concluir', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identificação do Cliente', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF1E1E24),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF00B894), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Resumo do Agendamento:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                      const SizedBox(height: 6),
                      Text('• Serviço: ${widget.corte}'),
                      Text('• Profissional: ${widget.barbeiro.nome}'),
                      Text('• Data e Hora: ${widget.data} às ${widget.horario}'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nomeCtrl,
                  decoration: const InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nascCtrl,
                  decoration: const InputDecoration(labelText: 'Data de Nascimento (DD/MM/AAAA)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Telefone com DDD (apenas números)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                  validator: (v) => (v == null || v.length < 10) ? 'Informe DDD + número (mín. 10 dígitos)' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Campo obrigatório';
                    if (!v.contains('@') || !v.contains('.')) return 'E-mail inválido (ex: nome@dominio.com)';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E24),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _salvar,
                    child: const Text('Confirmar Agendamento', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TelaPainelBarbeiro extends StatelessWidget {
  const TelaPainelBarbeiro({super.key});

  @override
  Widget build(BuildContext context) {
    var agendamentos = repositorioAgenda.obterTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Agendamentos', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF1E1E24),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: agendamentos.length,
            itemBuilder: (context, index) {
              var item = agendamentos[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00B894),
                    foregroundColor: Colors.white,
                    child: Text(item.horario, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  title: Text('${item.cliente.nome} — ${item.corte}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text('Profissional: ${item.profissional.nome}\nData: ${item.data} • Tel: ${item.cliente.telefone}', style: const TextStyle(color: Colors.grey)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
