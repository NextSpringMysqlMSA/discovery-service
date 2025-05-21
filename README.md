## 🌲 Eureka 서비스 등록 플로우 (Forest 테마)

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
