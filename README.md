# ansible-network-starter

## What it is..

* A starter playbook working with network devices. There are a million others out there but none of them really scratched the itch, so we make another...

* the main focus is creating a consistent runtime environment for ansible.

* Any playbook you've got should be able to be dropped in pretty easily.

## What it is not..

* This is not an exercise in Ansible best practices.

* [best practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html) are maintained by ansible and should be followed

* For a slightly more realistic sample playbook that attempts to follow these best practices in a network
context you can checkout the [netdevops-demo](https://github.com/kecorbin/netdevops-demo)


### with all that being said, let's get started..


# Ansible Quickstart

There's nothing really interesting in the playbook per se, we just run a couple show commands and dump their output.  

If your new to ansible, our starter playbook is really simple.  

There are a few components, please spend some time reviewing them and modifying where it makes sense:

* [site.yml](./site.yml) - a.k.a the *playbook* is where we tell ansible what we want to do

* [group_vars](./group_vars) - things we want to be the same over multiple devices.  Just drop a .yml in
here with a group name that you define in your.....

* [host_vars](./host_vars) - host specific vars (ip addresses and such), we didn't use any in our sample, but if you need them, create this folder and drop a .yml with the device name in there.

* [inventory file](./inventory.yml) where we define our devices and any logical groups of devices which we want to execute the playbook against. Here we use YAML, even though there are more samples of .ini styles samples out there.


We've made some opinionated assumptions about configuration, check them out in
[ansible.cfg](./ansible.cfg)


 There are lots of ways to use variables, groups, and inventories, again refer to the
 best practices guides and samples mentioned above.


## Environment Variables

It's likely you'll want to populate some additional information into your playbook
run.  A lot of the networking modules contain some useful defaults that we use, check them out in [env.vars](./env.vars).

If you are executing the playbook locally, you can load them up as such:

```
source env.vars
```

For more information see:
http://docs.ansible.com/ansible/latest/intro_networking.html#networking-environment-variables

You can also pass environment variables directly to your playbook if you'd like
    http://docs.ansible.com/ansible/devel/plugins/lookup/env.html

# Running the playbook

## Local

Make sure you install the proper dependencies, preferably in a virtual environment.

```
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```


If all goes well, you should be able to run

```
ansible-playbook -i inventory.yml site.yml
```


## Docker Usage

Wrapping playbooks up in docker containers provides a lot of benefits as it
isolates our dependencies into a known good runtime environment.

**NOTE:** This assumes you have docker installed on your machine, if you do not they have
great docs on installing docker on various platforms [here](https://docs.docker.com/install/)

To package your playbook up in docker, you can run the following **If you are actively developing
a playbook, you'll need to repeat this step each time you make changes!!**

```
  docker build -t my-awesome-playbook .
```

Now executing your playbook is as simple as

```
  docker run --env-file env.vars my-awesome-playbook
```
**NOTE:** here we are passing the environment to docker via a file, they can also be passed in via command line [(docs)](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file)
