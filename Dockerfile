# Utilisation d'une image JDK 17 officielle d'AdoptOpenJDK
FROM adoptopenjdk/openjdk17:alpine-jre

# Répertoire de travail
WORKDIR /app

# Copier le jar construit dans l'image Docker
COPY target/eventsProject-1.0.0-SNAPSHOT.jar /app/app.jar

# Commande par défaut pour lancer l'application au démarrage du conteneur
CMD ["java", "-jar", "app.jar"]
