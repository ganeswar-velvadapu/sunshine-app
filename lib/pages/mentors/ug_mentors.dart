import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunshine_iith/const/branch_data.dart';
import 'package:sunshine_iith/providers/branch_wise_provider.dart';
import 'package:sunshine_iith/providers/team_data_provider.dart';
import 'package:sunshine_iith/services/firestore_data.dart';
import 'package:sunshine_iith/widgets/expansion_tile.dart';
import 'package:sunshine_iith/widgets/headers.dart';
import 'package:sunshine_iith/widgets/team_data_widget.dart';

class UgMentors extends ConsumerStatefulWidget {
  const UgMentors({super.key});

  @override
  ConsumerState<UgMentors> createState() => _UgMentorsState();
}

class _UgMentorsState extends ConsumerState<UgMentors> {
  List pos = BranchData().codes;
  List branchName = BranchData().branchName;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFirstOpen();
  }

  getData() async {
    print(DateTime.now());
    Map<String, List> dataMap = {};
    for (var posItem in pos) {
      dataMap[posItem] = await FirestoreData.getUgMentorsData(posItem);
    print(DateTime.now());

    }
    print(DateTime.now());

    return dataMap;
  }

  addDataToProvider() async {
    Map<String, List> dataMap = await getData();
    // print(dataMap);
    for (int i = 0; i < dataMap.length; i++) {
      List data = dataMap[pos[i]] ?? [];
      print(data);
      ref.read(dataProvider.notifier).addAllData(pos[i], data);
    }
  }

  isFirstOpen()async{
    if(ref.read(dataProvider)[pos[0]]==null){
      // List list = await ;
      addDataToProvider();
    }
    setState(() {
        isLoading= false;
    }); 
  }

  getAllData(){
    List list = [];
    final dataMap = ref.watch(dataProvider);
    for (var posItem in pos) {
      if(dataMap[posItem]!=null && dataMap[posItem]!.isNotEmpty){
      list.addAll(dataMap[posItem]!);
      // print(dataMap[posItem]!);
      }
    }
    // print(list.length);
    
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final dataMap = ref.watch(dataProvider);
    List setData = getAllData() ?? [] ;
    print(setData.length);
    return Scaffold(
      body: Column(
        children: [
          const Headers(title: 'UG Mentors'),
          const SizedBox(
            height: 25.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pos.length,
              itemBuilder: ((context, index) {
              if(dataMap[pos[index]]!=null && dataMap[pos[index]]!.isNotEmpty){
                return ExpansionTileWidget(branchCode: pos[index].toString().toUpperCase(), branchName: branchName[index], data: dataMap[pos[index]]!);
              }else{
                return Container();
              }
            })))
        ],
      ),
    );
  }
}
