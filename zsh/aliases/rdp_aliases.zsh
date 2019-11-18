#!/bin/zsh -ex

_rdp() {
  project=$1
  zone=$2
  vm=$3
  port=$4
  try_sleep=3
  remaining_try=10
  last_exit_code="1"

  runningstuff="gcloud beta compute start-iap-tunnel $vm 3389 --local-host-port=localhost:$port --project=$project --zone=$zone &"

  echo "Creating tunnel using ${runningstuff}"
  eval ${runningstuff} 

  # Wait some time before first try
  sleep $try_sleep
  while [ ! "$last_exit_code" = "0" -a ! "$remaining_try" = "0" ]
  do
    echo "Remaining tries : $remaining_try"
    let remaining_try--

    nc -vz 127.0.0.1 $port
    last_exit_code="$?"
    echo "Last exit code $last_exit_code"
    
    # Wait some time before next try
    sleep $try_sleep
  done

  apple_script=$(cat <<==apple_script
# First let's go to the desktop 1 using keyboard shortcut ^1 :
tell application "System Events"
    key code 18 using (control down)
end tell

# Now that we are here, happily on this desktop, maybe empty, maybe not
# We can activate the proper window of Microsoft Remote Desktop Beta
# This assume you are using like the non full window version of "Microsoft Remote Desktop Beta"
tell application "Microsoft Remote Desktop Beta"
  activate

  tell application "System Events"
    set frontmost of process "Microsoft Remote Desktop Beta" to true

    # Here is the thing, now that we have this awesome window activated
    # Let's just search using COMMAND+DOWN
    # And search for the VM name
    # Wait a bit because... search is not instant
    # Select and go into the VM
    # \o/\o/\o/\o/\o/\o/\o/\o/\o/\o/\o/

    tell process "Microsoft Remote Desktop Beta"
      keystroke "f" using {command down}
      keystroke "$vm" --search query
      delay 0.5
      keystroke tab
      key code 125 -- down
      key code 36 -- enter
    end tell
  end tell
end tell
==apple_script
)

  echo -e "$apple_script" | osascript 
}

