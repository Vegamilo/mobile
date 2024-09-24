import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'favourites_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 48, 47, 82)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0; //ตำแหน่งเริ่มปุ่ม Home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Text('$index',
            style: const TextStyle(
                color:Color.fromARGB(255, 135, 172, 125),
                fontSize: 120,
                fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        child: CurvedNavigationBar(
          index: index, // ตำแหน่งเริ่ม
          height: 60.0, // ส่วนสูง
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.favorite, size: 30),
            Icon(Icons.settings, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Color.fromARGB(255, 99, 81, 61), // สีพื้น
          buttonBackgroundColor: Color.fromARGB(255, 135, 172, 125), // สีปุ่มที่เลือก
          backgroundColor: Colors.transparent, // สีพื้นหลัง
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600), // ความเร็ว
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        color: Color.fromARGB(255, 170, 114, 84),
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.freepik.com/512/5153/5153564.png?ga=GA1.1.540947269.1707125197&'),
            ),
            SizedBox(height: 12),
            Text('Planttery',
                style: TextStyle(fontSize: 28, color: Colors.white)),
            Text('Planterry@gg.com',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16, // vertical spacing
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined,
              color: Color.fromARGB(255, 170, 114, 84)),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Home Page')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border,
              color: Color.fromARGB(255, 170, 114, 84)),
              title: const Text('Favourites'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavouritesPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspaces_outline,
              color: Color.fromARGB(255, 170, 114, 84)),
              title: const Text('Workflow'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.update,
              color: Color.fromARGB(255, 170, 114, 84)),
              title: const Text('Updates'),
              onTap: () {},
            ),
            const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.account_tree_outlined,
              color: Color.fromARGB(255, 170, 114, 84)),
              title: const Text('Plugins'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined,
              color: Color.fromARGB(255, 170, 114, 84)),
              title: const Text('Notifications'),
              onTap: () {},
            )
          ],
        ),
      );
}
