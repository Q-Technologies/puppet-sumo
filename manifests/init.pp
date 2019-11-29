# @summary Configures the Sumo Collector

class sumo (
  Optional[String] $accessid,
  Optional[String] $accesskey,
  Optional[String] $category,
  Optional[String] $clobber,
  Optional[String] $collector_name,
  Optional[String] $collector_secure_files,
  Optional[String] $collector_url,
  Optional[String] $description,
  Optional[String] $disable_action_source,
  Optional[String] $disable_script_source,
  Optional[String] $disable_upgrade,
  Optional[String] $ephemeral,
  Optional[String] $hostname,
  Optional[String] $local_config_mgmt,
  Optional[String] $proxy_host,
  Optional[String] $proxy_ntlmdomain,
  Optional[String] $proxy_password,
  Optional[String] $proxy_port,
  Optional[String] $proxy_user,
  Optional[String] $runas_username,
  Optional[String] $skip_access_key_removal,
  Optional[String] $skip_registration,
  Optional[String] $sources_file_override,
  Optional[String] $sync_sources_override,
  Optional[String] $sources_path,
  Optional[String] $sync_sources_path,
  Optional[String] $target_cpu,
  Optional[String] $time_zone,
  Optional[String] $token,
  Optional[String] $win_run_as_password,
  String $sumo_user_properties_path,
  Optional[String] $sumo_install_properties_path,
  String $sumo_package_name,
  String $sumo_package_ver,
  String $sumo_service_name,
  Struct[{running => Boolean, enable => Boolean}] $sumo_service_state,
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
    'sources_file_override'   => $sources_file_override,
    'sync_sources_override'   => $sync_sources_override,
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
    file { $sumo_install_properties_path:
      content => epp('sumoVarFileWin.txt.epp', $template_data),
      before  => Package[$sumo_package_name],
    }
  } else {
    File {
      owner => 'root',
      group => 'root',
    }
  }
  file { $sumo_user_properties_path:
    ensure  => 'file',
    mode    => '0644',
    content => epp('user.properties.epp', $template_data),
    require => Package[$sumo_package_name],
    notify  => Service[$sumo_service_name];
  }

  ########## Install Package ############
  package { $sumo_package_name:
    ensure => $sumo_package_ver,
  }

  ########## start the service ############
  service { $sumo_service_name:
    ensure => $sumo_service_state['running'],
    enable => $sumo_service_state['enable'],
  }

}
