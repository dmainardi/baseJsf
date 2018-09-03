#!/bin/sh

readonly APP_NAME=base
readonly POSTGRESQL_JDBC_DRIVER=postgresql-42.2.5.jar

./asadmin delete-jdbc-resource jdbc/postgres_"${APP_NAME}"
./asadmin delete-jdbc-connection-pool postgres_"${APP_NAME}"_pool
rm ../glassfish/domains/domain1/lib/ext/"${POSTGRESQL_JDBC_DRIVER}"
