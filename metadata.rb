# -*- coding: utf-8 -*-

name 'autossh'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache-2.0'
description 'Deploy autossh services'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.0'
chef_version '>= 12.0' if respond_to?(:chef_version)

recipe 'autossh::default', 'Install autossh package'
recipe 'autossh::services', 'Deploy autossh services from attributes'

supports 'debian', '> 7.0'
supports 'ubuntu', '> 12.04'

source_url 'https://github.com/sliim-cookbooks/autossh' if
  respond_to?(:source_url)
issues_url 'https://github.com/sliim-cookbooks/autossh/issues' if
  respond_to?(:issues_url)
