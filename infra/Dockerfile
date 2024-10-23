FROM debian:12.7

# Set non-interactive session
RUN export DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install docker-ce -y
RUN apt install gnupg sudo curl -y
RUN mkdir -p /etc/default/grub.d
RUN echo 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT apparmor=0"' | sudo tee /etc/default/grub.d/apparmor.cfg

RUN curl -fsSL https://inverse.ca/downloads/GPG_PUBLIC_KEY | gpg --dearmor -o /etc/apt/keyrings/packetfence.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/packetfence.gpg] http://inverse.ca/downloads/PacketFence/debian/14.1 bookworm bookworm" > \
    /etc/apt/sources.list.d/packetfence.list
RUN apt update 
RUN apt install packetfence -y

## clean apt
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*