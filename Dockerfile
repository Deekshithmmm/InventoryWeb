# Step 1: Use Maven with Java 17 to build the app
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy all files to the container
COPY . .

# ✅ Give execute permission to mvnw (IMPORTANT)
RUN chmod +x mvnw

# ✅ Build the Spring Boot application (skip tests for faster build)
RUN ./mvnw clean package -DskipTests

# Step 2: Use a lightweight Java image to run the app
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy only the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
