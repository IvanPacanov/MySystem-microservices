import 'package:flutter/material.dart';
import 'package:flutter_client/constants.dart';

class MessageInputField extends StatelessWidget {
  const MessageInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaulPadding,
        vertical: defaulPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0x0FF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
          child: Row(
        children: [
          // Icon(Icons.mic, color: primaryColor),
          // SizedBox(width: defaulPadding),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaulPadding * 0.75,
              ),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Wprowadź wiadomość",
                      border: InputBorder.none,
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
