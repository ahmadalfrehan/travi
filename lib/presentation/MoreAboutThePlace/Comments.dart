import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';

import '../../main.dart';

class Comments extends StatelessWidget {
  final int id;

  const Comments({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit()..showComments(id: id),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var traviCubit = TraviCubit.get(context);
          if (state is GetCommentsTripLoadingStates ||
              state is DeleteTheCommentLoadingStates) {
            return const CircularProgressIndicator();
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            TraviCubit.get(context).showComments(id: 1);
                          },
                          child: CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xFFF16B52),
                            backgroundImage: NetworkImage(
                                TraviCubit.get(context).comments[0]['comments']
                                    [index]['users']['image']),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            height: 50,
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        TraviCubit.get(context)
                                            .comments[0]['comments'][index]
                                                ['body']
                                            .toString(),
                                        //TraviCubit.get(context).comments[0]['comment']['body'].toString(),
                                        style: const TextStyle(
                                          color: Color.fromRGBO(37, 40, 71, 1),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (imageUrl ==
                        TraviCubit.get(context)
                            .comments[0]['comments'][index]['users']['image']
                            .toString())
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Scaffold(
                                            body: SafeArea(
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: TextFormField(
                                                      controller: traviCubit
                                                          .commentController,
                                                      decoration:
                                                          InputDecoration(
                                                        label: const Text(
                                                            "write your email"),
                                                        //fillColor: Colors.white,
                                                        filled: true,
                                                        enabled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      validator:
                                                          (String? value) {
                                                        if (value!.isEmpty) {
                                                          return 'the field must not be empty';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      print(TraviCubit.get(context).comments[0]
                                                      ['comments'][index]['id']);
                                                      print(traviCubit
                                                          .commentController
                                                          .text);
                                                      traviCubit
                                                          .updateComment(
                                                        comment: traviCubit
                                                            .commentController
                                                            .text,
                                                        id: TraviCubit.get(context).comments[0]
                                                        ['comments'][index]['id'],
                                                        idTrip: id,
                                                      )
                                                          .then((value) {
                                                        traviCubit
                                                                .commentController =
                                                            TextEditingController();
                                                        traviCubit.showComments(
                                                            id: id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: const Text('Edit'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          'edit',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {
                                    TraviCubit.get(context).deleteComment(
                                      id: TraviCubit.get(context).comments[0]
                                          ['comments'][index]['id'],
                                      idTrip: id,
                                    );
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white),
                        ],
                      ),
                  ],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount:
                    TraviCubit.get(context).comments[0]['comments'].length,
              ),
            );
          }
        },
      ),
    );
  }
}
