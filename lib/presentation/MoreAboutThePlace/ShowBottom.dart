import 'package:flutter/material.dart';

class ShowBottom extends StatelessWidget {
  final traviCubit;
  final int id;

  const ShowBottom({Key? key, required this.traviCubit, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
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
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: traviCubit.commentController,
                            decoration: InputDecoration(
                              label: const Text("write your email"),
                              //fillColor: Colors.white,
                              filled: true,
                              enabled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
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
                        ElevatedButton(
                          onPressed: () {
                            print(traviCubit.commentController.text);
                            traviCubit
                                .addComment(
                                    comment: traviCubit.commentController.text,
                                    id: id)
                                .then((value) {
                              traviCubit.commentController =
                                  TextEditingController();

                              traviCubit.showComments(id: id);
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Post'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text(
            'Add Comment',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
