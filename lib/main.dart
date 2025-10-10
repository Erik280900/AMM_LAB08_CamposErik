import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagerApp());
}

// --- PALETA DE COLORES ---
const Color primaryBlue = Color(0xFF5A67D8); // Azul violeta moderno
const Color backgroundColor = Color.fromARGB(
  255,
  100,
  146,
  214,
); // Fondo gris claro
const Color textColor = Color(0xFF2D3748); // Gris oscuro elegante
const Color errorRed = Color(0xFFE53E3E); // Rojo cálido
const Color accentGreen = Color(0xFF48BB78); // Verde éxito
const Color accentYellow = Color(0xFFD69E2E); // Amarillo prioridad

// --- APP PRINCIPAL ---
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas ✨',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TaskManagerScreen(),
        '/menu': (context) => const MainMenuScreen(),
        '/profile': (context) => const UserRegistrationScreen(),
        '/tasks': (context) => const TaskRegistrationScreen(),
      },
    );
  }
}

// --- PANTALLA 1: INICIO ---
class TaskManagerScreen extends StatelessWidget {
  const TaskManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(flex: 2),
              const Text(
                '🗓️ Gestor de Tareas',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Organiza tu día, logra tus metas 💪',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/menu');
                },
                child: const Text('🚀 Entrar'),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PANTALLA 2: MENÚ ---
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📋 MENÚ PRINCIPAL')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            _MenuItem(
              emoji: "🏠",
              title: 'Home',
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            _MenuItem(
              emoji: "👤",
              title: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            _MenuItem(
              emoji: "📝",
              title: 'Tareas',
              onTap: () {
                Navigator.pushNamed(context, '/tasks');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Ítem del menú con emoji
class _MenuItem extends StatelessWidget {
  final String title;
  final String emoji;
  final VoidCallback onTap;

  const _MenuItem({
    required this.title,
    required this.onTap,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$emoji  $title",
              style: const TextStyle(fontSize: 20, color: textColor),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black26,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA 3: REGISTRO DE USUARIO ---
class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👤 Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: primaryBlue,
                ),
                labelText: 'Nombre',
                labelStyle: const TextStyle(color: Colors.black54),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryBlue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.work_outline, color: accentGreen),
                labelText: 'Ocupación',
                labelStyle: const TextStyle(color: Colors.black54),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryBlue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('✅ Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA 4: REGISTRO DE TAREAS ---
class TaskRegistrationScreen extends StatelessWidget {
  const TaskRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📝 Registro de Tareas')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Dropdown simulado
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'Trabajo',
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryBlue,
                  ),
                  style: const TextStyle(fontSize: 16, color: textColor),
                  items: <String>['Trabajo', 'Personal', 'Estudio']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text("📌 $value"),
                        );
                      })
                      .toList(),
                  onChanged: (String? newValue) {},
                ),
              ),
            ),
            const SizedBox(height: 30),
            const TaskListItem(
              taskName: '📚 Estudiar Flutter',
              priority: 'Alta',
            ),
            const TaskListItem(
              taskName: '💼 Reunión con el equipo',
              priority: 'Media',
            ),
            const TaskListItem(
              taskName: '🧘 Hacer ejercicio',
              priority: 'Baja',
            ),
          ],
        ),
      ),
    );
  }
}

// --- ÍTEM DE TAREA ---
class TaskListItem extends StatelessWidget {
  final String taskName;
  final String priority;

  const TaskListItem({
    super.key,
    required this.taskName,
    required this.priority,
  });

  Color _priorityColor() {
    switch (priority.toLowerCase()) {
      case 'alta':
        return errorRed;
      case 'media':
        return accentYellow;
      default:
        return accentGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: <Widget>[
          const Icon(Icons.check_circle_outline, color: primaryBlue),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              taskName,
              style: const TextStyle(fontSize: 18, color: textColor),
            ),
          ),
          Text(
            priority,
            style: TextStyle(
              color: _priorityColor(),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
