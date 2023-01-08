#!/usr/bin/env bash

echo 'Start!'

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

cd /vagrant

sudo apt-get update
sudo apt-get install tree

# if ! [ -e /vagrant/mysql-apt-config_0.8.15-1_all.deb ]; then
# 	wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
# fi

# sudo dpkg -i mysql-apt-config_0.8.15-1_all.deb
# sudo DEBIAN_FRONTEND=noninteractivate apt-get install -y mysql-server
# sudo apt-get install -y libmysqlclient-dev

# 安装配置 PostgresSQL https://www.postgresql.org/download/linux/ubuntu/
# Create the file repository configuration:
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the repository signing key:
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update the package lists:
sudo apt-get update

# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
sudo apt-get -y install postgresql

if [ ! -f "/usr/bin/pip" ]; then
  sudo apt-get install -y python3-pip
  sudo apt-get install -y python-setuptools
  sudo ln -s /usr/bin/pip3 /usr/bin/pip
else
  echo "pip3 已安装"
fi

# 升级pip，目前存在问题，read timed out，看脸，有时候可以，但大多时候不行
# python -m pip install --upgrade pip
# 换源完美解决
# 安装pip所需依赖
pip install --upgrade setuptools -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install --ignore-installed wrapt -i https://pypi.tuna.tsinghua.edu.cn/simple
# 安装pip最新版
pip install -U pip -i https://pypi.tuna.tsinghua.edu.cn/simple
# 根据 requirements.txt 里的记录安装 pip package，确保所有版本之间的兼容性
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple


# 设置mysql的root账户的密码为yourpassword
# 创建名为twitter的数据库
# sudo mysql -u root << EOF
# 	ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'yourpassword';
# 	flush privileges;
# 	show databases;
# 	CREATE DATABASE IF NOT EXISTS twitter;
# EOF

# for psycopg2
sudo apt-get install -y libpq-dev build-essential

# postgres user and db
sudo -u postgres createuser root
sudo -u postgres createdb twitter
sudo -u postgres psql -c "ALTER role root WITH PASSWORD 'yourpassword'"
# fi


# 如果想直接进入/vagrant路径下
# 请输入vagrant ssh命令进入
# 手动输入
# 输入ls -a
# 输入 vi .bashrc
# 在最下面，添加cd /vagrant

echo 'All Done!'