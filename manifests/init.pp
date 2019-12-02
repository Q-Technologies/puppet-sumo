# @summary Configures the Sumo Collector
#
# @example Basic usage
#   class { 'sumo': }
#   
# @example Set the following in the relevant hiera scope:
#
#   sumo::accessid: lkskj98983hjhj
#   sumo::accesskey: jlkdlkaldkalkda984nb197jdnkjsomjsdkjiocjJAOSALDJWBDahsikldjkja78
#   sumo::sumo_package_ver: 19.253-26
#   sumo::sources_path: "/tmp/sumo-%{osfamily}.json"
#    
#
# @param accessid
#   The Sumo Logic collector access ID
# @param accesskey
#   The Sumo Logic collector access Key
# @param category
#   Source category to use when a source does not specify a category.
# @param clobber
#   When true, if there is any existing collector with the same name, that collector will be deleted (clobbered).
# @param collector_name
#   Sets the name of collector used on Sumo Logic. The name can be a maximum of 128 characters.
# @param collector_secure_files
#   By default, new Collector installations will use Enhanced File System Security. 
#   To disable this feature during installation, set this to false.
# @param collector_url
#   Sets the URL used to register collector for data collection API. 
# @param description
#   Description for the collector to appear in Sumo Logic.
# @param disable_action_source
#   If your organization's internal policies restrict the use of Script Actions, you can disable them by setting this parameter to true.
#   Specify as 'true' or 'false'.
# @param disable_script_source
#   If your organization's internal policies restrict the use of Script Sources, you can disable them by setting this parameter to true.
#   Specify as 'true' or 'false'.
# @param disable_upgrade
#   If true, the collector rejects upgrade requests from Sumo.
# @param ephemeral
#   When true, the collector will be deleted after 12 hours of inactivity.
# @param hostname
#   The host name of the machine on which the collector is running. 
# @param local_config_mgmt
#   Needs yo be false when using ''sources_path'' and true when using ''sync_sources_path''.
# @param proxy_host
#   Sets proxy host when a proxy server is used.
# @param proxy_ntlmdomain
#   Sets proxy NTLM domain when a proxy server is used with NTLM authentication.  
# @param proxy_password
#   Sets proxy password when a proxy server is used with authentication.    
# @param proxy_port
#   Sets proxy port when a proxy server is used.
# @param proxy_user
#   Sets proxy user when a proxy server is used with authentication.
# @param skip_access_key_removal
#   If true, it will skip the access key removal from the user.properties file.
# @param skip_registration
#   Collectors normally register with Sumo Logic during the installation process, but setting this flag to true will skip registration. 
#   This way, the collector is installed as a service that will start and register automatically when next booted or started.
# @param sources_path
#   Specifies a single UTF-8 encoded JSON file, or a folder containing UTF-8 encoded JSON files, 
#   that defines the Sources to configure upon Collector registration. The contents of the file 
#   or files is read upon Collector registration only, 
#   it is not synchronized with the Collector's configuration on an on-going basis.
# @param sync_sources_path
#   Specifies either a single UTF-8 encoded JSON file, or a folder containing UTF-8 encoded JSON 
#   files, that define the Sources to configure upon Collector registration. The Source definitions 
#   will be continuously monitored and synchronized with the Collector's configuration.
# @param target_cpu
#   You can choose to set a CPU target to limit the amount of CPU processing a collector uses. 
#   The value must be expressed as a whole number percentage string, e.g. 20. 
# @param time_zone
#   The time zone to use when it is not extracted from the log timestamp.
# @param token
#   Sets the Setup Wizard Token, a one-time use token, available for one hour after it is generated, 
#   then it expires. This token authenticates the user. It is designed to be used for only one Collector. 
#   The token cannot be used with the API, and it cannot be disabled.
# @param runas_username
#   When set, the Collector will run as the specified user (Windows and Linux).
#   For Windows, the user account needs Log on as a Service permission.
# @param win_run_as_password
#   (Windows only) When set in conjunction with runas_username, the Collector will run as the specified user with the specified password.
# @param user_properties_path
#   Set the absolute path of the user.properties file.  It default to the location in the default install location.
# @param install_properties_path
#   Set this to the location specified in the Chocolatey configuration.  Default is 'C:\windows\temp\sumoVarFile.txt'.
# @param package
#   Set the name and version of the package to install
# @param service
#   Set the name and state of the collector service
class sumo (
  String $accessid,
  String $accesskey,
  Optional[String] $category,
  Boolean $clobber,
  String $collector_name,
  Boolean $collector_secure_files,
  String $collector_url,
  Optional[String] $description,
  Boolean $disable_action_source,
  Boolean $disable_script_source,
  Boolean $disable_upgrade,
  Boolean $ephemeral,
  String $hostname,
  Optional[String] $proxy_host,
  Optional[String] $proxy_ntlmdomain,
  Optional[String] $proxy_password,
  Optional[String] $proxy_port,
  Optional[String] $proxy_user,
  Boolean $skip_access_key_removal,
  Boolean $skip_registration,
  Boolean $local_config_mgmt,
  Optional[String] $sources_path,
  Optional[String] $sync_sources_path,
  Optional[Integer] $target_cpu,
  Optional[String] $time_zone,
  Optional[String] $token,
  Optional[String] $runas_username,
  Optional[String] $win_run_as_password,
  String $user_properties_path,
  Optional[String] $install_properties_path,
  Struct[{name => String, version => String}] $package,
  Struct[{name => String, running => Boolean, enable => Boolean}] $service,
){
  $template_data = {
    'accessid'                => $accessid,
    'accesskey'               => $accesskey,
    'category'                => $category,
    'clobber'                 => $clobber,
    'collector_name'          => $collector_name,
    'collector_secure_files'  => $collector_secure_files,
    'collector_url'           => $collector_url,
    'description'             => $description,
    'disable_action_source'   => $disable_action_source,
    'disable_script_source'   => $disable_script_source,
    'disable_upgrade'         => $disable_upgrade,
    'ephemeral'               => $ephemeral,
    'hostName'                => $hostname,
    'skip_access_key_removal' => $skip_access_key_removal,
    'proxy_host'              => $proxy_host,
    'proxy_ntlmdomain'        => $proxy_ntlmdomain,
    'proxy_password'          => $proxy_password,
    'proxy_port'              => $proxy_port,
    'proxy_user'              => $proxy_user,
    'runas_username'          => $runas_username,
    'skip_registration'       => $skip_registration,
    'sources_path'            => $sources_path,
    'local_config_mgmt'       => $local_config_mgmt,
    'sync_sources_path'       => $sync_sources_path,
    'target_cpu'              => $target_cpu,
    'time_zone'               => $time_zone,
    'token'                   => $token,
    'win_run_as_password'     => $win_run_as_password
  }
  ########## Write the config file ############
  File {
    mode    => '0644',
    ensure  => 'file',
  }
  if $::osfamily == 'windows' {
    File {
      group => 'Administrators',
    }
    Package {
      provider => 'chocolatey'
    }
    file { $install_properties_path:
      content => epp('sumo/user.properties.epp', $template_data + { installer => true } ),
      before  => Package[$package['name']],
    }
  } else {
    File {
      owner => 'root',
      group => 'root',
    }
  }
  file { $user_properties_path:
    ensure  => 'file',
    mode    => '0644',
    content => epp('sumo/user.properties.epp', $template_data),
    require => Package[$package['name']],
    notify  => Service[$service['name']];
  }

  ########## Install Package ############
  package { $package['name']:
    ensure => $package['version'],
  }

  ########## start the service ############
  service { $service['name']:
    ensure => $service['running'],
    enable => $service['enable'],
  }

}
