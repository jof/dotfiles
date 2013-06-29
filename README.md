dotfiles
========

This is a collection of various configuration files I've made for CLI utilities I use.

Included so far:
----------------

* GNU Readline / Editline/libedit
* zsh
* GNU screen
* mutt
* vim
* vimperator
* irb

Usage
-----
Plain text files live under the "homedir_root" directory in the repository
root.

Individual files can be edited or copied from there.

Deployment of files to a newly-setup host is done utilizing the Capistrano utility, and calling the "deploy" task.

First, install Capistrano if it is not present already:

    # For any generic Ruby environment.
    gem install capistrano
    
    # For Debian
    apt-get install capistrano

Then, to deploy to a specific host, call the "deploy" task, while passing in the "hostname" option.

    cap deploy -s hostname=hostname.domain.tld
