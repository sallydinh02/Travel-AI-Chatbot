enum City {
  hcmCity('Ho Chi Minh City'),
  daNangCity('Da Nang City'),
  canThoCity('Can Tho City'),
  vungTau('Vung Tau'),
  lamDong('Lam Dong'),
  haNoiCity('Ha Noi City');

  const City(this.cityName);

  final String cityName;

  static getCity(String cityName) {
    switch (cityName) {
      case ('Ho Chi Minh City'):
        return City.hcmCity;

      case ('Da Nang City'):
        return City.daNangCity;

      case ('Can Tho City'):
        return City.canThoCity;

      case ('Vung Tau'):
        return City.vungTau;

      case ('Lam Dong'):
        return City.lamDong;

      case ('Ha Noi City'):
        return City.haNoiCity;

      default:
        return null;
    }
  }

  static List<City> getAllCities() {
    return [
      City.hcmCity,
      City.haNoiCity,
      City.canThoCity,
      City.daNangCity,
      City.lamDong,
      City.vungTau,
    ];
  }

  static List<String> getAllCitiesName() {
    return [
      City.hcmCity.cityName,
      City.haNoiCity.cityName,
      City.canThoCity.cityName,
      City.daNangCity.cityName,
      City.lamDong.cityName,
      City.vungTau.cityName,
    ];
  }
}