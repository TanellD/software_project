import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:software_project/requestVerfication.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MapScreen extends StatefulWidget {
  GeoPoint place;
  MapScreen({required this.place});
  @override
  State<StatefulWidget> createState() {
    return MapScreenState_();
  }
}

class MapScreenState_ extends State<MapScreen> {
  final GlobalKey<DialogWindowState> _key = GlobalKey();
  RoadInfo? roadInfo;
  late Icon dial_icon = Icon(Icons.pedal_bike);
  bool show_banner = false;
  void clearRoads(){
    _mapController.clearAllRoads();
  }
  
  late MapController _mapController;
  initState(){
    _mapController = MapController.withPosition(initPosition: widget.place);
    super.initState();
  }
  @override
  build(context) {
    return SafeArea(
        child: Scaffold(
            appBar: getAppBar(text: 'Map', context: context),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
              Builder(
                builder: (context) {
                  return OSMFlutter(
                    mapIsLoading: Center(child: CircularProgressIndicator()),
                    isPicker: false,
                    showZoomController: true,
                    showDefaultInfoWindow: true,
                    maxZoomLevel: 19,
                    androidHotReloadSupport: true,
                    initZoom: 10,
                    controller: _mapController,
                    userTrackingOption: UserTrackingOption(
                        enableTracking: true, unFollowUser: true),
                    // userLocationMarker: UserLocationMaker(
                    //     directionArrowMarker: MarkerIcon(
                    //         icon: Icon(Icons.arrow_drop_up_outlined, size: 48)),
                    //     personMarker: MarkerIcon(
                    //         iconWidget: Center(child: Icon(
                    //       Icons.person,
                    //       color: Colors.yellow,
                    //       size: 48,
                    //     )))),
                    markerOption: MarkerOption(
                        defaultMarker: const MarkerIcon(
                            icon: Icon(
                      Icons.person,
                      color: Colors.red,
                    ))),
                    onMapIsReady: (isReady) async => {
                      if (isReady)
                        {
                          _mapController.addMarker(widget.place,
                              markerIcon: MarkerIcon(
                                  icon: Icon(
                                Icons.location_on_sharp,
                                color: Colors.red,
                                size: 48,
                              ))),
                          _mapController.enableTracking(
                              enableStopFollow: true,
                              disableUserMarkerRotation: true)
                          //  _mapController.addMarker(await _mapController.myLocation(), markerIcon: MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow,)))
                          //await _mapController.drawRoad(GeoPoint(latitude: User.position.latitude, longitude: User.position.longitude), place, roadOption: RoadOption(roadColor: Colors.purple, roadWidth: 50))
                          //_mapController.disabledTracking()
                        }
                    },
                  );
                }
              ),
              
              DialogWindow(key: _key, clearRoads: clearRoads,)
            ]),
            floatingActionButton: SpeedDial(
              icon: Icons.route_rounded,
              closeManually: true,
              renderOverlay: false,
              children: [
                SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.car_repair),
                  onTap: () async {
                    // _mapController.setMarkerIcon(await _mapController.myLocation(), MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow, size: 48,)));
                    
                      
                      await _mapController.removeLastRoad();
                      
                    roadInfo = await _mapController.drawRoad(
                        await _mapController.myLocation(), widget.place,
                        roadType: RoadType.car,
                        roadOption:
                            RoadOption(roadColor: Colors.purple, roadWidth: 7));
                            _mapController.enableTracking(enableStopFollow: true, disableUserMarkerRotation: true);
                      dial_icon = Icon(Icons.car_repair);
                            _key.currentState!.refresh(roadInfo, dial_icon);
                    
                    
                    //await _mapController.setMarkerIcon(await _mapController.myLocation(), MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow, size: 48,)));
                  },
                ),
                SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.pedal_bike),
                  onTap: () async {
                    
                      
                      await _mapController.removeLastRoad();
                    roadInfo = await _mapController.drawRoad(
                        await _mapController.myLocation(), widget.place,
                        roadType: RoadType.bike,
                        roadOption:
                            RoadOption(roadColor: Colors.purple, roadWidth: 7));
                            
                            _mapController.enableTracking(enableStopFollow: true, disableUserMarkerRotation: true);
                            dial_icon = Icon(Icons.pedal_bike);
                            _key.currentState!.refresh(roadInfo, dial_icon);
                      
                    
                    //await _mapController.setMarkerIcon(await _mapController.myLocation(), MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow, size: 48,)));
                  },
                ),
                SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.directions_walk),
                  onTap: () async {
                    
                      
                      await _mapController.removeLastRoad();
                    roadInfo = await _mapController.drawRoad(
                      
                        await _mapController.myLocation(), widget.place,
                        roadType: RoadType.foot,
                        roadOption:
                            RoadOption(roadColor: Colors.purple, roadWidth: 7));
                            _mapController.enableTracking(enableStopFollow: true, disableUserMarkerRotation: true);
                      dial_icon = Icon(Icons.directions_walk);
                            _key.currentState!.refresh(roadInfo, dial_icon);
                    
                    //await _mapController.setMarkerIcon(await _mapController.myLocation(), MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow, size: 48,)));
                  },
                ),
              ],
            )));
  }
}


class DialogWindow extends StatefulWidget{
  RoadInfo? roadInfo;
  Icon? dial_icon;
  bool visible = false;
  final VoidCallback clearRoads;
  DialogWindow({Key? key, this.roadInfo, this.dial_icon, required this.clearRoads}): super(key: key);
  
  createState()=>DialogWindowState();
}

class DialogWindowState extends State<DialogWindow>{
  @override
  build(context){
    return Visibility(visible: widget.visible,
      child: Container(height: 40, width: MediaQuery.of(context).size.width-100, color: Color(0xFFF6F6F6),
                  child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    widget.dial_icon!=null?widget.dial_icon!:Icon(Icons.pedal_bike), Text('${widget.roadInfo!=null?distance(widget.roadInfo!.distance!): 0}'), SizedBox(width: 50,), Text('${widget.roadInfo!=null?duration(widget.roadInfo!.duration!):0}'),
                    IconButton(onPressed: (){
                      
                      setState(() {
                        widget.visible = false;
                      });
                      widget.clearRoads();
                    }
                      , icon: Icon(Icons.close))
                  ],)
                ),
    );
  }

  refresh(RoadInfo? roadInfo, Icon? icon){
    setState(() {
      widget.visible = true;
      widget.dial_icon = icon;
      widget.roadInfo = roadInfo;
    });
  }
}

String distance(double kms){
  double dist;
  if(kms >= 1){
    return kms.toStringAsFixed(1) + 'km';
  } else {
    return (kms*1000).toStringAsFixed(0) + 'm';
  }

}

String duration(double sec){
  int dur = sec.round();
  int days = (dur~/(24*3600));
  int hours = (dur%(24*3600))~/3600;
  int minutes = ((dur%(24*3600))%3600)~/60;
  String result = (days>0?days.toString()+'d ':'') + (hours>0? hours.toString()+'h ':'') + (minutes>0?minutes.toString()+'min':'near you');
  return result;

}



