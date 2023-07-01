import 'package:flutter/material.dart';

getQCard() {
  return Card(
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Q Name"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getCountElement("count", "12"),
              getCountElement("Wait Time", "5m"),
              getCountElement("Avg Serve Time", "3m"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [getUserList(), getButtonList()],
          )
        ]),
      ));
}

getCountElement(heading, value) {
  return Column(
    children: [Text(heading), Text(value)],
  );
}

getUserList() {
  return Column(
    children: [
      Text("1. Aman (10)"),
      Text("2. Rajan (10)"),
      Text("3. Nimish (20)")
    ],
  );
}

getButtonList() {
  return Column(
    children: [Icon(Icons.undo), Icon(Icons.play_arrow)],
  );
}
