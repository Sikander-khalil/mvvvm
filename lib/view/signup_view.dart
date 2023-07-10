import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/rounded_btn.dart';
import '../utilis/utilis.dart';
import '../view_model/auth_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

//Why use Dispose because These values are release in ram after going to next page. App efficient are good


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _obscurePassword.dispose();
    emailController.dispose();
    passController.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final authviewmodel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(

          title: Text("Signup Page"),
        ),
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: "Email",

                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email)
                  ),
                  onFieldSubmitted: (value){

                    Utilis.fieldfocusChange(context, emailFocusNode, passFocusNode);

                  },
                ),
                ValueListenableBuilder(valueListenable: _obscurePassword,
                    builder: (context,child, value){
                      return  TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: passFocusNode,
                        obscureText: _obscurePassword.value,
                        controller: passController,
                        decoration: InputDecoration(
                          labelText: "Pass",

                          hintText: 'Enter your pass',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                              onTap: (){

                                _obscurePassword.value = !_obscurePassword.value;
                              },

                              child: Icon(
                                  _obscurePassword.value ?  Icons.visibility_off_outlined
                                      : Icons.visibility

                              )
                          ),
                        ),
                      );

                    }),
                SizedBox(height: height * .1,),
                RoundedBtn(

                  title: 'Signup',
                  loading: authviewmodel.signuploading,

                  onPress: (){
                    if(emailController.text.isEmpty){

                      Utilis.flushBarErrorMessage("Please Enter Email", context);

                    }else if(passController.text.isEmpty){

                      Utilis.flushBarErrorMessage("Please Enter Password", context);


                    }else if(passController.text.length < 6){
                      Utilis.flushBarErrorMessage("Please Enter 6 digit passsword", context);


                    }else{

                      Map data = {

                        'email' : emailController.text.toString(),
                        'password' : passController.text.toString()
                      };
                      authviewmodel.RegisterApi(data, context);
                      print("api hit");
                    }


                  },
                ),




              ],
            ))
    );
  }
}
