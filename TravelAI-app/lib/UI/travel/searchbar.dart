import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smart_travel_assistant/objects/city.dart';
import 'package:smart_travel_assistant/UI/travel/travel_ui.dart';

class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({Key? key}) : super(key: key);

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  String userSelected="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 253, 230, 1),
      //backgroundColor: Color.fromRGBO(253, 235, 244, 1),
      body: Padding(
          padding: const EdgeInsets.only(top: 80, left: 25, right: 25),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text("Search for a city or province",
                    style: TextStyle(
                      color: Color.fromRGBO(36, 134, 11, 1),
                        //color: Color.fromRGBO(62, 134, 252, 1),
                        //fontWeight: FontWeight.bold,
                        fontSize: 22,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,  // shadow blur
                            color: Color.fromRGBO(180, 181, 182, 1), // shadow color
                            offset: Offset(1.0, 1.0), // how much shadow will be shown
                          ),]
                    )),
              ),
              SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: TypeAheadField(
                    noItemsFoundBuilder: (context) => const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text('No result Found'),
                      ),
                    ),
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        color: Colors.white,
                        elevation: 4.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                    ),
                    debounceDuration: const Duration(milliseconds: 400),
                    textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(36, 134, 11, 1)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                )),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                borderSide: BorderSide(color: Color.fromRGBO(36, 134, 11, 1))),
                            hintText: "Search",
                            contentPadding:
                            const EdgeInsets.only(top: 4, left: 10),
                            hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon:
                                const Icon(Icons.search, color: Colors.grey)),
                            fillColor: Colors.white,
                            filled: true)),
                    suggestionsCallback: (value) {
                      return City.getAllCitiesName().where((element) {
                        return element
                            .toLowerCase()
                            .startsWith(value.toLowerCase());
                      });
                    },
                    itemBuilder: (context, String suggestion) {
                      return Row(
                        children: [
                          const SizedBox(
                            height: 30,
                            width: 10,
                          ),
                          /*const Icon(
                          Icons.map,
                          color: Colors.grey,
                        ),*/
                          const SizedBox(
                            child: Image(image: AssetImage("assets/customicons/mapicon.png")),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                suggestion,
                                maxLines: 1,
                                // style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    onSuggestionSelected: (String suggestion) {
                      setState(() {
                        userSelected = suggestion;
                        Navigator.of(context).push<void>(MaterialPageRoute(builder: (context) => TravelUI(citiesDropdownValue: City.getCity(userSelected))));
                      });
                    },
                  )
              ),
            ],
          )
      )
    );
  }
}