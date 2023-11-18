import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tiktactoe/presentation/components/scoreboard.dart';
import 'package:tiktactoe/presentation/screens/game_screen.dart';
import 'package:tiktactoe/presentation/screens/score_screen.dart';
import 'package:tiktactoe/presentation/screens/waiting_screen.dart';
import 'package:tiktactoe/provider/roomProvider.dart';
import 'package:tiktactoe/repository/game.dart';
import 'package:tiktactoe/repository/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;
  // EMITS
  void createRoom(String name) {
    if (name.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'name': name,
      });
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('roomCreated', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WaitingScreen()));
    });
  }

  void joinRoom(String name, String roomId) {
    if (name.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'name': name,
        'roomId': roomId,
      });
    }
  }

  void joinRoomSuccessListener(
      BuildContext context, SocketMethods socketMethods) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => GameScreen(
                    socketMethods: socketMethods,
                  )));
    });
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data.toString())));
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketId'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
      GameMethods().clearBoard(context);
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      GameMethods().clearBoard(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ScroreScreen(playerData)));
    });
  }
}
