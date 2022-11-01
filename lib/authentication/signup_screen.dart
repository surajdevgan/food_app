import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Util.dart';
import 'package:food_app/authentication/login_screen.dart';
import 'package:food_app/models/provinces_dropdown_list_items.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // as we are using getx so we are using .obs
  var isObscure = true.obs;

  var SelectedProvince;
  var SelectedGender; //no radio button will be selected
  //String SelectedGender = "male"; //if you want to set default value


  validateUserEmail()
  async {
try{

  var res = await http.post(Uri.parse(Util.validateEmail),
    body: {
// this 'user_email' is the same name that we have in php file
    'user_email' : emailController.text.trim(),
    },
  );
if(res.statusCode == 200)
  {
var resBodyOfValidateEmail = jsonDecode(res.body);

if(resBodyOfValidateEmail['emailFound'] == true)
  {
Fluttertoast.showToast(msg: "Email already exist");

  }

else{
// else save new user to database
  // register

  registerNewUser();
}
    
  }

}

catch(e)
    {

      Fluttertoast.showToast(msg: e.toString());

    }



  }

  registerNewUser() async {
User userModel = User(
  1,
  nameController.text.trim(),
  emailController.text.trim(),
  SelectedProvince.toString().trim(),
  SelectedGender.toString().trim(),
  passwordController.text.trim(),
);

try  {
  
 var res = await http.post(
    Uri.parse(Util.signUp),
    body: userModel.toJson(),
  );

 if(res.statusCode == 200)
   {

     var resBodyOfSignUp = jsonDecode(res.body);
     if(resBodyOfSignUp['success'] == true)
       {

         Fluttertoast.showToast(msg: "SignUp Successfully");
         Get.to(LoginScreen());
       }

     else{
       Fluttertoast.showToast(msg: "Error");


     }
   }
}
catch (e)
    {

      Fluttertoast.showToast(msg: e.toString());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: LayoutBuilder(

        builder: (context, cons)
        {
          return ConstrainedBox(constraints: BoxConstraints(
            minHeight: cons.maxHeight,

          ),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  // signup screen header
                  SizedBox(
                    // this MediaQuery will automatically adjust the width according to the phone screen
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset("images/login.jpeg"),
                  ),

                  // signup form
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18,50,18,0),
                    child: Container(
                      decoration: const BoxDecoration(

                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(

                                children: [

                                  // name
                                  TextFormField(

                                    controller: nameController,
                                    validator: (val) => val == ""? "Please enter name": null,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.black,

                                        ),

                                        hintText: "Name...",
                                        border: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),

                                        enabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,

                                        ),

                                        fillColor: Colors.purpleAccent,
                                        filled: true

                                    ),



                                  ),

                                  const SizedBox(height: 18),


                                  // email
                                  TextFormField(

                                    controller: emailController,
                                    validator: (val) => val == ""? "Please enter email": null,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: Colors.black,

                                        ),

                                        hintText: "Email...",
                                        border: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),

                                        enabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,

                                        ),

                                        fillColor: Colors.purpleAccent,
                                        filled: true

                                    ),


                                  ),


                                  // to make the space between email and password field we are using sizedbox widget
                                  const SizedBox(height: 18),

                                  Container(
                                    height: 45,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.purpleAccent,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Center(
                                      child: DropdownButton<String>(
                                          hint: const Text('Choose Your Province', style: TextStyle(color: Colors.black),),
                                          isExpanded: true,
                                          dropdownColor: Colors.purpleAccent,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          style: const TextStyle(color: Colors.black, fontSize: 17.0),
                                          onChanged: (String? changedValue) {
                                            SelectedProvince = changedValue;
                                            setState(() {
                                              SelectedProvince;
                                            });
                                          },
                                          value: SelectedProvince,
                                          items:
                                          ProvincesListItems.provinces().map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList()),
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  Container(
                                    height: 140,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.purpleAccent,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Column(
                                      children:  [
                                        const Text("What is your gender?"),

                                        RadioListTile(
                                          title: const Text("Male"),
                                          value: "Male",
                                          groupValue: SelectedGender,
                                          onChanged: (value){
                                            setState(() {
                                              SelectedGender = value.toString();
                                            });
                                          },
                                        ),

                                        RadioListTile(
                                          title: const Text("Female"),
                                          value: "Female",
                                          groupValue: SelectedGender,
                                          onChanged: (value){
                                            setState(() {
                                              SelectedGender = value.toString();
                                            });
                                          },
                                        ),

                                      ],


                                    ),

                                  ),

                                  const SizedBox(height: 18),

                                  // password
                                  // we are using Bbx getx bcoz password is changing its state when we press on show or hide password icon
                                  Obx(() =>
                                      TextFormField(

                                    controller: passwordController,
                                    obscureText: isObscure.value,
                                    validator: (val) => val == ""? "Please enter password": null,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_sharp,
                                          color: Colors.black,

                                        ),

                                        suffixIcon: Obx(
                                              () => GestureDetector(
                                            onTap: ()
                                            {
                                              isObscure.value = !isObscure.value;

                                            },
                                            child: Icon(
                                              isObscure.value ? Icons.visibility_off: Icons.visibility,
                                              color: Colors.black,

                                            ),
                                          ),

                                        ),

                                        hintText: "Password...",

                                        border: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),

                                        enabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,

                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,

                                        ),

                                        fillColor: Colors.purpleAccent,
                                        filled: true

                                    ),


                                  )
                                  ),

                                  const SizedBox(height: 18),


                                  // Button
                                  Material(
                                    color: Colors.purpleAccent,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: ()
                                      {
                                      //  Fluttertoast.showToast(msg: SelectedGender);
                 if(formKey.currentState!.validate())
            {

     // validate the email
    validateUserEmail();
  }
},

                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          "SignUp",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,

                                          ),
                                        ),
                                      ),

                                    ),
                                  ),

                                ],

                              ),
                            ),

                            // now ceate the row for signup text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center, // this is to make the text in center
                              children: [
                                const Text("Already have an Account?", style: TextStyle(color: Colors.black, fontSize: 16),),

                                TextButton(onPressed: (){

                                  Get.to(LoginScreen());

                                }, child: const Text("SignIn Here",
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                )
                              ],

                            ),
                          ],

                        ),
                      ),
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
}
