#!/usr/bin/env bash

acpi_info=$(acpi -b | grep -v 'Unknown' | grep -v 'unavailable' | head -n 1 | cut -d ":" -f 2- | sed "s/,//g")
percentage=$(echo $acpi_info | cut -d " " -f 2)
case $(echo $acpi_info | cut -d " " -f 1) in
    D*) case $percentage in
            [0-9]%|1[0-5]%)      battery_status=" ";;
            1[6-9]%|2[0-5]%)     battery_status=" ";;
            2[6-9]%|[3-4][0-9]%) battery_status=" ";;
            [5-9][0-9]%)         battery_status=" ";;
            100%)                battery_status=" ";;
            *)                   battery_status="Error";;
        esac;;
    F*) battery_status=" ";;
    C*) battery_status="";;
    *)  battery_status="Error";;
esac
remained_time=$(echo $acpi_info | cut -d " " -f 3)
echo "<span color='#7FFFD4'>$battery_status $percentage $remained_time</span>" 
