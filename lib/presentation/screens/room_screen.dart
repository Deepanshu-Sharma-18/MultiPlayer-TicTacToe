import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktactoe/presentation/screens/create_room.dart';
import 'package:tiktactoe/presentation/screens/join_room.dart';
import 'package:tiktactoe/repository/socket_client.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tic-tac-toe.png',
              height: 120.h,
              width: 120.w,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            Text(
              "Tic Tac Toe",
              style: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('~ The One'),
            SizedBox(
              height: 150.h,
            ),
            Container(
              height: 60.h,
              width: 350.w,
              child: OutlinedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10.r),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateScreen(),
                    ),
                  );
                },
                child: Text(
                  'Create Room',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 60.h,
              width: 350.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: OutlinedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10.r),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinRoom(),
                    ),
                  );
                },
                child: Text(
                  'Join Room',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
