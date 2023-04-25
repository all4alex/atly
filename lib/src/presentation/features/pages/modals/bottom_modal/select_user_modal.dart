import 'package:atly/src/app/app.dart';
import 'package:atly/src/presentation/features/pages/cubit/chat_cubit.dart';
import 'package:atly/src/presentation/features/pages/message_screen.dart';
import 'package:atly/src/presentation/features/pages/modals/samples/floating_modal.dart';
import 'package:atly/src/presentation/widgets/search_bar.dart';
import 'package:atly/src/presentation/widgets/user_list_item.dart';
import 'package:atly/src/utilities/debouncer.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class SelectUserModal extends StatefulWidget {
  SelectUserModal({Key? key}) : super(key: key);

  @override
  State<SelectUserModal> createState() => _SelectUserModalState();
}

class _SelectUserModalState extends State<SelectUserModal> {
  final List<types.User> selectedChatUsers = [];

  String groupName = 'Group Name';

  Debouncer debouncer = Debouncer(milliseconds: 500);

  TextEditingController textEditingController = TextEditingController();

  types.User? selectedContact;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invite Friends to your Event',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontFamily: 'Poppins',
                            color: AppColors.appBlack,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Create Event',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
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
              IconButton(
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(),
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SearchBar(
            textEditingController: textEditingController,
            hintText: 'Search for location and places',
            onChanged: (String text) {
              debouncer.run(() {});
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Suggested',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
            ),
          ),
          Expanded(
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
                          child: Text('No available user.'),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                addAutomaticKeepAlives: false,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  types.User chatUser = snapshot.data![index];

                                  return UserListItem(
                                    chatUser: chatUser,
                                    onChange: (isChecked, chatUser) {
                                      if (isChecked) {
                                        selectedChatUsers.add(chatUser);
                                      } else {
                                        selectedChatUsers.removeWhere(
                                            (element) =>
                                                element.id == chatUser.id);
                                      }
                                      logger().d(selectedChatUsers);
                                      logger().d(selectedChatUsers.length);
                                    },
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              ),
                            ),
                          ],
                        );
                } else {
                  return Center(child: AppLoader.loaderOne);
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: GFButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      shape: GFButtonShape.pills,
                      color: AppColors.appWhite,
                      child: Text('Cancel',
                          style: AppText.body2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.appBlue)),
                    ),
                  ),
                ),
                Gap(15),
                Expanded(
                  child: SizedBox(
                    child: GFButton(
                      onPressed: () {
                        logger().d(selectedChatUsers.length);
                        if (selectedChatUsers.isNotEmpty) {
                          if (selectedChatUsers.length > 1) {
                            //                               String groupName = await  showCupertinoModalBottomSheet(
                            // context: context,
                            // useRootNavigator: true,
                            // overlayStyle: SystemUiOverlayStyle(),
                            // builder: (context) => Material(child:));
                            BlocProvider.of<ChatCubit>(context).createGroupChat(
                                selectedChatUsers, groupName, context);
                          } else {
                            BlocProvider.of<ChatCubit>(context).creatDirectChat(
                                selectedChatUsers.first, context);
                          }
                        }
                      },
                      shape: GFButtonShape.pills,
                      child: Text('Invite',
                          style: AppText.body2.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
