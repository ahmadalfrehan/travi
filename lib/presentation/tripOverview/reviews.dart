import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';

class Reviews extends StatelessWidget {
  final int id;

  const Reviews({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit()..showRating(id: id),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var traviCubit = TraviCubit.get(context);
          return Scaffold(
            key: traviCubit.ScaffoldKey,
            body: SafeArea(
              child: Container(
                color: const Color.fromRGBO(250, 250, 250, 1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 20, 40, 0),
                  child: Column(
                    children: [
                      if (state is ShowRatingLoadingStates)
                        const LinearProgressIndicator(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Color.fromRGBO(180, 179, 179, 1),
                              size: 36,
                            ),
                          ),
                          const Text(
                            'Reviews',
                            style: TextStyle(
                                color: Color.fromRGBO(241, 107, 82, 1),
                                fontSize: 33,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          shrinkWrap: true,
                          itemCount: TraviCubit.get(context).rating.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      TraviCubit.get(context)
                                          .rating[index]
                                          .comment
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color.fromRGBO(37, 40, 71, 0.9),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 20,
                                      width: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: TraviCubit.get(context)
                                            .rating[index]
                                            .star,
                                        itemBuilder: (context, index) {
                                          return const Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.amber,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        color: const Color.fromRGBO(37, 40, 71, 1),
                        minWidth: double.infinity,
                        height: 50,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Add Review",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          var forKey = GlobalKey<FormState>();
                          traviCubit.ScaffoldKey.currentState!.showBottomSheet(
                            (context) => Container(
                              child: SizedBox(
                                height: 240,
                                width: double.infinity,
                                child: Form(
                                  key: forKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextFormField(
                                          controller:
                                              traviCubit.commentComtroller,
                                          decoration: InputDecoration(
                                            label: const Text("comment"),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                          keyboardType: TextInputType.text,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'the field must not be empty';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextFormField(
                                          controller: traviCubit.starComtroller,
                                          decoration: InputDecoration(
                                            label: const Text("Stars"),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                          keyboardType: TextInputType.text,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'the field must not be empty';
                                            }
                                            if (int.parse(value) > 5 ||
                                                int.parse(value) < 1) {
                                              return 'The Stars number must be between 1 and 5';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            if (forKey.currentState!
                                                .validate()) {
                                              traviCubit
                                                  .addRate(
                                                comment: traviCubit
                                                    .commentComtroller.text,
                                                star: traviCubit
                                                    .starComtroller.text,
                                                id: id,
                                              )
                                                  .then((value) {
                                                traviCubit.commentController =
                                                    TextEditingController();
                                                traviCubit.starComtroller =
                                                    TextEditingController();
                                                Navigator.of(context).pop();
                                              });
                                            }
                                          },
                                          child: const Text(
                                            'submit',
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 20,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
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
}
