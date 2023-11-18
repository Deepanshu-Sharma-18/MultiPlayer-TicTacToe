import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_methods.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.joinRoomSuccessListener(context, _socketMethods);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  Widget build(BuildContext context) {
    var roomData =
        Provider.of<RoomDataProvider>(context, listen: false).roomData;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              height: 40.h,
            ),
            Text(
              "Waiting for another player to join...",
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80.h,
            ),
            Text(
              "Room ID ",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7)),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 8.h,
            ),
            SelectableText(
              "${roomData['id']}",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                color: Colors.deepPurple.shade300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 150.h,
            ),
            Text(
              "Share this code with your friend",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5)),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
