import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget accommodationListTile(
    {required BuildContext context,
      required String name,
      required String description,
      required double price,
      String? image}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(context, image),
          const SizedBox(
            height: 8,
          ),
          _information(context, name, description, price),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 5,
  );
}

_image(BuildContext context, String? image) {
  final width = MediaQuery.of(context).size.width;
  if (image == null || image == '') {
    return Center(
        child: Image.asset(
          'assets/images/TravelAILogoNew.png',
          width: width * 0.70,
          fit: BoxFit.contain,
        ));
  }
  return FutureBuilder(
    future: _getImageFromFirebase(image),
    builder: (context, snapshot) {
      debugPrint(
          'snapshot.connection: ${snapshot.connectionState.name} snapshot.hasData: ${snapshot.hasData}');
      return Center(
          child: (snapshot.hasData)
              ? Image.network(
            snapshot.data!.toString(),
            width: width * 0.70,
            fit: BoxFit.contain,
          )
              : const CircularProgressIndicator(color: Colors.blue));
    },
  );
}

_information(
    BuildContext context,
    String name,
    String description,
    double price,
    ) {
  NumberFormat formatter = NumberFormat.decimalPattern('en_us');
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // name of accommodation
        Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.left,
          softWrap: true,
        ),
        // description
        const SizedBox(
          height: 5,
        ),
        Text(
          formatter.format(price) + ' VND',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        // description
        const SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
          softWrap: true,
        ),
      ],
    ),
  );
}

Future<String> _getImageFromFirebase(String imageLink) async {
  String downloadUrl =
  await FirebaseStorage.instance.ref(imageLink).getDownloadURL();

  debugPrint('download url: $downloadUrl');
  return downloadUrl;
}