import 'package:flutter/material.dart';
import 'package:project_one_maybe_clean_architecture/presentation/sharedHELper.dart';

import '../../data/Models/pageView.dart';
import '../login/login_screen.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            buildViewPageItem(context, ofPageViewModel[index], index),
        itemCount: ofPageViewModel.length,
        onPageChanged: (value) {
          setState(() {
            selected = value;
          });
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget smoothPageIndicator(Color color) {
    return CircleAvatar(
      radius: 5,
      backgroundColor: color,
    );
  }

  Widget buildViewPageItem(BuildContext context, PageViewModel data, index) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                data.image,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue[900]!.withOpacity(0),
                Colors.lightBlue[900]!.withOpacity(0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.5, 1],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                selected == 3
                    ? Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(
                            bottom: 4, left: 20, right: 10),
                        child: const Text(
                          'Travel Now',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 217, 132, 1),
                              fontSize: 40),
                        ),
                      )
                    : Text(
                        data.text1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                if (selected == 3)
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    child: OutlinedButton(
                      onPressed: () {
                        Shard.saveData(key: 'pageView', value: true)
                            .then((value) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            side: BorderSide(color: Colors.white, width: 1.0),
                          ),
                          side: const BorderSide(
                              color: Colors.white, width: 1.0)),
                      child: const Text(
                        ' Get Started ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  Text(
                    data.text2,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    smoothPageIndicator(selected == index
                                        ? const Color.fromRGBO(241, 107, 82, 1)
                                        : Colors.white),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                itemCount: 4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 40, right: 20),
          child: OutlinedButton(
            onPressed: () {
              Shard.saveData(key: 'pageView', value: true).then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              });
            },
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                side: BorderSide(color: Colors.white, width: 1.0),
              ),
              side: const BorderSide(color: Colors.white, width: 1.0),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            child: const Text(
              'skip >',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
