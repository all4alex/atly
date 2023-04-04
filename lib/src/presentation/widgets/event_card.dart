import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/size/gf_size.dart';

import '../../app/app.dart';

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
          height: screenSize.height * .12,
          width: screenSize.width * .3,
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
