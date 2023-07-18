


import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:software_project/requestVerfication.dart';

class PickerScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PickerScreenState();
  }
}

class _PickerScreenState extends State<PickerScreen>{
  late MapController _mapController;
  _PickerScreenState(){
    _mapController = MapController(initMapWithUserPosition: UserTrackingOption(enableTracking: true, unFollowUser: true));
  }
  @override
  dispose(){
    _mapController.dispose();
    super.dispose();

  }
  build(context){
    return SafeArea(child: Scaffold(
      appBar: getAppBar(text:'Map', context: context, result: ''),

      body: Stack(children: [
        OSMFlutter( isPicker: true, showZoomController: true, showDefaultInfoWindow: false, maxZoomLevel: 19, androidHotReloadSupport: false, initZoom: 10, controller: _mapController,
  userLocationMarker: UserLocationMaker(directionArrowMarker: const MarkerIcon(icon:Icon(Icons.location_on_sharp, color: Colors.red, size: 48,)), personMarker: MarkerIcon(icon:Icon(Icons.person, color: Colors.yellow,))),
  markerOption: MarkerOption(defaultMarker: const MarkerIcon(icon:Icon(Icons.location_on_sharp, color: Colors.red,))),
  onMapIsReady: (isReady)async=>{
    if(isReady){
      
      //await _mapController.drawRoad(GeoPoint(latitude: User.position.latitude, longitude: User.position.longitude), place, roadOption: RoadOption(roadColor: Colors.purple, roadWidth: 50))
      
    }
  },
  
  ),
        
        ]
    
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: Container(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      FloatingActionButton(onPressed: () async{
      await _mapController.goToLocation(await _mapController.myLocation());
    },
    backgroundColor: Colors.blue,
    child: Icon(Icons.my_location)
    ),
    SizedBox(height: 10,),
    FloatingActionButton(onPressed: ()async {
      GeoPoint location = await _mapController.getCurrentPositionAdvancedPositionPicker();
      var result = '${location.latitude} ${location.longitude}';
      Navigator.pop(context, result);
    },
    backgroundColor: Colors.blue,
    child: Icon(Icons.check)
    ) ,
    ],)) 
    ), 
    
    );
  }
}