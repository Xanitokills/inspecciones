import 'package:appproyecto2/home/Home_Page.dart';
import 'package:appproyecto2/home/Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/scroll_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuNavegacion extends StatelessWidget {
  MenuNavegacion({Key? key}) : super(key: key);
  String name = 'Sin usuario loggeado';
  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? 'xd';
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return ScrollNavigation(
      bodyStyle: const NavigationBodyStyle(
        /* Container(color: Colors.blue[100]), */
        background: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      barStyle: const NavigationBarStyle(
        background: Color.fromARGB(255, 222, 222, 222),
        elevation: 0.0,
      ),
      pages: [
        const HomePage(),
        Profile(),
        /* const ReportesPage(), */
        /*      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Detalle de Usuario'),
            TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('id');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: Text('Cerrar sesion')),
          ],
        ) */
      ],
      items: const [
        ScrollNavigationItem(icon: Icon(Icons.home)),
        ScrollNavigationItem(icon: Icon(Icons.person)),
      ],
    );
  }
}
