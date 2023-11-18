import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/socket_methods.dart';

class TicTacToe extends StatefulWidget {
  final SocketMethods socketMethods;
  const TicTacToe({super.key, required this.socketMethods});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  @override
  void initState() {
    super.initState();
    widget.socketMethods.tappedListener(context);
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    widget.socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['id'],
      roomDataProvider.displayElements,
    );
    if (kDebugMode) {
      print("tapped");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * 0.8,
        maxHeight: size.height * 0.6,
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketId'] !=
            widget.socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                tapped(index, roomDataProvider);
                if (kDebugMode) print("tapped on tap");
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple.shade300,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataProvider.displayElements[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.sp,
                          shadows: [
                            Shadow(
                              blurRadius: 40.r,
                              color:
                                  roomDataProvider.displayElements[index] == 'O'
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
