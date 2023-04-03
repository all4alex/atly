import 'package:atly/src/app/app.dart';
import 'package:atly/src/presentation/features/pages/cubit/chat_cubit.dart';
import 'package:atly/src/presentation/features/pages/message_screen.dart';
import 'package:atly/src/presentation/features/pages/modals/samples/floating_modal.dart';
import 'package:atly/src/presentation/widgets/search_bar.dart';
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

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_text.dart';

class AddMessageModal extends StatelessWidget {
  AddMessageModal({Key? key}) : super(key: key);

  List<types.User> selectedChatUsers = [];

  String groupName = 'Group Name';

  types.User? selectedContact;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is OnCreateChatSuccess) {
            Navigator.of(context).pop(state.room);
          }
          if (state is OnCreateChatFailed) {
            Navigator.of(context).pop();
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .72,
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
                          'Create New',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontFamily: 'Poppins',
                                    color: AppColors.appBlack,
                                  ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                showCustomModalBottomSheet(
                                    context: context,
                                    builder: (_) => SingleChildScrollView(
                                          controller:
                                              ModalScrollController.of(context),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text('Message'),
                                                ),
                                                ListTile(
                                                  title: Text('Group'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    containerWidget:
                                        (context, animation, child) =>
                                            FloatingModal(
                                              child: child,
                                            ),
                                    expand: false);
                              },
                              child: Text(
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
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        Text(
                          'New Message',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email can't be empty";
                    }
                    return null;
                  },
                  onSaved: (newValue) {},
                ),
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
                          child: Text('Draft',
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
                                BlocProvider.of<ChatCubit>(context)
                                    .createGroupChat(
                                        selectedChatUsers, groupName, context);
                              } else {
                                BlocProvider.of<ChatCubit>(context)
                                    .creatDirectChat(
                                        selectedChatUsers.first, context);
                              }
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
