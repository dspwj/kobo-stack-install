# copyleft 2015 teodorescu.serban@gmail.com

1. edit set_vars to suit your needs. Really look at them.

2. run bash prepare.sh (inspect, change and save if needed, exit)

3. docker-compose up -d

4. grab a coffee it will take some time until all images are pulled and containers are started

5. docker exec into kobocat and do:

    bash init.sh  -> ONLY ON NEW INSTALLS!

    bash sync_static.sh

5. docker exec into dkobo and do:

    bash init.sh -> ONLY ON NEW INSTALLS!

    bash sync_static.sh

    bash create_demo_user.sh -> ONLY FOR DEV / DEMO INSTALLS.


