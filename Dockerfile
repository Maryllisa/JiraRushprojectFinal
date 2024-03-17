FROM openjdk:17
EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=postgresql
WORKDIR app
ARG JAR=target/*.jar
COPY ${JAR} /app/jira-1.0.jar
COPY resources ./resources
ENTRYPOINT ["java", "-jar", "/app/jira-1.0.jar"]