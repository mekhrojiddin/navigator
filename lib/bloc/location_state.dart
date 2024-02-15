// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_bloc.dart';

class LocationState {
  final Point nextPoint;
  final Point myPoint;
  YandexMapController? controller;
  final PolylineMapObject route; 
  final Status status;
  LocationState({
    required this.nextPoint,
    required this.myPoint,
    this.controller,
   required this.route,
    required this.status,
  });


  LocationState copyWith({
    Point? borishJoyi,
    Point? myPoint,
    YandexMapController? controller,
    PolylineMapObject? route,
    Status? status,
  }) {
    return LocationState(
      nextPoint: borishJoyi ?? this.nextPoint,
      myPoint: myPoint ?? this.myPoint,
      controller: controller ?? this.controller,
      route: route ?? this.route,
      status: status ?? this.status,
    );
  }
 }

 enum Status{ 
  loading, success,
 }
