import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    if(state is LoadingUpdateUserData)
                      LinearProgressIndicator(
                        color: Colors.indigoAccent,
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      input_type: TextInputType.name,
                      validFuction: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }

                        return null;
                      },
                      lb_text: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      input_type: TextInputType.emailAddress,
                      validFuction: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                      lb_text: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      input_type: TextInputType.phone,
                      validFuction: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }

                        return null;
                      },
                      lb_text: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.indigoAccent,
                        ),
                        child: signOut(context),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(function: (){
                      if(formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          token: token,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text
                        );
                      }
                    }, text: 'UPDATE')
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
