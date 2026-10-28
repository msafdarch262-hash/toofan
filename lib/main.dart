import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xekkhzuqmnoxnoybuncz.supabase.co',
    anonKey: 'sb_publishable_fhB6tL6Fi_OUbRLYAMe3ZQ_Rc3E3j-I',
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
      theme: ThemeData(primarySwatch: Colors.orange),
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

  Future<void> signUp() async {
    setState(() => loading = true);
    try {
      await Supabase.instance.client.auth.signUp(email: email.text, password: pass.text);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account ban gaya! Login karo')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => loading = false);
  }

  Future<void> signIn() async {
    setState(() => loading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(email: email.text, password: pass.text);
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt, size: 80, color: Colors.orange),
            const Text('TOOFAN', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(controller: email, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            if (loading) const CircularProgressIndicator() else Column(
              children: [
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: signIn, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text('LOGIN'))),
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: signUp, child: const Text('SIGN UP'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List posts = [];
  final postCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final data = await supabase.from('posts').select().order('created_at', ascending: false);
    setState(() => posts = data);
  }

  Future<void> addPost() async {
    if (postCtrl.text.isEmpty) return;
    await supabase.from('posts').insert({'content': postCtrl.text, 'user_id': supabase.auth.currentUser!.id});
    postCtrl.clear();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOOFAN - Real Public'),
        backgroundColor: Colors.orange,
        actions: [IconButton(onPressed: () async { await supabase.auth.signOut(); if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())); }, icon: const Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: TextField(controller: postCtrl, decoration: const InputDecoration(hintText: 'Kya chal raha hai?', border: OutlineInputBorder()))),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: addPost, child: const Text('Post')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, i) {
                final p = posts[i];
                return Card(margin: const EdgeInsets.all(8), child: ListTile(title: Text(p['content'] ?? ''), subtitle: Text(p['created_at'].toString())));
              },
            ),
          ),
        ],
      ),
    );
  }
}
