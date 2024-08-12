import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  Future _scanQRCode(context) async{
    await Navigator.pushNamed(context, '/scanner-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to Etisal Event!'),
              MaterialButton(
                  onPressed:(){
                    _scanQRCode(context);
                  },
                  color: Colors.grey,
                  child: const Text('Scan Now',
                      style: TextStyle(
                          color: Colors.white
                      )
                  )
              )
            ]
          ),
        ],
      ),
    );
  }
}