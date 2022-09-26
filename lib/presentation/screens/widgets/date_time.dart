import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateTimeHeading extends StatefulWidget {
  const DateTimeHeading({Key? key}) : super(key: key);

  @override
  State<DateTimeHeading> createState() => _DateTimeHeadingState();
}

class _DateTimeHeadingState extends State<DateTimeHeading> {
  DateTime dateTime = DateTime.now();
  NepaliDateTime nepali = NepaliDateTime.now();
  List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Thrusday",
    "Frinday",
    "Saturday"
  ];
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${nepali.day},${nepali.month},${nepali.year}"),
                      const SizedBox(height: 5),
                      Text(
                        "${dateTime.year}-${months[dateTime.month]}-${dateTime.day}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                ),
                const SizedBox(width: 5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${dateTime.hour}: ${dateTime.minute} ${dateTime.hour < 12 ? "AM" : "PM"}",
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        days[nepali.weekday],
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.cloud,
                    ),
                    SizedBox(width: 10),
                    Text("23°C")
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "BuddhaNagar, Kathmandu",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
