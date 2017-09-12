yum install -y epel-release
yum install -y python-devel libffi-devel openssl-devel gcc python-setuptools git python-pip
git clone https://github.com/openstack/kolla.git
curl -sSL https://get.docker.io | bash
pip install -U tox
pip install kolla/
cd kolla/
pip install -r requirements.txt -r test-requirements.txt
tox -e genconfig
systemctl daemon-reload
systemctl enable docker
systemctl start docker
