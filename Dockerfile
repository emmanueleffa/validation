# Dockerfile

# Base image
FROM python:3.11-slim

# Variables d'environnement pour éviter les questions pendant pip install
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Créer le répertoire de l'app
WORKDIR /app

# Copier les fichiers requirements.txt si tu en as
COPY requirements.txt /app/requirements.txt

# Installer les dépendances système nécessaires
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Installer pip, pytest et semgrep
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    pip install pytest semgrep && \
    if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

# Copier le code source dans l'image
COPY . /app

# Exposer le port de l'application
EXPOSE 5000

# Commande par défaut pour lancer l'application
CMD ["python3", "app.py"]


