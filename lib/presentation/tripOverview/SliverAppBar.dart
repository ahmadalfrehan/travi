import 'package:flutter/material.dart';

import '../Home/CustomAppBar.dart';

class SliverAppBar2 {
  Widget sliverAppBar2(BuildContext context, var traviCubit) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      )),
      centerTitle: false,
      titleSpacing: 0,
      backgroundColor: const Color.fromRGBO(28, 30, 55, 1),
      expandedHeight: MediaQuery.of(context).size.height / 2.8,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        expandedTitleScale: 1.2,
        titlePadding: EdgeInsets.fromLTRB(45, 0, 10, 0),
        background: Image.network(
          fit: BoxFit.fill,
          traviCubit.details[0].tripDetails!.image.toString(),
        ),
      ),
      title: CustomAppBar(),
    );
  }
}
