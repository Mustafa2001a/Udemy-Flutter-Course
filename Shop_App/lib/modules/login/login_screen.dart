import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit_login.dart';
import 'package:shop_app/modules/login/status_login.dart';
import 'package:shop_app/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

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
      //appBar: AppBar(),
      
      body: SafeArea(
        child: BlocConsumer<LoginCubit,LoginStates>(
            listener: (context, state)async{

              if(state is LoginSuccessState){
                print(state.loginModel!.data!.token);
                if(state.loginModel!.status == true){

               //   flutterToast(text: state.loginModel!.message??'',state: ToastStates.SUCCESS);

                  await CacheHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then(
                          (value) => ReplaceNavigat(context, ShopLayout()))
                    ;

                }else{

                  flutterToast(
                      text: state.loginModel!.message??'',
                      state: ToastStates.ERROR
                  );
                }
              }
            },
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
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
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              ' Login now to check our hot offers',
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
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
                                labelStyle: TextStyle(
                                    fontFamily: 'Jannah',
                                    color: Colors.grey[800]
                                ),
                                enabledBorder: OutlineInputBorder(),
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
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => defaultButton(
                                function: (){
                                  if(formkey.currentState!.validate()){
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passController.text
                                    );
                                  }

                                },
                                text: 'LOGIN',
                                //bacground: Colors.blue[600]!,
                                radius: 10.0,
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t hava an account ? ',style: Theme.of(context).textTheme.subtitle1),
                                TextButton(
                                  onPressed: (){
                                    ReplaceNavigat(context, RegisterScreen());
                                  },
                                  child: Text('Register Now',
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                        color: Colors.indigo
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ),
    );
  }
}
