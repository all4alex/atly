import 'dart:io';

import 'package:atly/src/app/app_colors.dart';
import 'package:atly/src/app/app_text.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utilities/chat_util.dart';
import 'modals/bottom_modal/chat_attachement_modal.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _isAttachmentUploading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logger().d(widget.room);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .85,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .08,
              color: AppColors.appOriginalWhite,
              child: ListTile(
                leading: buildAvatar(
                  widget.room,
                ),
                title: Text(
                  getChatTitle(widget.room),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: 'Poppins',
                        color: AppColors.appBlue,
                      ),
                ),
                subtitle: Text(
                  '',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                ),
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.appGrey,
                child: StreamBuilder<types.Room>(
                  initialData: widget.room,
                  stream: FirebaseChatCore.instance.room(widget.room.id),
                  builder: (context, snapshot) =>
                      StreamBuilder<List<types.Message>>(
                    initialData: const [],
                    stream: FirebaseChatCore.instance.messages(snapshot.data!),
                    builder: (context, snapshot) => Chat(
                      showUserAvatars: true,
                      isAttachmentUploading: _isAttachmentUploading,
                      messages: snapshot.data ?? [],
                      usePreviewData: true,
                      showUserNames: true,
                      onAttachmentPressed: _handleAtachmentPressed,
                      onMessageTap: _handleMessageTap,
                      onPreviewDataFetched: _handlePreviewDataFetched,
                      onSendPressed: _handleSendPressed,
                      theme: DefaultChatTheme(
                          inputBackgroundColor: AppColors.appWhite,
                          primaryColor: AppColors.appBlue,
                          userAvatarImageBackgroundColor: AppColors.appBlue,
                          secondaryColor: AppColors.appWhite,
                          backgroundColor: AppColors.appOriginalWhite,
                          inputContainerDecoration: BoxDecoration(),
                          attachmentButtonIcon: Icon(
                            Icons.add_circle,
                            size: 26,
                            color: AppColors.appBlue,
                          ),
                          sendButtonIcon: Icon(
                            Icons.send,
                            size: 26,
                            color: AppColors.appBlue,
                          ),
                          inputTextColor: AppColors.appBlack,
                          inputTextStyle: AppText.subtitle2
                              .copyWith(color: AppColors.appBlack),
                          inputBorderRadius: BorderRadius.circular(30),
                          inputMargin:
                              EdgeInsets.only(bottom: 10, left: 15, right: 15),
                          receivedMessageBodyTextStyle: AppText.body2
                              .copyWith(color: AppColors.iconGrey)),
                      user: types.User(
                        id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAtachmentPressed() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 300,
            width: 130,
            child: ChatAttachementModal(
              onPressedButton1: () {
                Navigator.of(context).pop();

                _handleImageSelection();
              },
              onPressedButton2: () {
                // Handle button 2 press
                Navigator.of(context).pop();
                _handleFileSelection();
              },
              onPressedButton3: () {
                // Handle button 3 press
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
  // void _handleAtachmentPressed() {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) => SafeArea(
  //       child: Container(
  //         height: 144,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 _handleImageSelection();
  //               },
  //               child: const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text('Photo'),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 _handleFileSelection();
  //               },
  //               child: const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text('File'),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text('Cancel'),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }
}
