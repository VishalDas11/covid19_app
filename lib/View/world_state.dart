import 'package:covid_app/View/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Models/WorldStateModel.dart';
import '../Services/states_services.dart';

class WorldStateScreen extends StatefulWidget {
  WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices stateServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              FutureBuilder(
                  future: stateServices.fetchWorldStateData(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white38,
                          size: 50,
                          controller: controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .25,
                            child: PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              animationDuration: Duration(seconds: 3),
                              chartType: ChartType.ring,
                              chartRadius:
                                  MediaQuery.of(context).size.width * 3.2,
                              colorList: colorList,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50, bottom: 50),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Resuable(
                                        title: "Total",
                                        value: snapshot.data!.cases.toString()),
                                    Resuable(
                                        title: "Deaths",
                                        value: snapshot.data!.deaths.toString()),
                                    Resuable(
                                        title: "Recovered",
                                        value:
                                            snapshot.data!.recovered.toString()),
                                    Resuable(
                                        title: "Active",
                                        value: snapshot.data!.active.toString()),
                                    Resuable(
                                        title: "Critical",
                                        value:
                                            snapshot.data!.critical.toString()),
                                    Resuable(
                                        title: "Today Death",
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    Resuable(
                                        title: "Today Recovered",
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CountriesListScreen()));
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(20)),
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
    );
  }
}

class Resuable extends StatelessWidget {
  String title, value;
  Resuable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
