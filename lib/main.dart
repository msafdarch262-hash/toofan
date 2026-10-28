import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xekkhzuqmnoxnoybuncz.supabase.co',
    anonKey: 'sb_publishable_fhB6tL6Fi_OUbRLYAMe3ZQ_uIM__-k8',
  );
  runApp(ToofanApp());
}

final supabase = Supabase.instance.client;

class ToofanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: supabase.auth.currentUser == null ? AuthScreen() : MainScreen(),
    );
  }
}

// ========== REAL LOGIN ==========
class AuthScreen extends StatefulWidget {
  @override _AuthScreenState createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final name = TextEditingController();
  bool isLogin = true;
  bool loading = false;

  Future<void> doAuth() async {
    if(email.text.isEmpty || pass.text.isEmpty) return;
    setState(()=> loading = true);
    try {
      if(isLogin) {
        await supabase.auth.signInWithPassword(email: email.text.trim(), password: pass.text.trim());
      } else {
        await supabase.auth.signUp(email: email.text.trim(), password: pass.text.trim(), data: {'name': name.text.trim()});
        await supabase.from('profiles').insert({'id': supabase.auth.currentUser!.id, 'name': name.text.trim()});
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MainScreen()));
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(()=> loading = false);
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Color(0xFFFF7A1A), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.bolt, color: Colors.white, size: 32)),
              SizedBox(height: 12),
              Text('TOOFAN', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 1)),
              Text('Connect • Share • Toofan Machao', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 28),
              if(!isLogin) TextField(controller: name, decoration: InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
              if(!isLogin) SizedBox(height: 12),
              TextField(controller: email, decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
              SizedBox(height: 12),
              TextField(controller: pass, obscureText: true, decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
              SizedBox(height: 20),
              loading ? CircularProgressIndicator(color: Color(0xFFFF7A1A)) : SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: doAuth, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF7A1A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: Text(isLogin ? 'LOGIN' : 'CREATE ACCOUNT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)))),
              SizedBox(height: 12),
              TextButton(onPressed: ()=> setState(()=> isLogin = !isLogin), child: Text(isLogin ? 'Naya account? Sign Up' : 'Account hai? Login', style: TextStyle(color: Color(0xFF2D6BFF)))),
            ]),
          ),
        ),
      ),
    );
  }
}

// ========== MAIN APP WITH YOUR DESIGN ==========
class MainScreen extends StatefulWidget {
  @override _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int idx = 0;
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      body: idx == 0 ? HomeReal() : Center(child: Text('${['Video','Explore','Family','Society','Profile'][idx-1]} Page Coming Soon', style: TextStyle(fontWeight: FontWeight.bold))),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _nav(Icons.home_filled, 'Home', 0),
          _nav(Icons.play_circle_fill, 'Video', 1),
          _nav(Icons.explore, 'Explore', 2),
          _nav(Icons.groups, 'Family', 3),
          _nav(Icons.apartment, 'Society', 4),
          _nav(Icons.person, 'Profile', 5),
        ]),
      ),
    );
  }
  Widget _nav(IconData ic, String label, int i) {
    bool active = idx == i;
    return GestureDetector(onTap: ()=> setState(()=> idx = i), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(ic, color: active ? Color(0xFFFF7A1A) : Colors.grey, size: 24),
      SizedBox(height: 2),
      Text(label, style: TextStyle(fontSize: 10, fontWeight: active ? FontWeight.bold : FontWeight.normal, color: active ? Color(0xFFFF7A1A) : Colors.grey)),
    ]));
  }
}

class HomeReal extends StatefulWidget {
  @override _HomeRealState createState() => _HomeRealState();
}
class _HomeRealState extends State<HomeReal> {
  final postCtrl = TextEditingController();
  List<dynamic> posts = [];
  bool loadingPosts = true;

