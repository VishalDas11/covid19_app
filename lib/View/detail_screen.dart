import 'package:covid_app/View/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  var name;
  var image;
  var totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      TodayRecovered,
      test;

  DetailScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.TodayRecovered,
    required this.test,
  }) : super(key: key);
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .06,
                                ),
                                Resuable(
                                  title: 'Name',
                                  value: widget.name.toString(),
                                ),
                                Resuable(
                                    title: 'Critical',
                                    value: widget.critical.toString()),
                                Resuable(
                                  title: 'Active',
                                  value: widget.active.toString(),
                                ),
                                Resuable(
                                    title: 'Test', value: widget.test.toString()),
                                Resuable(
                                  title: 'Recovered',
                                  value: widget.TodayRecovered.toString(),
                                ),
                                Resuable(
                                    title: "Deaths", value: widget.active.toString()),
                                Resuable(
                                  title: 'Total Death',
                                  value: widget.totalDeaths.toString(),
                                ),
                                Resuable(
                                  title: 'Total Recovered',
                                  value: widget.totalRecovered.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.image),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
