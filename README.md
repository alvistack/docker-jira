# Docker Image Packaging for Atlassian Jira

<a href="https://alvistack.com" title="AlviStack" target="_blank"><img src="/alvistack.svg" height="75" alt="AlviStack"></a>

[![GitLab pipeline
status](https://img.shields.io/gitlab/pipeline/alvistack/docker-jira/master)](https://gitlab.com/alvistack/docker-jira/-/pipelines)
[![GitHub
tag](https://img.shields.io/github/tag/alvistack/docker-jira.svg)](https://github.com/alvistack/docker-jira/tags)
[![GitHub
license](https://img.shields.io/github/license/alvistack/docker-jira.svg)](https://github.com/alvistack/docker-jira/blob/master/LICENSE)
[![Docker
Pulls](https://img.shields.io/docker/pulls/alvistack/jira-10.7.svg)](https://hub.docker.com/r/alvistack/jira-10.7)

Jira Software unlocks the power of agile by giving your team the tools
to easily create & estimate stories, build a sprint backlog, identify
team commitments & velocity, visualize team activity, and report on your
team's progress.

Learn more about Jira: <https://www.atlassian.com/software/jira>

## Supported Tags and Respective Packer Template Links

- [`alvistack/jira-10.7`](https://hub.docker.com/r/alvistack/jira-10.7)
  - [`packer/docker-10.7/packer.json`](https://github.com/alvistack/docker-jira/blob/master/packer/docker-10.7/packer.json)
- [`alvistack/jira-10.3`](https://hub.docker.com/r/alvistack/jira-10.3)
  - [`packer/docker-10.3/packer.json`](https://github.com/alvistack/docker-jira/blob/master/packer/docker-10.3/packer.json)
- [`alvistack/jira-9.12`](https://hub.docker.com/r/alvistack/jira-9.12)
  - [`packer/docker-9.12/packer.json`](https://github.com/alvistack/docker-jira/blob/master/packer/docker-9.12/packer.json)

## Overview

This Docker container makes it easy to get an instance of Jira up and
running.

Based on [Official Ubuntu Docker
Image](https://hub.docker.com/_/ubuntu/) with some minor hack:

- Packaging by Packer Docker builder and Ansible provisioner in single
  layer
- Handle `ENTRYPOINT` with
  [catatonit](https://github.com/openSUSE/catatonit)

### Quick Start

For the `JIRA_HOME` directory that is used to store the repository data
(amongst other things) we recommend mounting a host directory as a [data
volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes),
or via a named volume if using a docker version \>= 1.9.

Volume permission is NOT managed by entry scripts. To get started you
can use a data volume, or named volumes.

Start Atlassian Jira Server:

    # Pull latest image
    docker pull alvistack/jira-10.7

    # Run as detach
    docker run \
        -itd \
        --name jira \
        --publish 8080:8080 \
        --volume /var/atlassian/application-data/jira:/var/atlassian/application-data/jira \
        alvistack/jira-10.7

**Success**. Jira is now available on <http://localhost:8080>

Please ensure your container has the necessary resources allocated to
it. We recommend 2GiB of memory allocated to accommodate both the
application server and the git processes. See [Supported
Platforms](https://confluence.atlassian.com/display/JIRA/Supported+Platforms)
for further information.

## Upgrade

To upgrade to a more recent version of Jira Server you can simply stop
the Jira container and start a new one based on a more recent image:

    docker stop jira
    docker rm jira
    docker run ... (see above)

As your data is stored in the data volume directory on the host, it will
still be available after the upgrade.

Note: Please make sure that you don't accidentally remove the jira
container and its volumes using the -v option.

## Backup

For evaluations you can use the built-in database that will store its
files in the Jira Server home directory. In that case it is sufficient
to create a backup archive of the directory on the host that is used as
a volume (`/var/atlassian/application-data/jira` in the example above).

## Versioning

### `YYYYMMDD.Y.Z`

Release tags could be find from [GitHub
Release](https://github.com/alvistack/docker-jira/tags) of this
repository. Thus using these tags will ensure you are running the most
up to date stable version of this image.

### `YYYYMMDD.0.0`

Version tags ended with `.0.0` are rolling release rebuild by [GitLab
pipeline](https://gitlab.com/alvistack/docker-jira/-/pipelines) in
weekly basis. Thus using these tags will ensure you are running the
latest packages provided by the base image project.

## License

- Code released under [Apache License 2.0](LICENSE)
- Docs released under [CC BY
  4.0](http://creativecommons.org/licenses/by/4.0/)

## Author Information

- Wong Hoi Sing Edison
  - <https://twitter.com/hswong3i>
  - <https://github.com/hswong3i>
