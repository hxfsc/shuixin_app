import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/network_checker.dart';
import 'core/network_banner.dart';
import 'package:shuixin_app/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => NetworkChecker(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool darkModeOn = false;
  bool customTheme = false;
  Map<String, void Function()>? homeCall;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    darkModeOn = brightness == Brightness.dark;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (!customTheme) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      setState(() {
        darkModeOn = brightness == Brightness.dark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: "ShuYun", brightness: Brightness.light),
      darkTheme: ThemeData(fontFamily: "ShuYun", brightness: Brightness.dark),
      themeMode: customTheme ? (darkModeOn ? ThemeMode.dark : ThemeMode.light) : ThemeMode.system,
      home: NetworkBanner(
        child: Scaffold(
          body: Stack(
            children: [
              HomePage(
                onReady: (funcMap) {
                  homeCall = funcMap;
                },
              ),
              Positioned(
                top: 20,
                right: 20,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: MaterialButton(
                    padding: const EdgeInsets.all(0),
                    child: Icon(darkModeOn ? Icons.dark_mode_outlined : Icons.dark_mode, size: 25),
                    onPressed: () {
                      setState(() {
                        customTheme = true;
                        darkModeOn = !darkModeOn;
                      });
                    },
                  ),
                ),
              ),

              Positioned(
                top: 20,
                right: 60,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: MaterialButton(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.replay_circle_filled_sharp),
                    onPressed: () {
                      homeCall?['text']?.call();
                      homeCall?['image']?.call();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
