FROM debian:bullseye-20240211

WORKDIR /usr/src

RUN apt-get update && \
    apt-get install -y python3 python3-pip

RUN useradd --create-home appuser
USER appuser

COPY app.py .

ENV API_KEY=hi_mom

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://localhost:6969/health || exit 1

VOLUME /db/data

CMD [ "python3", "-m", "http.server", "8000" ]

ENTRYPOINT [ "python3", "-m", "http.server" ]
CMD [ "8000" ]

LABEL maintainer="Vega de la Lyra"
LABEL version="1.0"
LABEL description="more garbage code"

