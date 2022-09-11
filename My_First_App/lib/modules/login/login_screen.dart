import 'package:flutter/material.dart';
import 'package:my_first_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool isPassShown = true;
  IconData sufx = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  defaultFormField(validFuction: (value) {
                    if(value!.isEmpty){
                      return 'Email should not be empty';
                    }
                  },controller: emailController, input_type: TextInputType.emailAddress, lb_text: 'Email Address'),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassShown,
                    validator: (value) {
                      if(value!.isEmpty)
                      return 'Password should not be empty';
                      },
                    decoration: InputDecoration(
                      //hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(icon: isPassShown?Icon(sufx): Icon(Icons.visibility_off),onPressed: (){
                        setState((){
                          isPassShown = !isPassShown;
                        });
                      },
                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  defaultButton(function: (){
                    if(formkey.currentState!.validate()){
                      print(emailController.text);
                    }
                   },
                    text: 'LOGIN',
                    bacground: Colors.blue[600]!,
                    radius: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t hava an account? '),
                      TextButton(onPressed: (){}, child: Text('Register Now'),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
