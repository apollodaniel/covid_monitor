class Country {

  String countryCode;
  String country;
  int NewConfirmed;
  int TotalConfirmed;
  int NewDeaths;
  int TotalDeaths;

  Country({required this.country, required this.countryCode, required this.NewConfirmed, required this.TotalConfirmed, required this.NewDeaths, required this.TotalDeaths});
  
  factory Country.fromMap(Map<String, dynamic> map){
    print(map.toString());
    return Country(country: map['Country'], countryCode: map['CountryCode'], NewConfirmed: map['NewConfirmed'], TotalConfirmed: map['TotalConfirmed'], NewDeaths: map['NewDeaths'], TotalDeaths: map['TotalDeaths']);
  }

  toMap(){
    return <String, dynamic>{
      "Country": country,
      "countryCode": countryCode,
      "NewConfirmed": NewConfirmed,
      "TotalConfirmed": TotalConfirmed,
      "NewDeaths":NewDeaths,
      "TotalDeaths": TotalDeaths
    };
  }

}