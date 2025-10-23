# Step 1: Use Maven to build the project
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

COPY . .

# ✅ Fix permission issue:
RUN chmod +x mvnw

# Build Spring Boot app without tests
RUN ./mvnw clean package -DskipTests

# Step 2: Use smaller Java image to run .jar
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
