import 'package:driver/ui/pages/splash/splashfour.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreenFour()),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Container(
                    width: double.infinity,
                    height: 600,
                    color: Colors.teal,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: const Alignment(0, -0.7),
                  child: Image.asset('assets/images/logokurir.png'),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 400, left: 55, right: 55),
                  child: Center(
                    child: Column(
                      children: [
                        Text('Driver Corner',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold)),
                        Divider(),
                        Text(' Drive efficiency, deliver excellence!',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                )
                // Padding(padding: EdgeInsets.only(top: 50, left: 30),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(

                //     )
                //   ],
                // ),
                // ),
              ],
            )),
      ),
    );
  }
}
