# apticron

[![Build Status](https://travis-ci.org/dhoppe/puppet-apticron.png?branch=master)](https://travis-ci.org/dhoppe/puppet-apticron)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/apticron.svg)](https://forge.puppetlabs.com/dhoppe/apticron)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/dhoppe/apticron.svg)](https://forge.puppetlabs.com/dhoppe/apticron)
[![Puppet Forge](https://img.shields.io/puppetforge/mc/dhoppe.svg)](https://forge.puppetlabs.com/dhoppe)
[![Puppet Forge](https://img.shields.io/puppetforge/rc/dhoppe.svg)](https://forge.puppetlabs.com/dhoppe)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with apticron](#setup)
    * [What apticron affects](#what-apticron-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with apticron](#beginning-with-apticron)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures the Apticron package.

## Module Description

This module handles installing and configuring Apticron across a range of operating systems and distributions.

## Setup

### What apticron affects

* apticron package.
* apticron configuration file.

### Setup Requirements

* Puppet >= 2.7
* Facter >= 1.6
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with apticron

Install apticron with the default parameters ***(No configuration files will be changed)***.

```puppet
    class { 'apticron': }
```

Install apticron with the recommended parameters.

```puppet
    class { 'apticron':
      config_file_template => "apticron/${::lsbdistcodename}/etc/apticron/apticron.conf.erb",
      config_file_hash     => {
        'apticron'         => {
          config_file_path     => '/etc/cron.d/apticron',
          config_file_template => 'apticron/common/etc/cron.d/apticron.erb',
        },
        'listchanges.conf' => {
          config_file_path     => '/etc/apt/listchanges.conf',
          config_file_template => 'apticron/common/etc/apt/listchanges.conf.erb',
          config_file_require  => 'Package[apt-listchanges]',
        },
      },
    }
```

## Usage

Update the apticron package.

```puppet
    class { 'apticron':
      package_ensure => 'latest',
    }
```

Remove the apticron package.

```puppet
    class { 'apticron':
      package_ensure => 'absent',
    }
```

Purge the apticron package ***(All configuration files will be removed)***.

```puppet
    class { 'apticron':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'apticron':
      config_dir_source => "puppet:///modules/apticron/${::lsbdistcodename}/etc/apticron",
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration files will be removed)***.

```puppet
    class { 'apticron':
      config_dir_purge  => true,
      config_dir_source => "puppet:///modules/apticron/${::lsbdistcodename}/etc/apticron",
    }
```

Deploy the configuration file from source.

```puppet
    class { 'apticron':
      config_file_source => "puppet:///modules/apticron/${::lsbdistcodename}/etc/apticron/apticron.conf",
    }
```

Deploy the configuration file from string.

```puppet
    class { 'apticron':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'apticron':
      config_file_template => "apticron/${::lsbdistcodename}/etc/apticron/apticron.conf.erb",
    }
```

Deploy the configuration file from custom template ***(Additional parameters can be defined)***.

```puppet
    class { 'apticron':
      config_file_template     => "apticron/${::lsbdistcodename}/etc/apticron/apticron.conf.erb",
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'apticron':
      config_file_hash => {
        'apticron.2nd.conf' => {
          config_file_path   => '/etc/apticron/apticron.2nd.conf',
          config_file_source => "puppet:///modules/apticron/${::lsbdistcodename}/etc/apticron/apticron.2nd.conf",
        },
        'apticron.3rd.conf' => {
          config_file_path   => '/etc/apticron/apticron.3rd.conf',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'apticron.4th.conf' => {
          config_file_path     => '/etc/apticron/apticron.4th.conf',
          config_file_template => "apticron/${::lsbdistcodename}/etc/apticron/apticron.4th.conf.erb",
        },
      },
    }
```

## Reference

### Classes

#### Public Classes

* apticron: Main class, includes all other classes.

#### Private Classes

* apticron::install: Handles the packages.
* apticron::config: Handles the configuration file.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present', 'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'apticron'.

#### `package_list`

Determines if additional packages should be managed. Defaults to '['apt-listchanges']'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are 'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc/apticron'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are 'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent' and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/etc/apticron/apticron.conf'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0644'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'Package[apticron]'.

#### `config_file_hash`

Determines which configuration files should be managed via `apticron::define`. Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

#### `email`

Determines which email address (recipient) should be notified about impending updates. Defaults to "apticron@${::domain}".

#### `email_from`

Determines which email address (sender) should be used. Defaults to "root@${::fqdn}".

#### `email_subject`

Determines which email subject should be used. Defaults to '[apticron] $SYSTEM: $NUM_PACKAGES package update(s)'.

#### `random`

Determines which time a cron job should be executed. Defaults to 'fqdn_rand('60')'.

## Limitations

This module has been tested on:

* Debian 6/7/8
* Ubuntu 12.04/14.04

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-apticron/graphs/contributors](https://github.com/dhoppe/puppet-apticron/graphs/contributors)
