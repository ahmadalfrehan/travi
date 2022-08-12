import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Home/HomeScreen.dart';
import 'package:project_one_maybe_clean_architecture/presentation/login/login_screen.dart';
import 'package:project_one_maybe_clean_architecture/presentation/onBordingScreen/splash_screen.dart';
import 'package:project_one_maybe_clean_architecture/presentation/sharedHELper.dart';

var viewPageView = false;
var viewLogin = false;
String access_token = '';
String imageUrl = '';

bool isActivity = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LVte0CT7aJjwuQy6INXL6l0fnzC9iIJC55oqfsLyYLp2gu0vPBED0iDEs2zAaxhamu5Hz1ALtZDW0CiBLuFeZ1N00uKnRshkJ';

  Stripe.merchantIdentifier = 'any string works';

  await Stripe.instance.applySettings();

  await Shard.initial();
  print(Shard.sharedprefrences!.getString('access_token'));

  if (Shard.sharedprefrences!.getBool('pageView') != null) {
    viewPageView = Shard.sharedprefrences!.getBool('pageView')!;
  }
  if (Shard.sharedprefrences!.getBool('isActivity') != null) {
    isActivity = Shard.sharedprefrences!.getBool('isActivity')!;
  }

  if (Shard.sharedprefrences!.getString('access_token') != null) {
    access_token = Shard.sharedprefrences!.getString('access_token')!;
    print(access_token);
  }
  if (access_token != '') {
    viewLogin = true;
  }
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SpllashScreen(),
    );
  }
}
