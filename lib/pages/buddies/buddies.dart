import 'package:flutter/material.dart';
import 'package:sunshine_iith/pages/buddies/pg_buddies.dart';
import 'package:sunshine_iith/pages/buddies/phd_buddies.dart';
import 'package:sunshine_iith/pages/buddies/ug_buddies.dart';
import 'package:sunshine_iith/widgets/headers.dart';

class BuddiesScreen extends StatelessWidget {
  const BuddiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body:TabBarView(
              children: [
                UgBuddies(),
                PgBuddies(),
                PhDBuddies()
              ],
            ),
            bottomNavigationBar: const TabBar(
                indicatorColor: Colors.purple,
                labelColor: Colors.purple,
                unselectedLabelColor:  Color.fromARGB(255, 44, 37, 10),
                tabs: [
                  Tab(text: 'UG BUDDIES',),
                  Tab(text: 'PG BUDDIES',),
                  Tab(text: 'PhD BUDDIES',),
                ],
              ),
              backgroundColor: const Color(0xfff2b545),
          ),
        ),
      );
  }
}