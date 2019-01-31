MKFILE_PATH=$(abspath $(lastword $(MAKEFILE_LIST)))
HOME=$(abspath $(patsubst %/,%,$(dir $(MKFILE_PATH))))

all: build

build:
	mvn -Phive-thriftserver  -pl sql/shaded-hive-thriftserver,sql/hive-thriftserver clean package -DskipTests
	aws s3 cp sql/shaded-hive-thriftserver/target/shaded-spark-hive-thriftserver_2.11-2.3.2.jar s3://advance-data-platform/lib/advai_infra/shaded-spark-hive-thriftserver_2.11-2.3.2.jar


check_%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: build
