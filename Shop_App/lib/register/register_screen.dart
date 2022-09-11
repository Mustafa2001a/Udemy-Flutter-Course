import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';

import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/register/cubit_register.dart';
import 'package:shop_app/register/status_register.dart';
import 'package:shop_app/shared/components/components.dart';

import 'package:shop_app/shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var formkey = GlobalKey<FormState>();

    bool isPassShow = true;
    IconData suf = Icons.visibility;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) async {
          if(state is RegisterSuccessState){
            if(state.loginModel!.status == true){
              print(state.loginModel!.message);
              print(state.loginModel!.data!.name);
              print(state.loginModel!.data!.token);
              await CacheHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then(
                      (value){
                        token = state.loginModel!.data!.token;
                        ReplaceNavigat(context, ShopLayout());
                      });
            }else{

              flutterToast(
                  text: state.loginModel!.message??'',
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder:(context, state) =>  Scaffold(
          body: SafeArea(
              child: Container(
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
                          'Register',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          ' Register now to check our hot offers',
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
                            return 'Name should not be empty';
                          }
                        },
                            prefix: Icons.person,
                            controller: nameController,
                            input_type: TextInputType.name,
                            lb_text: 'Name'
                        ),
                        SizedBox(
                          height: 25.0,
                        ),

                        defaultFormField(validFuction: (value) {
                          if(value!.isEmpty){
                            return 'Email should not be empty';
                          }
                        },
                            prefix: Icons.email,
                            controller: emailController,
                            input_type: TextInputType.emailAddress,
                            lb_text: 'Email Address'
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPassShow,
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
                            suffixIcon: IconButton(
                              icon: isPassShow? Icon(suf): Icon(Icons.visibility_off),
                              onPressed: (){
                                isPassShow = !isPassShow;
                            },
                            ),


                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormField(validFuction: (value) {
                          if(value!.isEmpty){
                            return 'Phone should not be empty';
                          }
                        },
                            prefix: Icons.phone,
                            controller: phoneController,
                            input_type: TextInputType.phone,
                            lb_text: 'Phone'
                        ),
                        SizedBox(
                          height: 35.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: (){
                              if(formkey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
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
                            Text('You hava an account ? ',style: Theme.of(context).textTheme.subtitle1),
                            TextButton(
                              onPressed: (){
                                ReplaceNavigat(context, LoginScreen());
                              },
                              child: Text('Login',
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
          ),
              ),
        ),
      ),
    );
  }
}
