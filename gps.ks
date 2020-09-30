declare parameter outputFilename is "gps.out".

print "Recording flight path".

// Track soi-raw coordinates of ship at 1000ms resolution
set recordedGeopositions to list().
until ship:altitude > 70000 {
  set soiRawGeoposition to ship:position - body:position.
  recordedGeopositions:add(soiRawGeoposition).
  wait 1.
}

switch to archive.

if exists(outputFilename) {
  deletePath(outputFilename).
}

set logfile to create(outputFilename).

logfile:writeln(recordedGeopositions:length:tostring).
for record in recordedGeopositions {
  logfile:writeln(record:tostring).
}
