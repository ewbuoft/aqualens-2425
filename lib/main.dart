import 'package:flutter/material.dart';

import 'package:aqualens/pages/login.dart';
export 'package:aqualens/main.dart';

void main() {
  runApp(const MyApp());
}

class Destination {
  const Destination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<Destination> destinations = <Destination>[
  Destination('Home', Icon(Icons.home_outlined), Icon(Icons.home_filled)),
  Destination('Login', Icon(Icons.account_circle_outlined), Icon(Icons.account_circle)),
  Destination('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
];


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGEN Aqualens',
      theme: ThemeData(
        useMaterial3: true,
        
        colorScheme: const ColorScheme (
          brightness: Brightness.light, 
          primary:  Color.fromRGBO(0, 127, 163, 1.0), 
          onPrimary: Colors.white, 
          secondary: Color.fromRGBO(111, 199, 234, 1.0), 
          onSecondary: Colors.black, 
          error: Color.fromRGBO(220, 70, 51, 1.0), 
          onError: Colors.white, 
          surface: Colors.white, 
          onSurface: Colors.black)
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        
        colorScheme: const ColorScheme (
          brightness: Brightness.light, 
          primary:  Color.fromRGBO(0, 127, 163, 1.0), 
          onPrimary: Colors.white, 
          secondary: Color.fromRGBO(111, 199, 234, 1.0), 
          onSecondary: Colors.black, 
          error: Color.fromRGBO(220, 70, 51, 1.0), 
          onError: Colors.white, 
          surface: Colors.black, 
          onSurface: Colors.white)
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: 
        Padding(
          padding: EdgeInsets.all(20),
          child: Text("Here's some info."
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  Widget page = const InfoPage();

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
    scaffoldKey.currentState!.closeEndDrawer();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            page
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations:
            destinations.map((Destination destination) {
              return NavigationDestination(
                label: destination.label,
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
                tooltip: destination.label,
              );
            }).toList(),
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
            width: 40.0,
            child: Image.asset('assets/logo.png'),
          ),
        ) ,
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Row(
          children: <Widget>[
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: page,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Menu', style: Theme.of(context).textTheme.titleLarge),
          ),
          ...destinations.map((Destination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          }),
          const Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    switch (screenIndex) {
      case 0:
        page = const InfoPage();
        break;
      case 1:
        page = const LoginPage();
        break;
      case 2:
        page = const InfoPage();
        break;
      default:
        throw UnimplementedError('no widget');
    }

    return showNavigationDrawer ? buildDrawerScaffold(context) : buildBottomBarScaffold();
  }
}