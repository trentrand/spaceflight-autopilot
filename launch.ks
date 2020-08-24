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

when maxthrust = 0 then {
  print "Shedding empty boosters".
  stage.
}

when ship:apoapsis > 70000 {
  HUDTEXT("Welcome to space!", 8, 10, 24, rgb(1,1,0.5), true).
  lock throttle to 0.
  set ship:control:pilotmainthrottle to 0.
}
