// TOOFAN - FULL APP WITH ALL 12 POINTS + 3D T ICON PURE CODE
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

// PURE CODE T LOGO - Blue-Purple Gradient like your 3D icon
class TLogo extends StatelessWidget {
  final double size;
  const TLogo({super.key, this.size = 40});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF7C4DFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: size * 0.15, offset: Offset(0, size * 0.1))],
      ),
      child: Center(
        child: Text("T", style: TextStyle(fontSize: size * 0.6, fontWeight: FontWeight.w900, color: Colors.white, shadows: [Shadow(blurRadius: 8, color: Colors.black26)])),
      ),
    );
  }
}

class ToofanApp extends StatelessWidget {
  const ToofanApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOOFAN',
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: Color(0xFFF5F7FB)),
      home: const SplashScreen(),
    );
  }
}

// 1. SPLASH - TOOFAN Logo 2 sec
class SplashScreen extends StatefulWidget { const SplashScreen({super.key}); @override State<SplashScreen> createState() => _SplashState(); }
class _SplashState extends State<SplashScreen> {
  @override
  void initState() { super.initState(); Future.delayed(Duration(seconds: 2), () { if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthGate())); }); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D47A1),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TLogo(size: 110),
          SizedBox(height: 20),
          Text("TOOFAN", style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 4)),
          Text("⚡", style: TextStyle(fontSize: 30)),
          SizedBox(height: 30),
          CircularProgressIndicator(color: Colors.white),
        ]),
      ),
    );
  }
}

class AuthGate extends StatelessWidget { const AuthGate({super.key}); @override Widget build(BuildContext context) { final s = Supabase.instance.client.auth.currentSession; if (s != null) return const MainShell(); return const LoginSignupScreen(); } }

// 2. LOGIN / SIGNUP - Mobile/Email + Password + Forgot
class LoginSignupScreen extends StatefulWidget { const LoginSignupScreen({super.key}); @override State<LoginSignupScreen> createState() => _LState(); }
class _LState extends State<LoginSignupScreen> {
  bool isLogin = true;
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool load = false;
  Future<void> submit() async {
    setState(() => load = true);
    try {
      if (isLogin) {
        await Supabase.instance.client.auth.signInWithPassword(email: emailC.text.trim(), password: passC.text.trim());
      } else {
        await Supabase.instance.client.auth.signUp(email: emailC.text.trim(), password: passC.text.trim());
      }
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    setState(() => load = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 50),
          Center(child: TLogo(size: 80)),
          SizedBox(height: 12),
          Center(child: Text("TOOFAN ⚡", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Color(0xFF0D47A1)))),
          SizedBox(height: 6),
          Center(child: Text(isLogin ? "Welcome Back" : "Create New Account", style: TextStyle(color: Colors.grey))),
          SizedBox(height: 36),
          TextField(controller: emailC, decoration: InputDecoration(labelText: "Mobile Number / Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: Icon(Icons.person))),
          SizedBox(height: 16),
          TextField(controller: passC, obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: Icon(Icons.lock))),
          Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: Text("Forgot Password"))),
          SizedBox(height: 10),
          load ? Center(child: CircularProgressIndicator()) : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D47A1), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: submit, child: Text(isLogin ? "Login" : "Create New Account", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          SizedBox(height: 16),
          OutlinedButton(onPressed: () => setState(() => isLogin = !isLogin), child: Text(isLogin ? "Create New Account" : "Already have account? Login")),
        ]),
      ),
    );
  }
}

