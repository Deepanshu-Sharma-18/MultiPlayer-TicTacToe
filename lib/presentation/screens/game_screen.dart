import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:tiktactoe/presentation/components/scoreboard.dart';
import 'package:tiktactoe/presentation/components/tictactoe_board.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_methods.dart';

class GameScreen extends StatefulWidget {
  final SocketMethods socketMethods;
  const GameScreen({super.key, required this.socketMethods});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    widget.socketMethods.updateRoomListener(context);
    widget.socketMethods.updatePlayersStateListener(context);
    widget.socketMethods.pointIncreaseListener(context);
    widget.socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    var roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Scoreboard(),
            SizedBox(
              height: 40.h,
            ),
            TicTacToe(
              socketMethods: widget.socketMethods,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              child: Text(
                '${roomDataProvider.roomData['turn']['name']}\'s turn',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
