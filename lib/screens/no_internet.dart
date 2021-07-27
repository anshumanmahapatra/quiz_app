import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NoInternet {
  noInternet(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
         const SliverAppBar(
            centerTitle: true,
            title: Text(
              'Quiz App',
              style: TextStyle(color: Color(0xFF1E1B17)),
            ),
            backgroundColor: Color(0xFFFAD410),
            foregroundColor: Color(0xFF1E1B17),
            toolbarHeight: 50,
            elevation: 0,
            floating: true,
            
          ),
        SliverToBoxAdapter(
              child: Container(
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
                        children: const <Widget>[
                          Text(
                            "No Internet. Make Sure you have an Active Internet Connection",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
