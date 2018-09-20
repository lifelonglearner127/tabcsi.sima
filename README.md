# TABC: CR (Compliance Reporting)

## Former Names

* Retail Compliance Reporting (RCR)
* Self Inspection (SI)
* Audit

## Dependencies

### General

* Ruby 2.5.1
* Node 8 (LTS)
* Yarn

### Development

* [Overmind](https://github.com/DarthSim/overmind)

## Development

### Getting Set Up

    > bundle install
    > yarn install
    > bin/rails db:setup
    > bin/rails admin:load_settings
    > bin/rails admin:data_feed
    > bin/rails admin:build_forms
    > cp .env.example .env

Edit `.env` file as necessary.

### Developing

    > yarn start

This will start the Rails and Webpack servers through Overmind.

## Deployment

This project uses Capistrano for deployment. Capistrano makes deployment easy
and straight-forward.

Deployment has two stages: `sandbox` and `production`. A stage is a target
server.
    
### Server Requirements

A target server (stage) must be setup before the `deploy` action may be used.
The following items must be setup for the `deploy` action to succeed.

1. Create the `deploy` user.
   ```bash
   # root@remote
   adduser tabcsi
   passwd -l tabcsi
   ```

2. Add developer SSH keys to `tabcsi`'s `authorized_keys` file.
   ```bash
   # root@remote
   su - tabcsi

   # tabcsi@remote
   # create directory and file
   mkdir ~/.ssh
   touch ~/.ssh/authorized_keys
   chmod 0700 ~/.ssh
   chmod 0600 ~/.ssh/authorized_keys

   # add key to file
   echo '<ssh_access_key>' >> ~/.ssh/authorized_keys
   ```

3. Install project SSH "Deploy Key" for GitHub access.
   ```bash
   # dev@local
   cd /path/to/project
   scp repo/ssh/* tabcsi@remote:/home/tabcsi/.ssh
   ssh tabcsi@remote chmod 0600 /home/tabcsi/.ssh/*
   ```

4. Install necessary software on server and configure accordingly.
   * Git
   * Nginx
   * RVM
   * Ruby
     ```bash
     # root@remote
     rvm install 2.5.1
     ```
     
   * Bundler
     ```bash
     # root@remote
     rvm use 2.5.1
     gem install -N bundler
     ```
     
   * Passenger >= 4.0.31 (for `passenger-config restart-app`)
     ```bash
     # root@remote
     rvm use 2.5.1
     gem install -N passenger
     passenger-config validate-install
     ```
   
   * Node
     ```bash
     # root@remote
     curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
     yum -y install nodejs
     ```

   * Yarn
     ```bash
     # root@remote
     curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
     yum -y install yarn
     ```

5. Create deployment directory.
   ```bash
   # root@remote
   mkdir -p /srv/www/rails/tabc-si/shared/config
   chown -R tabcsi: /srv/www/rails/tabc-si
   ```

6. Add config template files and edit accordingly.
   ```bash
   # dev@local
   cd /path/to/project
   scp config/master.key tabcsi@remote:/srv/www/rails/tabc-si/shared/config/master.key
   scp .env.example tabcsi@remote:/srv/www/rails/tabc-si/shared/.env
   # Then ssh in and edit the .env file.
   ```

### Deploy

```bash
# dev@local
# <stage> = sandbox|production
# quotes are optional
bin/deploy '<stage>'
```
