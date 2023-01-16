import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      print(response.statusCode);
      Map data =(response.statusCode==200) ?convert.jsonDecode(response.body) as Map:{};
      String dateTime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(1, 3);
      String offsetMinute = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(dateTime);

      now = now.add(Duration(
          hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));
      print(now.hour);
      isDayTime = (now.hour >= 5 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught an error");
      time = 'It was an error, oopsss!';
    }
  }
}
