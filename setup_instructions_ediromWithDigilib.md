# Edirom Services - Einfache Ein-Port Lösung

## Dateistruktur
```
ihr-projekt/
├── docker-compose.yml    (die neue kombinierte Version)
├── nginx.conf           (Reverse Proxy Konfiguration)
├── backend/             (Ihr bestehender Backend Ordner)
│   └── Dockerfile
├── frontend/            (Ihr bestehender Frontend Ordner)
│   └── Dockerfile
└── .env                 (Ihre bestehenden Umgebungsvariablen)
```

## Setup

1. **Ersetzen Sie Ihre bestehende `docker-compose.yml`** mit der neuen Version
2. **Erstellen Sie die `nginx.conf`** im Hauptverzeichnis  
3. **Ihre bestehenden Ordner und .env bleiben unverändert**

## Verwendung

### Starten (wie gewohnt)
```bash
docker-compose up -d
```

### Services erreichen - JETZT GANZ EINFACH:
- **Übersicht**: `http://localhost/` 
- **Dashboard (eXist-db)**: `http://localhost/dashboard/`
- **Edirom Frontend**: `http://localhost/edirom/`  
- **Digilib**: `http://localhost/digilib/`

### Stoppen
```bash
docker-compose down
```

## Was sich geändert hat

✅ **Nur noch Port 80 nach außen** - keine Portverwirrung mehr  
✅ **Ihre bestehenden Services bleiben unverändert**  
✅ **Automatischer Download** des Digilib Images  
✅ **Schöne Übersichtsseite** für Ihre Freundin  
✅ **Alle Services intern vernetzt**  

## Vorteile für Ihre Freundin

- Nur eine Adresse merken: `localhost`
- Klare Navigation über die Übersichtsseite
- Keine Ports mehr im Browser eingeben
- Professionelles Aussehen

## Migration von Ihrem bestehenden Setup

1. **Sichern Sie Ihre alte docker-compose.yml** (falls Sie sie behalten möchten)
2. **Ersetzen Sie sie durch die neue Version**
3. **Erstellen Sie nginx.conf**
4. **Starten Sie neu mit `docker-compose up -d`**

Das war's! Alle Ihre Services laufen weiter wie vorher, sind aber jetzt unter einer einheitlichen Adresse erreichbar.

## Technische Details

- **eXist-db Backend**: Läuft intern auf Port 8080, erreichbar via `/dashboard/`
- **Edirom Frontend**: Läuft intern auf Port 80, erreichbar via `/edirom/`  
- **Digilib**: Läuft intern auf Port 8080, erreichbar via `/digilib/`
- **Reverse Proxy**: NGINX als einziger Außenzugang auf Port 80