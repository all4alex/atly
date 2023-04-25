import 'package:atly/src/app/app.dart';
import 'package:atly/src/data/models/event_model.dart';
import 'package:atly/src/data/services/remote/event_service.dart';
import 'package:atly/src/data/services/remote/firebase_storage/firebase_storage_service.dart';
import 'package:atly/src/presentation/features/pages/cubit/chat_cubit.dart';
import 'package:atly/src/presentation/features/pages/Event_screen.dart';
import 'package:atly/src/presentation/features/pages/modals/samples/floating_modal.dart';
import 'package:atly/src/presentation/reusable_bloc/image_bloc.dart';
import 'package:atly/src/presentation/reusable_bloc/image_event.dart';
import 'package:atly/src/presentation/reusable_bloc/image_state.dart';
import 'package:atly/src/presentation/widgets/bxtra_simple_time_picker.dart';
import 'package:atly/src/presentation/widgets/search_bar.dart';
import 'package:atly/src/presentation/widgets/user_list_item.dart';
import 'package:atly/src/utilities/debouncer.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../../widgets/atly_textfield_small.dart';
import '../../../../widgets/bxtra_simple_date_picker.dart';

class AddEventModal extends StatefulWidget {
  AddEventModal({Key? key, required this.currentUser}) : super(key: key);
  final String currentUser;
  @override
  State<AddEventModal> createState() => _AddEventModalState();
}

class _AddEventModalState extends State<AddEventModal> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Variables to store the input values

  String? title;
  String? imageUrl;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  String? locationName;
  String? address;
  String? organizer;
  List<String>? attendees;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    return null;
  }

  String groupName = 'Group Name';

  Debouncer debouncer = Debouncer(milliseconds: 500);

  types.User? selectedContact;
  ImageBloc imageBloc = ImageBloc(StorageService());

  @override
  void initState() {
    super.initState();
    organizer = widget.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: BlocListener<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is OnCreateChatSuccess) {
              Navigator.of(context).pop(state.room);
            }
            if (state is OnCreateChatFailed) {
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * .12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create New',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
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
                                                ModalScrollController.of(
                                                    context),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text('Message'),
                                                  ),
                                                  ListTile(
                                                    title: Text('Event'),
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
                                  'Event',
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
                            'Event Information',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
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
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocProvider(
                        create: (context) => imageBloc,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.appWhite,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<ImageBloc, ImageState>(
                                      builder: (context, state) {
                                        if (state is ImageLoading) {
                                          return Center(
                                              child: AppLoader.loaderTwo);
                                        } else if (state is ImageLoaded) {
                                          imageUrl = state.imageURL;
                                          return SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl: state.imageURL,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child:
                                                          AppLoader.loaderTwo),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          );
                                        } else {
                                          return Icon(
                                            Icons.image,
                                            size: 150,
                                            color: AppColors.appGrey,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GFButton(
                              onPressed: () {
                                imageBloc.add(SelectImage());
                              },
                              text: "Add Photo",
                              type: GFButtonType.transparent,
                            ),
                          ],
                        ),
                      ),
                      Gap(16),
                      SizedBox(
                        height: screenSize.height * .065,
                        child: TextFormField(
                          validator: (value) =>
                              _validateNotEmpty(value, 'title'),
                          onSaved: (value) => title = value,
                          decoration: InputDecoration(
                            labelText: 'Event Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Gap(7),
                      SizedBox(
                        height: screenSize.height * .065,
                        child: TextFormField(
                          validator: (value) =>
                              _validateNotEmpty(value, 'locationName'),
                          onSaved: (value) => locationName = value,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: AppColors.appBlue,
                            ),
                            labelText: 'Location Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Gap(7),
                      SizedBox(
                        height: screenSize.height * .065,
                        child: TextFormField(
                          validator: (value) =>
                              _validateNotEmpty(value, 'address'),
                          onSaved: (value) => address = value,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Gap(7),
                      SizedBox(
                        height: screenSize.height * .065,
                        width: screenSize.width * .9,
                        child: Row(
                          children: [
                            Expanded(
                              child: BxtraSimpleDatePicker(
                                  titlte: 'From',
                                  onSelected: (DateTime selectedDate) {
                                    startTime = selectedDate;
                                  }),
                            ),
                            Text(
                              '  -  ',
                              style: AppText.subtitle2,
                            ),
                            Expanded(
                              child: BxtraSimpleDatePicker(
                                  titlte: 'To',
                                  onSelected: (DateTime selectedDate) {
                                    endTime = selectedDate;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Gap(7),
                      Text(
                        'Event Information',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                      ),
                      Gap(7),
                      SizedBox(
                        child: TextFormField(
                          validator: (value) =>
                              _validateNotEmpty(value, 'description'),
                          onSaved: (value) => description = value,
                          maxLines: 4,
                          minLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Gap(7),
                      Text(
                        'Invite Friends to your Event',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                      ),
                      Gap(7),
                      SizedBox(
                        height: screenSize.height * .065,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.supervisor_account_sharp,
                              color: AppColors.appBlue,
                            ),
                            labelText: 'Add Friends or Group',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: screenSize.height * .07,
                alignment: Alignment.center,
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
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              // // You need to convert the date strings to DateTime objects
                              // DateTime? startTime =
                              //     DateTime.tryParse(_startTimeController.text);
                              // DateTime? endTime =
                              //     DateTime.tryParse(_endTimeController.text);

                              // EventService eventService = EventService();
                              // eventService.addEvent(event);
                            }
                          },
                          shape: GFButtonShape.pills,
                          child: Text('Create Event',
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
