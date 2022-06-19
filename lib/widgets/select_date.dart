import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheets_data_kitzur/cubit/content_cubit.dart';
import 'package:google_sheets_data_kitzur/helpers/string_extension.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    initializeDateFormatting();
    // hebrewDateFormatter.hebrewFormat = true; // optional
    hebrewDateFormatter.useGershGershayim = false; // optional
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat(DateFormat.WEEKDAY, 'es').format(_currentDate);
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
              iconSize: 24 * 1.5,
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
                  locale: const Locale('es'),
                );
                if (selectedDate != null) {
                  updateDate(selectedDate);
                }
              },
              child: Column(
                children: [
                  Text(
                    hebrewDate,
                    // formattedDate,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                        ),
                  ),
                  Text(
                    formattedDate.capitalize(),
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 24 * 1.5,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                updateDate(_currentDate.add(const Duration(days: 1)));
              },
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        // Text(
        //   hebrewDate,
        //   style: Theme.of(context).textTheme.subtitle2?.copyWith(
        //         color: Theme.of(context).colorScheme.secondary,
        //       ),
        // ),
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
