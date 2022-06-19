import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheets_data_kitzur/helpers/convert_string_to_date_time.dart';
import 'package:google_sheets_data_kitzur/models/day_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentLoading());

  SharedPreferences? prefs;

  getData(DateTime dateTime) async {
    prefs ??= await SharedPreferences.getInstance();
    final DateTime dateFormated =
        DateTime(dateTime.year, dateTime.month, dateTime.day);

    emit(ContentLoading());
    try {
      http.Response response = await http.get(Uri.parse(
          'https://opensheet.elk.sh/1ZrQoS8icsexeMsEFkNveCQgcshF50z8a2kQYcEmJAVY/home'));
      prefs?.setString('data', response.body);

      try {
        Day currentDay = getCurrentDay(response.body, dateFormated);
        emit(ContentData(currentDay.message));
      } catch (e) {
        emit(ContentError('$e'));
      }
    } catch (e) {
      String? dataResponse = prefs?.getString('data');
      if (dataResponse != null) {
        try {
          Day currentDay = getCurrentDay(dataResponse, dateFormated);
          emit(ContentData(currentDay.message));
        } catch (e) {
          emit(ContentError('$e'));
        }
      } else {
        emit(ContentError('Sin Conexion a Internet'));
      }
    }
  }

  Day getCurrentDay(String dataResponse, DateTime dateTime) {
    List data = const JsonDecoder().convert(dataResponse) as List;
    List<Day> listOfDays = data.map((o) => Day.fromMap(o)).toList();

    try {
      Day currentDay = listOfDays
          .firstWhere((day) => convertStringToDateTime(day.date) == dateTime);
      return currentDay;
    } catch (e) {
      throw 'Dia no encontrado (${dateTime.toString().split(' ')[0]})';
    }
  }
}
