import 'package:covid_app/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  hintText: "Search with country",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
                onChanged: (value){
                  setState((){});
                },
              ),
            ),

            Expanded(
                child: FutureBuilder(
                    future: statesServices.CountriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade800,
                        highlightColor: Colors.grey.shade100,
                        child:ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return
                                  Column(
                                    children: [
                                      ListTile(
                                        title:
                                        Container(width: 89,
                                          height: 40,
                                          color: Colors.white,),
                                        subtitle: Container(width: 89,
                                          height: 40,
                                          color: Colors.white,),
                                        leading: Container(width: 89,
                                          height: 40,
                                          color: Colors.white,),
                                      )
                                    ],
                                  );
                              })
                      );
                    }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];

                          if(searchcontroller.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return DetailScreen(
                                       image: snapshot.data![index]['countryInfo']['flag'],
                                         name: snapshot.data![index]['country'].toString(),
                                         TodayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                         critical: snapshot.data![index]['critical'].toString(),
                                         active:snapshot.data![index]['active'].toString(),
                                         test: snapshot.data![index]['tests'].toString(),
                                         totalCases: snapshot.data![index]['cases'].toString(),
                                         totalDeaths:snapshot.data![index]['deaths'].toString(),
                                         totalRecovered: snapshot.data![index]['recovered'].toString(),

                                     );
                                   }));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle:  Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  ),
                                )
                              ],
                            );
                          }
                          else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'].toString(),
                                    TodayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                    critical: snapshot.data![index]['critical'].toString(),
                                    active:snapshot.data![index]['active'].toString(),
                                    test: snapshot.data![index]['tests'].toString(),
                                    totalCases: snapshot.data![index]['cases'].toString(),
                                    totalDeaths:snapshot.data![index]['deaths'].toString(),
                                    totalRecovered: snapshot.data![index]['recovered'].toString(),

                                  );
                                }));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle:  Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  )
                                ],
                              ),
                            );
                          }
                          else{
                            return Container();
                          }
                    });
                  }

                })
            )
          ],
        ),
      ),
    );
  }
}
