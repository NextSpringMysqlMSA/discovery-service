# 빌드 스테이지
FROM eclipse-temurin:17-jdk AS build
WORKDIR /workspace/app

# Gradle 빌드 관련 파일 복사
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src

RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# 실행 스테이지
FROM eclipse-temurin:17-jre
WORKDIR /app

# 타임존 설정 (tzdata는 apt 사용)
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    echo "Asia/Seoul" > /etc/timezone && \
    apt-get clean

ENV TZ=Asia/Seoul

# 빌드 결과 복사
COPY --from=build /workspace/app/build/libs/*.jar app.jar

# 실행 명령
ENTRYPOINT ["java", "-jar", "app.jar"]
