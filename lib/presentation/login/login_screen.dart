import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';
import 'package:project_one_maybe_clean_architecture/main.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Home/HomeScreen.dart';
import 'package:project_one_maybe_clean_architecture/presentation/register/Activities.dart';

import '../register/register_screen.dart';
import '../sharedHELper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var resetPassController = TextEditingController();
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  bool isAbscure = true;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.height.toString());
    debugPrint(MediaQuery.of(context).size.width.toString());
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.uId),
              ),
            );
          }
          if (state is LoginSuccessState &&
              state.message.toString().contains("access_token")) {
            Shard.saveData(key: 'access_token', value: state.uId).then((value) {
              access_token = state.uId;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => isActivity? const Activities(isDelete: false):const HomeScreen(),
                ),
                (route) => false,
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: Scaffoldkey,
            body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                color: Color(
                  0xFFFAFAFA,
                ),
              ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 90, 45, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Color(0xFFF16B52),
                            fontSize: 34,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 550 ? 30 : 20,
                      ),
                      textFormFields(emailController, 'Email'),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 550 ? 30 : 20,
                      ),
                      textFormFields(passController, 'Password'),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 550 ? 30 : 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text(
                                "Forget Password",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: false,
                              activeColor: const Color.fromRGBO(0, 0, 0, 0.15),
                              onChanged: (newValue) {},
                              contentPadding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 550 ? 35 : 10,
                      ),
                      MaterialButton(
                        color: const Color.fromRGBO(37, 40, 71, 1),
                        minWidth: double.infinity,
                        height: 50,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          UserModel user = UserModel(
                            name: '',
                            password: passController.text,
                            Birth: '',
                            email: emailController.text,
                            passwordConfirmation: '',
                            phone: '',
                            created_at: '',
                            image: '',
                            id: 42,
                            email_verified_at: '',
                            updated_at: '',
                          );
                          LoginCubit.get(context).userLogin(user);
                        },
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text('You don’t have an account?',
                                style: TextStyle(fontWeight: FontWeight.w400)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Create new one',
                              style: TextStyle(
                                  color: Color.fromRGBO(241, 107, 82, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textFormFields(var controllerVar, String label) {
    return Material(
      shadowColor: const Color(0xFFFAFAFA),
      elevation: 5,
      borderRadius: BorderRadius.circular(50.0),
      color: const Color(0xFFFAFAFA),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFFB4B3B3),
          ),
          fillColor: const Color(0xFFFAFAFA),
          contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          labelText: label,
        ),
        controller: controllerVar,
        keyboardType: TextInputType.text,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'the password must not be empty';
          }
          return null;
        },
      ),
    );
  }
}
