ansible-role-nrpe
=========

[![Build Status](https://travis-ci.org/CSCfi/ansible-role-nrpe.svg?branch=master)](https://travis-ci.org/CSCfi/ansible-role-nrpe)

Installs and configures NRPE or opsview-agent

 - Templates in a file that changes allowed_hosts of nrpe.cfg
 - Templates in a file that has custom nrpe/opsview checks

With EL7 and NRPE changing username that runs nrpe is not trivial and not yet implemented.
 - change systemd to User=nagios
 - ownership of the pid_file
  - More details in here: https://github.com/NagiosEnterprises/nrpe/issues/28

With EL6 changing nrpe_user and nrpe_group should work.

https://github.com/CSCfi/ansible-role-nrpe-plugins/ is a sister-role which one can use to actually install plugins.

Requirements
------------

 - opsview-agent requires that the yum repo is installed before running this role
 - if a firewall is used then it should allow access to TCP port 5666 from nagios_allowed_hosts variable
 - custom checks are installed separately
  - If they are available in yum add them to the nrpe_extra_rpms set
  - By default this installs a few rpms from EPEL.


Role Variables
--------------

See defaults/main.yml for a complete listing.

These are the two primary settings:
<pre>
install_opsview: True
install_nrpe: False
</pre>

install_opsview assumes that the server's yum is configured to talk to a repository that has the opsview-agent rpm.

Other important ones:

<pre>
nagios_plugins:
  - { command: "name", path: "path/to/where/plugin/is/installed", arguments: "arguments to this check" }
opsview_plugins:

nagios_allowed_hosts: "127.0.0.1,10.1.1.1"
</pre>

extra rpms:
<pre>
nrpe_extra_rpms:
 - nagios-common
 - nagios-plugins-smtp
</pre>

define an include_dir
<pre>
nagios_extra_settings_list:
 - include_dir={{ nagios_include_dir }}
</pre>

Adding nrpe checks from another git repository
<pre>
additional_nrpe_checks:
  - src: "https://github.com/CSCfi/puppet-opsviewagent.git"
    dest: "{{ nagios_plugins_dir }}/puppet_opsviewagent"
    version: "6fd3aae095a5d8691e8636214ff7d48c80c3ff67"
    script_path: "{{ nagios_plugins_dir }}/puppet_opsviewagent/files/nrpe/"
    type: 'git' # Possibility to add other sources in the future
    commands:
      - scripts_name: check_linux_memory
        command: check_linux_memory
        arguments: '-f -w 10 -c 5'
      - script_name: check_cpu
</pre>

Adding local nrpe checks with the `additional_nrpe_checks` variabel
<pre>
additional_nrpe_checks
  - script_path: "{{ nagios_plugins_dir }}"
    type: 'local'
    commands:
      - { command: 'check_procs' }
</pre>


Dependencies
------------

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: ansible-role-nrpe }

License
-------

MIT

Author Information
------------------
