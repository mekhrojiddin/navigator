import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc()
      : super(
          LocationState(
            route: const PolylineMapObject(
              mapId: MapObjectId('route'),
              polyline: Polyline(
                points: [],
              ),
            ),
            status: Status.loading,
            nextPoint: const Point(latitude: 41.285703, longitude: 69.203733),
            myPoint: const Point(
              latitude: 0,
              longitude: 0,
            ),
          ),
        ) {
    on<StartedLocationBloc>((event, emit) async {
      var point = await Location().getLocation();

      emit(state.copyWith(
        myPoint: Point(latitude: point.latitude!, longitude: point.longitude!),
        status: Status.success,
      ));
      final request = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
            point: state.myPoint,
            requestPointType: RequestPointType.wayPoint,
          ),
          RequestPoint(
            point: state.nextPoint,
            requestPointType: RequestPointType.wayPoint,
          ),
        ],
        drivingOptions: const DrivingOptions(
          initialAzimuth: 0,
          routesCount: 2,
          avoidTolls: true,
        ),
      );
      final result = await request.result;

      emit(state.copyWith(
        route: PolylineMapObject(
          strokeColor: Colors.black,
          strokeWidth: 3,
          mapId: const MapObjectId("route"),
          polyline: Polyline(
            points: result.routes?.first.geometry ?? [],
          ),
        ),
      ));
      
    
    });
  }
}
