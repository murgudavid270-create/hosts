#!/bin/bash
cat /etc/hosts | while read ip nume restul
do

    if [ -z "$ip" ]; then
        continue
    fi

    case "$ip" in
        \#*) continue ;;
    esac

    case "$ip" in
        *:*) continue ;;
    esac

    ips=$(nslookup "$nume" 8.8.8.8 | awk '/^Name:/ {n=1} n && /^Address:/ {print $2}')

    if ! echo "$ips" | grep -qx "$ip"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
