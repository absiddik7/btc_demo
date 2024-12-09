import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _username = "Jason Wilson";
  String _joinDate = "Joined April 15, 2024";

  String get username => _username;
  String get joinDate => _joinDate;

  final List<Map<String, dynamic>> _achievements = [
    {
      'icon': Icons.star,
      'title': 'Gold Member',
      'subtitle': 'April 15, 2024',
    },
    {
      'icon': Icons.school,
      'title': 'Scholar',
      'subtitle': 'May 23, 2024',
    },
    {
      'icon': Icons.sports_esports,
      'title': 'Gamer',
      'subtitle': 'June 23, 2024',
    },
    {
      'icon': Icons.workspace_premium,
      'title': 'Pro Developer',
      'subtitle': 'November 15, 2024',
    },
    {
      'icon': Icons.workspace_premium,
      'title': 'Pro Developer',
      'subtitle': 'December 15, 2024',
    },
  ];
  List<Map<String, dynamic>> get achievements => _achievements;

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  void updateJoinDate(String newDate) {
    _joinDate = newDate;
    notifyListeners();
  }
}
