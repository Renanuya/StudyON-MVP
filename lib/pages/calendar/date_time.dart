import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/pages/calendar/date_picker_item.dart';
import 'package:thinktank/pages/calendar/time_model.dart';

class SelectDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimeModel timeModel = Provider.of<TimeModel>(context);

    return DatePickerItem(
      children: <Widget>[
        const Text('Zaman'),
        CupertinoButton(
          onPressed: () => _showDialog(context, timeModel),
          child: Text(
            '${timeModel.time.hour}:${timeModel.time.minute}',
            style: const TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, TimeModel timeModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Zaman seç'),
          content: CupertinoDatePicker(
            initialDateTime: timeModel.time,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newTime) {
              timeModel.updateTime(newTime);
              print(newTime);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}
