import 'package:flutter/material.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/components/parking_detail_component.dart';

class ParkingDetailScreen extends StatelessWidget {
  final ParkingSpot spot;

  const ParkingDetailScreen({
    Key? key,
    required this.spot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ParkingDetailComponent(spot: spot),
      ),
    );
  }
}