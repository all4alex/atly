import 'package:atly/src/app/app.dart';
import 'package:atly/src/app/app_colors.dart';
import 'package:atly/src/app/app_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: AppColors.appWhite,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Events',
                            style: AppText.body2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.appBlue),
                          ),
                        ),
                        Container(
                            color: Colors.red,
                            height: screenSize.height * .18,
                            width: screenSize.width),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
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
                        Container(
                            color: Colors.red,
                            height: screenSize.height * .14,
                            width: screenSize.width),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: SizedBox(
          height: screenSize.height * .18,
          width: screenSize.width * .7,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/atly-98006.appspot.com/o/app_assets%2Fimages%2Fkelsey-knight-udj2tD3WKsY-unsplash.jpg?alt=media&token=d8df93c1-fe3c-4d26-be46-94399b863620',
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GFAvatar(
                            backgroundColor: AppColors.appGrey,
                            size: GFSize.SMALL,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GFAvatar(
                                size: GFSize.SMALL,
                                backgroundImage: CachedNetworkImageProvider(
                                    'https://firebasestorage.googleapis.com/v0/b/atly-98006.appspot.com/o/app_assets%2Fimages%2Fleio-mclaren-L2dTmhQzx4Q-unsplash.jpg?alt=media&token=f65eca68-cb30-4b3f-a6a9-e3ad6526aada'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: Text(
                                EventInviteStatus.going.displayMessage,
                                style: AppText.button.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Event Name',
                            style: AppText.body2.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Gap(5),
                          Text(
                            '@',
                            style: AppText.body2.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Gap(2),
                          Text(
                            "Adam's",
                            style: AppText.body2.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Feb 24',
                            style: AppText.caption.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Gap(5),
                          Text(
                            '00:00 - 00:00 PM',
                            style: AppText.caption.copyWith(
                                color: AppColors.appGrey, fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        '16 other friends going',
                        style: AppText.caption
                            .copyWith(color: AppColors.appGrey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
