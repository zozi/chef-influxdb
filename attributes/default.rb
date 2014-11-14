# attributes/default.rb
#
# Author: Simple Finance <ops@simple.com>
# License: Apache License, Version 2.0
#
# Copyright 2013 Simple Finance Technology Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Attributes for InfluxDB

# Versions are mapped to checksums
# By default, always installs 'latest'
default[:influxdb][:version] = 'latest'
default[:influxdb][:versions] = {
  amd64: {
    '0.8.5' => '58ae034557e6a2886530577ab368ed2153b4e0a41bcfa57d8b15a9d5006f14d0',
    :latest => '58ae034557e6a2886530577ab368ed2153b4e0a41bcfa57d8b15a9d5006f14d0'
  },
  i686: {
    '0.8.5' => 'b551d6d152c9af6e66a1eba3c07578a20678d0d3f3efa8852f19e2befd96a7fd',
    :latest => 'b551d6d152c9af6e66a1eba3c07578a20678d0d3f3efa8852f19e2befd96a7fd'
  }
}

# Grab clients -- right now only supports Ruby and CLI
default[:influxdb][:client][:cli][:enable] = false
default[:influxdb][:client][:ruby][:enable] = false
default[:influxdb][:client][:ruby][:version] = nil
default[:influxdb][:handler][:version] = '0.1.4'

# Parameters to configure InfluxDB
default[:influxdb][:config] = {
  'bind-address' => '0.0.0.0',
  :logging => {
    :level => 'info',
    :file => '/opt/influxdb/shared/log.txt'
  },
  :admin => {
    :port => 8083,
    :assets => '/opt/influxdb/current/admin'
  },
  :api => {
    'read-timeout' => '5s',
    :port => 8086
  },
  'input_plugins' => {
    :graphite => {
      :enabled => false
    }
  },
  raft: {
    :port => 8090,
    :dir => '/opt/influxdb/shared/data/raft'
  },
  storage: {
    'write-buffer-size' => 10_000,
    :dir => '/opt/influxdb/shared/data/db'
  },
  cluster: {
    'protobuf_port' => 8099,
    'protobuf_timeout' => '2s',
    'protobuf_heartbeat' => '200ms',
    'write-buffer-size' => 10_000,
    'max-response-buffer-size' => 100_000,
    'concurrent-shard-query-limit' => 10
  },
  leveldb: {
    'max-open-files' => 40,
    'lru-cache-size' => '200m',
    'max-open-shards' => 0,
    'point-batch-size' => 100
  },
  sharding: {
    'replication-factor' => 1,
    'short-term' => {
      :duration => '7d',
      :split => 1
    },
    'long-term' => {
      :duration => '30d',
      :split => 1
    }
  },
  wal: {
    :dir => '/opt/influxdb/shared/data/wal',
    'flush-after' => 1_000,
    'bookmark-after' => 1_000,
    'index-after' => 1_000,
    'requests-per-lifecycle' => 10_000
  }
}
