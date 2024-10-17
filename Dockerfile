FROM cypress/included:13.10.0@sha256:5b1d97ad6996ffa1611463d0e9720b0219b5c017f6107d6ca5090ee0d2b4d57f

ENV DOTNET_VERSION=8.0

RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb

RUN apt update && \
    apt install -y "dotnet-sdk-${DOTNET_VERSION}" && \
    npm i -g pnpm && \
    dotnet dev-certs https --trust
