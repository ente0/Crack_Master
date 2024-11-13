#!/bin/bash 
echo -n "Interface: ";read interface;
sudo airmon-ng check kill;sudo airodump-ng $interface
