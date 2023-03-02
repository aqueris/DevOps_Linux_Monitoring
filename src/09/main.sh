
#!/bin/bash

if [ $# != 0 ] ; then
    echo "error"
    exit 1
else
    while true; do
        if [[ -f index.html ]]; then
            rm index.html
        fi
        CPU="$(cat /proc/loadavg | awk '{print $1}')"
        Disk_Space="$(df /| grep / | awk '{print $2}')"
        Disk_Space_Used="$(df /| grep / | awk '{print $3}')"
        Memory="$(free | grep Mem | awk '{print $2}')"
        Memory_Used="$(free | grep Mem | awk '{print $3}')"
        echo "# HELP cpu Take Cpu" >> index.html
        echo "# TYPE cpu gauge" >> index.html
        echo "cpu $CPU" >> index.html
        echo "# HELP disk_space Take Disk_Space" >> index.html
        echo "# TYPE disk_space gauge" >> index.html
        echo "disk_space $Disk_Space" >> index.html
        echo "# HELP disk_space_used Take Disk_Space_Used" >> index.html
        echo "# TYPE disk_space_used gauge" >> index.html
        echo "disk_space_used $Disk_Space_Used" >> index.html
        echo "# HELP memory Take Memory" >> index.html
        echo "# TYPE memory" >> index.html
        echo "memory $Memory" >> index.html
        echo "# HELP memory Take Memory_Used" >> index.html
        echo "# TYPE memory_used" >> index.html
        echo "memory_used $Memory_Used" >> index.html
        sleep 3
    done
fi