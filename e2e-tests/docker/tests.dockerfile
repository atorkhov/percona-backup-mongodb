FROM oraclelinux:8 AS base-build
WORKDIR /build
RUN dnf update && dnf install make gcc krb5-devel

RUN curl -sL -o /tmp/golang.tar.gz https://go.dev/dl/go1.22.2.linux-amd64.tar.gz && \
rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/golang.tar.gz && rm /tmp/golang.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

ARG TESTS_BCP_TYPE
ENV TESTS_BCP_TYPE=${TESTS_BCP_TYPE}

COPY . .
RUN go build -o /bin/pbm-test ./e2e-tests/cmd/pbm-test

CMD ["pbm-test"]
