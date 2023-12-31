import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:stock_market_app/dto/shareHistoryDataDto.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/widgets/form/fields/dateFieldWidget.dart';

//ignore: must_be_immutable
class Graph extends StatefulWidget {
  String _symbol;

  Graph({Key? key, required String symbol})
      : _symbol = symbol,
        super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  DateTime _date = DateTime.now().add(Duration(days: -30));
  Future<List<ShareHistoryDataDto>?>? _shareHistory;

  Future<List<ShareHistoryDataDto>?> _shareHistoryRequest(
      ShareService shareService) async {
    Map<DateTime, double>? shareHistoryResponse = await shareService
        .getSymbolSharesPricesHistoryWithDate(widget._symbol, _date);
    List<ShareHistoryDataDto> shareHistory = [];
    shareHistoryResponse!.forEach((date, value) {
      shareHistory.add(ShareHistoryDataDto(date: date, value: value));
    });
    return shareHistory;
  }

  void _setShareHistory(Future<List<ShareHistoryDataDto>?> shareHistory) {
    setState(() {
      _shareHistory = shareHistory;
    });
  }

  void _setDate(DateTime date) {
    setState(() {
      _date = date;
    });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    _setShareHistory(_shareHistoryRequest(inheritedServices.shareService));

    return FutureBuilder<List<ShareHistoryDataDto>?>(
        future: _shareHistory,
        builder: ((context, shareHistory) {
          return Scaffold(
              backgroundColor: Colors.grey.shade800,
              resizeToAvoidBottomInset: false,
              body: Container(
                child: Column(children: [
                  Container(height: screenHeight * 0.07),
                  Row(children: [
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
                    if (shareHistory.hasData) ...[
                      Container(width: screenWidth * 0.17),
                      DateFieldWidget(
                        key: Key('request-beginning'),
                        onChange: (DateTime date) {
                          _setDate(date);
                        },
                        validator: (DateTime date) {
                          if(date.compareTo(DateTime.now()) <= 0){
                            return true;
                          }
                          return false;
                        },
                        label: 'Select a date : ',
                        errorLabel: 'Select a date before the current one',
                      )
                    ]
                  ]),
                  Container(height: screenHeight * 0.15),
                  if (shareHistory.hasData) ...[
                    Center(
                        child: Container(
                            width: screenWidth * 0.97,
                            height: screenHeight * 0.5,
                            child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                plotAreaBorderColor: Colors.transparent,
                                margin: EdgeInsets.all(0),
                                title: ChartTitle(
                                    text: '    Share value history',
                                    textStyle: TextStyle(color: Colors.white)),
                                primaryXAxis: CategoryAxis(
                                    majorTickLines: const MajorTickLines(
                                        color: Colors.transparent),
                                    majorGridLines: const MajorGridLines(
                                      color: Colors.transparent,
                                    ),
                                    title: AxisTitle(
                                        text: 'Date',
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                    axisLine: AxisLine(color: Colors.white)),
                                primaryYAxis: CategoryAxis(
                                    majorTickLines: const MajorTickLines(
                                        color: Colors.transparent),
                                    majorGridLines: const MajorGridLines(
                                      color: Colors.transparent,
                                    ),
                                    title: AxisTitle(
                                        text: 'Value',
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                    axisLine: AxisLine(color: Colors.white)),
                                series: <LineSeries<ShareHistoryDataDto,
                                    String>>[
                                  LineSeries<ShareHistoryDataDto, String>(
                                      enableTooltip: true,
                                      color: Colors.red,
                                      dataSource: shareHistory.data!,
                                      xValueMapper:
                                          (ShareHistoryDataDto share, _) =>
                                              DateFormat('yyyy-MM-dd')
                                                  .format(share.getDate()),
                                      yValueMapper:
                                          (ShareHistoryDataDto share, _) =>
                                              share.getValue(),
                                      dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                          textStyle:
                                              TextStyle(color: Colors.white)),
                                      animationDuration: 3000)
                                ]))),
                    if (shareHistory.data![0].getValue() <= 0) ...[
                      Container(height: screenHeight * 0.05),
                      Container(
                          width: screenWidth * 0.8,
                          child: Text(
                              "If values are equal to -1, it means that we couldn't retrieve the value data for that specific time",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 15)))
                    ]
                  ] else if (shareHistory.hasError) ...[
                    Container(height: screenHeight * 0.20),
                    Container(
                        width: screenWidth * 0.9,
                        child: Text('Something went wrong',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 20)))
                  ] else ...[
                    Container(height: screenHeight * 0.20),
                    const CircularProgressIndicator()
                  ]
                ]),
              ));
        }));
  }
}
