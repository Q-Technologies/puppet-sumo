# sumo

Install and configure the Sumo Logic collector install using local software distribution. Providing more control over lifecycle.

#### Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Setup](#setup)
  * [Setup Requirements](#setup-requirements)
    * [Windows](#windows)
    * [Linux](#linux)
  * [Beginning with sumo](#beginning-with-sumo)
* [Usage](#usage)
* [Limitations](#limitations)
* [Development](#development)

<!-- vim-markdown-toc -->


## Description

There are currently a few SumoLogic modules already.  Most notably https://forge.puppet.com/pjorg/sumo and 
https://github.com/SumoLogic/sumologic-collector-puppet-module.  The problem with the former is that it does not
support Windows or many of the options for the `user.properties` file.  The problem with the latter is that it assumes every
node can directly connect to the internet for curl (some firewalls only allow Sumo profile traffic) and it doesn't allow you to
upgrade or control the package versions.  So this module takes the approach of the former, but the detail from the second.

This module assumes an existing package management solution is in place (YUM for RHEL/SLES and Chocolatey for Windows). 
It takes the following platform approach:

* Windows - install pkg via chocolatey with the site customisation being driven during pkg install. Upgradeable via Chocolatey.
* Linux - install RPM, configure, then start sumo.  Upgradeable via RPM.
<!--* UNIX (TODO) - install from tar, configure, then start sumo.  Not readily upgradeable.-->


## Setup

### Setup Requirements

#### Windows

Assumes a functional Chocolatey environment and that the Sumo Logic Collector installer for Windows has been correctly imported into Chocolatey.

Setup the Chocolatey package so that it installs the exe with the following command line options:

```
-console -q -varfile 'C:\windows\temp\sumoVarFile.txt'
```

#### Linux

Download the Sumo Logic Collector package for your respective flavours and import into your repos.

### Beginning with sumo

Put the relevant configuration information into Hiera:

```
sumo::accessid: lkskj98983hjhj
sumo::accesskey: jlkdlkaldkalkda984nb197jdnkjsomjsdkjiocjJAOSALDJWBDahsikldjkja78
sumo::sumo_package_ver: 19.253-26
sumo::sources_path: "/tmp/sumo-%{osfamily}.json"
```

Call in the `sumo` class in your required scope:

```
  class { 'sumo': }
```

## Usage

Expanding on the previous section, all the user properties can be specified in hiera.  Here are the defaults that can be overridden by site
requirements:

```
---
sumo::accessid:                null
sumo::accesskey:               null
sumo::category:                null
sumo::clobber:                 true
sumo::collector_name:          "%{::hostname}"
sumo::collector_secure_files:  true
sumo::collector_url:           https://collectors.sumologic.com
sumo::description:             null
sumo::enable_action_source:    false
sumo::enable_script_source:    false
sumo::disable_upgrade:         true
sumo::ephemeral:               false
sumo::hostname:                "%{::hostname}"
sumo::proxy_host:              null
sumo::proxy_ntlmdomain:        null
sumo::proxy_password:          null
sumo::proxy_port:              null
sumo::proxy_user:              null
sumo::skip_access_key_removal: false
sumo::skip_registration:       false
sumo::local_config_mgmt:       false
sumo::sources_path:            null
sumo::sync_sources_path:       null
sumo::target_cpu:              null
sumo::time_zone:               null
sumo::token:                   null
sumo::runas_username:          null
sumo::win_run_as_password:     null
sumo::install_properties_path: null
sumo::user_properties_path:    /opt/SumoCollector/config/user.properties
sumo::package:
  name:    SumoCollector
  version: latest
sumo::service:
  name:    collector
  running: true
  enabled: true
```

Here are the Windows overrides:

```
sumo::service:
  name: sumo-collector
sumo::install_properties_path: 'C:\windows\temp\sumoVarFile.txt'
sumo::user_properties_path:    'C:\Program Files\Sumo Logic Collector\config\user.properties'
```

If you want to install globally except a few test systems, then you can specify the following Hiera in the scope of the test systems
so that it will not be installed or configured on them:

```
sumo::install: false
```

Please refer to Sumo documentation for an explanation of each setting: https://help.sumologic.com/03Send-Data/Installed-Collectors/05Reference-Information-for-Collector-Installation/06user.properties. (Bear in mind, some of the properties have been slightly modified, but it should be reasonably clear how they align).

See the Reference.md file for more detailed information.

## Limitations

* Nothing implemented for UNIX in this version.
* Assumes chocolatey is the Windows package manager.
* Debian/Ubuntu probably works, but is untested.

## Development

If you would like to contribute to this module, please submit a PR on github.  Thanks.


