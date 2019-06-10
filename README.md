# Zero down time demo

A basic php app to show multiple instances running, and a zero downtime app update.

Uses phpinfo to show hostname, VCAP variables, app name, and so on.

Each version has a different app name, and a different header at the top of the html page, to help with identification.

## Monitor your app url

```sh
./uptime-scripts/monitor.sh http://myapp.local.pcfdev.io
```
Or for PWS:-
```sh
./uptime-scripts/monitor.sh http://myapp.cfapps.io
```


## CF command steps

To DELIBERATELY show app downtime on update:-

```sh
cd phpinfo-v1
cf push myapp

cd ../phpinfo-v2
cf push myapp
```

Ye olde fashioned (manual) way, with canary step:-

```sh
cd phpinfo-v1
cf push myapp
cf scale -i 3 myapp

cd ../phpinfo-v2
cf push myapp-v2

cf map-route myapp-v2 local.pcfdev.io --hostname myapp

cf scale -i 3 myapp-v2
cf apps

cf scale -i 0 myapp
cf apps

cf delete myapp
cf apps

cf unmap-route myapp-v2 local.pcfdev.io --hostname myapp-v2
cf apps
```

The new V3 way (Works on PWS with CLI v6.45):-

```sh
cd phpinfo-v1
cf v3-create-app myapp
cf v3-push myapp
cf apps

cd ../phpinfo-v2
cf v3-zdt-push myapp
cf apps

```

## Licensing and Copyright

Code licensed under Apache 2. Copyright Pivotal All Rights Reserved.

## Support statement

This is demo ware and not supported for production uses.
