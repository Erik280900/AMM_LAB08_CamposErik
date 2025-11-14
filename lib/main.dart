import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const TaskManagerApp());
}

// --- PALETA DE COLORES ---
const Color primaryBlue = Color(0xFF5A67D8);
const Color backgroundColor = Color.fromARGB(255, 100, 146, 214);
const Color textColor = Color(0xFF2D3748);
const Color errorRed = Color(0xFFE53E3E);
const Color accentGreen = Color(0xFF48BB78);
const Color accentYellow = Color(0xFFD69E2E);

// ---------------------------------------------------------
//  WIDGETS ADAPTATIVOS
// ---------------------------------------------------------

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS =
        Theme.of(context).platform == TargetPlatform.iOS && !kIsWeb;

    if (isIOS) {
      return CupertinoButton.filled(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(text),
        onPressed: onPressed,
      );
    }

    // Material (Android / Web)
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}

class AdaptiveTextField extends StatelessWidget {
  final String label;
  final IconData icon;

  const AdaptiveTextField({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final bool isIOS =
        Theme.of(context).platform == TargetPlatform.iOS || kIsWeb;

    if (isIOS) {
      return CupertinoTextField(
        prefix: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: primaryBlue),
        ),
        padding: const EdgeInsets.all(16),
        placeholder: label,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryBlue),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
      ),
    );
  }
}

class AdaptiveDropdown extends StatefulWidget {
  final List<String> items;
  final String defaultValue;

  const AdaptiveDropdown({
    super.key,
    required this.items,
    required this.defaultValue,
  });

  @override
  State<AdaptiveDropdown> createState() => _AdaptiveDropdownState();
}

class _AdaptiveDropdownState extends State<AdaptiveDropdown> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS =
        Theme.of(context).platform == TargetPlatform.iOS || kIsWeb;

    // --- iOS (forzado en web también) ---
    if (isIOS) {
      return GestureDetector(
        onTap: () {
          showCupertinoModalPopup(
            context: context,
            builder: (_) => Container(
              height: 250,
              color: Colors.white,
              child: CupertinoPicker(
                itemExtent: 32,
                scrollController: FixedExtentScrollController(
                  initialItem: widget.items.indexOf(selected),
                ),
                onSelectedItemChanged: (index) {
                  setState(() => selected = widget.items[index]);
                },
                children: widget.items.map((e) => Text(e)).toList(),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("📌 $selected", style: const TextStyle(fontSize: 16)),
              const Icon(Icons.keyboard_arrow_down, color: primaryBlue),
            ],
          ),
        ),
      );
    }

    // --- Android / Material ---
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selected,
          items: widget.items
              .map(
                (value) =>
                    DropdownMenuItem(value: value, child: Text("📌 $value")),
              )
              .toList(),
          onChanged: (v) => setState(() => selected = v!),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
//  APP PRINCIPAL
// ---------------------------------------------------------

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

// ---------------------------------------------------------
//  PANTALLA 1: INICIO
// ---------------------------------------------------------

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
            children: [
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
              AdaptiveButton(
                text: '🚀 Entrar',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/menu');
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
//  PANTALLA 2: MENÚ
// ---------------------------------------------------------

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📋 MENÚ PRINCIPAL')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _MenuItem(
              emoji: "🏠",
              title: 'Home',
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (r) => false);
              },
            ),
            _MenuItem(
              emoji: "👤",
              title: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            _MenuItem(
              emoji: "📝",
              title: 'Tareas',
              onTap: () => Navigator.pushNamed(context, '/tasks'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String emoji;
  final VoidCallback onTap;

  const _MenuItem({
    required this.title,
    required this.emoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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

// ---------------------------------------------------------
//  PANTALLA 3: REGISTRO DE USUARIO
// ---------------------------------------------------------

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
          children: [
            AdaptiveTextField(label: 'Nombre', icon: Icons.person_outline),
            const SizedBox(height: 30),
            AdaptiveTextField(label: 'Ocupación', icon: Icons.work_outline),
            const SizedBox(height: 60),
            AdaptiveButton(
              text: "✅ Continuar",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
//  PANTALLA 4: REGISTRO DE TAREAS
// ---------------------------------------------------------

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
          children: [
            AdaptiveDropdown(
              items: ['Trabajo', 'Personal', 'Estudio'],
              defaultValue: 'Trabajo',
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

// ---------------------------------------------------------
//  ÍTEM DE TAREA
// ---------------------------------------------------------

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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
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
