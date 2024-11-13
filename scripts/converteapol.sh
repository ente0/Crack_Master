#!/bin/bash

ls .
echo -n "Capture file: "
read capture

if [ ! -f "$capture" ]; then
    echo "Error: Capture file '$capture' not found."
    exit 1
fi

hcxpcapngtool -o hash.txt -E essidlist "$capture"

if [ ! -f "essidlist" ]; then
    echo "Error: Failed to generate 'essidlist' file."
    exit 1
fi

ssid=$(cat essidlist)

mkdir -p "$ssid"

mv hash.txt "$ssid/"
mv essidlist "$ssid/"

echo "Conversion completed successfully. Output stored in: $ssid/"
