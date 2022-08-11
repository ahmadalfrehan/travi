import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/MyCurrentTripsModel.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';
import 'package:project_one_maybe_clean_architecture/domain/repositories/ProfileRepo.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/Bloc/States.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/Models/TripModel.dart';
import '../../../main.dart';

class TraviProfileBloc extends Cubit<ProfileStates> with ProfileRepo {
  TraviProfileBloc() : super(ProfileInitialStates());

  static TraviProfileBloc get(context) => BlocProvider.of(context);
  final baseUrl = 'https://ahmadalfrehan.000webhostapp.com';

  List<MyCurrentTripsModel> currentTrips = [];
  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  @override
  getCurrentUserTrips() async {
    emit(GetCurrentTripsLoadingStates());
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/current_user_trips'),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      var current = json.decode(value.body);
      for (var i in current) {
        currentTrips.add(MyCurrentTripsModel.fromJson(i));
      }
      emit(GetCurrentTripsSuccessStates());
    }).catchError((onError) {
      print(onError);
      emit(GetCurrentTripsErrorStates());
    });
  }

  @override
  addReport({
    required int id,
    required String header,
    required String subject,
  }) async {
    emit(AddReportTripsLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/addReport/$id'),
            headers: headers,
            body: json.encode({
              'header': header,
              'subject': subject,
            }))
        .then((value) {
      emit(AddReportTripsSuccessStates());
      debugPrint(value.body.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(AddReportTripsErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<String> listOfButtons = [
    'Edit Profile',
    'My Current Trips',
    'My Next Trips',
    'My Favourite Trips',
    'My Information',
    'My Ended Trips',
    'Contact Us',
    'Suggest trip',
    'Logout',
  ];

  @override
  myFavouriteTrips() async {
    emit(GetMyFavouriteLoadingStates());
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_Liked_trips'),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      var current = json.decode(value.body);
      for (var i in current) {
        currentTrips.add(MyCurrentTripsModel.fromJson(i));
      }
      emit(GetMyFavouriteSuccessStates());
    }).catchError((onError) {
      print(onError);
      emit(GetMyFavouriteErrorStates());
    });
  }

  List<UserModel> userInfo = [];

  @override
  myInformation() async {
    emit(MyInformationLoadingStates());
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/my_information'),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      userInfo.add(UserModel.fromJson(userdata));
      emit(MyInformationSuccessStates());
    }).catchError((onError) {
      print(onError);
      emit(MyInformationErrorStates());
    });
  }

  @override
  myNextTrips() async {
    emit(GetMyNextTripsLoadingStates());
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/next_user_trips'),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      var current = json.decode(value.body);
      for (var i in current) {
        currentTrips.add(MyCurrentTripsModel.fromJson(i));
      }
      emit(GetMyNextTripsSuccessStates());
    }).catchError((onError) {
      print(onError);
      emit(GetMyNextTripsErrorStates());
    });
  }

  @override
  updateProfile() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/updateProfile/?name=kkk'),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      print(value.statusCode);
    }).catchError((onError) {
      print(onError);
    });
  }

  var imageProfile;
  final Picker = ImagePicker();

  getImageProfile(ImageSource sre) async {
    final Pac = await Picker.pickImage(source: sre);
    emit(GetImageSuccessStates());
    if (Pac != null) {
      imageProfile = File(Pac.path);
      print(imageProfile.path);
    } else {
      emit(GetImageErrorStates());
      print('no image selected');
    }
  }

  String? linkPhoto;

  uploadPhoto() async {
    print(imageProfile);
    print(File(imageProfile.path).readAsBytesSync());
    emit(UploadImageLoadingStates());
    final headers = {
      'Authorization': 'Bearer public_FW25atN6RK5tXSM8ww74nt6EjzkR',
      'Content-Type': "image/jpg",
      'Content-Length': File(imageProfile!.path).lengthSync().toString(),
    };
    await http
        .post(
      Uri.parse('https://api.upload.io/v1/files/basic'),
      body: await File(imageProfile.path).readAsBytesSync(),
      headers: headers,
    )
        .then((value) {
      emit(UploadImageSuccessStates());
      print(value.body);
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      print(userdata['fileUrl']);
      linkPhoto = userdata['fileUrl'];
      print(value.statusCode);
    }).catchError((onError) {
      emit(UploadImageErrorStates());
      print(onError);
    });
  }

  setString(String var1, String var2) {
    var1 = var2;
    emit(SetStringSuccessStates());
    return var1;
  }

  updateProfilePhoto({required String link}) async {
    emit(UpdatedProfilePhotoLoadingStates());
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/upload_myphoto'),
      body: json.encode({
        'image': link,
      }),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      emit(UpdatedProfilePhotoSuccessStates());
      print(userdata['user photo']);
      imageUrl = userdata['user photo'];
      print(value.statusCode);
    }).catchError((onError) {
      emit(UpdatedProfilePhotoErrorStates());
      print(onError);
    });
  }

  List<TripModel> allTrips = [];

  @override
  getAllTrips() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    emit(GetMyNextTripsLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/ended_trips/'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(GetMyNextTripsSuccessStates());
      var userSearch = jsonDecode(value.body);
      debugPrint(userSearch.toString());
      for (var i in userSearch) {
        allTrips.add(TripModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetMyNextTripsErrorStates());
      debugPrint(onError.toString());
    });
  }

  launchUrll(String Url) async {
    emit(AddReportSuccessStates());
    await launchUrl(Uri.parse(Url));
  }

  makeMessage(String phoneNumber) async {
    emit(AddReportSuccessStates());
    final LaunchUrl =
        'sms:${phoneNumber}?body=hello%20there I need To suggest a trip ';
    await launchUrl(Uri.parse(LaunchUrl.toString()));
  }

  makeEmailCall(String emailAd) async {
    emit(AddReportSuccessStates());
    final LaunchUrl = Uri(
      scheme: 'mailto',
      path: emailAd,
    );
    await launch(LaunchUrl.toString());
  }

  logOut() async {
    emit(LogoutLoadingStates());
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/logout'),
      headers: headers,
    )
        .then((value) {
      emit(LogoutSuccessStates());
      debugPrint(value.body);
    }).catchError((onError) {
      print(onError);
      emit(LogoutErrorStates());
    });
  }
}
