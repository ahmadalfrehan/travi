import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';

class Payment extends StatelessWidget {
  final String amount;
  final int id;

  Payment({Key? key, required this.amount, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit(),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {
          if (state is RegisterTheTripErrorStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('An Error Occurred'),
                  backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: InkWell(
                onTap: () async {
                  await TraviCubit.get(context)
                      .regiterTrip(id: id)
                      .then((value) {
                    makePayment(context);
                  });
                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Pay',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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

  List<dynamic> paymentSheetData = [];
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(BuildContext context) async {
    await createPaymentIntent(amount, 'usd');
    debugPrint("payment intent created".toString());
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentSheetData[0]['client_secret'],
                customerId: paymentSheetData[0]['id'],
                customerEphemeralKeySecret: paymentSheetData[0]['ephemeralKey'],
                allowsDelayedPaymentMethods: true,
                applePay: const PaymentSheetApplePay(
                  merchantCountryCode: 'DE',
                ),
                googlePay: const PaymentSheetGooglePay(
                  merchantCountryCode: 'DE',
                  testEnv: true,
                ),
                style: ThemeMode.system,
                appearance: const PaymentSheetAppearance(
                  colors: PaymentSheetAppearanceColors(
                    background: Colors.lightBlue,
                    primary: Colors.blue,
                    componentBorder: Colors.red,
                  ),
                  shapes: PaymentSheetShape(
                    borderWidth: 4,
                    shadow: PaymentSheetShadowParams(color: Colors.red),
                  ),
                  primaryButton: PaymentSheetPrimaryButtonAppearance(
                    shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
                    colors: PaymentSheetPrimaryButtonTheme(
                      light: PaymentSheetPrimaryButtonThemeColors(
                        background: Color.fromARGB(255, 231, 235, 30),
                        text: Color.fromARGB(255, 235, 92, 30),
                        border: Color.fromARGB(255, 235, 92, 30),
                      ),
                    ),
                  ),
                ),
                merchantDisplayName: 'ANNIE'))
        .then((value) {
      print('ahmad alfrehan22');
      Stripe.instance.presentPaymentSheet();
      displayPaymentSheet(context);
    }).catchError((onError) {
      debugPrint(onError.toString());
    });
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['Client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('ahmad alfrehann');
        debugPrint('payment intent${paymentIntentData!['id']}'.toString());
        debugPrint(
            'payment intent${paymentIntentData!['client_secret']}'.toString());
        debugPrint('payment intent${paymentIntentData!['amount']}'.toString());
        debugPrint('payment intent$paymentIntentData'.toString());
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        debugPrint('ahmad');
        debugPrint(
            'Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace'.toString());
      });
    } on StripeException catch (e) {
      debugPrint('Exception/DISPLAYPAYMENTSHEET==> $e'.toString());
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled "),
        ),
      );
    } catch (e) {
      debugPrint('$e'.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': 'usd',
      'payment_method_types[]': 'card'
    };
    await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer ',
          'Content-Type': 'application/x-www-form-urlencoded'
        }).then((value) {
      debugPrint(value.body);
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      paymentSheetData.add(userdata);
      debugPrint(value.statusCode.toString());
    }).catchError((onError) {
      print(onError);
    });
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
