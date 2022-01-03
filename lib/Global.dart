class Global{
  int NewConfirmed;
  int TotalConfirmed;
  int NewDeaths;
  int TotalDeaths;

  Global({required this.NewConfirmed, required this.TotalConfirmed, required this.NewDeaths, required this.TotalDeaths});

  factory Global.fromMap(Map<String, dynamic> map){
    return Global(NewConfirmed: map['NewConfirmed'], TotalConfirmed: map['TotalConfirmed'], NewDeaths: map['NewDeaths'], TotalDeaths: map['TotalDeaths']);
  }

  toMap(){
    return <String, dynamic>{
      "NewConfirmed": NewConfirmed,
      "TotalConfirmed": TotalConfirmed,
      "NewDeaths":NewDeaths,
      "TotalDeaths": TotalDeaths
    };
  }


}