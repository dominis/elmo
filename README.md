# elmo

Elmo is the vagrant box for testing puppet.

![Elmo](http://25.media.tumblr.com/tumblr_m8eyxrYbdl1r9qaqpo1_400.gif)

## How it works
Elmo starts two virtual machines a puppet master and a client. The master mounts the puppet stuff under /etc/puppet and serve the manifests for the client. You don't have to evaluate your changes on the live infrastructure any more.

## Requirements
* VirtualBox
* Vagrant

## Quick start

### First boot
```
cd your-puppet-dir
git clone https://github.com/dominis/elmo.git
cd elmo
echo -ne 'testnode.your-domain.tld' > puppet-node
vagrant up
```

![HAPPY](http://i.imgur.com/72hJaMH.gif)

At this point the two vm's booting up and setting up a minimal puppet master-client env.

### Running puppet on the node
```
vagrant ssh node
sudo puppet agent -tv
```

## Building another node
```
vagrant destroy node -f
echo -ne 'another-node.your-domain.tld' > puppet-node
vagrant up
```
