# Image de base Python
FROM python:3.11-slim

# Créer un dossier pour l'application
WORKDIR /app

# Copier tous les fichiers locaux dans le conteneur
COPY . /app

# Commande pour lancer l'application
CMD ["python3", "app.py"]

