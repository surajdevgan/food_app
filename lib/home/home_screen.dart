import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Util.dart';
import 'package:food_app/models/item.dart';
import 'package:food_app/home/widgets/allfooditems.dart';
import 'package:food_app/home/widgets/seachbar.dart';
import 'package:food_app/home/widgets/trending.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
                // this to move the Trending to the left side
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 16,),

          //search bar widget
          SearchBar(),

          const SizedBox(height: 24,),

          //trending-popular items
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Trending",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

// Trending Items Widget
          TrendingItems(),

          const SizedBox(height: 24,),

          //all new collections/items
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "New Collections",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

// All items widget
             AllFoodItems(),
        ],
      ),
    );
  }

}
