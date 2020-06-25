# Docker Image Packaging for Atlassian Jira

[![Travis](https://img.shields.io/travis/com/alvistack/docker-jira.svg)](https://travis-ci.com/alvistack/docker-jira)
[![GitHub release](https://img.shields.io/github/release/alvistack/docker-jira.svg)](https://github.com/alvistack/docker-jira/releases)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-jira.svg)](https://github.com/alvistack/docker-jira/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/jira.svg)](https://hub.docker.com/r/alvistack/jira/)

Jira Software unlocks the power of agile by giving your team the tools to easily create & estimate stories, build a sprint backlog, identify team commitments & velocity, visualize team activity, and report on your team's progress.

Learn more about Jira: <https://www.atlassian.com/software/jira>

## Supported Tags and Respective `Dockerfile` Links

  - [`8.10`, `latest`](https://github.com/alvistack/docker-jira/blob/master/molecule/8.10/Dockerfile.j2)
  - [`8.9`](https://github.com/alvistack/docker-jira/blob/master/molecule/8.9/Dockerfile.j2)

## Overview

This Docker container makes it easy to get an instance of Jira up and running.

Based on [Official Ubuntu Docker Image](https://hub.docker.com/_/ubuntu/) with some minor hack:

  - Minimized `Dockerfile` for meta data definition
  - Provision by Ansible and Molecule Docker driver in single layer
  - Handle `ENTRYPOINT` with [catatonit](https://github.com/openSUSE/catatonit)

### Quick Start

For the `JIRA_HOME` directory that is used to store the repository data (amongst other things) we recommend mounting a host directory as a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes), or via a named volume if using a docker version \>= 1.9.

Volume permission is NOT managed by entry scripts. To get started you can use a data volume, or named volumes.

Start Atlassian Jira Server:

    # Pull latest image
    docker pull alvistack/jira
    
    # Run as detach
    docker run \
        -itd \
        --name jira \
        --publish 8080:8080 \
        --volume /var/atlassian/application-data/jira:/var/atlassian/application-data/jira \
        alvistack/jira

**Success**. Jira is now available on <http://localhost:8080>

Please ensure your container has the necessary resources allocated to it. We recommend 2GiB of memory allocated to accommodate both the application server and the git processes. See [Supported Platforms](https://confluence.atlassian.com/display/JIRA/Supported+Platforms) for further information.

### Memory / Heap Size

If you need to override Jira's default memory allocation, you can control the minimum heap (Xms) and maximum heap (Xmx) via the below environment variables.

#### JVM\_MINIMUM\_MEMORY

The minimum heap size of the JVM

Default: `384m`

#### JVM\_MAXIMUM\_MEMORY

The maximum heap size of the JVM

Default: `768m`

### Reverse Proxy Settings

If Jira is run behind a reverse proxy server, then you need to specify extra options to make Jira aware of the setup. They can be controlled via the below environment variables.

#### CATALINA\_CONNECTOR\_PROXYNAME

The reverse proxy's fully qualified hostname.

Default: *NONE*

#### CATALINA\_CONNECTOR\_PROXYPORT

The reverse proxy's port number via which Jira is accessed.

Default: *NONE*

#### CATALINA\_CONNECTOR\_SCHEME

The protocol via which Jira is accessed.

Default: `http`

#### CATALINA\_CONNECTOR\_SECURE

Set 'true' if CATALINA\_CONNECTOR\_SCHEME is 'https'.

Default: `false`

#### CATALINA\_CONTEXT\_PATH

The context path via which Jira is accessed.

Default: *NONE*

### JVM configuration

If you need to pass additional JVM arguments to Jira such as specifying a custom trust store, you can add them via the below environment variable

#### JVM\_SUPPORT\_RECOMMENDED\_ARGS

Additional JVM arguments for Jira

Default: `-Datlassian.plugins.enable.wait=300`

### Misc configuration

Other else misc configuration.

#### TZ

Default timezone for the docker instance

Default: `UTC`

#### SESSION\_TIMEOUT

Default session timeout for Apache Tomcat

Default: `300`

## Upgrade

To upgrade to a more recent version of Jira Server you can simply stop the Jira
container and start a new one based on a more recent image:

    docker stop jira
    docker rm jira
    docker run ... (see above)

As your data is stored in the data volume directory on the host, it will still
be available after the upgrade.

Note: Please make sure that you don't accidentally remove the jira container and its volumes using the -v option.

## Backup

For evaluations you can use the built-in database that will store its files in the Jira Server home directory. In that case it is sufficient to create a backup archive of the directory on the host that is used as a volume (`/var/atlassian/application-data/jira` in the example above).

## Versioning

### `alvistack/jira:latest`

The `latest` tag matches the most recent [GitHub Release](https://github.com/alvistack/docker-jira/releases) of this repository. Thus using `alvistack/jira:latest` or `alvistack/jira` will ensure you are running the most up to date stable version of this image.

### `alvistack/jira:<version>`

The version tags are rolling release rebuild by [Travis](https://travis-ci.com/alvistack/docker-jira) in weekly basis. Thus using these tags will ensure you are running the latest packages provided by the base image project.

## License

  - Code released under [Apache License 2.0](LICENSE)
  - Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

## Author Information

  - Wong Hoi Sing Edison
      - <https://twitter.com/hswong3i>
      - <https://github.com/hswong3i>
