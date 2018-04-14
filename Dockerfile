FROM library/postgres

ENV POSTGRES_PASSWORD postgres123456

COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
# COPY docker-entrypoint-datadb.d/* /docker-entrypoint-datadb.d/
