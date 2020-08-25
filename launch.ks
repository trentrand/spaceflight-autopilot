clearscreen.

print "Preparing for launch".

set compass to 0.
set direction to up.
lock steering to direction.

lock throttle to 1.0.

from { local countdown is 5. } until countdown = 0 step { set countdown to countdown - 1. } do {
  print "..." + countdown.
  wait 1.
}

print "Activating boosters".
stage.

wait until verticalspeed > 1.
print "Lift off!".
print " - - - - - - - - - -".


declare function gravityTurn {
  if ship:velocity:surface:mag < 100 {
    set direction to heading(compass, 90).
  }

  set pitch to (90 - ((ship:velocity:surface:mag - 100) / 10)).

  if pitch < 15 {
    set direction to heading(compass, 15).
    return.
  }

  print "Pitch: " + pitch at (0,10).
  set direction to heading(compass, pitch).
}

when maxthrust = 0 then {
  print "Shedding empty boosters".
  stage.
}

until ship:apoapsis > 70000 {
  print "Apoapsis: " + round(ship:apoapsis,0) at (0,9).

  gravityTurn().
}

print "En route to sub-orbital flight, taking a break...".
set direction to heading(compass, 0). // In case there boosters are still burning
lock throttle to 0.
set ship:control:pilotmainthrottle to 0.

when ship:altitude > 70000 then {
  HUDTEXT("Welcome to space!", 8, 10, 24, rgb(1,1,0.5), true).
}
