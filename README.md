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

#### Linux

Download the Sumo Logic Collector package for your respective flavours and import into your YUM repos.

### Beginning with sumo

Put the relevant configuration information into Hiera:

```
sumo::accessid: lkskj98983hjhj
sumo::accesskey: jlkdlkaldkalkda984nb197jdnkjsomjsdkjiocjJAOSALDJWBDahsikldjkja78
```

Call in the `sumo` class in your required scope:

```
  class { 'sumo': }
```

## Usage

Expanding on the previous section, all the user properties can be specified in hiera.  Here are the defaults that can be overridden by site
requirements:

```
accessid                 : null
accesskey                : null
category                 : null
clobber                  : 'true'
collector_name           : "%{::hostname}"
collector_secure_files   : null
collector_url            : https://collectors.sumologic.com
description              : "%{::hostname}"
disable_action_source    : 'false'
disable_script_source    : 'false'
disable_upgrade          : 'true'
ephemeral                : 'false'
hostname                 : "%{::hostname}"
local_config_mgmt        : null
proxy_host               : null
proxy_ntlmdomain         : null
proxy_password           : null
proxy_port               : null
proxy_user               : null
runas_username           : null
skip_access_key_removal  : null
skip_registration        : null
sources_file_override    : null
sync_sources_override    : null
sources_path             : null
sync_sources_path        : null
target_cpu               : null
time_zone                : null
token                    : null
win_run_as_password      : null
sumo_user_properties_path: /opt/SumoCollector/config/user.properties
sumo_package_name        : SumoCollector
sumo_package_ver         : latest
sumo_service_name        : collector
sumo_service_state: 
  running: true
  enable : true
```

Here are the Windows overrides:

```
sumo_service_name           : sumo-collector
sumo_install_properties_path: 'C:\windows\temp\sumoVarFile.txt'
sumo_user_properties_path   : 'C:\Program Files\Sumo Logic Collector\config\user.properties'
```

Please refer to Sumo documentation for an explanation of each setting: https://help.sumologic.com/03Send-Data/Installed-Collectors/05Reference-Information-for-Collector-Installation/06user.properties. (Bear in mind, some of the properties have been slightly modified, but it should be reasonably clear how they align).

## Limitations

* Nothing implemented for UNIX in this version.
* Assumes chocolatey is the Windows package manager.
* Debian/Ubuntu probably works, but is untested.

## Development

If you would like to contribute to this module, please submit a PR on github.  Thanks.


