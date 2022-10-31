import 'package:flutter/material.dart';

import '../models/poplation_model.dart';
import '../pages/page_detail.dart';

class PopulationCard extends StatelessWidget {
  final Population population;

  PopulationCard({required this.population });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PageTwo(
                        population: population,
                      )));
        },
        child: Row(
          children: [
            Icon(
              Icons.person,
              size: 54.0,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Text('Year : ${population.year}'),
              Text('Nation : ${population.nation}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ' ${population.population}',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );}}