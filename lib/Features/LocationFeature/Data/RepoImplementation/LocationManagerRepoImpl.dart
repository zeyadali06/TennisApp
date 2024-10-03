import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class LocationManagerRepoImpl implements LocationManagerRepo {
  LocationManagerRepoImpl({required this.firestore});

  final Firestore firestore;

  @override
  Future<RequestResault<void, FirebaseFailureHandler>> addLoaction(PositionEntity poistionEntity) async {
    try {
      var res = await firestore.getField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, key: ConstantNames.locationsField);
      bool alreadyExist = false;
      for (var ele in (res as List)) {
        if (PositionEntity.fromJson(ele).compare(poistionEntity)) {
          alreadyExist = true;
          break;
        }
      }
      if (!alreadyExist) {
        res.add(poistionEntity.toMap());
      }
      await firestore.updateField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, data: {ConstantNames.locationsField: res});
      return RequestResault.success(null);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<void, FirebaseFailureHandler>> deleteLoaction(PositionEntity poistionEntity) async {
    try {
      var res = await firestore.getField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, key: ConstantNames.locationsField);
      for (int i = 0; i < (res as List).length; i++) {
        if (PositionEntity.fromJson(res[i]).compare(poistionEntity)) {
          res.remove(i);
          break;
        }
      }
      await firestore.updateField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, data: {ConstantNames.locationsField: res});
      return RequestResault.success(null);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }
}
