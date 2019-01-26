# RubioDeMarzo

AdHoc minimal CMS

## Docker

### Install server basics
    ./server_setup.sh

### Restore backups

Go to S3 to get the backups

    docker exec -i a324c67ea86f mysql -uroot -proot rubiodemarzo < /tmp/hpq.20180629.daily.sql
    mv /tmp/public/paperclip/production/* /var/apps/RubioDeMarzo/public/paperclip/production/

### Redeploy

    ssh root@rubiodemarzo.com
    cd /var/apps/RubioDeMarzo
    git pull
    docker-compose restart app
    docker-compose restart web

### Consoling

    docker-compose exec app bundle exec rails c
    docker-compose exec db mysql -uroot -p hpq
