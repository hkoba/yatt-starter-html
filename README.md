
## Build
```sh
podman build -t yatt-starter-test1 -f Dockerfile
```

## Run
```sh
podman run -it -p 8000:80 \
  -v $PWD/yatt.webapp/public:/usr/local/apache2/yatt.webapp/public:O \
  yatt-starter-test1
```

## Open

- <http://0:8000/-/>
  - edit yatt.webapp/public/index.html and reload (by hand;-)

## Debug
```sh
podman exec -it "$(podman ps --noheading --format '{{.ID}}')" bash
```
