import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';


class CreateAcoount extends StatelessWidget {
  static const String routeName = "CreateAcoountScreen";

    var formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var PassController = TextEditingController();
  var nameController=TextEditingController();
  var ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "ToDo",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Expanded(

            child: Container(

              child: Form(
                key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Craete Acoount",
                          style:
                          Theme.of(context).textTheme.bodyLarge!.
                          copyWith(color: Colors.black26,
                            fontSize: 30,)),
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value){

                            if(value==null|| value.isEmpty){
                              return "please enter name";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text("Name"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.blue
                                  )
                              )
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                              label: Text("Age"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.blue
                                  )
                              )
                          ),
                        ),
                      ),
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
                      SizedBox(height: 70,),

                      ElevatedButton(onPressed: (){},
                          child:Text("Sign Up") ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text("I've an account ?",
                            style: GoogleFonts.quicksand(
                                fontSize:12,
                                color: Colors.black54
                            ),),
                          SizedBox(height: 4,),
                          TextButton(onPressed: (){
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          },
                              child: Text("Login")),

                        ],
                      ),SizedBox(height: 20,),


                    ],
                  ),
                ),
              ),
            ),
        ),
        ),

    );
  }
}
