import 'package:tennis_app/Core/Utils/Constants.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/LocationAlreadyExistException.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Core/Utils/FirebaseFirestoreServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class LocationManagerRepoImpl implements LocationManagerRepo {
  LocationManagerRepoImpl({required this.firestore});

  @override
  List<PositionEntity> locations = [];
  final Firestore firestore;

  @override
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      getLocations() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            FirebaseFailureHandler(NoInternetException()));
      }

      List<PositionEntity> poistionEntities = await _getAllLocations();

      return RequestResult.success(poistionEntities);
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      addLoaction(PositionEntity positionEntity) async {
    try {
      bool alreadyExist = false;

      for (PositionEntity ele in locations) {
        if (ele == positionEntity) {
          alreadyExist = true;
          break;
        }
      }

      if (!alreadyExist) {
        locations.add(positionEntity);

        List<Map<String, dynamic>> convertedData = _converter(locations);

        bool connStatus = await checkConn();
        if (!connStatus) {
          return RequestResult.failure(
              FirebaseFailureHandler(NoInternetException()));
        }

        await firestore.updateField(
          collectionPath: Constants.locationsCollection,
          docName: Constants.userModel.uid!,
          data: {Constants.locationsField: convertedData},
        );
      } else {
        return RequestResult.failure(
            FirebaseFailureHandler(LocationAlreadyExistException()));
      }

      return RequestResult.success(locations);
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      deleteLoaction(PositionEntity positionEntity) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            FirebaseFailureHandler(NoInternetException()));
      }

      for (int i = 0; i < locations.length; i++) {
        if (locations[i] == positionEntity) {
          locations.removeAt(i);
          break;
        }
      }

      List<Map<String, dynamic>> convertedData = _converter(locations);

      await firestore.updateField(
        collectionPath: Constants.locationsCollection,
        docName: Constants.userModel.uid!,
        data: {Constants.locationsField: convertedData},
      );

      return RequestResult.success(locations);
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      setLocationAsDefault(PositionEntity positionEntity) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            FirebaseFailureHandler(NoInternetException()));
      }

      for (int i = 0; i < locations.length; i++) {
        if (locations[i].isDefault == true) {
          locations[i].isDefault = false;
        }

        if (locations[i] == positionEntity) {
          locations[i].isDefault = true;
        }
      }

      List<Map<String, dynamic>> convertedData = _converter(locations);

      await firestore.updateField(
        collectionPath: Constants.locationsCollection,
        docName: Constants.userModel.uid!,
        data: {Constants.locationsField: convertedData},
      );

      return RequestResult.success(locations);
    } catch (e) {
      return RequestResult.failure(FirebaseFailureHandler(TryAgainException()));
    }
  }

  List<Map<String, dynamic>> _converter(List<PositionEntity> locations) {
    List<Map<String, dynamic>> convertedData = [];
    for (PositionEntity element in locations) {
      convertedData.add(element.toMap());
    }

    return convertedData;
  }

  Future<List<PositionEntity>> _getAllLocations() async {
    var res = await firestore.getField(
        collectionPath: Constants.locationsCollection,
        docName: Constants.userModel.uid!,
        key: Constants.locationsField);
    List<PositionEntity> poistionEntities = [];

    for (var ele in (res as List)) {
      poistionEntities.add(PositionEntity.fromJson(ele));
    }

    locations = poistionEntities;
    return poistionEntities;
  }

  @override
  PositionEntity? getDefaultPosition() {
    for (PositionEntity pos in locations) {
      if (pos.isDefault) {
        return pos;
      }
    }
    return null;
  }
}
