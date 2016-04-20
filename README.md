# Quick guide

1. edit set_vars to suit your needs. Really look at them.

2. run bash prepare.sh (inspect, change and save if needed, exit); please note you will at least have to add the SSL key and the enketo api token.

3. docker-compose up -d

4. grab a coffee it will take some time until all images are pulled and containers are started

5. docker exec into kobocat and do:

    bash /srv/init.sh

    bash /srv/sync_static.sh

5. docker exec into dkobo and do:

    bash /srv/init.sh

    bash /srv/sync_static.sh

    bash /srv/create_demo_user.sh -> ONLY FOR DEV / DEMO INSTALLS.

6. docker exec into mongo and do:

    bash /srv/add_index.sh # <- this will add a missing index to mongo db that will greatly improve speed
