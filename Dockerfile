FROM debian:13-slim AS base


RUN mkdir /opt/scripts
WORKDIR /opt/scripts/
COPY scripts/helper-functions.sh /opt/scripts


COPY scripts/00-essential.sh /opt/scripts
RUN chmod +x ./00-essential.sh && ./00-essential.sh

COPY scripts/01-development.sh /opt/scripts
RUN chmod +x ./01-development.sh && ./01-development.sh

COPY scripts/02-recon.sh /opt/scripts
RUN chmod +x ./02-recon.sh && ./02-recon.sh

COPY scripts/03-network.sh /opt/scripts
RUN chmod +x ./03-network.sh && ./03-network.sh

COPY scripts/04-exploitation.sh /opt/scripts
RUN chmod +x ./04-exploitation.sh && ./04-exploitation.sh

COPY scripts/05-web.sh /opt/scripts
RUN chmod +x ./05-web.sh && ./05-web.sh

COPY scripts/06-active-directory.sh /opt/scripts
RUN chmod +x ./06-active-directory.sh && ./06-active-directory.sh

COPY scripts/07-c2.sh /opt/scripts
RUN chmod +x ./07-c2.sh && ./07-c2.sh

COPY scripts/08-gui.sh /opt/scripts
RUN chmod +x ./08-gui.sh && ./08-gui.sh

COPY dotfiles /opt/dotfiles

COPY scripts/09-misc.sh /opt/scripts
RUN chmod +x ./09-misc.sh && ./09-misc.sh

COPY scripts/10-custom.sh /opt/scripts
RUN chmod +x ./10-custom.sh && ./10-custom.sh

FROM scratch
COPY --from=base / /
