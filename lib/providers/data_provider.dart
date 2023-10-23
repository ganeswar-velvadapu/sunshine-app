import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunshine_iith/services/data_model.dart';

//mentors
final ugMentorDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
final pgMentorDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
final phdMentorDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
//buddies
final ugBuddyDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
final pgBuddyDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
final phdBuddyDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
//for fic and counsellors
final teamDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
//faculty rep
final facultyRepDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());
//management 
final managementDataDataProvider = StateNotifierProvider<DataNotifier, Map<String, List>>((ref) => DataNotifier());

//slot timing
final selectedTimeProvider = StateProvider<String?>((ref) => null);
final selectedDateProvider = StateProvider<String?>((ref) => null);
//isAdmin
final isAdminProvider = StateProvider<bool>((ref) => false);
// final isControllerProvider = StateProvider<bool>((ref) => false);
// final adminAsUserProvider = StateProvider<bool>((ref) => false);


class DataNotifier extends StateNotifier<Map<String, List>> {
  DataNotifier() : super({});

void addData(String position, DataModel data) {
   if (!state.containsKey(position)) {
     state[position] = [];
   }
   state[position]!.add(data);
   state = {...state};
}

void addAllData(String position, List dataList) {
    if (!state.containsKey(position)) {
      state[position] = [];
    }
    state[position]!.addAll(dataList);
    state = {...state};
  }

}

