<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# DataFusion Comet Benchmark derived from TPC-H and TPC-DS

Follow the [Comet Installation](https://datafusion.apache.org/comet/user-guide/installation.html) guide to download or
create a Comet JAR file and then set the `COMET_JAR` environment variable to point to that jar file.

```shell
export COMET_JAR=spark/target/comet-spark-spark3.4_2.12-0.2.0-SNAPSHOT.jar
```

Set up `SPARK_HOME` to point to the relevant Spark version and use `spark-submit` to run the benchmark script.

The follow example is for running in local mode, which can be convenient when running locally against small scale
factors but is not representative of real-world use. It is recommended that benchmarks are run against a properly 
configured Spark cluster. 

```shell
export COMET_JAR=spark/target/comet-spark-spark3.4_2.12-0.1.0-SNAPSHOT.jar

$SPARK_HOME/bin/spark-submit \
    --master "local[*]" \
    --jars $COMET_JAR \
    --conf spark.driver.extraClassPath=$COMET_JAR \
    --conf spark.executor.extraClassPath=$COMET_JAR \
    --conf spark.plugins=org.apache.spark.CometPlugin \
    --conf spark.comet.enabled=true \
    --conf spark.comet.exec.enabled=true \
    --conf spark.comet.cast.allowIncompatible=true \
    --conf spark.comet.exec.shuffle.enabled=true \
    --conf spark.comet.exec.shuffle.mode=auto \
    --conf spark.shuffle.manager=org.apache.spark.sql.comet.execution.shuffle.CometShuffleManager \
    tpcbench.py \
    --benchmark tpch \
    --data /path/to/parquet-data \
    --queries ../../tpch/queries/ \
    --output .
```

When benchmarking Comet, we are generally interested in comparing the performance of Spark with Comet disabled to
the performance of Spark with Comet enabled. Comet can be enabled or disabled by setting the `spark.comet.exec.enabled`
config appropriately.
