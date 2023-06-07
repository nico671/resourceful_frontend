import 'package:creator/creator.dart';
import 'package:resourceful/repository/database_repository.dart';

DatabaseRepository repo = DatabaseRepository();

final givenLink = Creator.value('');

final checkIfBookmarked = Emitter<bool>((ref, emit) async {
  print('isWorking');
  final link = ref.watch(givenLink);
  var isBookmarked = await repo.checkIfBookmarked(link);
  print('isbookmarked $isBookmarked');
  emit(isBookmarked);
});
