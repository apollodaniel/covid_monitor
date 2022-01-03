import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'model/Country.dart';
import 'model/Global.dart';

class Helper{


  static getNumberFormat(Locale myLocale){
    NumberFormat nf = NumberFormat.compact(locale: myLocale.languageCode);
    return nf;
  }

  static getCountriesList({String? country_code}) async{

    if(country_code == null){
      // lista toda
      http.Response response = await http.get(Uri.parse("https://api.covid19api.com/summary"));
      if(response.statusCode == 200){
        Map<String, dynamic> responseMap = await json.decode(response.body);
        List<Country> countries = <Country>[];
        for(var country in responseMap["Countries"]){
          countries.add(Country.fromMap(country));
        }
        return countries;
      }
    }else {
      // somente o país de origem
      http.Response response = await http.get(
          Uri.parse("https://api.covid19api.com/summary"));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = await json.decode(response.body);
        List<Country> countries = <Country>[];
        for (var country in responseMap["Countries"]) {
          countries.add(Country.fromMap(country));
        }

        for (Country country in countries) {
          if (country.countryCode == country_code) {
            Map<String, dynamic> result = {
              "country": country,
              "global": Global.fromMap(responseMap["Global"])
            };
            return result;
          }
        }
      }
    }
  }

}