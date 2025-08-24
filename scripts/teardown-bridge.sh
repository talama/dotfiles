#!/bin/bash

# Disconnect the bridge connections in NetworkManager
nmcli con down bridge-slave-enp34s0
nmcli con down bridge-br0

# Remove the bridge connecctions in NetworkManager
nmcli con delete bridge-slave-enp34s0
nmcli con delete bridge-br0

# Remove enp34s0 from the brigde
ip link set enp34s0 nomaster

# Bring down the network interface
ip link set br0 down

# Delete the bridge
ip link delete br0

# Reconnect enp34s0 in NetworkManager
nmcli dev connect enp34s0
