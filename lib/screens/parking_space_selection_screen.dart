import 'package:flutter/material.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/components/primary_button.dart';
import 'package:parkright/utils/app_constants.dart';

class ParkingSpaceSelectionScreen extends StatefulWidget {
  final ParkingSpot spot;
  final int selectedHours;
  
  const ParkingSpaceSelectionScreen({
    super.key,
    required this.spot,
    required this.selectedHours,
  });

  @override
  State<ParkingSpaceSelectionScreen> createState() => _ParkingSpaceSelectionScreenState();
}

class _ParkingSpaceSelectionScreenState extends State<ParkingSpaceSelectionScreen> {
  int _selectedFloor = 1; // Default to 1st floor
  String? _selectedSpaceId;
  
  // Floors available in the parking
  final List<int> _floors = [1, 2, 3];
  
  // Simulated parking spaces data for each floor
  final Map<int, List<ParkingSpace>> _parkingSpaces = {
    1: [ // 1st floor
      ParkingSpace(id: 'A5', isAvailable: true, row: 0, column: 1),
      ParkingSpace(id: 'A6', isAvailable: true, row: 3, column: 0),
      ParkingSpace(id: 'A1', isAvailable: true, row: 1, column: 0),
      ParkingSpace(id: 'A2', isAvailable: true, row: 1, column: 1),
      ParkingSpace(id: 'A3', isAvailable: true, row: 2, column: 0),
      ParkingSpace(id: 'A4', isAvailable: true, row: 2, column: 1),
      ParkingSpace(id: 'A7', isAvailable: true, row: 3, column: 1),
      ParkingSpace(id: 'A8', isAvailable: true, row: 4, column: 0),
      ParkingSpace(id: 'A9', isAvailable: true, row: 4, column: 1),
    ],
    2: [ // 2nd floor
      ParkingSpace(id: 'B1', isAvailable: true, row: 0, column: 0),
      ParkingSpace(id: 'B2', isAvailable: true, row: 0, column: 1),
      ParkingSpace(id: 'B3', isAvailable: true, row: 1, column: 0),
      ParkingSpace(id: 'B4', isAvailable: true, row: 1, column: 1),
      ParkingSpace(id: 'B5', isAvailable: true, row: 2, column: 0),
      ParkingSpace(id: 'B6', isAvailable: false, row: 2, column: 1), // Unavailable
    ],
    3: [ // 3rd floor
      ParkingSpace(id: 'C1', isAvailable: true, row: 0, column: 0),
      ParkingSpace(id: 'C2', isAvailable: false, row: 0, column: 1), // Unavailable
      ParkingSpace(id: 'C3', isAvailable: true, row: 1, column: 0),
      ParkingSpace(id: 'C4', isAvailable: true, row: 1, column: 1),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Pick Parking Spot',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Floor selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _floors.map((floor) {
                bool isSelected = floor == _selectedFloor;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedFloor = floor;
                          _selectedSpaceId = null; // Clear selection when floor changes
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected 
                            ? AppColors.primary 
                            : Colors.grey[300],
                        foregroundColor: isSelected 
                            ? Colors.white 
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('${floor}${_getFloorSuffix(floor)} Floor'),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Entry label
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Entry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Parking layout
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildParkingLayout(),
            ),
          ),
          
          // Book button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              text: 'Pay and Confirm',
              onPressed: _selectedSpaceId == null
                  ? null // Disable button if no space is selected
                  : () {
                      // Navigate to booking review screen
                      Navigator.pushNamed(
                        context,
                        AppConstants.bookingReviewRoute,
                        arguments: {
                          'spot': widget.spot,
                          'hours': widget.selectedHours,
                          'spaceId': _selectedSpaceId,
                          'floor': _selectedFloor,
                          'vehicle': 'Toyota Camry', // Default vehicle
                        },
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to get floor suffix (st, nd, rd, th)
  String _getFloorSuffix(int floor) {
    if (floor == 1) return 'st';
    if (floor == 2) return 'nd';
    if (floor == 3) return 'rd';
    return 'th';
  }
  
  // Build parking layout based on selected floor
  Widget _buildParkingLayout() {
    final spaces = _parkingSpaces[_selectedFloor] ?? [];
    
    // Find the maximum row and column to determine grid size
    int maxRow = 0;
    int maxColumn = 0;
    for (var space in spaces) {
      if (space.row > maxRow) maxRow = space.row;
      if (space.column > maxColumn) maxColumn = space.column;
    }
    
    // Create a 2D array to represent the parking layout
    List<List<ParkingSpace?>> layout = List.generate(
      maxRow + 1, 
      (_) => List.generate(maxColumn + 1, (_) => null)
    );
    
    // Fill the layout with parking spaces
    for (var space in spaces) {
      layout[space.row][space.column] = space;
    }
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Arrow pointing down for entry
          const Icon(Icons.keyboard_arrow_down, size: 40, color: Colors.grey),
          
          // Build the parking layout rows
          ...List.generate(layout.length, (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // For odd-indexed rows, show the row indicator (A5, A6, etc.)
                if (rowIndex % 2 == 0 && 
                    rowIndex < layout.length && 
                    layout[rowIndex].any((space) => space != null)) 
                  _buildSpaceIndicator(
                    spaces.firstWhere(
                      (s) => s.row == rowIndex, 
                      orElse: () => ParkingSpace(id: '', isAvailable: false, row: 0, column: 0)
                    ).id
                  ),
                
                // Vertical white line
                if (rowIndex > 0) 
                  Container(
                    width: 1,
                    height: 80,
                    color: Colors.white,
                  ),
                
                // Parking spaces
                ...List.generate(layout[rowIndex].length, (columnIndex) {
                  final space = layout[rowIndex][columnIndex];
                  if (space != null) {
                    return _buildParkingSpace(space);
                  } else {
                    return const SizedBox(width: 60, height: 80);
                  }
                }),
                
                // For even-indexed rows, show the row indicator on the right
                if (rowIndex % 2 != 0 && 
                    rowIndex < layout.length && 
                    layout[rowIndex].any((space) => space != null))
                  _buildSpaceIndicator(
                    spaces.firstWhere(
                      (s) => s.row == rowIndex,
                      orElse: () => ParkingSpace(id: '', isAvailable: false, row: 0, column: 0)
                    ).id
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
  
  // Build a parking space indicator (gray box with ID)
  Widget _buildSpaceIndicator(String id) {
    if (id.isEmpty) return const SizedBox(width: 40);
    
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        id.length > 2 ? id.substring(0, 2) : id,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  // Build an individual parking space
  Widget _buildParkingSpace(ParkingSpace space) {
    final bool isSelected = space.id == _selectedSpaceId;
    
    return GestureDetector(
      onTap: space.isAvailable 
          ? () {
              setState(() {
                _selectedSpaceId = space.id;
              });
            }
          : null,
      child: Container(
        width: 60,
        height: 80,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Car icon
            Icon(
              Icons.directions_car,
              size: 40,
              color: space.isAvailable ? Colors.grey[700] : Colors.grey[300],
            ),
            
            // "Selected" indicator
            if (isSelected)
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Selected',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Simple model to represent a parking space
class ParkingSpace {
  final String id;
  final bool isAvailable;
  final int row;
  final int column;
  
  ParkingSpace({
    required this.id,
    required this.isAvailable,
    required this.row,
    required this.column,
  });
}