```sh
podman build -t yatt-starter-test1 -f Dockerfile
```

```sh
podman run -it -p 8000:80 -v $PWD/public:/usr/local/apache2/yatt.webapp/public:O yatt-starter-test1
```

<http://0:8000/-/>

```sh
podman exec -it "$(podman ps --noheading --format '{{.ID}}')" bash
```
