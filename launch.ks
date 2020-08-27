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

clearscreen.
print "Vehicle is approaching space. Standing by...".

unlock steering.
sas on.
set sasmode to "PROGRADE".

until ship:altitude > 70000 {
  if ship:apoapsis < 70000 {
    lock throttle to 1.0.
    set ship:control:pilotmainthrottle to 1.0.
  } else {
    lock throttle to 0.
    set ship:control:pilotmainthrottle to 0.
  }
}

sas off.

local keypress is "".

until keypress = "q" {
  clearscreen.
  print "Welcome to space!".

  print "Arriving to apoapsis in T-" + round(eta:apoapsis, 0) + " seconds.".

  print "Would you like to enter orbit? Type Y/n:  ".
  set keypress to terminal:input:getchar().

  if keypress = terminal:input:enter or keypress = "Y" {
    print "Proceeding to orbit!".
    runPath("0:automated-rocket-control/orbit.ks", compass).
    break.
  }

  if keypress = "N" {
    print "Returning to Kerbin...".
    runPath("0:automated-rocket-control/deorbit.ks").
    break.
  }

  print "Invalid".
  wait 0.5.
}
