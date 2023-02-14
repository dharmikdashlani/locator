import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Placemark? placemarks;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Map<String, dynamic> details =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${details['companyname']}",
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: StreamBuilder<Position?>(
          stream: Geolocator.getPositionStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              Position? data = snapshot.data;

              placemarkFromCoordinates(
                      details['latitude'], details['longitude'])
                  .then((List<Placemark> placemark) {
                setState(() {
                  placemarks = placemark[0];
                });
              });
              return (data != null)
                  ? Container(
                      margin: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: details['ceophoto'],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      details['ceoname'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const Text(
                                      "CEO",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Company Details",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                details['companylogo'],
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      details['companyname'],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "location_page",
                                            arguments: details);
                                      },
                                      child: const Text(
                                        "Tap to see Location",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // Text("${data}"),
                            const Text(
                              "Company Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Name : ${(placemarks != null) ? placemarks!.name : Container()}"),
                            Text(
                                "Street : ${(placemarks != null) ? placemarks!.street : Container()}"),
                            Text(
                                "Locality : ${(placemarks != null) ? placemarks!.locality : Container()}"),
                            Text(
                                "Country : ${(placemarks != null) ? placemarks!.country : Container()}"),
                            Text(
                                "Postal Code : ${(placemarks != null) ? placemarks!.postalCode : Container()}"),
                            Text(
                                "Administrative : ${(placemarks != null) ? placemarks!.administrativeArea : Container()}"),
                            Text(
                                "Thoroughfare : ${(placemarks != null) ? placemarks!.thoroughfare : Container()}"),
                            // Text("${placemarks}"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Company Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            details['description'],
                          ],
                        ),
                      ),
                    )
                  : Container();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
