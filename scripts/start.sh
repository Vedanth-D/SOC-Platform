#!/bin/bash
echo "========================================="
echo "     SOC Platform - Starting Up          "
echo "========================================="

if ! docker info > /dev/null 2>&1; then
  echo "ERROR: Docker is not running!"
  exit 1
fi

echo "Setting system parameters for Elasticsearch..."
sudo sysctl -w vm.max_map_count=262144

echo "Pulling latest images..."
docker compose pull

echo "Starting Elasticsearch..."
docker compose up -d elasticsearch

echo "Waiting for Elasticsearch to be ready..."
until curl -s http://localhost:9200 > /dev/null 2>&1; do
  echo "  ... still waiting"
  sleep 5
done
echo "Elasticsearch is ready!"

echo "Starting all services..."
docker compose up -d

echo ""
echo "========================================="
echo "  Services are running!"
echo ""
echo "  Kibana Dashboard : http://localhost:5601"
echo "  Elasticsearch    : http://localhost:9200"
echo "  Wazuh API        : http://localhost:55000"
echo "========================================="