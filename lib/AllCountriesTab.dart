import 'package:covid_monitor/Helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/Country.dart';

class AllCountriesTab extends StatefulWidget {
  const AllCountriesTab({Key? key}) : super(key: key);

  @override
  _AllCountriesTabState createState() => _AllCountriesTabState();
}

class _AllCountriesTabState extends State<AllCountriesTab> {

  late NumberFormat nf;
  late Locale myLocale;

  List<Widget> all_countries_card = [];

  _createCountryCard(Country country){

    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(country.country),
            Padding(
              padding: EdgeInsets.only(bottom: 8,top: 8),
              child: Text("Confirmados: ${nf.format(country.NewConfirmed)}\nMortos: ${nf.format(country.NewDeaths)}"),
            ),
            Image.asset("assets/images/country_flags/${country.countryCode.toLowerCase()}.png", width: 90,)
            /*Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: ,
                  fit: BoxFit.cover,
                ),
              ),
            )*/
          ],
        ),
      )
    );

  }

  _getAllCountriesInfo() async{
    List<Country> countries = await Helper.getCountriesList();
    List<Widget> countries_card = [];

    for(Country country in countries){
      countries_card.add(_createCountryCard(country));
    }

    setState(() {
      all_countries_card = countries_card;
    });
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    nf = Helper.getNumberFormat(myLocale);
    _getAllCountriesInfo();
    return GridView.count(
      crossAxisCount: 2,
      children: all_countries_card,
    );
  }
}