// 3. MAIN SHELL - TOP BAR + BOTTOM BAR
class MainShell extends StatefulWidget { const MainShell({super.key}); @override State<MainShell> createState() => _MShell(); }
class _MShell extends State<MainShell> {
  int idx = 0;
  final pages = [const HomeDashboard(), const VideoDashboard(), const ExploreDashboard(), const FamilyDashboard(), const SocietyDashboard()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(children: [TLogo(size: 32), SizedBox(width: 8), Text("TOOFAN ⚡", style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0D47A1), fontSize: 20))]),
        actions: [
          IconButton(icon: Icon(Icons.phone, color: Colors.black87), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceCallScreen(name: "Aisha")))),
          IconButton(icon: Icon(Icons.videocam, color: Colors.black87), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoCallScreen(name: "Aisha")))),
          IconButton(icon: Icon(Icons.search, color: Colors.black87), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()))),
          IconButton(icon: Icon(Icons.chat_bubble, color: Colors.black87), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatListScreen()))),
          Stack(children: [IconButton(icon: Icon(Icons.notifications, color: Colors.black87), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()))), Positioned(right: 6, top: 6, child: Container(padding: EdgeInsets.all(3), decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Text("1", style: TextStyle(fontSize: 10, color: Colors.white))))]),
          GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())), child: Padding(padding: EdgeInsets.only(right: 12, left: 4), child: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=32")))),
        ],
      ),
      body: pages[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (i) { if (i == 5) { Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())); } else { setState(() => idx = i); } },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: "VIDEO"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "EXPLORE"),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: "FAMILY"),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "SOCIETY"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        ],
      ),
    );
  }
}

// 4. HOME - Stories + What's happening + Feed
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(12), children: [
      SizedBox(height: 90, child: ListView(scrollDirection: Axis.horizontal, children: [_story("Your Story", "https://i.pravatar.cc/150?img=1", true), _story("Aisha", "https://i.pravatar.cc/150?img=5", false), _story("Leo", "https://i.pravatar.cc/150?img=8", false), _story("Mira", "https://i.pravatar.cc/150?img=9", false), _story("Dev", "https://i.pravatar.cc/150?img=12", false), _story("Sara", "https://i.pravatar.cc/150?img=32", false)])),
      Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), child: Padding(padding: EdgeInsets.all(12), child: Column(children: [TextField(decoration: InputDecoration(hintText: "What's happening?", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=1")))), SizedBox(height: 8), Row(children: [Icon(Icons.photo, color: Colors.green), Text(" Photo "), SizedBox(width: 10), Icon(Icons.emoji_emotions, color: Colors.orange), Text(" Emoji "), SizedBox(width: 10), Icon(Icons.location_on, color: Colors.red), Text(" Location "), Spacer(), ElevatedButton(onPressed: () {}, child: Text("Post"))])]))),
      SizedBox(height: 10),
      _postCard(name: "Sara Khan", img: "https://picsum.photos/500/300?1", avatar: "https://i.pravatar.cc/150?img=32", likes: "124", comments: "18"),
      _postCard(name: "Leo Martin", img: "https://picsum.photos/500/300?2", avatar: "https://i.pravatar.cc/150?img=8", likes: "89", comments: "12", isVideo: true),
    ]);
  }
  static Widget _story(String name, String url, bool isMe) { return Padding(padding: EdgeInsets.only(right: 12), child: Column(children: [Stack(children: [CircleAvatar(radius: 30, backgroundColor: Colors.blue, child: CircleAvatar(radius: 28, backgroundImage: NetworkImage(url))), if (isMe) Positioned(bottom: 0, right: 0, child: Container(decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: Icon(Icons.add, size: 16, color: Colors.white))) ]), SizedBox(height: 4), Text(name, style: TextStyle(fontSize: 12)) ])); }
  static Widget _postCard({required String name, required String img, required String avatar, required String likes, required String comments, bool isVideo = false}) { return Card(margin: EdgeInsets.only(bottom: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(avatar)), title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text("2 hours ago"), trailing: Row(mainAxisSize: MainAxisSize.min, children: [ElevatedButton.icon(icon: Icon(Icons.phone, size: 16), label: Text("Call"), onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(10, 30))), SizedBox(width: 4), ElevatedButton.icon(icon: Icon(Icons.chat, size: 16), label: Text("Chat"), onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(10, 30)))] )), Stack(children: [Image.network(img, width: double.infinity, height: 200, fit: BoxFit.cover), if (isVideo) Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white70))]), Padding(padding: EdgeInsets.all(10), child: Row(children: [Icon(Icons.favorite, color: Colors.red), Text(" $likes "), SizedBox(width: 10), Icon(Icons.comment), Text(" $comments "), SizedBox(width: 10), Icon(Icons.share), Text(" Share")]))])); }
}

