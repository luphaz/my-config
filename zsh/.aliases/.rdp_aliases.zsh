#!/bin/zsh -ex

_rdp() {
  project=$1
  zone=$2
  vm=$3
  port=$4
  try_sleep=3
  remaining_try=10
  last_exit_code="1"

  echo "Creating tunnel to project=$project zone=$zone vm=$vm port=$port"

  gcloud beta compute start-iap-tunnel --project $project --zone $zone "$vm" 3389 --local-host-port=localhost:$port

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
tell application "Microsoft Remote Desktop Beta"
  activate
  tell application "System Events"
    set frontmost of process "Microsoft Remote Desktop Beta" to true
    tell process "Microsoft Remote Desktop Beta"
      keystroke "f" using {command down}
      keystroke "$vm" --search query
      delay 0.5
      keystroke tab
      key code 125 -- down
      key code 36 --enter		
    end tell
  end tell
end tell
==apple_script
)

  echo -e "$apple_script" | osascript 
}

