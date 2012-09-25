Falcon-V0.1
===========

Member Signup

## Development notes

I've added configs to .gitignore to make it possible to configure it individually. You can copy examples configs
from config/configs directory and modify it if you want.

Use following commands to start project first time:

```
bundle install
rake configs:copy
rake db:create
rake db:migrate
rails s
```

## Dev box setup

```
sudo apt-get install mysql-server libmysqlclient16-dev mysql-client
libmysql-ruby libmysqlclient-dev libqt4-dev libqtwebkit-dev
imagemagick libmagickwand-dev

bundle install
bundle package
```
( the last step vendorizes the Ruby gems )
