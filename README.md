
# 🌲 Eureka 서비스 등록 플로우

Eureka는 Spring Cloud 기반 MSA에서 서비스 디스커버리(Discovery)를 제공하는 핵심 컴포넌트입니다.  
다음 흐름은 서비스가 Eureka 서버에 등록되고, 이후 주기적으로 헬스 체크를 수행하며 상태를 유지하는 과정을 나타냅니다.

---

## ✅ 등록 절차 요약

| 단계 | 설명 |
|------|------|
| Spring Boot 실행 | 클라이언트 애플리케이션이 기동 |
| Eureka Server 활성화 | Eureka 서버가 8761 포트에서 대기 |
| 서비스 등록 요청 | 클라이언트가 자신을 Eureka에 등록 |
| 레지스트리 갱신 | 서비스 정보가 저장되며 주기적으로 갱신됨 |
| 헬스 체크 | 일정 주기로 서비스 상태 확인 |
| 대시보드 확인 | 등록된 서비스 현황을 UI에서 확인 가능 (http://localhost:8761) |

---

## 🌐 기본 Eureka 서버 주소

```

[http://localhost:8761](http://localhost:8761)

````

---

## 🔄 등록 흐름도 (Mermaid)

```mermaid
flowchart TD
    %% 노드 정의
    start((Start)) 
    eurekaInit[Spring Boot 애플리케이션 실행]
    eurekaServer["Eureka Server 활성화"]
    listenPort["8761 포트에서 대기"]
    clientRegister[서비스 등록 요청 수신]
    registryUpdate[서비스 정보 등록/갱신]
    heartbeatCheck[주기적 헬스 체크 수행]
    dashboard["Eureka 대시보드 상태 확인"]
    endNode((완료))

    %% 흐름 정의
    start --> eurekaInit
    eurekaInit --> eurekaServer
    eurekaServer --> listenPort
    listenPort --> clientRegister
    clientRegister --> registryUpdate
    registryUpdate --> heartbeatCheck
    heartbeatCheck --> dashboard
    dashboard --> endNode

    %% 색상 정의
    classDef forest fill:#e6f4ea,stroke:#2e7d32,stroke-width:1.5px,color:#2e7d32;
    classDef terminal fill:#d0f0c0,stroke:#1b5e20,color:#1b5e20;

    %% 적용
    class start,endNode terminal;
    class eurekaInit,eurekaServer,listenPort,clientRegister,registryUpdate,heartbeatCheck,dashboard forest;
````

---

## ⚙️ 설정 예시 (클라이언트 `application.yml`)

```yaml
eureka.client.service-url.defaultZone=http://localhost:8761/eureka
eureka.client.register-with-eureka=true
eureka.client.fetch-registry=true

spring.application.name=auth-service

```

---

## 🧠 개발 포인트

* `@EnableEurekaServer` → 서버 측에 선언
* 클라이언트에서는 서비스 이름(`spring.application.name`)을 기반으로 Eureka에 등록됨
* `heartbeat` 주기는 기본 30초, `lease-expiration`은 90초 (설정 가능)

---

## 🔎 대시보드 기능

* 등록된 서비스 목록 조회
* 헬스 상태 표시 (UP / DOWN)
* 인스턴스 수, IP, 포트 정보 확인 가능

---

## 📈 확장 가능성

* 다중 인스턴스(Eureka Cluster) 구성
* Zone / Region 분산 설정
* 서비스 간 로드밸런싱 연동 (Spring Cloud LoadBalancer)

