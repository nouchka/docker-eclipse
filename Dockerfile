FROM debian:jessie
MAINTAINER Jean-Avit Promis "docker@katagena.com"

##TODO remove curl or wget
##wget && curl to DL
##jdk for eclipse
##php5 php5-cli php5-xdebug for php dev
##git svn for team
##libcanberra-gtk3-module for graph
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install wget openjdk-7-jdk php5 php5-cli php5-xdebug git subversion libcanberra-gtk3-module curl lintian fakeroot ssh-askpass openssh-client rsync && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://mirror.ibcp.fr/pub/eclipse//technology/epp/downloads/release/mars/1/eclipse-php-mars-1-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

RUN wget http://get.sensiolabs.org/php-cs-fixer.phar -O php-cs-fixer && \
	chmod a+x php-cs-fixer && \
	mv php-cs-fixer /usr/local/bin/php-cs-fixer
	
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN php /usr/local/bin/composer self-update


RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/developer

COPY home/.wakatime.cfg /home/developer/.wakatime.cfg
COPY configuration/ /opt/eclipse/configuration/
COPY metadata/ /home/developer/metadata/

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh
RUN chown developer: /launch.sh
RUN chown -R developer: /home/developer/.wakatime.cfg
RUN chown -R developer: /opt/eclipse/
RUN chown -R developer: /home/developer/metadata/

USER developer
ENV HOME /home/developer

CMD /launch.sh
