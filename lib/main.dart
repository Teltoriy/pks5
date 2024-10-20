import 'package:flutter/material.dart';
import 'package:pks/components/global.dart';
import 'package:pks/pages/home_page.dart';
import 'package:pks/pages/favourite.dart';
import 'package:pks/pages/profile.dart';
GlobalData appData = GlobalData();
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  List<Widget> pages = [HomePage(), Favourite(),Profile()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xdd',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Аптечка"),
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items:const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.medication_liquid_outlined), label: "Товары"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Избранное"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль")
          ],
          selectedItemColor: Colors.lightBlueAccent,
          currentIndex: selectedIndex,
          useLegacyColorScheme: true,
          onTap: (int barItemIndex) => {
            setState(() {
              selectedIndex = barItemIndex;
            })
          },
        ),
      ),
    );
  }
}