#!/bin/bash 
echo -n "Interface: ";read interface; 
echo -n "MAC: ";read mac; 
echo -n "Channel: ";read channel; 
sudo airodump-ng -w eapol --output-format pcap -c $channel --bssid $mac $interface
