import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectionCheck extends StatefulWidget {
  @override
  _ConnectionCheckState createState() => _ConnectionCheckState();
}

class _ConnectionCheckState extends State<ConnectionCheck> {
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        _connectionStatus = 'Mobile data';
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _connectionStatus = 'WiFi';
      });
    } else {
      setState(() {
        _connectionStatus = 'No connection';
      });
      _showNoConnectionSnackBar();
    }
  }

  void _showNoConnectionSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 228, 58, 24),
        content: Text('No Tienes conexión a internet'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Check'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connection Status: $_connectionStatus'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _checkConnection();
              },
              child: Text('Check Connection'),
            ),
          ],
        ),
      ),
    );
  }
}
