import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Util.dart';
import 'package:food_app/itemdetails/itemdetailsscreen.dart';
import 'package:food_app/models/item.dart';
import 'package:food_app/home/widgets/seachbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class TrendingItems extends StatelessWidget {


// This method is to get the trending items from the Items table, basically we getting the items with 4.4 or above rating
  // and this method will return us the List

  Future<List<Item>> getTrendingFoodItems() async
  {
    List<Item> trendingFoodItemsList = [];

    try
    {
      var res = await http.post(
          Uri.parse(Util.trendingItems)
      );

      if(res.statusCode == 200)
      {
        var responseBodyOfTrending = jsonDecode(res.body);
        if(responseBodyOfTrending["success"] == true)
        {
          for (var eachRecord in (responseBodyOfTrending["foodItemsData"] as List)) {
            trendingFoodItemsList.add(Item.fromJson(eachRecord));
          }
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Error, status code is not 200");
      }
    }
    catch(errorMsg)
    {
      Fluttertoast.showToast(msg: errorMsg.toString());

    }

    return trendingFoodItemsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTrendingFoodItems(),
      builder: (context, AsyncSnapshot<List<Item>> dataSnapShot)
      {
        if(dataSnapShot.connectionState == ConnectionState.waiting)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(dataSnapShot.data == null)
        {
          return const Center(
            child: Text(
              "No Trending item found",
            ),
          );
        }
        if(dataSnapShot.data!.isNotEmpty)
        {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              itemCount: dataSnapShot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index)
              {
                Item eachFoodItemData = dataSnapShot.data![index];
                return GestureDetector(
                  onTap: ()
                  {
                    
Get.to(ItemDetailsScreen(itemInfo: eachFoodItemData));
                  },
                  child: Container(
                    width: 200,
                    // here we are using if condition because if index == 0 means for first item in the list margin will be 16
                    // and for others it will be 8
                    margin: EdgeInsets.fromLTRB(
                      index == 0 ? 16 : 8,
                      10,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8,
                      10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      boxShadow:
                      const [
                        BoxShadow(
                          offset: Offset(0,3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        //item imageView
                        // we use ClipRRect to curve the image from topleft and topright

                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                          child: FadeInImage(
                            height: 150,
                            width: 200,
                            fit: BoxFit.cover,
                            placeholder: const AssetImage("images/place_holder.png"),
                            image: NetworkImage(
                              eachFoodItemData.item_image!,
                            ),
                            imageErrorBuilder: (context, error, stackTraceError)
                            {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                ),
                              );
                            },
                          ),
                        ),

                        //item name & price
                        //rating stars & rating numbers
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //item name & price
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachFoodItemData.item_name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "\$ ${eachFoodItemData.item_prices[0].trim().replaceAll("[", "").replaceAll("]", "")}",

                                    style: const TextStyle(
                                      color: Colors.purpleAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8,),

                              //rating stars & rating numbers
                              Row(
                                children: [

                                  RatingBar.builder(
                                    initialRating: eachFoodItemData.item_rating!,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, c)=> const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (updateRating){},
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey,
                                    itemSize: 20,
                                  ),

                                  const SizedBox(width: 8,),

                                  Text(
                                    "(${eachFoodItemData.item_rating})",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        else
        {
          return const Center(
            child: Text("Empty, No Data."),
          );
        }
      },
    );
  }
}
