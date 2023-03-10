import 'package:atly/src/presentation/widgets/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../../../app/app_colors.dart';

class AddMessageModal extends StatefulWidget {
  const AddMessageModal({Key? key}) : super(key: key);

  @override
  State<AddMessageModal> createState() => _AddMessageModalState();
}

class _AddMessageModalState extends State<AddMessageModal> {
  // Create a user with an ID of UID if you don't use `FirebaseChatCore.instance.users()` stream
  void _handlePressed(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
  }

  String? selectedMode;
  List list = [
    "Flutter",
    "React",
    "Ionic",
    "Xamarin",
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    selectedMode = selectedMode ?? 'Messages';
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * .75,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$selectedMode',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontFamily: 'Poppins',
                              color: AppColors.iconBlue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  Text(
                    'New Message',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: SearchBar(hintText: 'Search for contacts'),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Results',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              child: StreamBuilder<List<types.User>>(
                stream: FirebaseChatCore.instance.users(),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done ||
                      snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.hasData) {}
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text('Go create a conversation.'),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            addAutomaticKeepAlives: false,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              types.User chatUser = snapshot.data![index];
                              return InkWell(
                                  onTap: () async {
                                    _handlePressed(chatUser, context);
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            chatUser.imageUrl != null
                                                ? CachedNetworkImageProvider(
                                                    chatUser.imageUrl!)
                                                : null,
                                        radius: 20,
                                      ),
                                    ),
                                    title: Text(
                                      '${chatUser.firstName} ${chatUser.lastName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                    ),
                                    trailing: GFCheckbox(
                                      size: GFSize.SMALL,
                                      activeBgColor: GFColors.DANGER,
                                      type: GFCheckboxType.circle,
                                      onChanged: (value) {},
                                      value: false,
                                      inactiveIcon: null,
                                    ),
                                  ));
                            },
                            itemCount: snapshot.data!.length,
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         CupertinoPageScaffold(
//                                             navigationBar:
//                                                 CupertinoNavigationBar(
//                                               middle: Text('New Page'),
//                                             ),
//                                             child: Stack(
//                                               fit: StackFit.expand,
//                                               children: <Widget>[],
//                                             ))));