  @override void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    setState(()=> loadingPosts = true);
    try {
      final res = await supabase.from('posts').select().order('created_at', ascending: false).limit(50);
      setState(()=> posts = res);
    } catch(e) {}
    setState(()=> loadingPosts = false);
  }

  Future<void> addPost() async {
    if(postCtrl.text.trim().isEmpty) return;
    final user = supabase.auth.currentUser;
    String userName = user?.userMetadata?['name'] ?? user?.email?.split('@')[0] ?? 'User';
    await supabase.from('posts').insert({'user_id': user!.id, 'user_name': userName, 'content': postCtrl.text.trim()});
    postCtrl.clear();
    loadPosts();
  }

  @override Widget build(BuildContext context) {
    return SafeArea(child: ListView(children: [
      // HEADER - EXACT YOUR DESIGN
      Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Color(0xFFFF7A1A), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.bolt, color: Colors.white, size: 20)),
          SizedBox(width: 8),
          Text('TOOFAN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          Spacer(),
          Icon(Icons.call, color: Color(0xFF2D6BFF), size: 22),
          SizedBox(width: 12),
          Icon(Icons.videocam, color: Color(0xFF2D6BFF), size: 22),
          SizedBox(width: 12),
          Icon(Icons.search, color: Color(0xFF2D6BFF), size: 22),
          SizedBox(width: 12),
          GestureDetector(onTap: () async { await supabase.auth.signOut(); Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> AuthScreen())); }, child: Icon(Icons.logout, color: Colors.grey, size: 20)),
        ]),
      ),
      // STORIES
      Container(height: 110, child: ListView(scrollDirection: Axis.horizontal, padding: EdgeInsets.symmetric(horizontal: 12), children: [
        _storyItem('Your Story', 'https://i.pravatar.cc/150?img=12', true),
        _storyItem('Aisha', 'https://i.pravatar.cc/150?img=5', false),
        _storyItem('Rahul', 'https://i.pravatar.cc/150?img=8', false),
        _storyItem('Maya', 'https://i.pravatar.cc/150?img=9', false),
        _storyItem('Dev', 'https://i.pravatar.cc/150?img=15', false),
        _storyItem('Sara', 'https://i.pravatar.cc/150?img=32', false),
      ])),
      // WHAT'S HAPPENING BOX
      Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("What's happening?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 12),
          Row(children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12')),
            SizedBox(width: 10),
            Expanded(child: TextField(controller: postCtrl, decoration: InputDecoration(hintText: "What's happening?", filled: true, fillColor: Color(0xFFF2F4F7), contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none)))),
          ]),
          SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: ElevatedButton(onPressed: addPost, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2D6BFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: Text('Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
        ]),
      ),
      // POSTS
      if(loadingPosts) Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(color: Color(0xFFFF7A1A)))),
      ...posts.map((p) => _postCard(p)).toList(),
      // DEFAULT POST IF EMPTY - YOUR DESIGN
      if(!loadingPosts && posts.isEmpty) _defaultPost(),
      SizedBox(height: 100),
    ]));
  }

  Widget _postCard(dynamic p) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 20, backgroundColor: Color(0xFFF2F4F7), child: Text((p['user_name']??'U')[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p['user_name']??'User', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Society • Public • ${DateTime.now().difference(DateTime.parse(p['created_at'])).inMinutes}m ago', style: TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
          Spacer(), Icon(Icons.more_horiz, color: Colors.grey),
        ]),
        SizedBox(height: 12),
        Text(p['content'], style: TextStyle(fontSize: 15, height: 1.4)),
        SizedBox(height: 12),
        Row(children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: Color(0xFFFF7A1A), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.call, size: 16, color: Colors.white), SizedBox(width: 5), Text('Call', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))])),
          SizedBox(width: 8),
          Container(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: Color(0xFFFF7A1A), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.chat_bubble, size: 16, color: Colors.white), SizedBox(width: 5), Text('Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))])),
          Spacer(),
          Icon(Icons.favorite_border, color: Color(0xFF2D6BFF), size: 20),
          SizedBox(width: 4),
          Text('${p['likes']??0}', style: TextStyle(color: Colors.grey, fontSize: 13)),
          SizedBox(width: 12),
          Icon(Icons.share_outlined, color: Color(0xFF2D6BFF), size: 20),
          SizedBox(width: 4),
          Text('Share', style: TextStyle(color: Colors.grey, fontSize: 13)),
        ]),
      ]),
    );
  }

  Widget _defaultPost() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 20, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Sara Khan', style: TextStyle(fontWeight: FontWeight.bold)), Text('Society • Public • 12m ago', style: TextStyle(fontSize: 11, color: Colors.grey))]),
          Spacer(), Icon(Icons.more_horiz, color: Colors.grey),
        ]),
        SizedBox(height: 12),
        Text('Community Cleanup — Join us this weekend!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 6),
        Text("Let's come together to clean the park and plant new trees. Volunteers needed — snacks & water provided 🌳", style: TextStyle(color: Colors.black87, height: 1.3)),
        SizedBox(height: 12),
        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://images.unsplash.com/photo-1593113598332-cd288d649433?w=600', height: 180, width: double.infinity, fit: BoxFit.cover)),
        SizedBox(height: 12),
        Row(children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: Color(0xFFFF7A1A), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.call, size: 16, color: Colors.white), SizedBox(width: 5), Text('Call', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))])),
          SizedBox(width: 8),
          Container(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: Color(0xFFFF7A1A), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.chat_bubble, size: 16, color: Colors.white), SizedBox(width: 5), Text('Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))])),
          Spacer(), Icon(Icons.favorite, color: Color(0xFF2D6BFF), size: 20), SizedBox(width: 4), Text('24', style: TextStyle(color: Colors.grey, fontSize: 13)), SizedBox(width: 12), Icon(Icons.share_outlined, color: Color(0xFF2D6BFF), size: 20), SizedBox(width: 4), Text('Share', style: TextStyle(color: Colors.grey, fontSize: 13)),
        ]),
      ]),
    );
  }

  Widget _storyItem(String name, String img, bool isMe) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Column(children: [
      Stack(children: [
        Container(padding: EdgeInsets.all(3), decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFF2D6BFF), Color(0xFFFF7A1A)])), child: Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: CircleAvatar(radius: 28, backgroundImage: NetworkImage(img))))),
        if(isMe) Positioned(bottom: 0, right: 0, child: Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Color(0xFF2D6BFF), shape: BoxShape.circle), child: Icon(Icons.add, color: Colors.white, size: 14))),
      ]),
      SizedBox(height: 4),
      Text(name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
    ]));
  }
}
