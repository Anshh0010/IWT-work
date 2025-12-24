FROM maven:3.8-openjdk-17 AS build

WORKDIR /app

# Copy source files
COPY src ./src
COPY pom.xml .

# Build the application
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

CMD ["catalina.sh", "run"]
