// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:covid_tracker/view/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.todayRecovered,
    required this.test,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.critical,
    required this.active,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        ReusableRow(
                            title: 'Cases',
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: 'Total Recovered',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'Recovered Today',
                            value: widget.todayRecovered.toString()),
                        ReusableRow(
                            title: 'Deaths',
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        ReusableRow(
                            title: 'Active', value: widget.active.toString()),
                        ReusableRow(
                            title: 'Tests', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
