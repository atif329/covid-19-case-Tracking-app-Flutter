// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:covid_tracker/model/world_states_model.dart';
import 'package:covid_tracker/services/utilities/states_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade700,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PieChart(
                              chartRadius: 120,
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              dataMap: {
                                "total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "recovered": double.parse(
                                    snapshot.data!.recovered!.toString()),
                                "deaths": double.parse(
                                    snapshot.data!.deaths!.toString())
                              },
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.right),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .04),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: "Total",
                                        value:
                                            snapshot.data!.cases!.toString()),
                                    ReusableRow(
                                        title: "Active",
                                        value:
                                            snapshot.data!.active!.toString()),
                                    ReusableRow(
                                        title: "Recovered",
                                        value: snapshot.data!.recovered!
                                            .toString()),
                                    ReusableRow(
                                        title: "Deaths",
                                        value:
                                            snapshot.data!.deaths!.toString()),
                                    ReusableRow(
                                        title: "Critical",
                                        value: snapshot.data!.critical!
                                            .toString()),
                                    ReusableRow(
                                        title: "Today Cases",
                                        value: snapshot.data!.todayCases!
                                            .toString()),
                                    ReusableRow(
                                        title: "Today Recovered",
                                        value: snapshot.data!.todayRecovered!
                                            .toString()),
                                    ReusableRow(
                                        title: "Today Deaths",
                                        value: snapshot.data!.todayDeaths!
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff1aa260)),
                                child: const Center(
                                  child: Text("Track Countries"),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 5, left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}
