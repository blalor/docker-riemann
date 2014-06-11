# docker-riemann

[Riemann](http://riemann.io) in a Docker container, just like it says on the label.

## ports

* `5555/tcp` -- tcp-server
* `5555/udp` -- udp-server
* `5556/tcp` -- ws-server

## config and reloading

Riemann config entry point is `/etc/riemann/riemann.conf`.  The basic config is
basically worthless.

`[incrond](http://inotify.aiken.cz/?section=incron&page=about&lang=en)` watches
for changes to the main config file and whatever is in `/etc/riemann/conf.d` and
triggers a reload of Riemann.  In theory, all you need to focus on is writing
your config.  Mount your own config at `/etc/riemann` (ensuring the entry point
is the same, at *least*) and you should be good to go.  `incrond` uses inotify
to watch files; I don't know how or if this is going to work with Docker bind
mounts.  My limited testing was mixed.
