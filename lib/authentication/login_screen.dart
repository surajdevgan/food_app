import 'package:flutter/material.dart';
import 'package:food_app/authentication/signup_screen.dart';
import 'package:get/get.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // as we are using getx so we are using .obs
  var isObscure = true.obs;

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
                // login screen header
                SizedBox(
                  // this MediaQuery will automatically adjust the width according to the phone screen
width: MediaQuery.of(context).size.width,
                  height: 285,
                  child: Image.asset("images/login.jpeg"),
                ),

 // login form
                Padding(
                  padding: const EdgeInsets.fromLTRB(18,100,18,0),
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

          // password
          // we are using Bbx getx bcoz password is changing its state when we press on show or hide password icon
Obx(() =>         TextFormField(

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


            },

            borderRadius: BorderRadius.circular(30),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 28,
              ),
child: Text(
  "Login",
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
      const Text("Don't have an Account?", style: TextStyle(color: Colors.black, fontSize: 16),),

      TextButton(onPressed: (){
Get.to(SignUpScreen());

      }, child: const Text("SignUp Here",
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
