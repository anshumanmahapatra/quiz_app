import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({Key ?key, this.message = "There was an unknown error." }) : super(key: key);


  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Error', style: TextStyle(color: Color(0xFF1E1B17)),),
        backgroundColor: const Color(0xFFFAD410),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Lottie.asset("assets/oops.json"),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(message,textAlign: TextAlign.center,style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          child: const Text("Try Again", style: TextStyle(color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFAD410),
                          ),
                          onPressed: ()=> Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}