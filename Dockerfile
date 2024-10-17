FROM cypress/included:13.10.0@sha256:5b1d97ad6996ffa1611463d0e9720b0219b5c017f6107d6ca5090ee0d2b4d57f

ENV DOTNET_VERSION=8.0
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH="/.aspnet/https"
ENV ASPNETCORE_Kestrel__Certificates__Default__Password="BF713A02-D596-4E55-8CDA-8DE664719378"

RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb

RUN apt update && \
    apt install -y "dotnet-sdk-${DOTNET_VERSION}" && \
    npm i -g pnpm

RUN mkdir -p "${ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH}"

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "${ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH}/aspnetcore.key" -out "${ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH}/aspnetcore.crt" -subj "/CN=localhost"

RUN openssl pkcs12 -export -out "${ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH}/aspnetcore.pfx" -inkey "${ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH}/aspnetcore.key" -in "${ASPNETCORE_KESTREL__CERTIFICATES__DEFAULT__PATH}/aspnetcore.crt" -passout pass:${ASPNETCORE_Kestrel__Certificates__Default__Password}
