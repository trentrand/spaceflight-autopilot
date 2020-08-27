declare parameter compass.

sas off.
set direction to heading(compass, 0).
lock steering to direction.

clearScreen.
HUDTEXT("Welcome to space!", 8, 10, 24, rgb(1,1,0.5), true).
print "Reaching apoapsis in T-" + round(eta:apoapsis, 0) + " seconds.".

until eta:apoapsis <= 30 {
  print round(eta:apoapsis, 0) + " seconds" at (23, 1).
}

print "Approaching apoapsis. Starting orbital burn...".
set direction to heading(compass, 0).
lock throttle to 1.0.
set ship:control:pilotmainthrottle to 1.0.

wait until ship:periapsis > 70000.

lock throttle to 0.
set ship:control:pilotmainthrottle to 0.

local keypress is "".

HUDTEXT("Welcome to orbit!", 8, 10, 24, rgb(1,1,0.5), true).

until keypress = "q" {
  clearscreen.
  print "Welcome to orbit!".
  print "Ready to return to Kerbin? Type Y/n:  ".
  set keypress to terminal:input:getchar().

  if keypress = terminal:input:enter or keypress = "Y" {
    print "Proceeding to orbit!".
    runPath("0:automated-rocket-control/deorbit.ks").
    break.
  } else if keypress = "N" {
    print "When you're ready to return, type Y".
    wait 3.
  } else {
    print "Invalid".
    wait 0.5.
  }
}
