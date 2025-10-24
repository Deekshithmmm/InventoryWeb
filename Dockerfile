# ==============================
# ✅ Stage 1: Build the project
# ==============================
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven wrapper files first (for dependency caching)
COPY mvnw .
COPY .mvn .mvn

# ✅ Fix 'Permission Denied' for mvnw
RUN chmod +x mvnw

# Copy the rest of the source code
COPY . .

# Build the Spring Boot project WITHOUT tests (faster build)
RUN ./mvnw clean package -DskipTests


# ==============================
# ✅ Stage 2: Run the application
# ==============================
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy built JAR from Stage 1
COPY --from=build /app/target/*.jar app.jar

# Expose Spring Boot default port
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "/app/app.jar"]
