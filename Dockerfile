# (c) Wong Hoi Sing Edison <hswong3i@pantarei-design.com>
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

FROM ubuntu:18.04

ENV JAVA_VERSION                 "1.8.0"
ENV JIRA_VERSION                 "8.3.3"
ENV JIRA_OWNER                   "jira"
ENV JIRA_GROUP                   "jira"
ENV JIRA_HOME                    "/var/atlassian/application-data/jira"
ENV JIRA_CATALINA                "/opt/atlassian/jira"
ENV JVM_MINIMUM_MEMORY           "384m"
ENV JVM_MAXIMUM_MEMORY           "768m"
ENV CATALINA_CONNECTOR_PROXYNAME ""
ENV CATALINA_CONNECTOR_PROXYPORT ""
ENV CATALINA_CONNECTOR_SCHEME    "http"
ENV CATALINA_CONNECTOR_SECURE    "false"
ENV CATALINA_CONTEXT_PATH        ""
ENV JVM_SUPPORT_RECOMMENDED_ARGS "-Datlassian.plugins.enable.wait=300 -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1"
ENV TZ                           "UTC"
ENV SESSION_TIMEOUT              "300"

VOLUME  $JIRA_HOME
WORKDIR $JIRA_HOME

EXPOSE 8005
EXPOSE 8080

ENTRYPOINT [ "dumb-init", "--", "docker-entrypoint.sh" ]
CMD        [ "/opt/atlassian/jira/bin/start-jira.sh", "-fg" ]

# Explicitly set system user UID/GID
RUN set -ex \
    && groupadd -r $JIRA_OWNER \
    && useradd -r -g $JIRA_GROUP -d $JIRA_HOME -M -s /usr/sbin/nologin $JIRA_OWNER

# Prepare APT dependencies
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install ca-certificates curl gcc git libffi-dev libssl-dev make python python-dev sudo \
    && rm -rf /var/lib/apt/lists/*

# Install PIP
RUN set -ex \
    && curl -skL https://bootstrap.pypa.io/get-pip.py | python

# Copy files
COPY files /

# Bootstrap with Ansible
RUN set -ex \
    && cd /etc/ansible/roles/localhost \
    && pip install --upgrade --requirement requirements.txt \
    && molecule test \
    && rm -rf /var/cache/ansible/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.cache/* \
    && rm -rf /tmp/*
