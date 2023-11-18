import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tiktactoe/presentation/screens/room_screen.dart';
import 'package:tiktactoe/presentation/screens/splash_screen.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: ScreenUtilInit(
        designSize: const Size(411, 891),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TicTacToe',
          theme: ThemeData.dark(
            useMaterial3: true,
          ).copyWith(
            scaffoldBackgroundColor: const Color.fromRGBO(16, 13, 34, 1),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
