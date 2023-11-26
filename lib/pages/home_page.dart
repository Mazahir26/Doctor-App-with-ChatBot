import 'package:flutter/material.dart';
import 'package:healthsphere/pages/main/hostital_page.dart';
import 'package:healthsphere/utils/extensions.dart';
import 'package:healthsphere/values/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HospitalPage(),
    Text(
      '',
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      AppRoutes.bot.pushName();
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital_outlined),
                label: 'Hospitals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assistant_rounded),
                label: 'Assistant',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.personal_injury_rounded),
                label: 'Doctors',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          )),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   // void _getAccount() async {
//   //   final id = supabase.auth.currentUser?.id;

//   // }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text("Welcome")),
//     );
//   }
// }
