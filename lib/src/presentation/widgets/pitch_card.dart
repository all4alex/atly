import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/size/gf_size.dart';

import 'package:atly/src/presentation/widgets/atly_name_avatar.dart';

import '../../app/app.dart';

class PitchHost {
  String firstName;
  String lastName;

  PitchHost({
    required this.firstName,
    required this.lastName,
  });
}

class PitchCard extends StatelessWidget {
  const PitchCard({
    Key? key,
    required this.pitchName,
    required this.pitchLocation,
    required this.pitchHost,
    this.hosImageUrl,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final String pitchName;
  final String pitchLocation;
  final PitchHost pitchHost;
  final String? hosImageUrl;
  final String date;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Text(
                      pitchName,
                      style: AppText.body2
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '@',
                      style: AppText.body2
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Gap(2),
                    Text(
                      "$pitchLocation's",
                      style: AppText.body2
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Gap(5),
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * .2,
                    child: AutoSizeText(
                      date,
                      maxLines: 1,
                      minFontSize: 8,
                      style: AppText.caption
                          .copyWith(color: AppColors.appBlack, fontSize: 12),
                    ),
                  ),
                  Gap(5),
                  SizedBox(
                    width: screenSize.width * .2,
                    child: AutoSizeText(
                      '$startTime - $endTime',
                      maxLines: 1,
                      minFontSize: 8,
                      style: AppText.caption
                          .copyWith(color: AppColors.appGrey, fontSize: 12),
                    ),
                  )
                ],
              ),
              Gap(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: hosImageUrl != null
                        ? GFAvatar(
                            backgroundColor: AppColors.appGrey,
                            size: GFSize.SMALL,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GFAvatar(
                                size: GFSize.SMALL,
                                backgroundImage:
                                    CachedNetworkImageProvider('$hosImageUrl'),
                              ),
                            ),
                          )
                        : AtlyNameAvatar(
                            firstName: pitchHost.firstName,
                            lastName: pitchHost.lastName),
                  ),
                  Gap(5),
                  Text(
                    'Hosted by',
                    style: AppText.caption
                        .copyWith(color: AppColors.appGrey, fontSize: 12),
                  ),
                  Gap(2),
                  Text(
                    '${pitchHost.firstName} ${pitchHost.lastName.split('').first}.',
                    style: AppText.caption
                        .copyWith(color: AppColors.appPink, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