// 5. VIDEO - TikTok Style Full Screen + Swipe Up
class VideoDashboard extends StatelessWidget { const VideoDashboard({super.key}); @override Widget build(BuildContext context) { return PageView.builder(itemCount: 5, scrollDirection: Axis.vertical, itemBuilder: (_, i) { return Stack(children: [Container(color: Colors.black, child: Center(child: Image.network("https://picsum.photos/400/800?${i + 10}", fit: BoxFit.cover, width: double.infinity))), Positioned(top: 10, left: 10, child: Row(children: [IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () {}), TLogo(size: 28), SizedBox(width: 6), Text("TOOFAN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])), Positioned(right: 10, bottom: 120, child: Column(children: [_sideIcon(Icons.favorite, "1.2K"), _sideIcon(Icons.comment, "348"), _sideIcon(Icons.share, "89"), _sideIcon(Icons.bookmark, "24"), SizedBox(height: 20), CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"))])), Positioned(left: 12, bottom: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text("@user${i + 1}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), SizedBox(width: 8), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(4)), child: Text("Follow", style: TextStyle(color: Colors.white, fontSize: 12)))]), SizedBox(height: 4), Text("This is my TOOFAN video caption 🔥 #viral", style: TextStyle(color: Colors.white)), Text("🎵 Original Music - TOOFAN Beats", style: TextStyle(color: Colors.white70, fontSize: 12))]))]); }); } static Widget _sideIcon(IconData ic, String txt) { return Padding(padding: EdgeInsets.only(bottom: 16), child: Column(children: [Icon(ic, color: Colors.white, size: 32), Text(txt, style: TextStyle(color: Colors.white, fontSize: 12))])); } }

// 6. EXPLORE - Naye Log / Trending
class ExploreDashboard extends StatelessWidget { const ExploreDashboard({super.key}); @override Widget build(BuildContext context) { return GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8), itemCount: 10, itemBuilder: (_, i) => Card(child: Column(children: [Expanded(child: Image.network("https://picsum.photos/200/200?${i + 20}", fit: BoxFit.cover, width: double.infinity)), ListTile(title: Text("User ${i + 1}"), subtitle: Text("Trending in TOOFAN"), trailing: ElevatedButton(onPressed: () {}, child: Text("Follow")))]))); } }

// 7. FAMILY - Members + Map + Emergency
class FamilyDashboard extends StatelessWidget { const FamilyDashboard({super.key}); @override Widget build(BuildContext context) { return ListView(padding: EdgeInsets.all(12), children: [Text("Family Members List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), _familyTile("Mom", "Safe At Home", "https://i.pravatar.cc/150?img=26"), _familyTile("Dad", "Safe At Home", "https://i.pravatar.cc/150?img=15"), _familyTile("Sister", "At School", "https://i.pravatar.cc/150?img=32"), ElevatedButton.icon(icon: Icon(Icons.add), label: Text("Add Member [+]"), onPressed: () {}), SizedBox(height: 16), Text("Location Map (Family Kahan Hai)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Container(height: 180, decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(16)), child: Center(child: Icon(Icons.location_on, size: 40, color: Colors.red))), SizedBox(height: 20), SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 16)), onPressed: () {}, child: Text("🚨 Emergency Help Button (Red)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),]); } static Widget _familyTile(String name, String status, String avatar) { return Card(child: ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(avatar)), title: Text(name), subtitle: Text(status, style: TextStyle(color: Colors.green)), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: Icon(Icons.phone, color: Colors.blue), onPressed: () {}), IconButton(icon: Icon(Icons.videocam, color: Colors.green), onPressed: () {}), IconButton(icon: Icon(Icons.chat, color: Colors.orange), onPressed: () {})]))); } }

// 8. SOCIETY - Safety + Members + Events
class SocietyDashboard extends StatelessWidget { const SocietyDashboard({super.key}); @override Widget build(BuildContext context) { return ListView(padding: EdgeInsets.all(12), children: [Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red)), child: Row(children: [Icon(Icons.warning, color: Colors.red), SizedBox(width: 8), Text("Safety Alert (Upar Red)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))])), SizedBox(height: 10), Row(children: [Expanded(child: Card(child: Padding(padding: EdgeInsets.all(12), child: Column(children: [Text("128", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text("Active Members")])))), Expanded(child: Card(child: Padding(padding: EdgeInsets.all(12), child: Column(children: [Text("Events", style: TextStyle(fontWeight: FontWeight.bold)), Text("Cleanup Drive, Football Match")]))))]), SizedBox(height: 10), Text("Community Posts + Create New Post Button", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Card(child: Padding(padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Ali Khan: Today we cleaned society park! Great job team."), SizedBox(height: 8), Row(children: [Icon(Icons.favorite_border, size: 16), Text(" 24  "), Icon(Icons.comment, size: 16), Text(" 5")])]))), ElevatedButton(onPressed: () {}, child: Text("+ Create New Post"))]); } }

// 9. PROFILE - All Settings + Owner Authority + Full Security
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Profile / Settings"), backgroundColor: Colors.white), body: ListView(children: [SizedBox(height: 20), Center(child: TLogo(size: 80)), SizedBox(height: 10), Center(child: Text("Sara Khan", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))), Center(child: Text("Bio: TOOFAN Lover ⚡ | Privacy Lover", style: TextStyle(color: Colors.grey))), Divider(height: 30), _setting(Icons.person, "My Profile (Photo, Name, Bio)"), _setting(Icons.lock, "Privacy (Kaun Dekh Sakta Hai)"), _setting(Icons.security, "Password / Security - Full security and privacy"), _setting(Icons.family_restroom, "Family Settings"), _setting(Icons.face, "Hijab Settings (ON/OFF, Styles)"), _setting(Icons.call, "Call Settings (Voice/Video Quality)"), _setting(Icons.chat, "Chat Settings"), _setting(Icons.video_settings, "Video Settings"), _setting(Icons.notifications, "Notification Settings"), _setting(Icons.admin_panel_settings, "For Owner authority - Admin Panel"), _setting(Icons.help, "Help & Support"), ListTile(leading: Icon(Icons.logout, color: Colors.red), title: Text("Logout", style: TextStyle(color: Colors.red)), onTap: () async { await Supabase.instance.client.auth.signOut(); if (context.mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginSignupScreen()), (_) => false); }),])); } static Widget _setting(IconData ic, String title) { return ListTile(leading: Icon(ic), title: Text(title), trailing: Icon(Icons.arrow_forward_ios, size: 14), onTap: () {}); } }

// 10. CHAT - Text + Voice + Photo
class ChatListScreen extends StatelessWidget { const ChatListScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Chats 💬")), body: ListView(children: [_chatTile(context, "Aisha", "https://i.pravatar.cc/150?img=5"), _chatTile(context, "Leo", "https://i.pravatar.cc/150?img=8"), _chatTile(context, "Sara Khan", "https://i.pravatar.cc/150?img=32")]), floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add_comment))); } static Widget _chatTile(BuildContext ctx, String name, String av) { return ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(av)), title: Text(name), subtitle: Text("Hi, TOOFAN me dekha..."), trailing: Text("2m"), onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => ChatDetailScreen(name: name, avatar: av)))); } }
class ChatDetailScreen extends StatelessWidget { final String name; final String avatar; const ChatDetailScreen({super.key, required this.name, required this.avatar}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text(name), actions: [IconButton(icon: Icon(Icons.phone), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VoiceCallScreen(name: name)))), IconButton(icon: Icon(Icons.videocam), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoCallScreen(name: name))))]), body: Column(children: [Expanded(child: ListView(padding: EdgeInsets.all(12), children: [Align(alignment: Alignment.centerLeft, child: Card(child: Padding(padding: EdgeInsets.all(10), child: Text("Salam! TOOFAN kaisa lag raha?")))), Align(alignment: Alignment.centerRight, child: Card(color: Color(0xFF0D47A1), child: Padding(padding: EdgeInsets.all(10), child: Text("Walaikum Salam! Bohat acha 🔥", style: TextStyle(color: Colors.white)))))])), Padding(padding: EdgeInsets.all(8), child: Row(children: [IconButton(icon: Icon(Icons.mic), onPressed: () {}), Expanded(child: TextField(decoration: InputDecoration(hintText: "Text Message | Voice 🎤 | Photo/Video", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))))), IconButton(icon: Icon(Icons.photo), onPressed: () {}), IconButton(icon: Icon(Icons.send, color: Color(0xFF0D47A1)), onPressed: () {})]))])); } }

