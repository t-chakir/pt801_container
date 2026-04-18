# Cisco Packet Tracer v8.0.1 in a container

## What this Dockerfile does

- Installs required GUI dependencies
- Creates a non-root user `pt`
- Downloads Cisco Packet Tracer 8.0.1
- verifies file integrity using SHA256
- Extracts and installs the package
- Prepares environment for GUI execution

---
## Important: --no-sandbox option

This project uses the `--no-sandbox` option.

Reason:
- When running Cisco Packet Tracer, especially PT Activity tasks, content may not display or function correctly without this flag.

If you do not need PT Activity features or prefer a more secure setup, you can remove the `--no-sandbox` option from the [packettracer](https://github.com/t-chakir/pt801_container/blob/main/packettracer) launch command.

---

## Git clone in PC

```bash
git clone https://github.com:frzifus/docker-pt.git
```

## Use the command only inside the repository

```bash
make build   # creates a docker image packettracer
make run     # starts packettracer
make shell   # opens a shell in the container
make clean   # removes packettracer image
```

---



---

## Requirements

- Docker
- X11 server
- Allow X11 access:
```bash
xhost +local:docker
```
