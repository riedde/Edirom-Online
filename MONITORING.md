# Edirom Docker Setup - Monitoring & Debugging

## Schnellstart

```bash
# System starten
docker-compose up --build -d

# Monitoring-Script ausführbar machen
chmod +x monitor.sh

# Alle Services testen
./monitor.sh all
```

## Monitoring-Befehle

### Container und Endpunkte testen
```bash
./monitor.sh test
```

### Live-Logs verfolgen
```bash
./monitor.sh live
```

### Aktuelle Logs anzeigen
```bash
./monitor.sh logs
```

### Komplette Übersicht
```bash
./monitor.sh all
```

## Manuelle Debugging-Befehle

### Container-Status prüfen
```bash
docker-compose ps
```

### Einzelne Container-Logs
```bash
docker-compose logs nginx
docker-compose logs edirom-online-backend
docker-compose logs edirom-online-frontend
docker-compose logs digilib
```

### Live-Logs eines einzelnen Containers
```bash
docker-compose logs -f edirom-online-backend
```

### In Container hineinschauen
```bash
docker-compose exec edirom-online-backend bash
docker-compose exec nginx sh
```

## Wichtige URLs

- **Hauptseite**: http://localhost/
- **Edirom Frontend**: http://localhost/edirom/
- **eXist-db Dashboard**: http://localhost/dashboard/
- **Digilib**: http://localhost/digilib/
- **Health Check**: http://localhost/health
- **eXist-db Apps**: http://localhost/apps/

## Troubleshooting

### Frontend lädt nicht richtig
1. Browser-Entwicklertools öffnen (F12)
2. Network-Tab beobachten
3. Fehlgeschlagene API-Calls identifizieren
4. Entsprechende Proxy-Regeln in `nginx.conf` hinzufügen

### Backend nicht erreichbar
```bash
# Backend-Container direkt testen
docker-compose exec edirom-online-backend curl http://localhost:8080/exist/

# Nginx-Logs prüfen
docker-compose logs nginx | grep ERROR
```

### Container startet nicht
```bash
# Build-Logs anzeigen
docker-compose build --no-cache

# Container einzeln starten und Logs verfolgen
docker-compose up edirom-online-backend
```

## System neu starten

```bash
# Alles stoppen und neu starten
docker-compose down
docker-compose up --build -d

# Mit Monitoring
./monitor.sh all
```

## Netzwerk-Debugging

```bash
# Container-Netzwerk inspizieren
docker network inspect claude_app-network

# Container-IP-Adressen anzeigen
docker-compose exec nginx nslookup edirom-online-backend
docker-compose exec edirom-online-frontend nslookup edirom-online-backend
```
