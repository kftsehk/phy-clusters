
## Management

### Install base packages
Base packages should
- have general interest, and 
- should have tested in user environment

`conda install <package_name>`
### Updating conda
Update
`conda update --all`

## Install

https://conda.io/docs/user-guide/install/download.html

Considerations for cluster environment
- Conda on each computing node should be identical
- User's conda environment must be on NFS
- Conda can be conveniently triggered by linking to `/etc/profile.d`

Recommended installation route
- Install conda in NFS's app directory
- Linking init script `conda.sh and conda.csh` to `/etc/profile.d` for all nodes