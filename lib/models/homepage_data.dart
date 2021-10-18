import 'dart:convert';

List<Coutries> coutriesFromJson(String str) =>
    List<Coutries>.from(json.decode(str).map((x) => Coutries.fromJson(x)));

String coutriesToJson(List<Coutries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coutries {
  Coutries(
      {this.name,
      this.independent,
      this.status,
      this.unMember,
      this.area,
      this.capital,
      this.region,
      this.subregion,
      this.landlocked,
      this.flag,
      this.maps,
      this.population,
      this.timezones,
      this.continents,
      this.flags});

  Name? name;
  bool? independent;
  String? status;
  bool? unMember;

  List<String>? capital;
  String? region;
  String? subregion;
  bool? landlocked;
  List<String>? borders;
  double? area;
  String? flag;
  Maps? maps;
  int? population;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;

  factory Coutries.fromJson(Map<String, dynamic> json) => Coutries(
        name: Name.fromJson(json["name"]),
        // ignore: prefer_if_null_operators
        independent: json["independent"] == null ? null : json["independent"],
        status: json["status"],
        unMember: json["unMember"],
        capital: json["capital"] == null
            ? null
            : List<String>.from(json["capital"].map((x) => x)),
        region: json["region"],
        subregion: json["subregion"] == null ? null : json["subregion"],
        landlocked: json["landlocked"],
        area: json["area"].toDouble(),
        flag: json["flag"] == null ? null : json["flag"],
        maps: Maps.fromJson(json["maps"]),
        population: json["population"],
        timezones: List<String>.from(json["timezones"].map((x) => x)),
        continents: List<String>.from(json["continents"].map((x) => x)),
        flags: Flags.fromJson(json["flags"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name!.toJson(),
        "independent": independent == null ? null : independent,
        "status": status,
        "unMember": unMember,
        "capital":
            capital == null ? null : List<dynamic>.from(capital!.map((x) => x)),
        "region": region,
        "subregion": subregion == null ? null : subregion,
        "landlocked": landlocked,
        "borders":
            borders == null ? null : List<dynamic>.from(borders!.map((x) => x)),
        "area": area,
        "flag": flag == null ? null : flag,
        "maps": maps!.toJson(),
        "population": population,
        "timezones": List<dynamic>.from(timezones!.map((x) => x)),
        "continents": List<dynamic>.from(continents!.map((x) => x)),
        "flags": flags!.toJson(),
      };
}

class Flags {
  Flags({
    this.png,
    this.svg,
  });

  String? png;
  String? svg;

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
      };
}

class Maps {
  Maps({
    this.googleMaps,
    this.openStreetMaps,
  });

  String? googleMaps;
  String? openStreetMaps;

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["googleMaps"],
        openStreetMaps: json["openStreetMaps"],
      );

  Map<String, dynamic> toJson() => {
        "googleMaps": googleMaps,
        "openStreetMaps": openStreetMaps,
      };
}

class Name {
  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  String? common;
  String? official;
  Map<String, Translation>? nativeName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
        nativeName: json["nativeName"] == null
            ? null
            : Map.from(json["nativeName"]).map((k, v) =>
                MapEntry<String, Translation>(k, Translation.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
        "nativeName": nativeName == null
            ? null
            : Map.from(nativeName!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Translation {
  Translation({
    this.official,
    this.common,
  });

  String? official;
  String? common;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        official: json["official"],
        common: json["common"],
      );

  Map<String, dynamic> toJson() => {
        "official": official,
        "common": common,
      };
}
