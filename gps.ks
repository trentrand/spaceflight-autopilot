set gpsOutPath to "gps.out.txt".

print "Recording flight path".

set recordedGeoposition to list().

// First entry is the body radius
set kerbin to body("Kerbin").
recordedGeoposition:add(kerbin:radius).

// Subsequent entries track soi-raw coordinates of ship at 1000ms resolution
until ship:altitude > 5000 {
  set soiRawGeoposition to ship:geoposition:position - ship:body:position.
  recordedGeoposition:add(soiRawGeoposition).
  wait 1.
}

switch to archive.

if exists(gpsOutPath) {
    deletePath(gpsOutPath).
}

set logfile to create(gpsOutPath).
for record in recordedGeoposition {
    logfile:writeln(record:tostring).
}
