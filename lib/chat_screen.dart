import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

import 'services/gemini_service.dart';


class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

}



class _ChatScreenState extends State<ChatScreen> {


  // 🎤 Speech Recognition
  final stt.SpeechToText speech = stt.SpeechToText();


  // Controllers
  final TextEditingController controller =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();



  // 🔊 Text To Speech
  late FlutterTts tts;



  bool isLoading = false;

  bool isDarkMode = false;

  bool isListening = false;

  bool autoSpeak = true;



  List<Map<String,dynamic>> messages = [

    {
      "text":
      "Hello! I am LifeLine AI 🤖\nHow can I help you today?",
      "isUser": false
    }

  ];




  @override
  void initState() {

    super.initState();

    initializeTTS();

    loadMessages();

  }





  // 🔊 Initialize TTS
  Future<void> initializeTTS() async {

    tts = FlutterTts();


    await tts.setLanguage(
        "en-US"
    );


    await tts.setSpeechRate(
        0.5
    );


  }





  // LOAD CHAT HISTORY

  Future<void> loadMessages() async {


    try {

      final prefs =
      await SharedPreferences.getInstance();


      String? data =
      prefs.getString(
          "chat_history"
      );


      if(data != null){


        setState(() {

          messages =
          List<Map<String,dynamic>>
              .from(
              jsonDecode(data)
          );


        });


      }


    }
    catch(e){

      debugPrint(
          "Load Error $e"
      );

    }


  }





  // SAVE CHAT HISTORY

  Future<void> saveMessages() async {


    try {


      final prefs =
      await SharedPreferences.getInstance();


      await prefs.setString(

          "chat_history",

          jsonEncode(messages)

      );


    }

    catch(e){

      debugPrint(
          "Save Error $e"
      );

    }

  }





  // AUTO SCROLL

  void scrollToBottom(){


    Future.delayed(
        const Duration(milliseconds:200),
            (){

          if(scrollController.hasClients){


            scrollController.animateTo(

              scrollController.position.maxScrollExtent,

              duration:
              const Duration(milliseconds:300),

              curve:
              Curves.easeOut,

            );


          }


        }
    );


  }






  // 🎤 VOICE INPUT

  Future<void> listenVoice() async {



    if(isListening){


      await speech.stop();


      setState(() {

        isListening=false;

      });


      return;


    }



    bool available =
    await speech.initialize(


      onStatus:(status){


        if(status=="done"){


          if(mounted){

            setState(() {

              isListening=false;

            });

          }


        }


      },


      onError:(error){


        if(mounted){

          setState(() {

            isListening=false;

          });

        }


      },


    );





    if(!available){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
              "Speech recognition not available"
          ),

        ),

      );


      return;


    }





    setState(() {

      isListening=true;

    });





    speech.listen(


      listenFor:
      const Duration(seconds:10),


      pauseFor:
      const Duration(seconds:3),




      onResult:(result){



        setState(() {


          controller.text =
              result.recognizedWords;



          controller.selection =
              TextSelection.fromPosition(

                TextPosition(

                  offset:
                  controller.text.length,

                ),

              );


        });




      },


    );



  }







  // 🔊 SPEAK AI RESPONSE

  Future<void> speak(String text) async {


    try {


      await tts.stop();


      await tts.speak(text);



    }

    catch(e){

      debugPrint(
          "TTS Error $e"
      );

    }


  }







  // SEND MESSAGE

  Future<void> sendMessage() async {


    if(
    controller.text.trim().isEmpty ||
        isLoading
    ){

      return;

    }



    String userMessage =
    controller.text.trim();



    controller.clear();




    setState(() {


      messages.add({

        "text":userMessage,

        "isUser":true


      });


      isLoading=true;


    });





    await saveMessages();


    scrollToBottom();






    try{


      String aiReply =
      await GeminiService.askGemini(
          userMessage
      );




      setState((){


        messages.add({

          "text":aiReply,

          "isUser":false


        });



        isLoading=false;



      });




      await saveMessages();


      scrollToBottom();




      if(autoSpeak){

        await speak(aiReply);

      }




    }

    catch(e){



      setState((){


        isLoading=false;


        messages.add({

          "text":
          "Something went wrong.\n$e",

          "isUser":false

        });



      });


    }




  }








  @override
  Widget build(BuildContext context) {


    return Theme(


      data:
      isDarkMode
          ?
      ThemeData.dark()
          :
      ThemeData.light(),



      child: Scaffold(



        appBar: AppBar(


          title:
          const Text(
              "LifeLine AI"
          ),



          centerTitle:true,


          backgroundColor:
          Colors.red,



          foregroundColor:
          Colors.white,



          actions:[



            IconButton(

              icon:
              Icon(
                autoSpeak
                    ?
                Icons.volume_up
                    :
                Icons.volume_off,
              ),



              onPressed:(){


                setState((){

                  autoSpeak =
                  !autoSpeak;


                });


              },


            ),




            IconButton(

              icon:
              Icon(

                isDarkMode
                    ?
                Icons.light_mode
                    :
                Icons.dark_mode,

              ),


              onPressed:(){


                setState((){


                  isDarkMode =
                  !isDarkMode;


                });


              },


            )



          ],


        ),






        body:Column(


          children:[




            Expanded(


              child:
              ListView.builder(


                controller:
                scrollController,


                itemCount:
                messages.length,



                itemBuilder:
                    (context,index){


                  final msg =
                  messages[index];



                  return Align(


                    alignment:
                    msg["isUser"]

                        ?
                    Alignment.centerRight

                        :

                    Alignment.centerLeft,



                    child:
                    Container(


                      margin:
                      const EdgeInsets.all(8),



                      padding:
                      const EdgeInsets.all(14),



                      decoration:
                      BoxDecoration(


                        color:
                        msg["isUser"]

                            ?
                        Colors.blue

                            :
                        Colors.grey.shade300,



                        borderRadius:
                        BorderRadius.circular(12),


                      ),




                      child:
                      Text(

                        msg["text"],

                      ),



                    ),



                  );


                },


              ),


            ),






            if(isLoading)

              const CircularProgressIndicator(),





            Padding(


              padding:
              const EdgeInsets.all(10),




              child:
              Row(



                children:[



                  IconButton(

                    icon:
                    Icon(

                      isListening

                          ?
                      Icons.mic

                          :
                      Icons.mic_none,


                      color:
                      isListening
                          ?
                      Colors.red
                          :
                      null,

                    ),


                    onPressed:
                    listenVoice,


                  ),




                  Expanded(


                    child:
                    TextField(


                      controller:
                      controller,



                      decoration:
                      const InputDecoration(

                        hintText:
                        "Ask something...",


                        border:
                        OutlineInputBorder(),

                      ),



                    ),



                  ),




                  IconButton(


                    icon:
                    const Icon(
                        Icons.send
                    ),



                    onPressed:
                    sendMessage,


                  )



                ],



              ),



            )




          ],


        ),



      ),



    );


  }







  @override
  void dispose(){


    controller.dispose();


    scrollController.dispose();


    speech.stop();


    tts.stop();


    super.dispose();


  }


}