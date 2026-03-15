# Ansible Kitty

An Ansible role for managing a Kitty (https://sw.kovidgoyal.net/kitty) installation.


### Requirements

This role requires two separate tools be installed.

First it requires the `ansible.utils` collection be installed from Ansible-Galaxy via:

```bash
ansible-galaxy collection install ansible.utils
```

Secondly it requires the `jsonschema` Python package be installed via:

```bash
pip install jsonschema
```

### Setup

Before the role can be used it needs to be added to the machine running the playbook, and as of writing this, this role is not hosted on Ansible-Galaxy only on Github.

1. Create a `requirements.yml` file in the root directory of the playbook being worked on.

2. Add the following definition inside the `requirements.yml` file:

```yml
- name: hth-kitty
  src: https://github.com/hrafnthor/ansible-kitty.git
  scm: git
```

3. Install the requirements by executing

```shell
ansible-galaxy install -r .requirements.yml
```

This will allow any playbook run from this machine to use the role `hth-kitty`

### Variables

All parameters are optional unless otherwise stated.

```yaml
kitty:
  remove:       [bool]    Indicates that every version, path addition and desktop entry should be removed.
  trim:         [bool]    Indicates that any versions that don't match either 'nightly' (if requested to be present) or the configured 'stable' version, should be removed. Defaults to false.
  default:
    remove:     [bool]    If true will remove the version from the path as well as removing any desktop entry that may exist.
    version:    [string]  [required] The version number to add to path. Can be any value but will fail if the subsequent directory matching this value is not found. Setting it to 'nightly' will attempt to link to the nightly version, while 'latest' will attempt to link to the latest version.
    desktop:              If present, and if [desktop.remove] is missing or false, will add a desktop client entry.
      remove:   [bool]    If true will remove any current desktop entry and not create a new one. Defaults to false.
      force:    [bool]    Indicates if a new desktop entry should be created if a prior one already exists. Icon paths and keywords will still be changed if needed.
      keywords: [array]   List of keywords to add to the desktop entry, making it searchable by them.
  releases:
    - version:  [string]  [required] The version code to install
      checksum: [string]  Optional checksum for the archive.
      remove:   [boolean] Indicates if the version should be removed or not.
```

#### Default variables

`hth_default_kitty_latest_version_url`:

This is the url of the text document containing the latest version as published by the author of Kitty themselves. Is used if either variables [stable.version] or [default.version] are set to  'latest'.

Defaults to `https://sw.kovidgoyal.net/kitty/current-version.txt`.


`hth_default_kitty_linux_installation_path`:

This is the default extraction path for linux versions.

Defaults to `/opt/kitty`.


`hth_default_kitty_linux_symlink_path`:

This is the default path to which the requested default version of `kitty` will be symlinked to.

Defaults to `/usr/bin`.


`hth_default_kitty_linux_desktop_entry_path`:

This is the default path to where desktop entries will be created.

Defaults to `/usr/share/applications`.


`hth_kitty_default_linux_desktop_entry_group`:

This is the default owner of the symlink created to `hth_default_kitty_linux_symlink_path`.

Defaults to `root`.


`hth_kitty_default_linux_symlink_path_group`:

This is the default group owner of the symlink created to `hth_default_kitty_linux_symlink_path`.

Defaults to `root`.


`hth_kitty_default_linux_installation_owner`:

This is the default owner of the symlink created to `hth_default_kitty_linux_installation_path`.

Defaults to `root`.


`hth_kitty_default_linux_installation_group`:

This is the default group owner of the symlink created to `hth_default_kitty_linux_installation_path`.

Defaults to `root`.


`hth_kitty_default_linux_desktop_entry_owner`:

This is the default owner of the symlink created to `hth_default_kitty_linux_desktop_entry_path`.

Defaults to `root`.


`hth_kitty_default_linux_desktop_entry_group`:

This is the default group owner of the symlink created to `hth_default_kitty_linux_desktop_entry_path`.

Defaults to `root`.


`hth_kitty_default_os_linux_architecture_map`:

This is a mapping of supported Linux architectures and their associated Kitty artifacts.

If missing mappings, needs to be added just override this mapping and add the new map next to the present one. For example to add support for armv8 architecture override via:

```yaml
hth_kitty_default_os_linux_architecture_map:
  x86_64: ["x86_64", "amd64"]
  arm64: ["the armv8 architecture you need supported"]
```

Defaults to `x86_64: ["x86_64", "amd64"]`

#### Example

The following example fetches the latest stable version and the nightly version, trims any other versions that might exist afterwards and adds the nightly version to the path as well as creating a desktop entry for kitty.

```yaml
- hosts: all
  vars:
    kitty:
      trim: true
      nightly: true
      stable:
        version: latest
      default:
        version: nightly
        desktop:
          keywords:
            - nightly
  roles:
    - hth-kitty
```

This configuration also fetches the nightly and latest stable versions, trims any stragglers but adds the latest stable version to the path and forcefully adds a desktop entry for kitty.

```yaml
- hosts: all
  vars:
    kitty:
      trim: true
      nightly: true
      stable:
        version: "latest"
      default:
        version: "latest"
        desktop:
          force: true
          keywords:
            - kitty-latest
  roles:
    - hth-kitty
```

This configuration skips fetching the nightly version, fetches stable version "0.43.0" and adds that version to the path. No desktop entry is created.

```yaml
- hosts: all
  vars:
    kitty:
      trim: true
      stable:
        version: "0.43.0"
      default:
        version: "0.43.0"
  roles:
    - hth-kitty
```

## License

```
Copyright 2025 Hrafn Thorvaldsson

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
