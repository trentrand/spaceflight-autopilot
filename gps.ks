set gpsOutPath to "gps.out.txt".

print "Recording flight path".

// Track soi-raw coordinates of ship at 1000ms resolution
set recordedGeopositions to list().
until ship:altitude > 70000 {
  set soiRawGeoposition to ship:geoposition:position - ship:body:position.
  recordedGeopositions:add(soiRawGeoposition).
  wait 1.
}

switch to archive.

if exists(gpsOutPath) {
  deletePath(gpsOutPath).
}

set logfile to create(gpsOutPath).

logfile:writeln(recordedGeopositions:length:tostring).
for record in recordedGeopositions {
  logfile:writeln(record:tostring).
}
