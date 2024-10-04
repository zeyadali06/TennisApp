import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class LocationManagerRepoImpl implements LocationManagerRepo {
  LocationManagerRepoImpl({required this.firestore});

  @override
  List<PositionEntity> locations = [];
  final Firestore firestore;

  @override
  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> getLocations() async {
    try {
      List<PositionEntity> poistionEntities = await _getAllLocations();

      return RequestResault.success(poistionEntities);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<List<PositionEntity>, dynamic>> addLoaction(PositionEntity positionEntity) async {
    try {
      bool alreadyExist = false;

      for (PositionEntity ele in locations) {
        if (ele.compare(positionEntity)) {
          alreadyExist = true;
          break;
        }
      }

      if (!alreadyExist) {
        locations.add(positionEntity);

        List<Map<String, dynamic>> convertedData = converter(locations);

        await firestore.updateField(
          collectionPath: ConstantNames.locationsCollection,
          docName: ConstantNames.userModel.uid!,
          data: {ConstantNames.locationsField: convertedData},
        );
      } else {
        return RequestResault.failure("Location already exist");
      }

      return RequestResault.success(locations);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> deleteLoaction(PositionEntity positionEntity) async {
    try {
      for (int i = 0; i < locations.length; i++) {
        if (locations[i].compare(positionEntity)) {
          locations.removeAt(i);
          break;
        }
      }

      List<Map<String, dynamic>> convertedData = converter(locations);

      await firestore.updateField(
        collectionPath: ConstantNames.locationsCollection,
        docName: ConstantNames.userModel.uid!,
        data: {ConstantNames.locationsField: convertedData},
      );

      return RequestResault.success(locations);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> setLocationAsDefault(PositionEntity positionEntity) async {
    try {
      for (int i = 0; i < locations.length; i++) {
        if (locations[i].compare(positionEntity)) {
          locations.removeAt(i);
          locations.insert(0, positionEntity);
          break;
        }
      }

      List<Map<String, dynamic>> convertedData = converter(locations);

      await firestore.updateField(
        collectionPath: ConstantNames.locationsCollection,
        docName: ConstantNames.userModel.uid!,
        data: {ConstantNames.locationsField: convertedData},
      );

      return RequestResault.success(locations);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  List<Map<String, dynamic>> converter(List<PositionEntity> locations) {
    List<Map<String, dynamic>> convertedData = [];
    for (PositionEntity element in locations) {
      convertedData.add(element.toMap());
    }

    return convertedData;
  }

  Future<List<PositionEntity>> _getAllLocations() async {
    var res = await firestore.getField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, key: ConstantNames.locationsField);
    List<PositionEntity> poistionEntities = [];

    for (var ele in (res as List)) {
      poistionEntities.add(PositionEntity.fromJson(ele));
    }

    locations = poistionEntities;
    return poistionEntities;
  }
}