// 11. CALL SCREENS
class VoiceCallScreen extends StatelessWidget { final String name; const VoiceCallScreen({super.key, required this.name}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Color(0xFF0D47A1), body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Spacer(), CircleAvatar(radius: 70, backgroundImage: NetworkImage("https://i.pravatar.cc/300?img=5")), SizedBox(height: 20), Text(name, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)), Text("Calling...", style: TextStyle(color: Colors.white70)), Spacer(), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_callBtn(Icons.mic_off, "Mute"), _callBtn(Icons.volume_up, "Speaker"), _callBtn(Icons.call_end, "End", isEnd: true)]), SizedBox(height: 40)])); } static Widget _callBtn(IconData ic, String txt, {bool isEnd = false}) { return Column(children: [CircleAvatar(radius: 30, backgroundColor: isEnd ? Colors.red : Colors.white24, child: Icon(ic, color: Colors.white)), SizedBox(height: 6), Text(txt, style: TextStyle(color: Colors.white, fontSize: 12))]); } }
class VideoCallScreen extends StatelessWidget { final String name; const VideoCallScreen({super.key, required this.name}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Colors.black, body: Stack(children: [Image.network("https://picsum.photos/400/800?100", fit: BoxFit.cover, width: double.infinity, height: double.infinity), Positioned(top: 40, left: 16, child: Text(name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))), Positioned(bottom: 30, left: 0, right: 0, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_vBtn(Icons.mic_off), _vBtn(Icons.videocam_off), _vBtn(Icons.chat), _vBtn(Icons.call_end, isEnd: true)])), Positioned(top: 40, right: 16, child: Container(width: 100, height: 140, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: NetworkImage("https://i.pravatar.cc/150?img=1"), fit: BoxFit.cover), border: Border.all(color: Colors.white, width: 2))))])); } static Widget _vBtn(IconData ic, {bool isEnd = false}) { return CircleAvatar(radius: 28, backgroundColor: isEnd ? Colors.red : Colors.black54, child: Icon(ic, color: Colors.white)); } }

class SearchScreen extends StatelessWidget { const SearchScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: TextField(decoration: InputDecoration(hintText: "Search in TOOFAN...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), prefixIcon: Icon(Icons.search), contentPadding: EdgeInsets.symmetric(horizontal: 12)))), body: ListView(children: [ListTile(leading: Icon(Icons.trending_up), title: Text("Trending: #TOOFANChallenge")), ListTile(leading: Icon(Icons.person), title: Text("Sara Khan - 1.2K followers"))])); } }
class NotificationScreen extends StatelessWidget { const NotificationScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Notifications (1)")), body: ListView(children: [ListTile(leading: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5")), title: Text("Aisha liked your post"), subtitle: Text("2 minutes ago"), trailing: Icon(Icons.favorite, color: Colors.red)) ])); } }
