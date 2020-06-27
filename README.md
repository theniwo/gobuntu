# Gobuntu


Not for you, just for me ;=)\
Really. It's just ubuntu with fail2ban and some other tools for testing.

## Installed Software / Tools
bash-completion, byobu, cron, curl, fail2ban, inetutils, iproute2, less, locales, locate, lsb_release, net-tools, ntp, openssh-server, screen, sudo, traceroute, tzdata, unattended-upgrades, vim, whois

## Usage
```
docker run -d \
        --name gobuntu \
        --hostname gobuntu \
        --restart unless-stopped \
        --memory "128M" \
        --cap-add=NET_ADMIN \
        --cap-add=NET_RAW \
        -e TZ=America/New_York \
        -e LANG=en_US.UTF-8 \
        -e LANGUAGE=en_US.UTF-8 \
        -p 2222:22 \
        -v gobuntu_data:/root \
        theniwo/gobuntu:latest
```
*Info*
- Set the amount of ram to your liking. (128 MB - 256 MB should be plenty)
- The capacities NET_ADMIN and NET_RAW are needed for fail2ban to work properly
- Set your timezone and localisation in the variables TZ and LANG and LANGUAGE respectively.
- Of course you can change the port, too

## Connect

### Per ssh
`ssh root@localhost -p 2222`\
or \
`ssh root@$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gobuntu)`


#### Password
`toor`

(There is also a user `user` with the password `userpw`)

### With docker directly

`docker exec -it gobuntu bash`

---
**NOTES**
<!---
<pre>
Scrolltext
</pre>
-->

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Infobox_info_icon.svg/1200px-Infobox_info_icon.svg.png" alt="drawing" width="20"/>

The latest version will be updated regularly. \
The 18.04 will be left untouched. \
Additionally there is the unminimized version, that includes most common tools like man etc. \
that will not be updated regularly either.

**TODO**

Actually nothing.

**CONTACT**

[disp@mailbox.org](mailto:disp@mailbox.org)

