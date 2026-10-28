import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xekkhzuqmnoxnoybuncz.supabase.co',
    anonKey: 'sb_publishable_fhB6tL6Fi_OUbRLYAMe3ZQ_uIM__-k8',
  );
  runApp(ToofanApp());
}

class ToofanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOOFAN - Connect Communicate Protect',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xFF0A1931)),
      home: SplashScreen(),
    );
  }
}

// 1. SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF0A1931), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.bolt, size: 120, color: Colors.cyanAccent), Text('TOOFAN', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: 2)), Text('Connect • Communicate • Protect', style: TextStyle(color: Colors.white70)) ])));
  }
}

// 2. LOGIN / SIGNUP
class LoginScreen extends StatefulWidget { @override _LoginScreenState createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.bolt, size: 80, color: Colors.cyan), Text('TOOFAN', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        SizedBox(height: 30),
        Row(children: [Expanded(child: ElevatedButton(onPressed: ()=>setState(()=>isLogin=true), child: Text('Login'), style: ElevatedButton.styleFrom(backgroundColor: isLogin?Colors.cyan:Colors.grey))), SizedBox(width:10), Expanded(child: ElevatedButton(onPressed: ()=>setState(()=>isLogin=false), child: Text('Sign Up'), style: ElevatedButton.styleFrom(backgroundColor: !isLogin?Colors.cyan:Colors.grey)))]),
        SizedBox(height: 20),
        TextField(decoration: InputDecoration(hintText: 'Mobile Number / Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: Icon(Icons.person))),
        SizedBox(height: 12),
        TextField(obscureText: true, decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: Icon(Icons.lock))),
        SizedBox(height: 20),
        ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen())), child: Text(isLogin?'Login':'Create New Account', style: TextStyle(fontSize: 16)), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.cyan)),
        if(isLogin) TextButton(onPressed: (){}, child: Text('Forgot Password?')),
      ])),
    );
  }
}

// 3. OTP VERIFICATION
class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Verify Your Account')), body: Padding(padding: EdgeInsets.all(24), child: Column(children: [
      Text('Enter the 6 digit code sent to +92 300 1234567'),
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(6, (i) => Container(width: 45, height: 55, decoration: BoxDecoration(border: Border.all(color: Colors.cyan), borderRadius: BorderRadius.circular(12)), child: Center(child: TextField(textAlign: TextAlign.center, decoration: InputDecoration(border: InputBorder.none)))))),
      SizedBox(height: 10), Text('Resend Code (0:45)', style: TextStyle(color: Colors.cyan)),
      SizedBox(height: 30),
      ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainApp())), child: Text('Verify'), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.cyan)),
    ])));
  }
}

// 4-8 MAIN APP WITH BOTTOM NAV
class MainApp extends StatefulWidget { @override _MainAppState createState() => _MainAppState(); }
class _MainAppState extends State<MainApp> {
  int idx = 0;
  final screens = [HomeScreen(), VideoDashboard(), ExploreScreen(), FamilyDashboard(), SocietyDashboard(), ProfileSettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TOOFAN'), backgroundColor: Color(0xFF112244), actions: [
        IconButton(icon: Icon(Icons.search), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen()))),
        IconButton(icon: Icon(Icons.call), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>VoiceCallScreen()))),
        IconButton(icon: Icon(Icons.videocam), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>VideoCallScreen()))),
      ]),
      body: screens[idx],
      bottomNavigationBar: BottomNavigationBar(currentIndex: idx, onTap: (i)=>setState(()=>idx=i), type: BottomNavigationBarType.fixed, backgroundColor: Color(0xFF112244), selectedItemColor: Colors.cyan, unselectedItemColor: Colors.white54, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family'),
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Society'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ]),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(height: 100, child: ListView(scrollDirection: Axis.horizontal, children: [StoryItem('Your Story', true), StoryItem('Aisha'), StoryItem('Leo'), StoryItem('Mira'), StoryItem('Dev')])),
      Card(color: Color(0xFF1A2A4A), margin: EdgeInsets.all(8), child: Padding(padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(leading: CircleAvatar(child: Text('S')), title: Text('Sara Khan'), subtitle: Text('2 hours ago')),
        Text('Life is better with good people ❤️', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Container(height: 180, color: Colors.black26, child: Center(child: Icon(Icons.image, size: 60))),
        Row(children: [IconButton(icon: Icon(Icons.favorite, color: Colors.red), onPressed: (){}), Text('124'), IconButton(icon: Icon(Icons.comment), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen()))), IconButton(icon: Icon(Icons.share), onPressed: (){})]),
        Row(children: [Expanded(child: ElevatedButton.icon(icon: Icon(Icons.call), label: Text('Call'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>VoiceCallScreen())))), SizedBox(width: 8), Expanded(child: ElevatedButton.icon(icon: Icon(Icons.chat), label: Text('Chat'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen()))))]),
      ]))),
