import 'package:flutter/material.dart';
import 'package:rider_app/tabScreens/HomeTabPage.dart';
import 'package:rider_app/tabScreens/EarningsTabPage.dart';
import 'package:rider_app/tabScreens/RatingTabPage.dart';
import 'package:rider_app/tabScreens/ProfileTabPage.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> with SingleTickerProviderStateMixin {
  int selectedTab = 0;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    onItemClicked(int index) {
      setState(() {
        selectedTab = index;
        tabController!.index = index;
      });
    }
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Hometabpage(),
          Earningstabpage(),
          Ratingtabpage(),
          Profiletabpage(),
        ],
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Earnings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Rating"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: selectedTab,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        onTap: onItemClicked,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        showUnselectedLabels: true,
      ),
    );
  }
}
