import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/group_screen.dart';
import 'screens/meeting_screen.dart';
import 'screens/call_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String registration = '/registration';
  static const String chat = '/chat';
  static const String group = '/group';
  static const String meeting = '/meeting';
  static const String call = '/call';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case registration:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      // case chat:
      // Extract arguments passed to ChatScreen route
        final args = settings.arguments as Map<String, dynamic>;
        // return MaterialPageRoute(
        //   builder: (_) => ChatScreen(contactName: args['contactName']),
        // );
      case chat:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case group:
        return MaterialPageRoute(builder: (_) => GroupScreen());
      case meeting:
        return MaterialPageRoute(builder: (_) => MeetingScreen());
      case call:
      // Extract arguments passed to CallScreen route
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CallScreen(contactName: args['contactName']),
        );
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
