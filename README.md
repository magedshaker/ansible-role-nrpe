ansible-role-nrpe
=========

Installs and configures NRPE / opsview-agent

 - Templates in a file that changes allowed_hosts of nrpe.cfg
 - Templates in a file that has custom nrpe/opsview checks
  - Which checks are configured are controlled via two variables

Requirements
------------


Role Variables
--------------

See defaults/main.yml for a complete listing.

These are the two primary settings:
<pre>
install_opsview: True
install_nrpe: False
</pre>

install_opsview assumes that the server's yum is configured to talk to a repository that has the opsview-agent rpm.

nagios_plugins:

opsview_plugins:

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

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
