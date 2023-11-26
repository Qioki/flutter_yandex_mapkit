import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late YandexMapController controller;
  static const Point _point = Point(latitude: 59.945933, longitude: 30.320045);
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 0.3);
  double zoomValue = 1.0;
  @override
  Widget build(BuildContext context) {
    double minZoom = 1.0;
    double maxZoom = 21.0;
    return Stack(
      children: [
        YandexMap(
          onMapCreated: (YandexMapController yandexMapController) async {
            controller = yandexMapController;

            minZoom = await controller.getMinZoom();
            maxZoom = await controller.getMaxZoom();

            controller.moveCamera(
                CameraUpdate.newCameraPosition(
                    const CameraPosition(target: _point)),
                animation: animation);
          },
          onCameraPositionChanged: (CameraPosition cameraPosition,
              CameraUpdateReason reason, bool finished) {
            if (finished) {
              setState(() {
                zoomValue = cameraPosition.zoom;
              });
            }
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await controller.moveCamera(
                      CameraUpdate.newCameraPosition(
                          const CameraPosition(target: _point)),
                      animation: animation);
                },
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                child: const Icon(Icons.home),
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  await controller.moveCamera(CameraUpdate.zoomIn(),
                      animation: animation);
                },
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.moveCamera(CameraUpdate.zoomOut(),
                      animation: animation);
                },
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                child: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 60,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: zoomValue,
                    min: minZoom,
                    max: maxZoom,
                    divisions: maxZoom.toInt() - minZoom.toInt(),
                    onChanged: (newValue) {
                      setState(() {
                        zoomValue = newValue;
                        controller.moveCamera(CameraUpdate.zoomTo(zoomValue),
                            animation: animation);
                        controller.getMaxZoom();
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
