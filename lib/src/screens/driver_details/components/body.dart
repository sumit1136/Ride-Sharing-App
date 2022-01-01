import 'package:flutter/material.dart';
import 'package:ride_sharing/view/driver_details_viewmodel.dart';
import 'reusable_button.dart';
import 'ride_confirmed.dart';
import 'call_widget.dart';
import 'package:ride_sharing/config/app_config.dart';

class Body extends StatelessWidget {
  final DriverDetailsViewModel model;
  final Map<String, dynamic>? driver;
  Body({Key? key, required this.model, required this.driver}) : super(key: key);

  final double sizedHeight = getProportionateScreenHeight(7);

  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return model.isRideConfirmed
            ? rideConfirmed(drivername: driver!['uid'], context: context)
            : rideNotConfirmed(
                context: context, drivername: 'New user', model: model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(200), //change to app height
          child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(8),
            vertical: getProportionateScreenHeight(40),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/user_img.png',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver!['uid'].length < 15
                            ? driver!['uid']
                            : driver!['uid'].substring(0, 15),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Row(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(30),
                            width: getProportionateScreenWidth(30),
                            child: Image.asset('assets/images/check_mark.png'),
                          ),
                          Text(
                            'Vaccinated',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Color(0xFF2eb574),
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        'Gender : Female',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        'Age : 35 years',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        '3.5 stars',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        driver!['vehicle'],
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(45)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Source : ${driver!['source']}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      'Destination : ${driver!['dest']}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      'On ${driver!['time']}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/call.png',
                          fit: BoxFit.cover,
                          height: 38,
                        ),
                        Text(
                          '+91 60708090100',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: resuableButton(
                                text: 'Chat',
                                onPress: () {
                                  model.rideStatus(true);
                                },
                                buttoncolor: null)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: resuableButton(
                            text: 'Call',
                            buttoncolor: null,
                            onPress: () {
                              showModalSheet(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
