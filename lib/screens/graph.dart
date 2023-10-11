import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  Graph({Key? key, required String symbol})
      : _symbol = symbol,
        super(key: key);

  String _symbol;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<ShareData> shareDataList = [
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 14)),
          shareValue: 10.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 13)),
          shareValue: 5.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 12)),
          shareValue: 10.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 11)),
          shareValue: 75.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 10)),
          shareValue: 25.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 9)),
          shareValue: 1.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 8)),
          shareValue: 47.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 7)),
          shareValue: 78.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 6)),
          shareValue: 38.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 5)),
          shareValue: 59.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 4)),
          shareValue: 53.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 3)),
          shareValue: 38.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 2)),
          shareValue: 9.0),
      ShareData(
          shareDateTime: DateTime.now().subtract(Duration(days: 1)),
          shareValue: 26.0),
      ShareData(shareDateTime: DateTime.now(), shareValue: 10.0),
    ];

    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(height: screenHeight * 0.07),
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              Container(height: screenHeight * 0.15),
              Center(
                  child: Container(
                      width: screenWidth * 0.97,
                      height: screenHeight * 0.5,
                      child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          plotAreaBorderColor: Colors.transparent,
                          margin: EdgeInsets.all(0),
                          title: ChartTitle(
                              text: '${widget._symbol} Share value history',
                              textStyle: TextStyle(color: Colors.white)),
                          primaryXAxis: CategoryAxis(
                              majorTickLines: const MajorTickLines(color: Colors.transparent),
                              majorGridLines: const MajorGridLines(
                                color: Colors.transparent,
                              ),
                              title: AxisTitle(
                                  text: 'Date',
                                  textStyle: TextStyle(color: Colors.white)),
                              axisLine: AxisLine(color: Colors.white)),
                          primaryYAxis: CategoryAxis(
                              majorTickLines: const MajorTickLines(color: Colors.transparent),
                              majorGridLines: const MajorGridLines(
                                color: Colors.transparent,
                              ),
                              title: AxisTitle(
                                  text: 'Value',
                                  textStyle: TextStyle(color: Colors.white)),
                              axisLine: AxisLine(color: Colors.white)),
                          series: <LineSeries<ShareData, String>>[
                            LineSeries<ShareData, String>(
                                enableTooltip: true,
                                color: Colors.pink,
                                dataSource: shareDataList,
                                xValueMapper: (ShareData share, _) =>
                                    DateFormat('yyyy-MM-dd')
                                        .format(share._shareDateTime),
                                yValueMapper: (ShareData share, _) =>
                                    share._shareValue,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(color: Colors.white)),
                                animationDuration: 3000)
                          ])))
            ],
          ),
        ));
  }
}

class ShareData {
  DateTime _shareDateTime;
  double _shareValue;

  DateTime getShareDateTime() {
    return _shareDateTime;
  }

  double getShareValue() {
    return _shareValue;
  }

  ShareData({shareDateTime, shareValue})
      : this._shareDateTime = shareDateTime,
        this._shareValue = shareValue;
}
