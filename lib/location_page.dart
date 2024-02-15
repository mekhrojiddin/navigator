import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:uy_ishi_map/bloc/location_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Location location = Location();
  @override
  void initState() {
    location.onLocationChanged.listen((event) {
      context.read<LocationBloc>().add(StartedLocationBloc());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          if (state.status == Status.loading) {
            context.read<LocationBloc>().add(StartedLocationBloc());
            return const CupertinoActivityIndicator();
          } else if (state.status == Status.success) {
            return Scaffold(
              body: YandexMap(
                mapObjects: [
                  CircleMapObject(
                    fillColor: Colors.red,
                    mapId: const MapObjectId("source"),
                    circle: Circle(
                      center: state.myPoint,
                      radius: 10,
                    ),
                  ),
                  PlacemarkMapObject(
                    mapId: const MapObjectId("destination"),
                    point: state.nextPoint,
                  ),
                  state.route,
                ],
                onMapCreated: (controller) async {
                  state.controller = controller;
                  await controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 20,
                        target: state.myPoint,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("Hato yuzbedi"),
              ),
            );
          }
        });
      },
    );
  }
}
