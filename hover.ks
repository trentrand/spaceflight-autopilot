clearscreen.

set targetAltitude to 1000.
print "Hovering at target altitude " + targetAltitude.

set compass to 0.
sas on.
rcs on.
stage.

// Tune PID control system
set kP to 0.5.
set kI to 0.0005.
set kD to 0.5.

set pid to pidloop(kP, kI, kD, -1, 1).

set pid:setpoint to targetAltitude.

set thrott to 1.
lock throttle to thrott.

gear off.

until maxthrust = 0 {
  clearscreen.

  set altitude to ship:apoapsis.

  set out to pid:update(time:seconds, altitude).

  set thrott to max(out, 0).

  print "Altitude  : " + round(altitude).
  print "PID Out: " + out.

  wait 0.001.
}

gear on.
