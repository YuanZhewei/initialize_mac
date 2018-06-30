#!/bin/sh

install_boost() {
    cd /tmp
    wget https://jaist.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
    tar -zxf boost_1_59_0.tar.gz
    cd boost_1_59_0
    ./bootstrap.sh --prefix=/usr --with-libraries=all --with-toolset=gcc
    ./b2
    sudo ./b2 install
}

install_apt() {
    sudo apt install -y $1
}

install_prerequisite() {
    install_boost

    install_apt bison
    install_apt libncurses5-dev
}

install_mysql() {
    cd z
    git clone https://github.com/mysql/mysql-server.git
    cd mysq-server
    git checkout 5.7
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_DATADIR=/var/mysql/data -DSYSCONFDIR=/etc -DMYSQL_TCP_PORT=3306 -DEXTRA_CHARSETS=all -DMYSQL_USER=_mysql -DDOWNLOAD_BOOST=1 -DWITH_BOOST=system -DWITH_DEBUG=1
    make
    sudo make install
}

initialize_mysql() {
    sudo groupadd mysql
    sudo useradd -r -g mysql -s /bin/false mysql
    mkdir -p /var/mysql/data
    chmod rwx -R /var
    cd /usr/local/mysql
    bin/mysqld --initialize --user=mysql --initialize-insecure
}
