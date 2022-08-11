import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';

import '../login/login_screen.dart';
import 'Activities.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passConfirmController = TextEditingController();
  var numberController = TextEditingController();
  var birthController = TextEditingController();
  var isAbscure = true;

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.height.toString());
    debugPrint(MediaQuery.of(context).size.width.toString());
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.success),
              ),
            );
          }
          if (state is RegisterSuccessState &&
              state.success.contains("User successfully registered")) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                color: Color(
                  0xFFFAFAFA,
                ),
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(45, 90, 45, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Color(0xFFF16B52),
                              fontSize: 34,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        textFormFields(nameController, 'Username'),
                        const SizedBox(
                          height: 20,
                        ),
                        textFormFields(emailController, 'Email'),
                        const SizedBox(
                          height: 20,
                        ),
                        textFormFields(passController, 'Password'),
                        const SizedBox(
                          height: 20,
                        ),
                        textFormFields(
                            passConfirmController, 'Confirm Password'),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: textFormFields(
                                  numberController, 'Phone Number'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: textFormFields(birthController, 'Birth'),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text(
                                  'by clicking this button you agree with our terms and conditions',
                                  style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                value: RegisterCubit.get(context).by,
                                activeColor:
                                    const Color.fromRGBO(0, 0, 0, 0.15),
                                onChanged: (newValue) {
                                  RegisterCubit.get(context).by =
                                      RegisterCubit.get(context).changeBool(
                                          RegisterCubit.get(context).by,
                                          newValue);
                                },
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
                            "Sign Up",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () async {
                            UserModel user = UserModel(
                              name: nameController.text,
                              email: emailController.text,
                              phone: numberController.text,
                              Birth: birthController.text,
                              password: passController.text,
                              passwordConfirmation: passConfirmController.text,
                              updated_at: '',
                              image: '',
                              id: 3,
                              created_at: '',
                              email_verified_at: '',
                            );
                            RegisterCubit.get(context).userRegister(user);
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Color.fromRGBO(241, 107, 82, 1),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
