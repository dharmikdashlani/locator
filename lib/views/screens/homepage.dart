
// ignore_for_file: non_constant_identifier_names

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator_geocoding/model/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // permission() async {
  //   PermissionStatus status = await Permission.location.request();
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   permission();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "Company Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...CEODetails.map(
                (e) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "detail_page", arguments: e);
                  },
                  child: Collection(
                    e['companylogo'],
                    e['companyname'],
                    e['ceoname'],
                    e['ceophoto'],
                  ),
                ),
              ).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Collection(Image logo, String CompanyName, String CEO,
       AssetImage ceoImage) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Neumorphic(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
               SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              logo,
               SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CompanyName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    CEO,
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              CircleAvatar(
                radius: 35,
                backgroundImage: ceoImage,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
