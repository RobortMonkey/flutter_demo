import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/res/gaps.dart';
import 'package:flutterapp/res/resources.dart';

class StoreSelectTextItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;

  StoreSelectTextItem(
      {Key key,
      this.onTap,
      this.title,
      this.content: '',
      this.textAlign: TextAlign.start,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 8.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        )),
        child: Row(
          children: <Widget>[
            Text(title),
            Gaps.hGap16,
            Expanded(
              child: Text(
                content,
                maxLines: 2,
                textAlign: textAlign,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ),
            Gaps.hGap8,
            Images.arrowRight
          ],
        ),
      ),
    );
  }
}
