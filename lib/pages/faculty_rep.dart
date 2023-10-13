import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunshine_iith/const/branch_data.dart';
import 'package:sunshine_iith/providers/data_provider.dart';
import 'package:sunshine_iith/services/firestore_database.dart';
import 'package:sunshine_iith/widgets/expansion_tile.dart';
import 'package:sunshine_iith/widgets/headers.dart';
import 'package:sunshine_iith/widgets/shimmer/expansion_tile_shimmer.dart';

class FacultyRep extends ConsumerStatefulWidget {
  const FacultyRep({super.key});

  @override
  ConsumerState<FacultyRep> createState() => _FacultyRepState();
}

class _FacultyRepState extends ConsumerState<FacultyRep> {
  List pos = BranchData().pgCodes;
  List branchName = BranchData().pgBranchName;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isFirstOpen();
  }

  getData() async {
    Map<String, List> dataMap = {};
    print(DateTime.now());
    List<Future<List>> futures = [];
    for (var posItem in pos) {
       futures.add(FirestoreData.getSpecificData('faculty-rep',posItem));
    }
    List results = await Future.wait(futures);
    for (int i = 0; i < results.length; i++) {
      dataMap[pos[i]] = results[i];
    }
    print(DateTime.now());

    return dataMap;
  }

  addDataToProvider() async {
    Map<String, List> dataMap = await getData();
    for (int i = 0; i < dataMap.length; i++) {
      List data = dataMap[pos[i]] ?? [];
      print(data);
      ref.read(facultyRepDataProvider.notifier).addAllData(pos[i], data);
    }
  }

  isFirstOpen() async {
    if (ref.read(facultyRepDataProvider)[pos[0]] == null) {
      await addDataToProvider();
    }
    setState(() {
      isLoading = false;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final dataMap = ref.watch(facultyRepDataProvider);
    List setData = [];

    for (var posItem in pos) {
      if (dataMap[posItem] != null && dataMap[posItem]!.isNotEmpty) {
        setData.addAll(dataMap[posItem]!);
      }
    }
    print(setData.length);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Headers(title: 'FACULTY REPRESENTATIVES'),
            const SizedBox(
              height: 25.0,
            ),
            isLoading? 
            Expanded(child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 50,
              itemBuilder: (ctx,index){
                return const ExpansionTileShimmer();
            })) :
            Expanded(
                child: ListView.builder(
                    itemCount: pos.length,
                    itemBuilder: ((context, index) {
                      if (dataMap[pos[index]] != null &&
                          dataMap[pos[index]]!.isNotEmpty) {
                        return ExpansionTileWidget(
                          facRep: true,
                            branchCode: pos[index].toString().toUpperCase(),
                            branchName: branchName[index],
                            data: dataMap[pos[index]]!);
                      } else {
                        return Container();
                      }
                    })))
          ],
        ),
      ),
    );
  }
}
