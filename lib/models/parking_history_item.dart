// Parking history item model

class ParkingHistoryItem {
  final String id;
  final String spotName;
  final String address;
  final DateTime startTime;
  final DateTime endTime;
  final String spaceId;
  final int floor;
  final String vehicle;
  final double amount;
  final bool isCompleted;

  ParkingHistoryItem({
    required this.id,
    required this.spotName,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.spaceId,
    required this.floor,
    required this.vehicle,
    required this.amount,
    required this.isCompleted,
  });

  // Calculate duration in hours
  int get durationInHours {
    final difference = endTime.difference(startTime);
    return (difference.inMinutes / 60).ceil();
  }
  
  // Format date (Oct 18)
  String get formattedDate {
    return 'Oct ${startTime.day}';
  }
  
  // Format start time (14:30)
  String get formattedStartTime {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }
  
  // Format end time (16:30)
  String get formattedEndTime {
    return '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }
  
  // Get time remaining for ongoing bookings (2h 30m left)
  String get timeRemaining {
    final now = DateTime.now();
    if (now.isAfter(endTime)) {
      return 'Expired';
    }
    
    final difference = endTime.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m left';
    } else {
      return '${minutes}m left';
    }
  }
}