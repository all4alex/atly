import 'package:atly/src/app/app.dart';
import 'package:atly/src/app/app_screen_size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../app/app_colors.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
        color: AppColors.appWhite,
        child: Column(
          children: [
            SizedBox(
              height: AppScreenSizeUtil.appBarDefaultSizeSpaced,
              width: screenSize.width,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Slidable(
                      closeOnScroll: true,
                      // Specify a key if the Slidable is dismissible.
                      key: ValueKey(index),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        extentRatio: .7,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 3,
                            onPressed: (context) {},
                            backgroundColor: AppColors.appBlue,
                            foregroundColor: Colors.white,
                            label: 'Pitch',
                          ),
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 3,
                            onPressed: (context) {},
                            backgroundColor: AppColors.appPink,
                            foregroundColor: Colors.white,
                            label: 'Invite',
                          ),
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 3,
                            onPressed: (context) {},
                            backgroundColor: AppColors.appOriginalWhite,
                            foregroundColor: AppColors.appBlue,
                            label: 'Message',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: ListTile(
                          title: Text(
                            'Andy Smith',
                            style: AppText.subtitle1,
                          ),
                          subtitle: Text(
                            'Insert bio or status here',
                            style: AppText.caption,
                          ),
                          leading: Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              AppString.dummyImageUrl,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          trailing: Icon(
                            Icons.more_horiz,
                            color: AppColors.appGrey,
                            size: 24,
                          )));
                },
              ),
            ),
          ],
        ));
  }
}
