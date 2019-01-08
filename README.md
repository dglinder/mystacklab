# mystacklab
A small lab setup using containers to simulate a working CI/CD environment with Ansible, Jenkins, Git, and Artifactory.

## My notes

```
docker stop tower1 ; docker image rm tower
docker-compose build tower && docker-compose up -d tower && docker exec -ti tower1 bash
```

# Phases
As of December 28, 2018.

## Phase 1 - Basic stack
Build out Jenkins, Git, Artifactory, and Ansible AWX/Tower systems

## Phase 2 - Simple "DEV" servers
Build three systems to be a webserver, middle-ware, and database.

## Phase 3 - Example application
Add a very basic application that runs on the dev servers.

## Phase 4 - Build out a Preprod network environment
Build a new network for the Preprod systems, including a "router/firewall" and an Ansible Bastion host.

## Phase 5 - Simple "Preprod" servers
Nearly identical to Phase 2, but on the Preprod network

## Phase 6 - Lifecycle demo
Setup the Git repository to show lifecycle progression (Dev -> Preprod)

## Phase 7 - Build out a "Production" network and populate
Identical to Phase 4 and 5, then extend lifecycle

## Future
 * Setup multiple nodes a loadbalancer within the router/firewall to simulate failover
   * App can pull back colors or hostnames of the systems it hits to show LB and failover.
 * Expand stack systems so they use external DBs (Tower, Artifactory), and increase server count to setup HA/LB 
 
# Installation steps
All:
 * ssh server for remote login
   * Install the Tower "master_key.pub" into authorized_keys

## Ansible AWX
 * AWX
 * Ansible CLI
 * SSH master key (public and private)
 * Local DB
 
## Jenkins
 * Jenkins
   * Ansible Tower plugins
   * Colorize plugin
 * XRay
 * Local DB

## Git
 * Git server

## Artifactory
 * JFrog Artifactory
