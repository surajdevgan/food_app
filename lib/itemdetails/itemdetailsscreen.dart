import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Util.dart';

import 'package:food_app/models/item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/sharedPreferences/current_user_shared_prefs_data.dart';


import 'package:get/get.dart';

import '../controllers/item_details_controller.dart';


class ItemDetailsScreen extends StatefulWidget {
  Item? itemInfo;

  ItemDetailsScreen({this.itemInfo});



  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();


}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {


  final itemDetailsController = Get.put(ItemDetailsController());

  // this is to get the user details from shared preferences
  final currentUserData = Get.put(CurrentUserData());


  addItemToCart() async
  {
    try {
      var res = await http.post(
        Uri.parse(Util.cartItems),
        body: {
          // user id we are getting from shared preferences
          "user_id": currentUserData.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
          "quantity": itemDetailsController.quantityItem.toString(),
          "size": widget.itemInfo!.item_sizes![itemDetailsController.sizeItem.value].replaceAll("[","").replaceAll("]",""),
         "item_total_price" : widget.itemInfo!.item_prices![itemDetailsController.sizeItem.value].replaceAll("[","").replaceAll("]","")

        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
          {
        var resBodyOfAddCart = jsonDecode(res.body);
        if (resBodyOfAddCart['success'] == true) {
          Fluttertoast.showToast(msg: "item saved to Cart Successfully.");
        }
        else {
          Fluttertoast.showToast(
              msg: "Error Occur. Item not saved to Cart and Try Again.");
        }
      }
      else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    }
    catch (errorMsg) {
      Fluttertoast.showToast(msg: errorMsg.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Stack(
        children: [

          //Item Image
          FadeInImage(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            width: MediaQuery
                .of(context)
                .size
                .width,
            fit: BoxFit.cover,

            placeholder: const AssetImage("images/place_holder.png"),
            image: NetworkImage(
              widget.itemInfo!.item_image!,
            ),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),

          // Item Information
          Align(
            alignment: Alignment.bottomCenter,
            child: itemInfoWidget(),

          ),


          // Item Information

        ],
      ),

    );
  }

  itemInfoWidget() {
    return Container(
// here we are covering 60% (0.6) of the total height on the screen to display the items info
      height: MediaQuery
          .of(Get.context!)
          .size
          .height * 0.6,
      width: MediaQuery
          .of(Get.context!)
          .size
          .width,
      decoration: const BoxDecoration(
        color: Colors.black,
        // border radius will make your container circular from topleft and topight by 30
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.purpleAccent,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
// we lot of information so we are using scroolview
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 30,),

            //name
            Text(
              widget.itemInfo!.item_name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10,),

            //rating + rating num
            //tags
            //price
            //quantity item counter
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //rating + rating num
                //tags
                //price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //rating + rating num
                      Row(
                        children: [

                          //rating bar
                          RatingBar.builder(
                            initialRating: widget.itemInfo!.item_rating!,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, c) =>
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (updateRating) {},
                            ignoreGestures: true,
                            unratedColor: Colors.grey,
                            itemSize: 20,
                          ),

                          const SizedBox(width: 8,),

                          //rating num
                          Text(
                            "(${widget.itemInfo!.item_rating})",
                            style: const TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 10),

                      //tags
                      Text(
                        widget.itemInfo!.item_tags!.toString().trim().replaceAll(
                            "[", "").replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //price
                      Obx(() {
                        return Text(

                          //    if(widget.itemInfo!.item_size!.toString().replaceAll("[", "")[itemDetailsController.sizeItem.value],)


                          "\$${widget.itemInfo!.item_prices[itemDetailsController.sizeItem.value].trim()
                              .replaceAll("[","")
                              .replaceAll("]","")}",
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      ),

                      const SizedBox(height: 8),


                    ],
                  ),
                ),

                //quantity item counter
                Obx(
                      () =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //+
                          IconButton(
                            onPressed: () {

                              // shorter version
                              itemDetailsController.quantityItem + 1;
                              //  itemDetailsController.setQuantityItem(itemDetailsController.quantity + 1);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline, color: Colors.white,),
                          ),
                          Text(
                            itemDetailsController.quantityItem.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //-
                          IconButton(
                            onPressed: () {
                              if (itemDetailsController.quantityItem > 1) {
                                // short version
                                itemDetailsController.quantityItem - 1;
                                // itemDetailsController.setQuantityItem(itemDetailsController.quantity - 1);                           // itemDetailsController.setQuantityItem(itemDetailsController.quantity - 1);
                              }
                              else {
                                Fluttertoast.showToast(
                                    msg: "Quantity must be 1 or greater than 1");
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.white,),
                          ),
                        ],
                      ),
                ),
              ],
            ),

            //sizes
            const Text(
              "Size:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),
            // This is the Widget for selecting the size
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(
                  widget.itemInfo!.item_sizes!.length, (index) {
                return Obx(
                      () =>
                      GestureDetector(
                        onTap: () {
                          itemDetailsController.sizeItem(index);
                        },
                        child: Container(
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: itemDetailsController.sizeItem == index
                                  ? Colors.transparent
                                  : Colors.grey,
                            ),
                            color: itemDetailsController.sizeItem == index
                                ? Colors.purpleAccent.withOpacity(0.4)
                                : Colors.black,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.itemInfo!.item_sizes![index].trim().replaceAll(
                                "[","").replaceAll("]",""),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                );
              }),
            ),
            const SizedBox(height: 20),

            //This is the text widget for the description
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemInfo!.item_description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            //add to cart button
            Material(
              elevation: 4,
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  addItemToCart();
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),


          ],

        ),

      ),
    );
  }
}
