import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_client.dart';
import 'package:tiktactoe/repository/socket_methods.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var _roomController = TextEditingController();

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    SocketClient.instance;
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _roomController.dispose();
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
              "Create Room",
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
                  _socketMethods.createRoom(
                    _roomController.text,
                  );
                  roomData.updateMyName(_roomController.text);
                },
                child: Text(
                  'Create',
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
