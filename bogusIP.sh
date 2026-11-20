#!/bin/bash
echo "Script modificat de Murgu David"
echo "SCRIPTUL"
verifica_ip() {
    local nume="$1"
    local ip="$2"
    local dns="$3"
    local ips

    ips=$(nslookup "$nume" "$dns" | awk '/^Name:/ {n=1} n && /^Address:/ {print $2}')

    if ! echo "$ips" | grep -qx "$ip"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
}

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

    verifica_ip "$nume" "$ip" 8.8.8.8
done
