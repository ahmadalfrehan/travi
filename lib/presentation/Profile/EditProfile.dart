import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/Bloc/Bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/Bloc/States.dart';
import 'package:project_one_maybe_clean_architecture/presentation/register/Activities.dart';

import '../../main.dart';

class EditProfile extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passConfirmController = TextEditingController();
  var numberController = TextEditingController();
  var birthController = TextEditingController();
  var isAbscure = true;

  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.height.toString());
    debugPrint(MediaQuery.of(context).size.width.toString());
    return BlocProvider(
      create: (BuildContext context) => TraviProfileBloc()..updateProfile(),
      child: BlocConsumer<TraviProfileBloc, ProfileStates>(
        listener: (context, state) {
          if (state is UpdatedProfilePhotoSuccessStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully updated the Photo'),
              ),
            );
          }
          if (state is UploadImageErrorStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('An Error Occured try again '),
                  backgroundColor: Colors.red),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (state is UploadImageLoadingStates)
                          const LinearProgressIndicator(),
                        if (state is UpdatedProfilePhotoLoadingStates)
                          const CircularProgressIndicator(),
                        Row(
                          children: const [
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Color(0xFFF16B52),
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 81,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor:
                                    const Color.fromRGBO(37, 40, 71, 1),
                                foregroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      TraviProfileBloc.get(context).linkPhoto ==
                                              null
                                          ? NetworkImage(imageUrl)
                                          : NetworkImage(
                                              TraviProfileBloc.get(context)
                                                  .linkPhoto
                                                  .toString(),
                                            ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                TraviProfileBloc.get(context)
                                    .getImageProfile(ImageSource.gallery);
                              },
                              child: const CircleAvatar(
                                child: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (TraviProfileBloc.get(context).imageProfile != null)
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(50.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  blurStyle: BlurStyle.normal,
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  offset: Offset(0, -0.8),
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.inner,
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                TraviProfileBloc.get(context)
                                    .uploadPhoto()
                                    .then((value) {
                                  TraviProfileBloc.get(context)
                                      .updateProfilePhoto(
                                          link: TraviProfileBloc.get(context)
                                              .linkPhoto
                                              .toString());
                                  TraviProfileBloc.get(context).imageProfile =
                                      null;
                                });
                              },
                              child: const Text('update Photo'),
                            ),
                          ),
                        const SizedBox(
                          height: 35,
                        ),
                        textFormFields(nameController, 'Username'),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.15),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                blurStyle: BlurStyle.normal,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.15),
                                offset: Offset(0, -0.8),
                                blurRadius: 10,
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const Activities(isDelete: false),
                                ));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(width: 30),
                                  Text(
                                    'Edit Activity',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFB4B3B3),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          //                      width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.15),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                blurStyle: BlurStyle.normal,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.15),
                                offset: Offset(0, -0.8),
                                blurRadius: 10,
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const Activities(isDelete: true),
                                ));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(width: 30),
                                  Text(
                                    'Delete Activity',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFB4B3B3),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          color: const Color.fromRGBO(37, 40, 71, 1),
                          minWidth: double.infinity,
                          height: 50,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () async {},
                        ),
                        const SizedBox(
                          height: 40,
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
            return 'the field must not be empty';
          }
          return null;
        },
      ),
    );
  }
}
