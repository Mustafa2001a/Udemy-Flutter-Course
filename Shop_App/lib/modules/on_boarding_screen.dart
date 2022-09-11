import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _Controller = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onBoard_1.jpg',
        title: 'Title One',
        body: 'Body 1'),
    BoardingModel(
        image: 'assets/images/onBoard_2.jpg',
        title: 'Title Tow',
        body: 'Body 2'),
    BoardingModel(
        image: 'assets/images/onBoard_3.jpg',
        title: 'Title Three',
        body: 'Body 3'),
  ];
  bool isLast = false;

  saveOnboardStatus() async
  {
    await CacheHelper.saveData(key: 'onBoarding', value: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async{
              await saveOnboardStatus();
              ReplaceNavigat(context, LoginScreen());
              },
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            children: [
              PageView.builder(
                onPageChanged: (pageIndex) {
                  if (pageIndex == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: _Controller,
                itemBuilder: (context, index) =>
                    buildPageViewBoardinf(boarding[index]),
                itemCount: boarding.length,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmoothPageIndicator(
                    controller: _Controller,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      expansionFactor: 3.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Spacer(),
                      FloatingActionButton(
                          child: Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: () async{
                            if (isLast) {
                              await saveOnboardStatus();
                              ReplaceNavigat(context, LoginScreen());
                            } else {
                              _Controller.nextPage(
                                  duration: Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildPageViewBoardinf(BoardingModel model) => Column(
      children: [
        Spacer(),
        Expanded(child: Image(image: AssetImage('${model.image}'))),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30.0,
        ),
        Spacer(),
      ],
    );
