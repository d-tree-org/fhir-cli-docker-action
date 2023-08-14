# Use the official Gradle image as the build image
FROM gradle:jdk11 AS build

# Set the working directory in the container
WORKDIR /app

RUN git clone --depth 1 https://github.com/d-tree-org/Fhir-Helpers-Extension.git

RUN ls
RUN ls -a

# Build the fat JAR using the Shadow plugin
RUN gradle -p /app/Fhir-Helpers-Extension/Fhir_Kotlin :cli:shadowJar

RUN mv /app/Fhir-Helpers-Extension/Fhir_Kotlin/cli/build/libs/cli-*-all.jar /app/cli.jar


# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "cli.jar"]
