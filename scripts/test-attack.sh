#!/bin/bash
echo "========================================="
echo "   SOC Platform - Attack Simulation      "
echo "========================================="

TARGET="localhost"

echo "[1] Running port scan (triggers Suricata SCAN rule)..."
nmap -sS -p 1-1000 $TARGET

echo "[2] Simulating SSH brute force..."
for i in {1..6}; do
  ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no testuser@$TARGET 2>/dev/null
done

echo "[3] Sending SQL injection HTTP request..."
curl -s "http://$TARGET/?id=1+UNION+SELECT+1,2,3--" > /dev/null

echo "[4] Simulating ICMP flood (10 pings fast)..."
ping -c 10 -i 0.1 $TARGET > /dev/null

echo "[5] Simulating directory traversal..."
curl -s "http://$TARGET/../../etc/passwd" > /dev/null

echo ""
echo "Attack simulation complete!"
echo "Check Kibana at http://localhost:5601 for alerts."