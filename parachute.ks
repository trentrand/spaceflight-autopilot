wait until ship:altitude < 70000.

// TODO: Should probably name a designated "landingDecoupler"
// and jettison junk as a single part.
when maxthrust > 0 then {
  print "Shedding unnecessary weight".
  stage.
  return true.
}

unlock steering.
sas on.
set sasmode to "RETROGRADE".

wait until ship:altitude < 2500.
print "Deploying drogue parachtues.".
chutessafe on.

wait until ship:altitude < 1000.
print "Deploying radial parachutes.".
chutessafe on.

wait until ship:altitude < 100.
set sasmode to "STABILITYASSIST".
