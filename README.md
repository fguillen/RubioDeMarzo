# RubioDeMarzo

AdHoc minimal CMS

## Docker

### Install server basics
    ./server_setup.sh

### Restore backups

Go to S3 to get the backups

    docker exec -i a324c67ea86f mysql -uroot -proot rubiodemarzo < /tmp/hpq.20180629.daily.sql
    mv /tmp/public/paperclip/production/* /var/apps/RubioDeMarzo/public/paperclip/production/

### Activate SweetyBacky

    vim /root/secret/.s3.passwd # set the S3 credentials
    chmod -R 600 /root/secret/
    apt-get install ruby-all-dev build-essential zlib1g-dev mysql-client
    gem install "sweety_backy"
    crontab -l | { cat; echo "50 22 * * * /bin/bash -l -c '/usr/local/bin/sweety_backy /var/apps/RubioDeMarzo/config/sweety_backy.conf >> /tmp/sweety_backy.RubioDeMarzo.log 2>&1'"; } | crontab -


### Redeploy

    ssh root@rubiodemarzo.com
    cd /var/apps/RubioDeMarzo
    git pull
    docker-compose restart app
    docker-compose restart web

### Consoling

    docker-compose exec app bundle exec rails c
    docker-compose exec db mysql -uroot -p hpq
