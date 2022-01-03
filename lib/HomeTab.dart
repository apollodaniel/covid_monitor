import 'package:covid_monitor/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Country.dart';
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
    getCountriesCovidInfo();
  }

  getCountriesCovidInfo() async{
    http.Response response = await http.get(Uri.parse("https://api.covid19api.com/summary"));
    if(response.statusCode == 200){
      Map<String, dynamic> responseMap = await json.decode(response.body);
      List<Country> countries = <Country>[];
      for(var country in responseMap["Countries"]){
        countries.add(Country.fromMap(country));
      }

      setState(() {
        world = Global.fromMap(responseMap["Global"]);
      });

      for(Country country in countries){
        if(country.countryCode == myLocale.countryCode){
          setState(() {
            currentCountry = country;
            currentCountryFlagDir = "assets/images/country_flags/${country.countryCode.toLowerCase()}.png";
          });
        }
      }

    }else{
      getCountriesCovidInfo();
    }
  }


  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    print(myLocale.languageCode);
    print(myLocale.toLanguageTag());
    nf = NumberFormat.compact(locale: myLocale.languageCode);
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


