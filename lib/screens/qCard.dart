import 'package:flutter/material.dart';

getQCard() {
  return Container(
    child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Q Name"),
          IconButton(onPressed: () {}, icon: Icon(Icons.stop_circle)),
          IconButton(onPressed: () {}, icon: Icon(Icons.pause_circle))
        ],
      ),
      Row(
        children: [
          getCountElement("count", "12"),
          getCountElement("count", "5m"),
          getCountElement("count", "3m"),
        ],
      ),
      Row()
    ]),
  );
}

getCountElement(heading, value) {
  return Column(
    children: [Text(heading), Text(value)],
  );
}
