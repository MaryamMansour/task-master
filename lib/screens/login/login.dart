import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/network/firebase/firebase_functions.dart';
import 'package:to_do/screens/create_account/create_account.dart';
import 'package:to_do/screens/login/connector.dart';
import 'package:to_do/screens/login/login_viewmodel.dart';
import 'package:to_do/shared/base.dart';

import '../../my_provider.dart';
import '../../shared/styles/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel, LoginScreen> implements LoginConnsector  {
  var emailController=TextEditingController();

  var PassController = TextEditingController();

  var formKey=GlobalKey<FormState>();


  void initState(){
    super.initState();
    viewModel.connector=this;
  }

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) =>  Scaffold(
        //another way other than single child to avoid keyboard over flow
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Task Master",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ),
        body:


        Column(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10), // Adjust as needed
            //   child: Image.asset(
            //     'assets/time.jpg',
            //     fit: BoxFit.fill,
            //   ),
            // ),

             Container(
              width: 200,
              height: 200,
              color: Colors.transparent, // Container background color
              child: Image.asset('assets/time.jpg'), // Replace with your image path
            ),

            Card(
              margin: EdgeInsets.all(20),
              child: Expanded(

                child: Container(

                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Login",
                            style:
                            Theme.of(context).textTheme.bodyLarge!.
                            copyWith(color: Colors.black26,
                              fontSize: 30,)),
                        SizedBox(height: 50,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value){
                              bool emailValid =
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if( value.isEmpty){
                                return "please enter email";
                              }
                              else if (!emailValid)
                                {
                                  return "Please enter valid email";
                                }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.blue
                                )
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextFormField(
                             controller: PassController,
                             obscureText: true,
                             validator: (value){
                               if(value==null || value.isEmpty){
                                 return "please enter Password";
                               }
                               return null;
                             },
                            decoration: InputDecoration(
                                label: Text("Password"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue
                                    ),
                                )
                            ),
                        ),
                         ),

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: darkPurple2,)
                            ,onPressed: (){
                          if(formKey.currentState!.validate())
                             {
                               viewModel.login(emailController.text, PassController.text);
                             }
                            //   FireBaseFunctions.Login(emailController.text,
                            //       PassController.text,
                            //       (value){
                            //     showDialog(context: context,barrierDismissible: false ,
                            //         builder: (context) =>
                            //         AlertDialog(
                            //
                            //           title:Text("Error"),
                            //             content: Text(value),
                            //           actions: [
                            //             ElevatedButton(onPressed: (){
                            //               Navigator.pop(context);
                            //             },
                            //                 child:Text( "OK")),
                            //           ],
                            //         ),);
                            //       },
                            //       (){
                            //     provider.initUser();
                            //     Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                            //       }
                            //   );
                            //
                            // }
                        }
                            , child:Text("Login") ),

                        Row(

                          children: [
                            SizedBox(width: 10,),
                            Text("Don't have an account ?",
                            style: GoogleFonts.quicksand(
                              fontSize:12,
                              color: Colors.black54
                            ),),
                            SizedBox(height: 4,),
                            TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.black),
                                  onPressed: (){
                              Navigator.pushReplacementNamed(context, CreateAcoount.routeName);
                            },
                                child: Text("Create Account"))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }


}
