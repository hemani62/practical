// import 'package:flutter/material.dart';
//
// import 'WeatherScreen/DetailsScreen.dart';
// import 'WeatherScreen/HomeScreen.dart';
// import 'LoginScreen.dart';
// import 'ToDoApp.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => LoginScreen(),
//         '/toDoApp': (context) => ToDoApp(),
//         '/': (context) => HomeScreen(),
//         '/details': (context) => DetailsScreen(),
//       },
//       //home:LoginScreen(),
//     );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'CalculatorScreen.dart';
import 'LoginScreen.dart';
import 'ToDoScreen.dart';
import 'WeatherScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // final List<Widget> _screens = [
  //   LoginScreen(),
  //   ToDoScreen(),
  //   WeatherScreen(),
  //   CalculatorScreen(),
  // ];
  //
  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: _screens.length,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Multi-Function App'),
  //         bottom: TabBar(
  //           tabs: [
  //             Tab(icon: Icon(Icons.login)),
  //             Tab(icon: Icon(Icons.list)),
  //             Tab(icon: Icon(Icons.cloud)),
  //             Tab(icon: Icon(Icons.calculate)),
  //           ],
  //         ),
  //       ),
  //       body: TabBarView(
  //         children: _screens,
  //       ),
  //     ),
  //   );
  // }

  int _currentIndex = 0;
  List<Widget> _screens = [
    const LoginScreen(),
    const ToDoScreen(),
    WeatherScreen(),
    CalculatorScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'App Drawer',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login Page'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('ToDo App'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text('Weather App'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator App'),
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
    );
  }


}

