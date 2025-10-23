# Step 1: Use a Maven image to build the app
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy everything
COPY . .

# Build the Spring Boot application without tests
RUN ./mvnw clean package -DskipTests

# Step 2: Use a smaller Java image to run the app
FROM eclipse-temurin:17
WORKDIR /app

# Copy the JAR file from previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
