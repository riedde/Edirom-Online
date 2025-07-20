#!/bin/bash

# Edirom Services Monitor Script
# Überwacht Container-Logs und testet Endpunkte

echo "=== Edirom Services Monitor ==="
echo "Gestartet am: $(date)"
echo

# Farben für Output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funktion zum Testen von Endpunkten
test_endpoint() {
    local url=$1
    local name=$2
    local expected_code=${3:-200}
    
    echo -n "Testing $name ($url)... "
    
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url" --max-time 10)
    
    if [ "$response" -eq "$expected_code" ]; then
        echo -e "${GREEN}OK${NC} ($response)"
        return 0
    else
        echo -e "${RED}FAIL${NC} ($response)"
        return 1
    fi
}

# Funktion zum Überprüfen ob Container laufen
check_containers() {
    echo -e "${BLUE}=== Container Status ===${NC}"
    docker-compose ps
    echo
}

# Funktion zum Testen aller Endpunkte
test_all_endpoints() {
    echo -e "${BLUE}=== Endpoint Tests ===${NC}"
    
    # Basis-URLs testen
    test_endpoint "http://localhost/" "Main Page"
    test_endpoint "http://localhost/health" "Health Check"
    
    # eXist-db Endpunkte
    test_endpoint "http://localhost/exist/" "eXist-db Base"
    test_endpoint "http://localhost/dashboard/" "eXist-db Dashboard"
    test_endpoint "http://localhost/apps/" "eXist-db Apps"
    
    # Edirom und Digilib
    test_endpoint "http://localhost/edirom/" "Edirom Frontend"
    test_endpoint "http://localhost/digilib/" "Digilib Service"
    
    echo
}

# Funktion zum Anzeigen der Live-Logs
show_live_logs() {
    echo -e "${BLUE}=== Live Container Logs ===${NC}"
    echo "Drücke Ctrl+C zum Beenden der Log-Anzeige"
    echo
    
    # Logs von allen Services parallel anzeigen
    docker-compose logs --follow --tail=50 \
        nginx \
        edirom-online-backend \
        edirom-online-frontend \
        digilib
}

# Funktion zum Anzeigen der letzten Logs
show_recent_logs() {
    echo -e "${BLUE}=== Recent Container Logs (letzte 20 Zeilen) ===${NC}"
    
    echo -e "${YELLOW}--- Nginx Proxy ---${NC}"
    docker-compose logs --tail=20 nginx
    echo
    
    echo -e "${YELLOW}--- eXist-db Backend ---${NC}"
    docker-compose logs --tail=20 edirom-online-backend
    echo
    
    echo -e "${YELLOW}--- Edirom Frontend ---${NC}"
    docker-compose logs --tail=20 edirom-online-frontend
    echo
    
    echo -e "${YELLOW}--- Digilib ---${NC}"
    docker-compose logs --tail=20 digilib
    echo
}

# Main Menu
case "${1:-menu}" in
    "test")
        check_containers
        test_all_endpoints
        ;;
    "logs")
        show_recent_logs
        ;;
    "live")
        show_live_logs
        ;;
    "all")
        check_containers
        test_all_endpoints
        show_recent_logs
        ;;
    *)
        echo "Verwendung: $0 [test|logs|live|all]"
        echo
        echo "Optionen:"
        echo "  test  - Testet alle Endpunkte"
        echo "  logs  - Zeigt die letzten Container-Logs"
        echo "  live  - Zeigt Live-Logs (Ctrl+C zum Beenden)"
        echo "  all   - Container-Status + Endpoint-Tests + Recent Logs"
        echo
        echo "Beispiele:"
        echo "  ./monitor.sh test    # Nur Endpoint-Tests"
        echo "  ./monitor.sh live    # Live-Log-Streaming"
        echo "  ./monitor.sh all     # Komplette Übersicht"
        ;;
esac
