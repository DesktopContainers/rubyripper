# Rubyripper
_Rubyripper_

This is a container for the audiophile ripping application.

It needs access to /dev/sr0 device and run as privileged container at the moment.

It's based on __DesktopContainers/base-mate__

## Usage: Run the Client

### Simple SSH X11 Forwarding

Since it is an X11 GUI software, usage is in two steps:
  1. Run a background container as server or start existing one.

        docker start rubyripper || docker run -d --name rubyripper --privileged -v /dev/sr0:/dev/sr0 -v /tmp/:/rips desktopcontainers/rubyripper
        
  2. Connect to the server using `ssh -X`. 
     _Logging in with `ssh` automatically opens rubyripper_

        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
        -X app@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' rubyripper)
        
  3. Rip your CDs and enjoy.
