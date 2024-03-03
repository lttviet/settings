ARG VERSION

FROM fluent/fluentd:${VERSION}
USER root
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-document", "--version", "5.4.3"]
USER fluent
