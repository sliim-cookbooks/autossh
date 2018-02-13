autossh Cookbook
================

Configure autossh service from attributes or LWRP.

[![Cookbook Version](https://img.shields.io/cookbook/v/autossh.svg)](https://supermarket.chef.io/cookbooks/autossh) [![Build Status](https://travis-ci.org/sliim-cookbooks/autossh.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/autossh) 

Requirements
------------

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 8`

Attributes
----------
#### autossh::services

|  Key        | Type |  Description                              |
| ----------- | ---- | ----------------------------------------- |
| `[autossh]` | Hash | Hash of autossh services to deploy: `{}`) |

Usage
-----
#### autossh::default
Include `autossh` in your node's `run_list` to install autossh package:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[autossh]"
  ]
}
```

#### autossh::services
Include `autossh::services` in your node's `run_list` to deploy autossh services:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[autossh]",
    "recipe[autossh::services]"
  ],
  "attributes": {
    "autossh": {
      "kitchen": {
        "ssh_host": "localhost",
        "lport": 42,
        "rport": 22,
        "luser": "kitchen",
        "ruser": "kitchen"
      }
    }
  }
}
```

#### Custom resources

##### autossh_service
This LWRP can be used to deploy autossh services.

###### Actions
|  Action   |  Description                            |
| --------- | --------------------------------------- |
| `:create` | Create an autossh service               |
| `:delete` | Disable service and delete systemd file |

###### Attributes
| Attribute |  Type   |  Description                      |
| --------- | ------- | --------------------------------- |
| `bin`     | String  | Path to `autossh`                 |
| `flags`   | String  | Flags to pass to autossh command  |
| `ssh_host`| String  | SSH host to connect               |
| `ssh_port`| Integer | SSH port to connect               |
| `bind`    | String  | Bind address on remote host       |
| `lport`   | Integer | Local port of the reverse ssh     |
| `rport`   | Integer | Remote port of the reverse ssh    |
| `luser`   | String  | Local user to connect to the host |
| `ruser`   | String  | Remote user to connect to         |


###### Example
```ruby
autossh_service 'kitchen' do
  ssh_host 'localhost'
  lport 42
  rport 22
  luser 'kitchen'
  ruser 'kitchen'
end
```

Testing
-------
See [TESTING.md](TESTING.md)

Contributing
------------
See [CONTRIBUTING.md](CONTRIBUTING.md)

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
