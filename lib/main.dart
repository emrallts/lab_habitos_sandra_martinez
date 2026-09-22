import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panel de hábitos',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: const PanelHabitos(),
    );
  }
}

class PanelHabitos extends StatefulWidget {
  const PanelHabitos({super.key});

  @override
  State<PanelHabitos> createState() => _PanelHabitosState();
}

class _PanelHabitosState extends State<PanelHabitos> {
  final List<String> _habitos = const [
    'Beber 2 L de agua',
    'Leer 20 minutos',
    'Caminar 30 minutos',
    'Estudiar Flutter',
    'Dormir 8 horas',
  ];

  late List<bool> _cumplidos;
  int _meta = 3;
  bool _enfoque = false;
  String _nota = '';

  final TextEditingController _notaCtrl = TextEditingController();

  static const int _metaInicial = 3;

  @override
  void initState() {
    super.initState();

    _cumplidos = List<bool>.filled(_habitos.length, false);
  }

  @override
  void dispose() {
    _notaCtrl.dispose();
    super.dispose();
  }

  int get _totalCumplidos {
    return _cumplidos.where((cumplido) => cumplido).length;
  }

  double get _progreso {
    if (_habitos.isEmpty) {
      return 0;
    }

    return _totalCumplidos / _habitos.length;
  }

  bool get _metaAlcanzada {
    return _totalCumplidos >= _meta;
  }

  String get _mensaje {
    final porcentaje = (_progreso * 100).round();

    if (porcentaje == 0) {
      return '¡Empecemos!';
    }

    if (porcentaje < 50) {
      return 'Buen inicio';
    }

    if (porcentaje < 100) {
      return '¡Vas muy bien!';
    }

    return '¡Día completado! 🎉';
  }

  void _alternarHabito(int index) {
    setState(() {
      _cumplidos[index] = !_cumplidos[index];
    });
  }

  void _cambiarMeta(double valor) {
    setState(() {
      _meta = valor.round();
    });
  }

  void _alternarEnfoque(bool valor) {
    setState(() {
      _enfoque = valor;
    });
  }

  void _guardarNota() {
    setState(() {
      _nota = _notaCtrl.text.trim();
    });
  }

  void _reiniciarDia() {
    setState(() {
      _cumplidos = List<bool>.filled(_habitos.length, false);
      _meta = _metaInicial;
      _enfoque = false;
      _nota = '';
      _notaCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Hábitos | Cumplidos: $_totalCumplidos / ${_habitos.length}',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LinearProgressIndicator(value: _progreso, minHeight: 10),

          const SizedBox(height: 8),

          Text(
            '${(_progreso * 100).round()} % completado',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Text(
            _mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),
          const Divider(),

          const Text('Meta del día'),

          Slider(
            value: _meta.toDouble(),
            min: 1,
            max: _habitos.length.toDouble(),
            divisions: _habitos.length - 1,
            label: _meta.toString(),
            onChanged: _cambiarMeta,
          ),

          Text('Meta: $_meta hábitos'),

          if (_metaAlcanzada) const Text('Meta alcanzada'),

          const SizedBox(height: 12),

          SwitchListTile(
            title: const Text('Modo enfoque'),
            value: _enfoque,
            onChanged: _alternarEnfoque,
          ),

          const Divider(),

          ...List.generate(_habitos.length, (index) {
            if (_enfoque && _cumplidos[index]) {
              return const SizedBox.shrink();
            }

            return CheckboxListTile(
              title: Text(_habitos[index]),
              value: _cumplidos[index],
              onChanged: (_) => _alternarHabito(index),
            );
          }),

          const SizedBox(height: 12),

          TextField(
            controller: _notaCtrl,
            decoration: const InputDecoration(
              labelText: 'Nota del día',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _guardarNota(),
          ),

          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: _guardarNota,
            child: const Text('Guardar nota'),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_nota.isEmpty ? 'Sin nota' : _nota),
            ),
          ),

          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: _reiniciarDia,
            child: const Text('Reiniciar día'),
          ),
        ],
      ),
    );
  }
}
