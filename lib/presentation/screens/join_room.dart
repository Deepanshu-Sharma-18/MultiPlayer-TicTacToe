import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_client.dart';
import 'package:tiktactoe/repository/socket_methods.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  var _roomController = TextEditingController();
  var _nameController = TextEditingController();

  SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SocketClient.instance;
    _socketMethods.joinRoomSuccessListener(context, _socketMethods);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    _roomController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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
              "Join Room",
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8)),
            ),
            SizedBox(
              height: 80.h,
            ),
            SizedBox(
              width: 350.w,
              child: TextField(
                controller: _roomController,
                decoration: InputDecoration(
                  hintText: "Enter Room ID",
                  hintStyle: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 350.w,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  hintStyle: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
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
                  _socketMethods.joinRoom(
                      _nameController.text, _roomController.text);
                  roomData.updateMyName(_nameController.text);
                },
                child: Text(
                  'Join',
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
