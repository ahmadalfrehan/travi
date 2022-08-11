import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_one_maybe_clean_architecture/data/Models/DayModel.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/DetailsTripModel.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/TripModel.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';
import 'package:project_one_maybe_clean_architecture/domain/repositories/TripRepo.dart';
import 'package:project_one_maybe_clean_architecture/main.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/Models/EventDetailsModel.dart';
import '../../data/Models/EventModel.dart';
import '../../data/Models/HomeTripsModel.dart';
import '../../data/Models/RatingModel.dart';

class TraviCubit extends Cubit<TraviStates> with TripRepo {
  TraviCubit() : super(TraviInitialStates());

  static TraviCubit get(context) => BlocProvider.of(context);

  final baseUrl = 'https://ahmadalfrehan.000webhostapp.com';
  var trips = <HomeTripsModel>[];
  var user = <UserModel>[];

  var details = <DetailsTripModel>[];

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  @override
  getDataForHomeScreen() async {
    emit(GetHomeDataLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/home'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(GetHomeDataSuccessStates());
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      debugPrint(userdata.toString());
      trips.add(HomeTripsModel.fromJson(userdata));
      debugPrint(trips[0].recommended.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetHomeDataErrorStates());
      debugPrint(onError.toString());
    });
  }

  @override
  getDetailsForTrips(int id) async {
    emit(GetDetailsTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_trip_details/$id'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(GetDetailsTripSuccessStates());
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      debugPrint(userdata.toString());
      details.add(DetailsTripModel.fromJson(userdata));
      debugPrint(details[0].tripDetails!.name.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetDetailsTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  List temp = [];

  @override
  getWeatherDetailsForTrips(int id) async {
    emit(GetWeatherDetailsTripLoadingStates());
    await http
        .get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=32.6264&lon=36.1033&units=metric&appid=76b5222b48869ac7baa1d1239fb2354b'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      debugPrint(userdata.toString());
      temp.add(userdata);
      debugPrint(temp[0]['main']['temp'].toString());
      emit(GetWeatherDetailsTripSuccessStates());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetWeatherDetailsTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  @override
  likeTrip(int id) async {
    emit(LikesTripLoadingStates());
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/like-trip/$id'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(LikesTripSuccessStates());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(LikesTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  @override
  disLikeTrip(int id) async {
    emit(LikesTripLoadingStates());
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/dislike-trip/$id'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(LikesTripSuccessStates());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(LikesTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  var searchController = TextEditingController();

  List<String> category = ['Offers', 'Recommended for you', 'Most popular'];

  List<String> category2 = ['pacific ocean ', 'India life', 'pacific ocean'];

  List<String> list = ['Comments', 'place gallery', 'On map'];

  List<String> images = [
    'https://images.unsplash.com/photo-1520962922320-2038eebab146?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8bmF0dXJhbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1500622944204-b135684e99fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJhbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60'
  ];
  double top = 1000;
  double top2 = 1000;
  bool t = false;

  int selected = 0;

  void changeIndex(index) {
    selected = index;
    emit(ChangeIndexStates());
  }

  bool l = false;

  changeConstraintsBiggestHeight(double t, double l) {
    emit(ChangeConstraintsBiggestHeightStates());
    t = l;
    return t;
  }

  changeBoolean(bool t, bool l) {
    emit(ChangeConstraintsBiggestHeightStates());
    t = l;
    return t;
  }

  List<TripModel> allTrips = [];

  @override
  getAllTrips() async {
    emit(SearchLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/ended_trips/'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(SearchSuccessStates());
      var userSearch = jsonDecode(value.body);
      debugPrint(userSearch.toString());
      for (var i in userSearch) {
        allTrips.add(TripModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(SearchErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<TripModel> searchList = [];

  @override
  search({required String query}) async {
    emit(SearchLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/search/$query'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(SearchSuccessStates());
      var userSearch = jsonDecode(value.body);
      debugPrint(userSearch.toString());
      for (var i in userSearch) {
        searchList.add(TripModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(SearchErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<TripModel> best = [];

  @override
  showBestTrips() async {
    emit(GetDetailsTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_highrated_trips'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(GetDetailsTripSuccessStates());
      var bestTrips = jsonDecode(value.body);
      debugPrint(bestTrips.toString());
      for (var i in bestTrips) {
        best.add(TripModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetDetailsTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<TripModel> offered = [];

  @override
  showOfferedTrips() async {
    emit(GetDetailsTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_offered_trips'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(GetDetailsTripSuccessStates());
      var offeredTrips = jsonDecode(value.body);
      debugPrint(offeredTrips.toString());
      for (var i in offeredTrips) {
        offered.add(TripModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetDetailsTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<TripModel> recommended = [];

  @override
  showRecommendedTrips() async {
    emit(GetDetailsTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_recommended_trips'),
      headers: headers,
    )
        .then((value) {
      debugPrint(value.body.toString());
      emit(GetDetailsTripSuccessStates());
      var recommendedTrips = jsonDecode(value.body);
      debugPrint(recommendedTrips.toString());
      for (var i in recommendedTrips) {
        recommended.add(TripModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetDetailsTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  @override
  addComment({required String comment, required int id}) async {
    emit(AddedTheCommentLoadingStates());
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/Comments/$id'),
      body: json.encode({
        'body': comment,
      }),
      headers: headers,
    )
        .then((value) {
      emit(AddedTheCommentSuccessStates());
      comments = [];
      showComments(id: id);
      debugPrint(value.body);
    }).catchError((onError) {
      emit(AddedTheCommentErrorStates());
    });
  }

  List<dynamic> comments = [];

  @override
  showComments({required int id}) async {
    emit(GetCommentsTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/ShowComments/$id'),
      headers: headers,
    )
        .then((value) {
      emit(GetCommentsTripSuccessStates());
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      comments.add(userdata);
      debugPrint(comments[0]['comments'].toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(GetCommentsTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  var commentController = TextEditingController();
  List<DayModel> tripDays = [];
  int? daysNumber;

  @override
  showDays({required int id}) async {
    emit(ShowDaysTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_days/$id'),
      headers: headers,
    )
        .then((value) {
      emit(ShowDaysTripSuccessStates());
      debugPrint(value.body[0].toString());
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      debugPrint(userdata['days'].toString());
      daysNumber = userdata['daysNumber'];
      var l = json.encode(userdata['days']);
      var r = json.decode(l);
      for (var i in r) {
        tripDays.add(DayModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(ShowDaysTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<EventDetailsModel> eventDetails = [];
  List<EventModel> events = [];
  List<DayModel> days = [];

  @override
  showEvent({required int id}) async {
    emit(ShowEventTripLoadingStates());
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/show_event_details/$id'),
      headers: headers,
    )
        .then((value) {
      emit(ShowEventTripSuccessStates());
      debugPrint(value.body.toString());
      days = [];
      events = [];
      var eventDetails2 = json.decode(value.body);
      for (var i in eventDetails2) {
        days.add(DayModel.fromJson(i));
      }
      var t = json.encode(eventDetails2[0]['events']);
      var r = json.decode(t);
      for (var i in r) {
        events.add(EventModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(ShowEventTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<String> activity = [];

  @override
  showActivity() async {
    emit(ShowDaysTripLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_activity'),
      headers: headers,
    )
        .then((value) {
      emit(ShowDaysTripSuccessStates());
      var r = json.decode(value.body);
      for (var i in r) {
        activity.add(i['name']);
      }
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(ShowDaysTripErrorStates());
      debugPrint(onError.toString());
    });
  }

  bool isSelected = false;
  Map<String, bool> activitiesPost = {};
  List<String> activities = [];

  addActivity({required String name, required bool added}) {
    activitiesPost.addAll({name: true});
    emit(AddedActivitySuccessStates());
  }

  removeActivity(String name) {
    activitiesPost.remove(name);
    emit(RemovedActivitySuccessStates());
  }

  @override
  postActivity({required List<String> activities}) async {
    emit(PostActivityLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/insert_user_activity'),
            headers: headers,
            body: json.encode({
              'activities': activities,
            }))
        .then((value) {
      emit(PostActivitySuccessStates(value.body));
      debugPrint(value.body.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(PostActivityErrorStates());
      debugPrint(onError.toString());
    });
  }

  uploadPhoto(File file) async {}

  @override
  addRate(
      {required String comment, required String star, required int id}) async {
    emit(PostActivityLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/addRate/$id'),
            headers: headers,
            body: json.encode({
              'star': star,
              'comment': comment,
            }))
        .then((value) {
      emit(PostActivitySuccessStates(value.body));
      rating = [];
      showRating(id: id);
      debugPrint(value.body.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(PostActivityErrorStates());
      debugPrint(onError.toString());
    });
  }

  List<RatingModel> rating = [];

  @override
  showRating({required int id}) async {
    emit(ShowRatingLoadingStates());
    await http
        .get(
      Uri.parse('$baseUrl/api/auth/show_ratings/$id'),
      headers: headers,
    )
        .then((value) {
      emit(ShowRatingSuccessStates());

      var r = json.decode(value.body);
      for (var i in r) {
        rating.add(RatingModel.fromJson(i));
      }
      debugPrint(value.statusCode.toString());
      debugPrint(value.body.toString());
    }).catchError((onError) {
      emit(ShowRatingErrorStates());
      debugPrint(onError.toString());
    });
  }

  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var commentComtroller = TextEditingController();
  var starComtroller = TextEditingController();

  @override
  addReport({
    required int id,
    required String header,
    required String subject,
  }) async {
    emit(AddReportLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/addReport/$id'),
            headers: headers,
            body: json.encode({
              'header': header,
              'subject': subject,
            }))
        .then((value) {
      emit(AddReportSuccessStates());
      debugPrint(value.body.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(AddReportErrorStates());
      debugPrint(onError.toString());
    });
  }

  @override
  deleteUserActivity({required List activity}) async {
    emit(PostActivityLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/delete_user_activities'),
            headers: headers,
            body: json.encode({
              'activities': activity,
            }))
        .then((value) {
      emit(PostActivitySuccessStates(value.body));
      debugPrint(value.body.toString());
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      emit(PostActivityErrorStates());
      debugPrint(onError.toString());
    });
  }

  @override
  updateComment(
      {required String comment, required int id, required int idTrip}) async {
    emit(AddedTheCommentLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/updateComment/$id'),
            body: json.encode({
              'body': comment,
            }),
            headers: headers)
        .then((value) {
      comments = [];
      showComments(id: idTrip);
      emit(AddedTheCommentSuccessStates());
      debugPrint(value.body);
    }).catchError((onError) {
      emit(AddedTheCommentErrorStates());
    });
  }

  @override
  deleteComment({required int id, required int idTrip}) async {
    emit(DeleteTheCommentLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/deleteComment/$id'),
            headers: headers)
        .then((value) {
      emit(DeleteTheCommentSuccessStates());
      comments = [];
      showComments(id: idTrip);
      debugPrint(value.body);
    }).catchError((onError) {
      emit(DeleteTheCommentErrorStates());
    });
  }

  @override
  regiterTrip({required int id}) async {
    emit(RegisterTheTripLoadingStates());
    await http
        .post(Uri.parse('$baseUrl/api/auth/registerTrip/$id'), headers: headers)
        .then((value) {
      emit(RegisterTheTripSuccessStates());
      debugPrint(value.body);
    }).catchError((onError) {
      emit(RegisterTheTripErrorStates());
    });
  }

  launchUrll(String Url) async {
    emit(AddReportSuccessStates());
    await launchUrl(Uri.parse(Url));
  }

  makeMessage(String phoneNumber) async {
    emit(AddReportSuccessStates());
    final LaunchUrl =
        'sms:${phoneNumber}?body=hello%20there i\'m using imagin_true to chat - We invite you to join us! Get it on google play :https://play.google.com/store/apps/details?id=com.ahmad_alfrehan.imagin_true';
    await launchUrl(Uri.parse(LaunchUrl.toString()));
  }
}
