import 'package:atly/src/app/app.dart';
import 'package:atly/src/app/app_colors.dart';
import 'package:atly/src/app/app_text.dart';
import 'package:atly/src/presentation/widgets/event_card.dart';
import 'package:atly/src/presentation/widgets/pitch_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';

import '../../widgets/atly_appbar_subtitle.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  ];
  final List<String> imageList2 = [
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          snap: false,
          floating: false,
          expandedHeight: screenSize.height * .3,
          backgroundColor: AppColors.appBlue,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                height: screenSize.height,
                width: screenSize.width,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: AppColors.appWhite,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/backgrounds/home_header_image.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Container(
                  height: screenSize.height * .2,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment(0.0,
                          0.1), // 10% of the width, so there are ten blinds.
                      colors: [
                        AppColors.appWhite,
                        AppColors.appWhite.withOpacity(.05),
                      ], // red to yellow
                    ),
                  ),
                )),
          ),
        ),
        // SliverToBoxAdapter(
        //   child: InkWell(
        //     onTap: () async {},
        //     child: SizedBox(
        //       height: 20,
        //       child: Center(
        //         child: Text('Scroll to see the SliverAppBar in effect.'),
        //       ),
        //     ),
        //   ),
        // ),

        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      'Events',
                      style: AppText.body2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.appBlue),
                    ),
                  ),
                  Gap(5),
                  GFItemsCarousel(rowCount: 2, children: [
                    EventCard(),
                    EventCard(),
                    EventCard(),
                    EventCard(),
                    EventCard(),
                  ]),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Pitches',
                      style: AppText.body2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.appPink),
                    ),
                  ),
                  GFItemsCarousel(
                      rowCount: 2,
                      itemHeight: screenSize.height * .12,
                      children: [
                        PitchCard(
                          pitchName: 'Pitch Name',
                          date: 'April 25',
                          endTime: '05:00 PM',
                          pitchLocation: 'Area 51',
                          startTime: '08:00 AM',
                          pitchHost:
                              PitchHost(firstName: 'Alex', lastName: 'Ayso'),
                        ),
                        PitchCard(
                          pitchName: 'Pitch Name',
                          date: 'April 22',
                          endTime: '03:00 PM',
                          pitchLocation: 'Narnia',
                          startTime: '010:00 AM',
                          hosImageUrl: AppString.dummyImageUrl,
                          pitchHost:
                              PitchHost(firstName: 'John', lastName: 'Wick'),
                        ),
                        PitchCard(
                          pitchName: 'Pitch Name',
                          date: 'April 25',
                          endTime: '05:00 PM',
                          pitchLocation: 'Area 51',
                          startTime: '08:00 AM',
                          pitchHost:
                              PitchHost(firstName: 'Alex', lastName: 'Ayso'),
                        ),
                        PitchCard(
                          pitchName: 'Pitch Name',
                          date: 'April 22',
                          endTime: '03:00 PM',
                          pitchLocation: 'Narnia',
                          startTime: '010:00 AM',
                          hosImageUrl: AppString.dummyImageUrl,
                          pitchHost:
                              PitchHost(firstName: 'John', lastName: 'Wick'),
                        ),
                        PitchCard(
                          pitchName: 'Pitch Name',
                          date: 'April 25',
                          endTime: '05:00 PM',
                          pitchLocation: 'Area 51',
                          startTime: '08:00 AM',
                          pitchHost:
                              PitchHost(firstName: 'Alex', lastName: 'Ayso'),
                        ),
                      ]),
                ],
              ),
              Gap(20),
              Card(
                color: AppColors.appOriginalWhite,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(TextSpan(
                            text: 'Check out your  ',
                            style: AppText.caption,
                            children: <InlineSpan>[
                              TextSpan(
                                  text: 'Highlights  ',
                                  style: AppText.body2
                                      .copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: 'for this week', style: AppText.caption)
                            ])),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.appBlue,
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
