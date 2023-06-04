### References:
- https://douglocks.blog/posts/20220821-terraform-and-bind/
- https://github.com/ChristianLempa/videos/tree/main/bind9-terraform-tutorial
- https://medium.com/nagoya-foundation/running-a-dns-server-in-docker-61cc2003e899
- https://datatracker.ietf.org/doc/rfc8945/

### Commands
tsig-keygen -a hmac-sha256
include "<path-to-tsig.key>";