Cloudmesh Instalation with curl
===============================

We are providing a variety of simple instalation workflows via a get
repositoryy on github.

Currently we maintain two different get systems. Firts we maintain one
for users, and for developers. We will migrate all gets into the
github pages location as it provides a much better url link that is
mor readable.






Get for users (use this)
=========================

This provides a "one-line-install" process for setting up applications
developed by the Cloudmesh organization.

For instance, to install cloudmesh on an Ubuntu/14.04 system, see the
``cloudmesh/ubuntu/14.04.sh`` script. You can run this directly using::

  $ curl https://raw.githubusercontent.com/cloudmesh/get/master/cloudmesh/ubuntu/14.04.sh | bash


System Dependencies
----------------------------------------------------------------------

A list system dependencies that cloudmesh requires are provided in
`cloudmesh/system-dependencies.csv`_.  This provides the name of the
dependency, the appropriate package on systems such as Ubuntu/14.04 or
Fedora 21, etc. Additional script can then use this list as part of
provisioning procedures.




.. _cloudmesh/system-dependencies.csv: https://github.com/cloudmesh/get/blob/dev/cloudmesh/system-dependencies.csv
