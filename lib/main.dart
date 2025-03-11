import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'login_and_signup.dart';
// import 'camera_pages/tips_page.dart';

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

    return const SizedBox(
      height: 400.0,
      child: CarouselWithIndicatorDemo()
    );
  }
}


final List<Widget> sliderContent = [
  ListView(
    children: const [
      Text("Header 1"),
      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec imperdiet dapibus maximus. Suspendisse tincidunt orci ipsum, ac malesuada orci hendrerit vel. Donec eu risus est. Aenean lacinia metus eu velit eleifend convallis. Fusce semper placerat ligula ornare condimentum. Proin commodo risus sed consequat dapibus. Quisque viverra velit nulla. Ut ut aliquet leo, nec hendrerit est. Aliquam eu porttitor felis. Suspendisse ac elit condimentum, vestibulum leo vitae, lobortis metus. Phasellus aliquet pulvinar purus et aliquam. Nunc ultrices euismod hendrerit. Quisque faucibus felis vel nisi venenatis vulputate nec ac leo. Maecenas consectetur congue lacus et maximus. Donec odio metus, molestie eu fringilla in, vulputate sit amet massa. Aliquam commodo sapien suscipit diam faucibus pharetra. Aenean vehicula neque ut lectus dignissim, rhoncus tempus quam rutrum. Etiam porttitor tellus est, vitae faucibus elit laoreet ut. Aliquam et varius ipsum, eu consequat augue. Nunc convallis aliquam lectus quis blandit. Nullam venenatis condimentum ultrices. Quisque porttitor et felis eget fringilla. Sed eget massa augue. Quisque tincidunt aliquam tellus ac ultricies. Nulla facilisi. Fusce aliquam turpis vitae dui suscipit porttitor. Nam auctor aliquam urna, in auctor elit accumsan ac. Fusce id accumsan ligula, vel rutrum diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec commodo ultrices turpis, vel accumsan mi viverra sit amet. Nunc auctor, erat sit amet vestibulum volutpat, velit nulla vehicula elit, id finibus justo libero faucibus velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec id enim sed nibh ultrices tristique. Nullam ut porta risus. Vivamus suscipit vestibulum nisl sit amet auctor. Donec pellentesque a lectus sed eleifend. Curabitur suscipit ante at porta facilisis. Proin sit amet feugiat enim, ultrices commodo sapien. Maecenas malesuada erat neque, quis tincidunt massa sagittis eget. Etiam ut augue semper, molestie tortor a, consectetur nulla. Vivamus lacinia, ante nec lacinia semper, urna arcu tempor metus, vel fringilla dui eros et turpis. Etiam ac blandit felis, vel cursus libero. Praesent vel tincidunt est. Donec elementum sagittis turpis, vel ultrices tortor volutpat a. Proin tempor viverra leo, quis lacinia ante convallis id. Fusce volutpat nisl commodo diam blandit, sed consequat nisl cursus. Vivamus sapien elit, maximus nec molestie accumsan, eleifend et diam. Ut pretium fermentum tempus. Quisque in volutpat leo. Nunc varius vehicula lorem, in tincidunt nisl tristique et.Integer quis tellus elementum, ullamcorper erat ac, hendrerit lacus. Duis vel imperdiet lorem. Nunc fringilla, massa sit amet hendrerit auctor, dolor lacus dignissim metus, eget imperdiet diam metus eget turpis. Vivamus et rutrum eros. Praesent vitae sem tincidunt, luctus velit sit amet, egestas velit. Nulla felis magna, fringilla a ex quis, suscipit posuere neque. In at ligula odio. Donec id quam iaculis, commodo dolor id, scelerisque ante. Proin ac libero pulvinar, cursus lorem vel, euismod est. Pellentesque dapibus imperdiet euismod. Mauris luctus ac nibh non aliquam. Nullam id eros sed magna congue porta non in nibh. Aenean felis libero, faucibus ac orci vitae, porta sagittis elit."),
    ],
  ), 

  ListView(
    children: const [
      Text("Header 2"),
      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec imperdiet dapibus maximus. Suspendisse tincidunt orci ipsum, ac malesuada orci hendrerit vel. Donec eu risus est. Aenean lacinia metus eu velit eleifend convallis. Fusce semper placerat ligula ornare condimentum. Proin commodo risus sed consequat dapibus. Quisque viverra velit nulla. Ut ut aliquet leo, nec hendrerit est. Aliquam eu porttitor felis. Suspendisse ac elit condimentum, vestibulum leo vitae, lobortis metus. Phasellus aliquet pulvinar purus et aliquam. Nunc ultrices euismod hendrerit. Quisque faucibus felis vel nisi venenatis vulputate nec ac leo. Maecenas consectetur congue lacus et maximus. Donec odio metus, molestie eu fringilla in, vulputate sit amet massa. Aliquam commodo sapien suscipit diam faucibus pharetra. Aenean vehicula neque ut lectus dignissim, rhoncus tempus quam rutrum. Etiam porttitor tellus est, vitae faucibus elit laoreet ut. Aliquam et varius ipsum, eu consequat augue. Nunc convallis aliquam lectus quis blandit. Nullam venenatis condimentum ultrices. Quisque porttitor et felis eget fringilla. Sed eget massa augue. Quisque tincidunt aliquam tellus ac ultricies. Nulla facilisi. Fusce aliquam turpis vitae dui suscipit porttitor. Nam auctor aliquam urna, in auctor elit accumsan ac. Fusce id accumsan ligula, vel rutrum diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec commodo ultrices turpis, vel accumsan mi viverra sit amet. Nunc auctor, erat sit amet vestibulum volutpat, velit nulla vehicula elit, id finibus justo libero faucibus velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec id enim sed nibh ultrices tristique. Nullam ut porta risus. Vivamus suscipit vestibulum nisl sit amet auctor. Donec pellentesque a lectus sed eleifend. Curabitur suscipit ante at porta facilisis. Proin sit amet feugiat enim, ultrices commodo sapien. Maecenas malesuada erat neque, quis tincidunt massa sagittis eget. Etiam ut augue semper, molestie tortor a, consectetur nulla. Vivamus lacinia, ante nec lacinia semper, urna arcu tempor metus, vel fringilla dui eros et turpis. Etiam ac blandit felis, vel cursus libero. Praesent vel tincidunt est. Donec elementum sagittis turpis, vel ultrices tortor volutpat a. Proin tempor viverra leo, quis lacinia ante convallis id. Fusce volutpat nisl commodo diam blandit, sed consequat nisl cursus. Vivamus sapien elit, maximus nec molestie accumsan, eleifend et diam. Ut pretium fermentum tempus. Quisque in volutpat leo. Nunc varius vehicula lorem, in tincidunt nisl tristique et.Integer quis tellus elementum, ullamcorper erat ac, hendrerit lacus. Duis vel imperdiet lorem. Nunc fringilla, massa sit amet hendrerit auctor, dolor lacus dignissim metus, eget imperdiet diam metus eget turpis. Vivamus et rutrum eros. Praesent vitae sem tincidunt, luctus velit sit amet, egestas velit. Nulla felis magna, fringilla a ex quis, suscipit posuere neque. In at ligula odio. Donec id quam iaculis, commodo dolor id, scelerisque ante. Proin ac libero pulvinar, cursus lorem vel, euismod est. Pellentesque dapibus imperdiet euismod. Mauris luctus ac nibh non aliquam. Nullam id eros sed magna congue porta non in nibh. Aenean felis libero, faucibus ac orci vitae, porta sagittis elit."),
    ],
  )
]; 

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
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
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
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
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]);
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
            width: 70.0,
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