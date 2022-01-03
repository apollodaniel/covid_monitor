import 'package:covid_monitor/Helper.dart';
import 'package:covid_monitor/model/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/Country.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  Country currentCountry = Country(country: "Usa", countryCode: "us", NewConfirmed: 123123, TotalConfirmed: 123123, NewDeaths: 123123, TotalDeaths: 123123);
  Global world = Global(NewConfirmed: 123123, TotalConfirmed: 123123, NewDeaths: 123123, TotalDeaths: 123123);

  String currentCountryFlagDir = "assets/images/country_flags/us.png";
  late NumberFormat nf;

  late Locale myLocale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getCountriesCovidInfo() async{
    Map<String, dynamic> result = await Helper.getCountriesList(country_code: myLocale.countryCode);
    setState(() {
      currentCountry = result["country"];
      world = result["global"];
      currentCountryFlagDir = "assets/images/country_flags/${currentCountry.countryCode.toLowerCase()}.png";
    });
  }


  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    nf = Helper.getNumberFormat(myLocale);
    getCountriesCovidInfo();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(currentCountry.country),
                      ),
                      Container(
                        width: 60.0,
                        height: 60.0,
                        child: Image.asset(currentCountryFlagDir),
                      )
                    ],
                  ),
                  //today
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16, top: 8),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(bottom: 8),child: Text("Hoje"),),
                            Text("Confirmados:\n${nf.format(currentCountry.NewConfirmed)}\n\nMortos:\n${nf.format(currentCountry.NewDeaths)}")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(bottom: 8),child: Text("Geral"),),
                            Text("Confirmados:\n${nf.format(currentCountry.TotalConfirmed)}\n\nMortos:\n${nf.format(currentCountry.TotalDeaths)}")
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Text("Mundo"),
                      ),
                      Image.asset("assets/images/country_flags/globo.png", width: 60, height: 60, fit: BoxFit.cover,)
                    ],
                  ),
                  //today
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16, top: 8),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(bottom: 8),child: Text("Hoje"),),
                            Text("Confirmados:\n${nf.format(world.NewConfirmed)}\n\nMortos:\n${nf.format(world.NewDeaths)}")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(bottom: 8),child: Text("Geral"),),
                            Text("Confirmados:\n${nf.format(world.TotalConfirmed)}\n\nMortos:\n${nf.format(world.TotalDeaths)}")
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


