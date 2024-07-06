import 'package:anidetection/presentation/screens/directory_picker_screen.dart';
import 'package:anidetection/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => DirectoryPickerPage(),
    // ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Animals Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: false,
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      routerConfig: _router,
    );
  }
}