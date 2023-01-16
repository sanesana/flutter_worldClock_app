import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setupWorldTime() async {
    WorldTime instance =
        WorldTime(location: 'Berlin', url: 'Europe/Berlin', flag: 'Germany');

    await instance.getTime();
    // print(instance.time);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return 
   Center(
        child: SpinKitFadingFour(
          color: Colors.black,
          size: 50.0,
        ),
      );
    
  }
}
