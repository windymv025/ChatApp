import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/message.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/message/components/item_message_notify.dart';
import 'package:chat_app_mobile_client/ui/message/components/item_message_receiver.dart';
import 'package:chat_app_mobile_client/ui/message/components/item_message_sender.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyChat extends StatefulWidget {
  const BodyChat({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  _BodyChatState createState() => _BodyChatState();
}

class _BodyChatState extends State<BodyChat> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  late MessageProvider provider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<MessageProvider>(context);
  }

  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        if (widget.type == MessageScreen.typeGroup) {
          await provider.loadGroupMessage(provider.inChatId);
        } else {
          await provider.loadInvidualMessage(provider.inChatId);
        }
      },
      child: Container(
          color: Colors.white,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                buildListMessage(provider.messages),
                buildTextFieldChat()
              ],
            ),
          )),
    );
  }

  Widget buildListMessage(List<Message> messages) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        itemBuilder: (BuildContext context, int index) =>
            buildItemMessage(messages[messages.length - index - 1]),
        itemCount: messages.length,
      ),
    );
  }

  Widget buildItemMessage(Message message) {
    if (message.isNotification) {
      return ItemMessageNotify(message: message.content);
    }
    if (message.sender.id == provider.inChatId ||
        message.group?.id == provider.inChatId) {
      return ItemMessageReceiver(message: message);
    } else {
      return ItemMessageSender(message: message);
    }
  }

  Widget buildTextFieldChat() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
        constraints: const BoxConstraints(
          maxHeight: 150,
          minHeight: 80,
        ),
        child: Row(
          children: [
            // IconButton(onPressed: (){}, icon: const Icon(Icons.attach_file)),
            Expanded(
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      isSend = true;
                    } else {
                      isSend = false;
                    }
                  });
                },
                onTap: scrollDDown,
                decoration: InputDecoration(
                  hintText: S.current.type_message,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: isSend ? kPrimaryColor : Colors.grey,
                    ),
                    onPressed: isSend
                        ? () {
                            sendMessage(_controller.text, provider.inChatId);
                          }
                        : null,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollDDown() {
    setState(() {
      final double end = _scrollController.position.minScrollExtent;
      _scrollController.jumpTo(end);
    });
  }

  void sendMessage(String message, String id) {
    setState(() {
      if (widget.type == MessageScreen.typeInvidual) {
        provider.sendMessage(message, userId: id);
      } else {
        provider.sendMessage(message, groupId: id);
      }
      _controller.text = "";
    });
  }
}
