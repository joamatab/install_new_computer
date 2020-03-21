# Supervisor

sudo /etc/supervisor/conf.d/long_script.conf

```
[program:long_script]
command=/usr/local/bin/long.sh
autostart=true
autorestart=true
stderr_logfile=/var/log/long.err.log
stdout_logfile=/var/log/long.out.log
```

Once our configuration file is created and saved, we can inform Supervisor of our new program through the supervisorctl command. First we tell Supervisor to look for any new or changed program configurations in the /etc/supervisor/conf.d directory with:

# VNC service

# Working with `supervisor`

To install `supervisord` and `supervisorctl`:

```
sudo apt install supervisor
```

Main config files is here:

```
/etc/supervisor/supervisord.conf
```

Jobs go here:

```
/etc/supervisor/conf.d/...
```

To let all users run `supervisorctl`, edit `/etc/supervisor/supervisord.conf` like this (just change these sections and leave others alone):

```
...

[supervisorctl]
serverurl=http://127.0.0.1:9001

[inet_http_server]
port=127.0.0.1:9001

...
```

Then make jobs by adding `.conf` files in `/etc/supervisor/conf.d/` like this:

```
[program:myapp]
environment = FLASK_APP="/home/myapp/myapp/myapp/__init__.py",FLASK_DEBUG="0"
directory = /home/myapp/myapp/myapp
user = myapp
stdout_logfile = /home/myapp/stdout.log
stderr_logfile = /home/myapp/stderr.log
command = flask run -p 8002
autostart = true
stopasgroup = true
```

Then run

```
supervisorctl
> status
> add myapp
> update
> start myapp
> stop myapp
```

Git hook (in `/home/myapp/myapp.git/hooks/post-receive`) looks like:

```
#!/bin/sh
GIT_WORK_TREE=/home/myapp/myapp git checkout -f
cd /home/myapp/myapp
python setup.py develop --user
supervisorctl restart myapp
supervisorctl restart rq
```

:::warning
:warning: Remember to `chmod +x` the hook!
:::

## Tips

- I usually `sudo adduser myapp` to make a special user who owns all the code and files for the app.
