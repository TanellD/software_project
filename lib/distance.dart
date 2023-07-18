import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:software_project/person_account.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';


double dist(Position start, GeoPoint finish){
  
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((finish.latitude - start.latitude) * p)/2 + 
          c(start.latitude * p) * c(finish.latitude * p) * 
          (1 - c((finish.longitude - start.longitude) * p))/2;
    return 12742 * asin(sqrt(a));
}