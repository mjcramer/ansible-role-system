System Ansible Role
===================
[![Build Status](https://travis-ci.org/mjcramer/ansible-role-system.svg?branch=master)](https://travis-ci.org/mjcramer/ansible-role-system) 
[![Ansible Galaxy](https://img.shields.io/badge/ansible--galaxy-mjcramer.system-green.svg)](https://galaxy.ansible.com/mjcramer/system/) 

An ansible role for system service handlers and configuring logging

Requirements
------------

First, it's a good idea to create a python virtual environment to isolate these dependencies from the rest of the system.
```bash
cd ansible-role-system
virtualenv .
. ./bin/activate.fish # or just ./bin/activate if you use a lame shell
pip3 install -r requirements.txt
gcloud components update 
```


Role Variables
--------------
There are no variables for this role.

Dependencies
------------
There are no dependencies for this role

Tags
----
- require
- apply
- configure
- initialize
- check

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
- hosts: servers
  roles:
    - role: mjcramer.system
```

License
-------

Unlicensed

Author Information
------------------

[Michael Cramer](http://michael.cramer.name), *michael@cramer.name* [_mjcramer_](http://github.com/mjcramer)
