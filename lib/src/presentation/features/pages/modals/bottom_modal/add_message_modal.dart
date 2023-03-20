import 'package:atly/src/presentation/features/pages/cubit/chat_cubit.dart';
import 'package:atly/src/presentation/widgets/search_bar.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_text.dart';

class AddMessageModal extends StatefulWidget {
  const AddMessageModal({Key? key}) : super(key: key);

  @override
  State<AddMessageModal> createState() => _AddMessageModalState();
}

class _AddMessageModalState extends State<AddMessageModal> {
  List<types.User> selectedChatUsers = [];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is OnCreateChatSuccess) {
            Navigator.of(context).pop(state.room);
          }
          if (state is OnCreateChatFailed) {
            Navigator.of(context).pop();
          }
        },
        child: Material(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .72,
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
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Message',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
                    'Suggested',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * .45,
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
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      addAutomaticKeepAlives: false,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        types.User chatUser =
                                            snapshot.data![index];

                                        return ChatUserListTIle(
                                          chatUser: chatUser,
                                          onChange: (isChecked, chatUser) {
                                            if (isChecked) {
                                              selectedChatUsers.add(chatUser);
                                            } else {
                                              selectedChatUsers.removeWhere(
                                                  (element) =>
                                                      element.id ==
                                                      chatUser.id);
                                            }
                                            logger().d(selectedChatUsers);
                                            logger()
                                                .d(selectedChatUsers.length);
                                          },
                                        );
                                      },
                                      itemCount: snapshot.data!.length,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: screenSize.height * .05,
                                            child: GFButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              shape: GFButtonShape.pills,
                                              color: AppColors.appWhite,
                                              child: Text('Draft',
                                                  style: AppText.body2.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.appBlue)),
                                            ),
                                          ),
                                        ),
                                        Gap(15),
                                        Expanded(
                                          child: SizedBox(
                                            height: screenSize.height * .05,
                                            child: GFButton(
                                              onPressed: () {
                                                if (selectedChatUsers.length >
                                                    1) {
                                                  BlocProvider.of<ChatCubit>(
                                                          context)
                                                      .createGroupChat(
                                                          selectedChatUsers,
                                                          context);
                                                } else {
                                                  BlocProvider.of<ChatCubit>(
                                                          context)
                                                      .creatDirectChat(
                                                          selectedChatUsers
                                                              .first,
                                                          context);
                                                }
                                              },
                                              shape: GFButtonShape.pills,
                                              child: Text('Message',
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
        ),
      ),
    );
  }
}

class ChatUserListTIle extends StatefulWidget {
  const ChatUserListTIle({
    super.key,
    required this.chatUser,
    required this.onChange,
  });

  final types.User chatUser;
  final Function(bool, types.User) onChange;

  @override
  State<ChatUserListTIle> createState() => _ChatUserListTIleState();
}

class _ChatUserListTIleState extends State<ChatUserListTIle> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: EdgeInsets.only(right: 16),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: widget.chatUser.imageUrl != null
              ? CachedNetworkImageProvider(widget.chatUser.imageUrl!)
              : null,
          radius: 20,
        ),
      ),
      title: Text(
        '${widget.chatUser.firstName} ${widget.chatUser.lastName}',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
      ),
      trailing: GFCheckbox(
        size: GFSize.SMALL,
        activeBgColor: AppColors.appOrange,
        type: GFCheckboxType.circle,
        onChanged: (value) {
          setState(() {
            isChecked = value;
          });
          widget.onChange(isChecked, widget.chatUser);
        },
        value: isChecked,
        inactiveIcon: null,
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
