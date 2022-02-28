import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/componants/chat_bubble.dart';
import 'package:we_chat/componants/constant.dart';
import 'package:we_chat/models/message_model.dart';

class ChatPage extends StatelessWidget {
  // final _controllerAnimation = ScrollController();
  ScrollController _controllerAnimation = new ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  // backwardsCompatibility: false,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogo,
                        height: 45,
                      ),
                      const Text(
                        'We Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  )),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? ChatBubble(
                                  message: messagesList[index],
                                )
                              : ChatBubbleForFriend(
                                  message: messagesList[index],
                                );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        // _controllerAnimation.animateTo(
                        //   // _controllerAnimation.position.maxScrollExtent,
                        //   0,
                        //   duration: Duration(seconds: 2),
                        //   curve: Curves.fastOutSlowIn,
                        // );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            messages.add({
                              kMessage: controller.text,
                              kCreatedAt: DateTime.now(),
                              'id': email
                            });
                            controller.clear();
                            // _controllerAnimation.animateTo(
                            //   // _controllerAnimation.position.maxScrollExtent,
                            //   0,
                            //   duration: Duration(seconds: 2),
                            //   curve: Curves.fastOutSlowIn,
                            // );
                          },
                          icon: const Icon(Icons.send),
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                  child: Text(
                'Loading...',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )),
            );
          }
        });
  }
}
