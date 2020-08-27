clearScreen.
print "Returning to Kerbin.".
print "Waiting for launch window in T-".

until eta:apoapsis <= 30 {
  print round(eta:apoapsis, 0) + " seconds   " at (32, 1).
}

print "Approaching apoapsis. Starting de-orbital burn...".

// TODO: this will accidentally jettison the payload and fairings, and stage recovery
when maxthrust = 0 then {
  print "Shedding empty stage.".
  stage.
  return true.
}

sas on.
set sasmode to "RETROGRADE".
lock throttle to 1.0.
set ship:control:pilotmainthrottle to 1.0.

wait until ship:periapsis <= 30000.

print "En route to re-enter atmosphere. Standing by...".

lock throttle to 0.
set ship:control:pilotmainthrottle to 0.

wait until ship:altitude <= 70000.

print "Re-entering atmosphere.".
print "Fasten your seat belts and prepare for landing.".
