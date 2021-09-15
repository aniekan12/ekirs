import 'package:carbon_icons/carbon_icons.dart';
import 'package:data_collection/util/colors.dart';
import 'package:data_collection/views/demandnotice.dart';
import 'package:flutter/material.dart';

class BannerTwo extends StatelessWidget {
  const BannerTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DemandNotice())),
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        width: MediaQuery.of(context).size.width,
        height: 194,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.207182884216309)),
          color: buttonColorOne,
        ),
        child: Stack(clipBehavior: Clip.none, children: [
          //AssetImage('assets/images/littlegirl.png),
          Positioned(
            top: 0,
            bottom: 0,
            left: -32,
            child: Container(
              width: 226,
              height: 226,
              child: Icon(
                CarbonIcons.camera_action,
                size: 100,
              ),
              //child: AssetImage('assets/images/littlegirl.png')
            ),
          ),
          Positioned(
            top: 194 / 4,
            left: MediaQuery.of(context).size.width / 2.75,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: 160,
                      //color:Colors.yellow,
                      child: Text(
                        'Demand Notice',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(246, 246, 246, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          width: 160,
                          child: Text(
                            'Send us a photo of your property here!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(246, 246, 246, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
