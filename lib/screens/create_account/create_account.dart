import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do/network/firebase/firebase_functions.dart';
import 'package:to_do/screens/create_account/sign_up_viewmodel.dart';
import 'package:to_do/shared/base.dart';

import '../../home_layout/home_layout.dart';
import '../../my_provider.dart';
import '../../shared/styles/app_colors.dart';
import '../login/login.dart';
import 'create_account_connector.dart';

class CreateAcoount extends StatefulWidget {
  static const String routeName = "CreateAcoountScreen";

  @override
  State<CreateAcoount> createState() => _CreateAcoountState();
}

class _CreateAcoountState extends BaseView<SignUpViewModel, CreateAcoount> implements CreateAccountConnector {



  @override
  SignUpViewModel initViewModel() {
    // TODO: implement initViewModel
    return SignUpViewModel();
  }

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var PassController = TextEditingController();

  var nameController = TextEditingController();

  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Task Master",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: 200,
                height: 200,
                color: Colors.transparent, // Container background color
                child: Image.asset('assets/time2.png'), // Replace with your image path
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Create Account",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black26,
                                      fontSize: 30,
                                    )),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter name";
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Name"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.blue))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: ageController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    label: Text("Age"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.blue))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!);
                                  if (value.isEmpty) {
                                    return "please enter email";
                                  } else if (!emailValid) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Email"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.blue))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: PassController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter Password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Password"),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.blue),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: darkPurple2),
                                onPressed: () {
                                  // viewModel.SignUp(emailController.text,
                                  //     PassController.text, nameController.text, int.parse(ageController.text));
                                  FireBaseFunctions.createAcoount(
                                      nameController.text,
                                      int.parse(ageController.text),
                                      emailController.text,
                                      PassController.text, () {
                                        provider.initUser();
                                    Navigator.pushReplacementNamed(
                                        context, HomeLayout.routeName);
                                  });
                                },
                                child: Text("Sign Up")),

                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "I've an account ?",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.black),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, LoginScreen.routeName);
                                    },
                                    child: Text("Login")),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

}
