import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/network/firebase/firebase_functions.dart';
import 'package:to_do/screens/create_account.dart';

import '../my_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  var emailController=TextEditingController();
  var PassController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return Scaffold(
      //another way other than single child to avoid keyboard over flow
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
      body:

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
                  SizedBox(height: 100,),
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
                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: (){
                    if(formKey.currentState!.validate())
                      {
                        FireBaseFunctions.Login(emailController.text, 
                            PassController.text,
                            (value){
                          showDialog(context: context,barrierDismissible: false ,
                              builder: (context) =>
                              AlertDialog(

                                title:Text("Error"),
                                  content: Text(value),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  },
                                      child:Text( "OK")),
                                ],
                              ),);
                            },
                            (){
                          provider.initUser();
                          Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                            }
                        );

                      }
                  }
                      , child:Text("Login") ),
                  SizedBox(height: 30,),
                  Row(

                    children: [
                      SizedBox(width: 10,),
                      Text("Don't have an account ?",
                      style: GoogleFonts.quicksand(
                        fontSize:12,
                        color: Colors.black54
                      ),),
                      SizedBox(height: 4,),
                      TextButton(onPressed: (){
                        Navigator.pushReplacementNamed(context, CreateAcoount.routeName);
                      },
                          child: Text("Create Account"))
                    ],
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
