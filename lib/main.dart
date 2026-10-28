import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xekkhzuqmnoxnoybuncz.supabase.co',
    anonKey: 'sb_publishable_mq5d4H_Jo5w3xlnvB5h2Dw_LQJtJcDM',
  );
  runApp(const ToofanApp());
}

class ToofanApp extends StatelessWidget {
  const ToofanApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOOFAN',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) return const HomePage();
    return const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool loading = false;
  Future<void> login() async {
    setState(() => loading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(email: email.text.trim(), password: pass.text.trim());
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    setState(() => loading = false);
  }
  Future<void> signup() async {
    setState(() => loading = true);
    try {
      await Supabase.instance.client.auth.signUp(email: email.text.trim(), password: pass.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account bana, ab Login karo')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    setState(() => loading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TOOFAN - Login'), backgroundColor: const Color(0xFF1976D2), foregroundColor: Colors.white),
      body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
        TextField(controller: pass, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
        const SizedBox(height: 20),
        loading ? const CircularProgressIndicator() : Row(children: [
          Expanded(child: ElevatedButton(onPressed: login, child: const Text('Login'))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(onPressed: signup, child: const Text('Signup'))),
        ])
      ])),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TOOFAN'), backgroundColor: const Color(0xFF1976D2), foregroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () async { await Supabase.instance.client.auth.signOut(); if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())); })]),
      body: const Center(child: Text('Welcome to TOOFAN 🔥\nApp is working!', textAlign: TextAlign.center, style: TextStyle(fontSize: 22))),
    );
  }
}
