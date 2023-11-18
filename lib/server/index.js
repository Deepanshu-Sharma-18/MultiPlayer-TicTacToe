// importing modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);
const admin = require('firebase-admin');

// middle ware
app.use(express.json());


const serviceAccount = require('./credentials.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });


const db = admin.firestore();
  


io.on("connection", (socket) => {
    console.log("connected!");

    socket.on("createRoom" , ( { name } ) => {
        console.log(name);


        ref = db.collection('rooms').doc();

        roomData = {
            "occupancy" : 2 ,
            "maxRounds" : 2 ,
            "currentRound" : 0,
            "isJoin" : true ,
            "turnIndex" : 0, 
            "players" : [
                {
                    "name" : name.toString(),
                    "socketId" : socket.id.toString(),
                    "score" : 0,
                    "xoro" : "X"
                }
            ] ,
            "turn" : {
                "name" : name.toString(),
                "socketId" : socket.id.toString(),
                "score" : 0,
                "xoro" : "X"
            },
            "id" : ref.id.toString(),
        }

        try{
            ref.set(
                roomData
            );

            socket.join(ref.id.toString());
            socket.emit("roomCreated" , roomData);
        }catch(e){
            console.log(e);
        }
        
    });



    socket.on("joinRoom" , async ( { name , roomId } ) =>  {
        console.log(name);
        console.log(roomId);

        try{

            let docref = await db.collection('rooms').doc(roomId).get();
            let doc = docref.data();
        
            console.log(doc);
        
            if (doc.isJoin === true) {
              console.log("joinRoom");
        
              let ref = db.collection('rooms').doc(roomId);
              await ref.update({
                "players": admin.firestore.FieldValue.arrayUnion({
                  "name": name.toString(),
                  "socketId": socket.id.toString(),
                  "score": 0,
                  "xoro": "O"
                }),
                "isJoin": false
              });
        
              console.log("joinRoom");
        
              docref = await db.collection('rooms').doc(roomId).get();
              await socket.join(roomId.toString());

              console.log(docref.data());
        
              io.to(roomId).emit("joinRoomSuccess", docref.data());
              io.to(roomId).emit("updatePlayers", docref.data().players);
              io.to(roomId).emit("updateRoom", docref.data());
            
            }else{
                    socket.emit(
                        "errorOccurred",
                        "The game is in progress, try again later."
                      );
            }
        }catch(e){
            console.log(e);
        } 
    });


    socket.on("tap", async ({ index, roomId }) => {
      console.log("trigger")
        try {
          docref = await db.collection('rooms').doc(roomId).get().then((doc) => {

              let choice = doc.data().turn.xoro;
              if (doc.data().turnIndex == 0) {

                ref.update({
                    "turn" : doc.data().players[1],
                    "turnIndex" : 1
                });
              } else {
                ref.update({
                    "turn" : doc.data().players[0],
                    "turnIndex" : 0
                });
              }
              docupdateRef = db.collection('rooms').doc(roomId).get().then((docUpdated) => {

                  io.to(roomId).emit("tapped", {
                    "index" : index,
                    "choice" : choice,
                    "room" : docUpdated.data()
                  });
              });

          });
    
          
        } catch (e) {
          console.log(e);
        }
      });
    
      socket.on("winner", async ({ winnerSocketId, roomId }) => {
        try {
            docref = await db.collection('rooms').doc(roomId).get()
          
            let winnerPlayer
          
            player = docref.data().players

            if(winnerSocketId != ""){

              player.forEach(element => {
                if(element.socketId == winnerSocketId){
                  element.score = element.score + 1;
                  winnerPlayer = player.indexOf(element);
                }
              });

            }


            let ref = db.collection('rooms').doc(roomId);
            await ref.update({
                "players" : player,
                "currentRound" : docref.data().currentRound + 1,
            });
          

          console.log(player);
          
            docUpdateRef =  db.collection('rooms').doc(roomId).get().then((docUpdated) => {

              console.log(docUpdated.data());
              
              
              
              if (docUpdated.data().currentRound >= docUpdated.data().maxRounds) {
                io.to(roomId).emit("pointIncrease", player[winnerPlayer]);
                
              
                io.to(roomId).emit("endGame", player);
                
                  socket.leave(roomId);
                } else {
                  io.to(roomId).emit("pointIncrease", player[winnerPlayer]);
                }
              
                
            });
        
        } catch (e) {
          console.log(e);
        }
      });
});

server.listen(port, "0.0.0.0", () => {
    console.log(`Server started and running on port ${port}`);
});


