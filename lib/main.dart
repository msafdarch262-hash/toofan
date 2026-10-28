import 'package:flutter/material.dart';
import 'dart:async';

void main() { runApp(const ToofanApp()); }

class ToofanApp extends StatelessWidget {
  const ToofanApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOOFAN',
      theme: ThemeData(primaryColor: const Color(0xFF6A5AE0), scaffoldBackgroundColor: Colors.black),
      home: const SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget { const SplashScreen({super.key}); @override State<SplashScreen> createState()=>_SplashScreenState(); }
class _SplashScreenState extends State<SplashScreen> {
  @override void initState(){ super.initState(); Timer(const Duration(seconds:2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>const LoginScreen()))); }
  @override Widget build(BuildContext context){
    return Scaffold(body: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6A5AE0), Color(0xFF00C6FF)])), child: Center(child: Container(width:140,height:140,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35)), child: const Center(child: Text("T", style: TextStyle(fontSize:90, fontWeight:FontWeight.w900, color: Color(0xFF6A5AE0))))))));
  }
}
class LoginScreen extends StatelessWidget { const LoginScreen({super.key}); @override Widget build(BuildContext context){
  return Scaffold(body: Container(padding: const EdgeInsets.all(25), decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1A1A2E), Color(0xFF16213E)])), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text("TOOFAN", style: TextStyle(color: Colors.white, fontSize:42, fontWeight:FontWeight.w900)), const Text("Toofani Logon Ka Adda", style: TextStyle(color: Colors.white70)), const SizedBox(height:50),
    TextField(decoration: InputDecoration(hintText: "Email", filled:true, fillColor: Colors.white12, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
    const SizedBox(height:15),
    TextField(obscureText:true, decoration: InputDecoration(hintText: "Password", filled:true, fillColor: Colors.white12, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
    const SizedBox(height:25),
    SizedBox(width: double.infinity, height:55, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF6A5AE0)), onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>const MainApp())); }, child: const Text("LOGIN / SIGNUP"))),
  ])));
}}
class MainApp extends StatefulWidget { const MainApp({super.key}); @override State<MainApp> createState()=>_MainAppState(); }
class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  int bottomIndex=0; late TabController topController; final topTabs=["For You","Family","Society","Trending","Live"];
  final bottomPages=[const FeedPage(), const FamilyPage(), const SocietyPage(), const ToofanPage(), const InboxPage(), const ProfilePage()];
  @override void initState(){ super.initState(); topController=TabController(length:5, vsync:this); }
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: bottomIndex==0 ? AppBar(backgroundColor: Colors.black, title: const Text("TOOFAN", style: TextStyle(fontWeight:FontWeight.w900)), bottom: TabBar(controller: topController, isScrollable:true, indicatorColor: Color(0xFF6A5AE0), tabs: topTabs.map((e)=>Tab(text:e)).toList())) : AppBar(backgroundColor: Colors.black, title: Text(["Home","Family","Society","Toofan","Inbox","Profile"][bottomIndex])),
      body: bottomIndex==0 ? TabBarView(controller: topController, children: List.generate(5, (_)=>const FeedPage())) : bottomPages[bottomIndex],
      bottomNavigationBar: BottomNavigationBar(currentIndex:bottomIndex, onTap:(i)=>setState(()=>bottomIndex=i), type:BottomNavigationBarType.fixed, backgroundColor: Colors.black, selectedItemColor: Color(0xFF6A5AE0), unselectedItemColor: Colors.white54,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"), BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label:"Family"), BottomNavigationBarItem(icon: Icon(Icons.groups), label:"Society"), BottomNavigationBarItem(icon: Icon(Icons.bolt), label:"Toofan"), BottomNavigationBarItem(icon: Icon(Icons.inbox), label:"Inbox"), BottomNavigationBarItem(icon: Icon(Icons.person), label:"Profile")]),
    );
  }
}
class FeedPage extends StatelessWidget { const FeedPage({super.key}); @override Widget build(BuildContext context){
  return PageView.builder(scrollDirection: Axis.vertical, itemCount:10, itemBuilder:(c,i){
    return Stack(fit: StackFit.expand, children: [
      Container(color: [Colors.black, const Color(0xFF1A1A2E), const Color(0xFF16213E)][i%3]),
      Positioned(bottom:20, left:15, right:80, child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [Text("@user_$i", style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold)), Text("TOOFAN video #${i+1} - Point 5/6 TikTok vertical feed", style: TextStyle(color: Colors.white70))])),
      Positioned(right:10, bottom:30, child: Column(children: [Icon(Icons.favorite, color: Colors.white, size:32), Text("${(i+1)*12}K", style: TextStyle(color: Colors.white, fontSize:12)), SizedBox(height:15), Icon(Icons.comment, color: Colors.white, size:32), SizedBox(height:15), GestureDetector(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>ChatPage(name:"user_$i"))), child: CircleAvatar(backgroundColor: Color(0xFF6A5AE0), child: Icon(Icons.person, color: Colors.white)))])),
    ]);
  });
}}
class FamilyPage extends StatelessWidget { const FamilyPage({super.key}); @override Widget build(BuildContext context){ return ListView(padding: EdgeInsets.all(15), children: [Card(color: Colors.white12, child: ListTile(leading: CircleAvatar(child: Text("F")), title: Text("Family Group", style: TextStyle(color: Colors.white)), subtitle: Text("12 members - Point 7", style: TextStyle(color: Colors.white54)))), Card(color: Colors.white12, child: ListTile(leading: CircleAvatar(child: Text("M")), title: Text("Mom", style: TextStyle(color: Colors.white)), subtitle: Text("Online", style: TextStyle(color: Colors.green))))]); }}
class SocietyPage extends StatelessWidget { const SocietyPage({super.key}); @override Widget build(BuildContext context){ return ListView(padding: EdgeInsets.all(15), children: [Card(color: Colors.white12, child: ListTile(title: Text("Lahore Society", style: TextStyle(color: Colors.white)), subtitle: Text("5.2K members - Point 8", style: TextStyle(color: Colors.white54))))]); }}
class ToofanPage extends StatelessWidget { const ToofanPage({super.key}); @override Widget build(BuildContext context){ return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.bolt, size:100, color: Color(0xFF6A5AE0)), Text("TOOFAN Challenges - Point 9", style: TextStyle(color: Colors.white, fontSize:20)), ElevatedButton(onPressed: (){}, child: Text("Upload Toofan Video"))])); }}
class InboxPage extends StatelessWidget { const InboxPage({super.key}); @override Widget build(BuildContext context){ return ListView.builder(itemCount:8, itemBuilder:(c,i){ return ListTile(leading: CircleAvatar(child: Text("U$i")), title: Text("User $i", style: TextStyle(color: Colors.white)), subtitle: Text("Last message - Point 10 Chat/Call", style: TextStyle(color: Colors.white54)), onTap: (){ Navigator.push(c, MaterialPageRoute(builder:(_)=>ChatPage(name:"User $i"))); }); }); }}
class ChatPage extends StatelessWidget { final String name; const ChatPage({super.key, required this.name}); @override Widget build(BuildContext context){ return Scaffold(appBar: AppBar(title: Text(name), backgroundColor: Colors.black, actions: [IconButton(icon: Icon(Icons.call), onPressed: (){}), IconButton(icon: Icon(Icons.videocam), onPressed: (){})]), body: Column(children: [Expanded(child: Center(child: Text("Chat with $name - Point 10 Done", style: TextStyle(color: Colors.white)))), Padding(padding: EdgeInsets.all(10), child: Row(children: [Expanded(child: TextField(decoration: InputDecoration(hintText: "Message...", filled:true, fillColor: Colors.white12, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))))), IconButton(icon: Icon(Icons.send, color: Color(0xFF6A5AE0)), onPressed: (){})]))])); }}
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context){ return ListView(padding: EdgeInsets.all(20), children: [Center(child: CircleAvatar(radius:50, backgroundColor: Color(0xFF6A5AE0), child: Text("T", style: TextStyle(fontSize:40, color: Colors.white)))), SizedBox(height:15), Center(child: Text("MSAF DARCH - Owner", style: TextStyle(color: Colors.white, fontSize:22, fontWeight:FontWeight.bold))), Center(child: Text("Verified Owner - Point 11", style: TextStyle(color: Colors.green))), SizedBox(height:20), Card(color: Colors.white12, child: ListTile(leading: Icon(Icons.security, color: Colors.white), title: Text("Security & Privacy - Point 12", style: TextStyle(color: Colors.white)), subtitle: Text("2FA, Block, Report", style: TextStyle(color: Colors.white54))))]); }}
