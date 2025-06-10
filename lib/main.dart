import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_grow_app/screens/splash_screen.dart';
import 'package:learn_grow_app/screens/auth_screen.dart';
import 'package:learn_grow_app/screens/main_navigation_screen.dart';
import 'package:learn_grow_app/screens/course_detail_screen.dart';
import 'package:learn_grow_app/screens/task_list_screen.dart';
import 'package:learn_grow_app/screens/notes_screen.dart';
import 'package:learn_grow_app/screens/calendar_screen.dart';
import 'package:learn_grow_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap with ChangeNotifierProvider for theme
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Create ThemeProvider instance
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Learn & Grow',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.teal,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.latoTextTheme(
                Theme.of(context).textTheme,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                elevation: 1,
                titleTextStyle: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.grey[900],
              cardColor: Colors.grey[850],
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.latoTextTheme(
                Theme.of(context).primaryTextTheme, // Use primaryTextTheme for dark mode base
              ).apply(bodyColor: Colors.white, displayColor: Colors.white),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[850],
                foregroundColor: Colors.white,
                elevation: 1,
                titleTextStyle: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey[850],
                selectedItemColor: Colors.tealAccent,
                unselectedItemColor: Colors.grey[400],
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                )
              )
            ),
            themeMode: themeProvider.themeMode, // Use themeMode from provider
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/auth': (context) => const AuthScreen(),
              '/home': (context) => const MainNavigationScreen(),
              '/tasks': (context) => const TaskListScreen(),
              '/notes': (context) => const NotesScreen(),
              '/calendar': (context) => const CalendarScreen(),
            },
            // Handle dynamic routes like course details
            onGenerateRoute: (settings) {
              if (settings.name == '/course_detail') {
                final args = settings.arguments as String; // Assuming course ID is passed as String
                return MaterialPageRoute(
                  builder: (context) {
                    return CourseDetailScreen(courseId: args);
                  },
                );
              }
              // Handle other routes or unknown routes if necessary
              assert(false, 'Need to implement ${settings.name}');
              return null;
            },
          );
        },
      ),
    );
  }
}
