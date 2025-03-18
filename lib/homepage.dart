import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'login_and_signup.dart';
import 'camera_pages/tips_page.dart';

// --- Destination Definition ---
class Destination {
  const Destination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<Destination> destinations = <Destination>[
  Destination('Home', Icon(Icons.home_outlined), Icon(Icons.home_filled)),
  Destination('Start', Icon(Icons.water_drop_outlined), Icon(Icons.water_drop)),
  Destination('Logout', Icon(Icons.account_circle_outlined), Icon(Icons.account_circle)),
];

// --- InfoPage & Carousel ---
class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Wrap the Column with SingleChildScrollView
      child: Column(
        children: [
          // Logo above the carousel
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 40.0),
            child: SizedBox(
              width: 100.0,
              child: Image.asset('assets/logo.png'),
            ),
          ),
          const SizedBox(
            height: 400.0,
            child: CarouselWithIndicatorDemo(),
          ),
        ],
      ),
    );
  }
}

final List<Widget> sliderContent = [
  Scrollbar( // Wrap the ListView with Scrollbar
    child: ListView(
      children: const [
        Text(
          "Welcome to LluviaLens",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF007FA3),
          ),
        ),
        Text(
          "This application is a sophisticated bacteriological water quality assessment tool developed by the Centre for Global Engineering and Engineers Without Borders at the University of Toronto, Canada. It is specifically designed to support practitioners and partners in monitoring and analyzing rainwater harvesting systems and their bacteriological water quality.",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Color(0xFF007FA3),
          ),
        ),
      ],
    ),
  ),
  Scrollbar( // Wrap the ListView with Scrollbar
    child: ListView(
      children: const [
        Text(
          "Key Features:",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF007FA3),
          ),
        ),
        Text(
          "• Utilizes image analysis to complement [field test kit – brand name] to monitor water quality and system integrity.",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Color(0xFF007FA3),
          ),
        ),
        Text(
          "• Designed for ease of use by practitioners in the field to facilitate regular monitoring and maintenance activities.",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Color(0xFF007FA3),
          ),
        ),
      ],
    ),
  ),
];

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<CarouselWithIndicatorDemo> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: sliderContent,
            carouselController: _controller,
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 1.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: sliderContent.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// --- HomePage with Modified Navigation ---
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

  // Called from the drawer selection
  void handleScreenChanged(int selectedScreen) {
    scaffoldKey.currentState!.closeEndDrawer();
    if (selectedScreen == 1) {
      // Navigate away completely to SwipePages
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SwipePages()),
      );
    } else {
      setState(() {
        screenIndex = selectedScreen;
      });
    }
  }

  void onDestinationSelected(int index) {
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SwipePages()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TipsPage()),  // Navigate to TipsPage
      );
    } else {
      setState(() {
        screenIndex = index;
      });
    }
  }


  Widget buildBottomBarScaffold() {
    // Set page for indices other than login
    if (screenIndex == 0) {
      page = const InfoPage();
    }
    return Scaffold(
      body: Center(child: page),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations.map((Destination destination) {
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
    if (screenIndex == 0) {
      page = const InfoPage();
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 70.0,
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: Center(child: page)),
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
          const Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
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
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }
}
