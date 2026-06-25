import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'chat_screen.dart';
import 'reminder_screen.dart';
import 'profile_screen.dart';
import 'splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

await NotificationService.init();

runApp(const LifeLineAI());
}

class LifeLineAI extends StatelessWidget {
const LifeLineAI({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'LifeLine AI',
theme: ThemeData(
colorSchemeSeed: Colors.red,
useMaterial3: true,
),
home: const SplashScreen(),
);
}
}

class MainNavigation extends StatefulWidget {
const MainNavigation({super.key});

@override
State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
int currentIndex = 0;

final List<Widget> screens = const [
HomeScreen(),
ChatScreen(),
ReminderScreen(),
ProfileScreen(),
];

@override
Widget build(BuildContext context) {
return Scaffold(
body: screens[currentIndex],
bottomNavigationBar: BottomNavigationBar(
currentIndex: currentIndex,
type: BottomNavigationBarType.fixed,
selectedItemColor: Colors.red,
unselectedItemColor: Colors.grey,
onTap: (index) {
setState(() {
currentIndex = index;
});
},
items: const [
BottomNavigationBarItem(
icon: Icon(Icons.home),
label: "Home",
),
BottomNavigationBarItem(
icon: Icon(Icons.smart_toy),
label: "AI Chat",
),
BottomNavigationBarItem(
icon: Icon(Icons.medication),
label: "Reminder",
),
BottomNavigationBarItem(
icon: Icon(Icons.person),
label: "Profile",
),
],
),
);
}
}
