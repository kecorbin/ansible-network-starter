FROM ubuntu
# Place stuff that doesn't change much up here
RUN apt-get update && apt-get install -y python python-virtualenv python-pip
ADD ./requirements.txt /ansible/

RUN pip install -r /ansible/requirements.txt

# Add our latest code..
ADD . /ansible

# the files in the main project will be available to you here
# can be overwritten at runtime..
WORKDIR /ansible

# Run our playbook
CMD ansible-playbook -i inventory.yml site.yml
