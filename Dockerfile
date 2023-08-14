# Use the official Gradle image as the build image
FROM gradle:jdk11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container
COPY Fhir-Helpers-Extension/Fhir_Kotlin /app

RUN ls

# Build the fat JAR using the Shadow plugin
RUN gradle -p /app :cli:shadowJar

RUN mv /app/cli/build/libs/cli-*-all.jar /app/cli.jar

# Create a new container for the runtime image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built fat JAR from the build container to the runtime container
COPY --from=build /app/cli.jar /app/cli.jar

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "cli.jar"]
