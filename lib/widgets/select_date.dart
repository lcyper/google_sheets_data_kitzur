import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheets_data_kitzur/cubit/content_cubit.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _currentDate = DateTime.now();
  late final JewishCalendar jewishCalendar =
      JewishCalendar.fromDateTime(_currentDate);
  HebrewDateFormatter hebrewDateFormatter = HebrewDateFormatter();

  @override
  void initState() {
    super.initState();
    hebrewDateFormatter.hebrewFormat = true; // optional
    // hebrewDateFormatter.useGershGershayim = true; // optional
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d/M/y').format(_currentDate);
    jewishCalendar.setDate(_currentDate);
    String hebrewDate = hebrewDateFormatter.format(
      jewishCalendar,
      // pattern: 'dd MM yy',
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                updateDate(_currentDate.subtract(const Duration(days: 1)));
              },
              icon: const Icon(Icons.chevron_left),
            ),
            TextButton(
              onPressed: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _currentDate,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (selectedDate != null) {
                  updateDate(selectedDate);
                }
              },
              child: Text(
                formattedDate,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                    ),
              ),
            ),
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                updateDate(_currentDate.add(const Duration(days: 1)));
              },
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        Text(
          hebrewDate,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        )
      ],
    );
  }

  void updateDate(DateTime newDateTime) {
    setState(() {
      _currentDate = newDateTime;
    });
    context.read<ContentCubit>().getData(newDateTime);
  }
}
