#!/bin/sh

echo "=== Informasi Jaringan di FreeBSD ==="

# IP Lokal
echo -e "\n-- IP Lokal (per antarmuka) --"
ifconfig -u | grep -E '^[a-z0-9]+' | cut -d: -f1 | while read iface; do
  ip=$(ifconfig $iface | grep -w 'inet ' | awk '{print $2}')
  [ -n "$ip" ] && echo "$iface: $ip"
done

# Nameserver
echo -e "\n-- Nameserver dari /etc/resolv.conf --"
grep -i ^nameserver /etc/resolv.conf | awk '{print $2}'

# DNS Resolver Lokal (opsional)
echo -e "\n-- Layanan DNS Lokal Aktif (jika ada) --"
sockstat -4 -l | grep ':53' || echo "Tidak ada layanan DNS lokal yang berjalan di port 53"

echo -e "\nSelesai."
