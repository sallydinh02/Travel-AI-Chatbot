import 'package:flutter/material.dart';
import 'package:smart_travel_assistant/UI/travel/accommodation_list_tile.dart';
import 'package:smart_travel_assistant/UI/travel/attraction_list_tile.dart';
import 'package:smart_travel_assistant/objects/accommodation.dart';
import 'package:smart_travel_assistant/objects/attraction.dart';
import 'package:smart_travel_assistant/objects/city.dart';

class TravelUI extends StatefulWidget {
  City citiesDropdownValue;
  TravelUI({required this.citiesDropdownValue});

  @override
  State<TravelUI> createState() => _TravelUIState();
}

class _TravelUIState extends State<TravelUI> {
  final List<City> _cities = [
    City.hcmCity,
    City.haNoiCity,
    City.daNangCity,
    City.canThoCity,
    City.vungTau,
    City.lamDong
  ];

  //City _citiesDropdownValue = City.hcmCity;

  final List<String> _types = [
    'Attractions',
    'Accommodations',
  ];

  String _typesDropdownValue = 'Attractions';

  final List<AttractionType> _attractionType = [
    AttractionType.siteAndLandmark,
    AttractionType.museum,
    AttractionType.pagodaAndChurch,
  ];

  AttractionType _attractionTypeDropdownValue = AttractionType.siteAndLandmark;

  final List<AccommodationType> _accommodationTypes = [
    AccommodationType.hotel,
    AccommodationType.homestay,
  ];

  AccommodationType _accommodationTypeDropdownValue = AccommodationType.hotel;

  final _dropdownMenuIcon =
  const Icon(Icons.keyboard_arrow_down_rounded, size: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: Text(
          widget.citiesDropdownValue.cityName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _dropdownSelectingCategory(),
              _listResult(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownSelectingCategory() {
    // header
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 3,
      child: Container(
        child:
          /*// location
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 5, 0, 5),
            child: _selectLocation(),
          ),*/
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 5, 0, 10),
            child: _selectCategory(),
          )
      ),
    );
  }

  Row _selectCategory() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // text
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
          child: Text(
            'Category',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        // dropdown select types
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
            child: DropdownButton<String>(
              items: _types
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _typesDropdownValue = value!;
                });
              },
              value: _typesDropdownValue,
              icon: _dropdownMenuIcon,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        // dropdown select types of attractions / accommodations
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: _typesDropdownValue == 'Attractions'
                ? _dropdownAttractions()
                : _dropdownAccommodations(),
          ),
        ),
      ],
    );
  }

  _dropdownAttractions() {
    return DropdownButton<AttractionType>(
      items: _attractionType
          .map((e) =>
          DropdownMenuItem<AttractionType>(child: Text(e.name), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _attractionTypeDropdownValue = value!;
        });
      },
      value: _attractionTypeDropdownValue,
      icon: _dropdownMenuIcon,
      style: TextStyle(color: Colors.black, fontSize: 12),
    );
  }

  _dropdownAccommodations() {
    return DropdownButton<AccommodationType>(
      items: _accommodationTypes
          .map((e) => DropdownMenuItem<AccommodationType>(
          child: Text(e.name), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _accommodationTypeDropdownValue = value!;
        });
      },
      value: _accommodationTypeDropdownValue,
      icon: _dropdownMenuIcon,
      style: TextStyle(color: Colors.black),
    );
  }

  _listResult() {
    return StreamBuilder(
      stream: _getResultsFromFirebase(),
      builder: (context, AsyncSnapshot snapshot) {
        debugPrint(
            'hasError: ${snapshot.hasError}, snapshot.hasData: ${snapshot.hasData}');
        if (snapshot.hasError) {
          return const Text("Error occur");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingIndicator();
        } else if (snapshot.hasData) {
          if (snapshot.data!.docs.length > 0) {
            debugPrint('snapshot data length: ${snapshot.data!.docs.length}');
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                if (_typesDropdownValue == 'Attractions') {
                  return attractionListTile(
                      context: context,
                      name: data['name'],
                      description: data['description'],
                      image: data['image']);
                } else {
                  return accommodationListTile(
                      context: context,
                      name: data['name'],
                      description: data['description'],
                      image: data['image'],
                      price: data['price'] is int
                          ? data['price'].toDouble()
                          : data['price']);
                }
              },
              itemCount: snapshot.data!.docs.length,
            );
          } else {
            return _noResult();
          }
        } else {
          return const Text("Else hasData");
        }
      },
    );
  }

  Center _noResult() {
    return Center(
      child: Text(
        'No result',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  _getResultsFromFirebase() {
    return _typesDropdownValue == 'Attractions'
        ? _getAttractions()
        : _getAccommodations();
  }

  _getAccommodations() {
    return Accommodation.collection
        .where('city', isEqualTo: widget.citiesDropdownValue.cityName)
        .where('type', isEqualTo: _accommodationTypeDropdownValue.value)
        .snapshots();
  }

  _getAttractions() {
    return Attraction.collection
        .where('city', isEqualTo: widget.citiesDropdownValue.cityName)
        .where('type', isEqualTo: _attractionTypeDropdownValue.value)
        .snapshots();
  }

  _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.blue),
    );
  }
}
