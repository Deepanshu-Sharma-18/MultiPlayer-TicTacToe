import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tiktactoe/presentation/components/scoreboard.dart';
import 'package:tiktactoe/presentation/screens/room_screen.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_client.dart';

class ScroreScreen extends StatefulWidget {
  var playerData;
  ScroreScreen(this.playerData, {super.key});

  @override
  State<ScroreScreen> createState() => _ScroreScreenState();
}

class _ScroreScreenState extends State<ScroreScreen> {
  @override
  Widget build(BuildContext context) {
    var roomData = Provider.of<RoomDataProvider>(context, listen: false);
    return Scaffold(
      body: SizedBox(
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
              height: 5.h,
            ),
            Text(
              "Tic Tac Toe",
              style: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Score card",
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8)),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              widget.playerData[0]['score'] == widget.playerData[1]['score']
                  ? "Draw"
                  : widget.playerData[0]['score'] >
                          widget.playerData[1]['score']
                      ? widget.playerData[0]['name'] == roomData.myName
                          ? "You won"
                          : "You lost"
                      : widget.playerData[1]['name'] == roomData.myName
                          ? "You won"
                          : "You lost",
              style: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade300,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Scoreboard(),
            SizedBox(
              height: 100.h,
            ),
            SizedBox(
              height: 60.h,
              width: 350.w,
              child: OutlinedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(20.r),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RoomScreen()),
                  );
                  SocketClient.disconnectSocket();
                },
                child: Text(
                  'New Game',
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
