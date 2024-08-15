import 'package:flutter/material.dart';
import 'package:testproject/Screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testproject/Screens/chat.dart';
import 'package:testproject/Screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF6200EA), // Primary color
          primaryVariant: Color(0xFF3700B3), // Variant of primary color
          secondary: Color(0xFF03DAC6), // Secondary color
          secondaryVariant: Color(0xFF018786), // Variant of secondary color
          surface: Colors.white, // Color of surfaces like cards
          background: Colors.white, // Background color for pages
          error: Colors.red, // Error color
          onPrimary:
              Colors.white, // Color to use for text/icons on primary color
          onSecondary:
              Colors.black, // Color to use for text/icons on secondary color
          onSurface: Colors.black, // Color to use for text/icons on surfaces
          onBackground:
              Colors.black, // Color to use for text/icons on backgrounds
          onError: Colors.white, // Color to use for text/icons on error
          brightness: Brightness.light, // Overall brightness of the theme
        ),
        // Additional theme configurations
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
