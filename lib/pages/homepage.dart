import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testexfinal/models/poplation_model.dart';
import 'package:http/http.dart' as http;
import 'package:testexfinal/pages/page_detail.dart';
import 'package:testexfinal/widget/population_card.dart';

class PopulationPage extends StatefulWidget {
  const PopulationPage({Key? key}) : super(key: key);

  @override
  State<PopulationPage> createState() => _PopulationPageState();
}

class _PopulationPageState extends State<PopulationPage> {
  List<Population> _populaton = [];
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPop();
  }

  void _fetchPop() async {
    setState(() {
      _isLoading = true;
    });
    var data = await http.get(Uri.parse(
        "https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    var jsonBody = json.decode(data.body)['data'];
    //var jsonData = jsonBody['data'];
    // print(jsonBody);

    for (int j = 0; j < jsonBody.length; j++) {
      _populaton.add(Population(
          year: int.parse(jsonBody[j]['Year']),
          nation: jsonBody[j]['Nation'],
          population: jsonBody[j]['Population']));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POPULATION'),
      ),
      body: Stack(
        children: [
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return PopulationCard(population: _populaton[index]);
                    },
                    itemCount: _populaton.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
