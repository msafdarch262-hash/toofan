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
      title: 'TOOFAN',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xFF0A1931)),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1931),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.bolt, size: 100, color: Colors.cyanAccent),
          Text('TOOFAN', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
          Text('Connect • Communicate • Protect'),
        ]),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.bolt, size: 80, color: Colors.cyan),
          Text('TOOFAN', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(children: [
            Expanded(child: ElevatedButton(onPressed: (){ setState(()=>isLogin=true); }, child: Text('Login'))),
            SizedBox(width:10),
            Expanded(child: ElevatedButton(onPressed: (){ setState(()=>isLogin=false); }, child: Text('Sign Up'))),
          ]),
          SizedBox(height: 20),
          TextField(decoration: InputDecoration(hintText: 'Mobile / Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
          SizedBox(height: 12),
          TextField(obscureText: true, decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock))),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen())),
            child: Text(isLogin?'Login':'Create Account'),
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.cyan),
          ),
        ]),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          Text('Enter 6 digit code'),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainApp())),
            child: Text('Verify'),
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.cyan),
          ),
        ]),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  int idx = 0;
  final screens = [HomeScreen(), VideoDashboard(), ExploreScreen(), FamilyDashboard(), SocietyDashboard(), ProfileSettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TOOFAN'), backgroundColor: Color(0xFF112244)),
      body: screens[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (i)=>setState(()=>idx=i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF112244),
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.white54,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Society'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Card(
        color: Color(0xFF1A2A4A),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(leading: CircleAvatar(child: Text('S')), title: Text('Sara Khan'), subtitle: Text('2 hours ago')),
            Text('Life is better with good people'),
            SizedBox(height: 8),
            Container(height: 150, color: Colors.black26, child: Center(child: Icon(Icons.image, size: 60))),
            Row(children: [
              IconButton(icon: Icon(Icons.favorite, color: Colors.red), onPressed: (){}),
              IconButton(icon: Icon(Icons.comment), onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen())); }),
              IconButton(icon: Icon(Icons.share), onPressed: (){}),
            ]),
            Row(children: [
              Expanded(child: ElevatedButton.icon(icon: Icon(Icons.call), label: Text('Call'), onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>VoiceCallScreen())); })),
              SizedBox(width: 8),
              Expanded(child: ElevatedButton.icon(icon: Icon(Icons.chat), label: Text('Chat'), onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen())); })),
            ]),
          ]),
        ),
      ),
    ]);
  }
}

class VideoDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black, child: Center(child: Icon(Icons.play_circle, size: 100, color: Colors.white54)));
  }
}

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
    Padding(padding: EdgeInsets.all(12), child: TextField(decoration: InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()))),
    ListTile(title: Text('Trending #LifeStyle')),
    ListTile(title: Text('Suggested: Aisha'), trailing: ElevatedButton(onPressed: (){}, child: Text('Follow'))),
  ]);
}

class FamilyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: EdgeInsets.all(12), children: [
    Card(child: ListTile(title: Text('Family Group'), subtitle: Text('Mom: Ok'))),
    ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>FamilyEmergencyScreen())); }, child: Text('Emergency Alert'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
  ]);
}

class SocietyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Society Dashboard'));
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Aisha')),
    body: Column(children: [
      Expanded(child: Center(child: Text('Chat Messages'))),
      Padding(
        padding: EdgeInsets.all(8),
        child: Row(children: [
          Expanded(child: TextField(decoration: InputDecoration(hintText: 'Type message...', border: OutlineInputBorder()))),
          IconButton(icon: Icon(Icons.send, color: Colors.cyan), onPressed: (){}),
        ]),
      ),
    ]),
  );
}

class VoiceCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFF0A1931),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Aisha - Voice Call', style: TextStyle(fontSize: 22)),
      SizedBox(height: 20),
      CircleAvatar(radius: 80, child: Text('A', style: TextStyle(fontSize: 60))),
      SizedBox(height: 40),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CircleAvatar(backgroundColor: Colors.red, radius: 30, child: Icon(Icons.call_end)),
        CircleAvatar(backgroundColor: Colors.green, radius: 30, child: Icon(Icons.call)),
      ]),
    ])),
  );
}

class VideoCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Center(child: Text('Video Call - Aisha')),
  );
}

class ProfileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: EdgeInsets.all(16), children: [
    Center(child: Column(children: [CircleAvatar(radius: 50, child: Text('S')), Text('Sara Khan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))])),
    Divider(),
    ListTile(leading: Icon(Icons.face), title: Text('Hijab Settings'), onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>HijabSettingsScreen())); }),
    ListTile(leading: Icon(Icons.notifications), title: Text('Notification Settings'), onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationSettingsScreen())); }),
    ListTile(leading: Icon(Icons.admin_panel_settings), title: Text('Admin Panel'), onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminPanelScreen())); }),
    ListTile(leading: Icon(Icons.logout), title: Text('Logout'), onTap: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen())); }),
  ]);
}

class HijabSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Hijab Settings')), body: ListView(children: [SwitchListTile(value: true, onChanged: (v){}, title: Text('Enable Hijab Display'))]));
}

class NotificationSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Notifications')), body: ListView(children: [SwitchListTile(value: true, onChanged: (v){}, title: Text('New Followers')), SwitchListTile(value: true, onChanged: (v){}, title: Text('Messages'))]));
}

class FamilyEmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(backgroundColor: Color(0xFF330000), appBar: AppBar(backgroundColor: Colors.red, title: Text('Emergency')), body: Center(child: ElevatedButton(onPressed: (){}, child: Text('Send Alert'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red))));
}

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Admin Panel')), body: Center(child: Text('Owner Admin Panel - Total Users: 48k')));
}
