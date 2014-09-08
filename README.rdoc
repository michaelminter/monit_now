== README

Installing with yum package manager (Redhat, CentOS, Fedora, etc)
```
yum install monit
```

Installing with apt-get package manager (Debian, Ubuntu, etc)
```
apt-get install monit
```

Installing with Pacman package manager (Arch Linux)
```
pacman -S monit
```

FreeBSD
```
cd /usr/ports/sysutils/monit
make
make install
```

On openSUSE 10.3
```
yast2 -i monit
```

Manual Install
```
wget http://mmonit.com/monit/dist/monit-5.8.1.tar.gz
tar zxvf monit-x.y.z.tar.gz (were x.y.z denotes version numbers)
cd monit-x.y.z
./configure (use ./configure --help to view available options)
make && make install
```

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
