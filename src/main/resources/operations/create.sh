#!/bin/sh

readonly APP_NAME=base
readonly IP_ADDRESS=172.25.52.2
readonly POSTGRESQL_JDBC_DRIVER=postgresql-42.2.5.jar
readonly DB_NAME="${APP_NAME}"
readonly DB_USER_NAME="${APP_NAME}"
readonly DB_USER_PASSWORD=verysecret

wget -P ../glassfish/domains/domain1/lib/ext/ https://jdbc.postgresql.org/download/"${POSTGRESQL_JDBC_DRIVER}"
./asadmin start-domain
./asadmin create-jdbc-connection-pool \
--datasourceclassname=org.postgresql.ds.PGSimpleDataSource \
--restype=javax.sql.DataSource \
--validationmethod=auto-commit \
--allownoncomponentcallers=false \
--nontransactionalconnections=false \
--driverclassname=org.postgresql.Driver \
--property user="${DB_USER_NAME}":\
password="${DB_USER_PASSWORD}":\
databaseName="${DB_NAME}":\
serverName="${IP_ADDRESS}":\
portNumber=5432:\
url=jdbc\\:postgresql\\://"${IP_ADDRESS}"\\:5432/"${DB_NAME}" \
postgres_"${APP_NAME}"_pool
./asadmin create-jdbc-resource --connectionpoolid postgres_"${APP_NAME}"_pool jdbc/postgres_"${APP_NAME}"
./asadmin stop-domain
