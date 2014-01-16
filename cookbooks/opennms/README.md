Description
===========

Installs OpenNMS.

Requirements
============
## apt and postgresql:

## Platform:

The following platform families are supported:

* Ubuntu

Planned support for:
* Mac OS X (10.6.0+)
* Arch
* RHEL
* Fedora
* Debian
* Amazon

## Attributes

### default

* `node['opennms']['opennms_home']` - directory to install OpenNMS
* `node['opennms']['pg_hba_location']` - location of pg_hba.conf for PostgreSQL

The following attributes are platform-specific.

#### Debian Based

#### Mac OS X

#### RedHat Based


Recipes
=======

## default

Installs OpenNMS

## serverent on Windows

Usage
=====

License and Author
==================

- Author:: Mike Huot (<mhuot@opennms.org>)

