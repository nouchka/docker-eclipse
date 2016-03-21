#!/bin/bash

sed -i \
    -e "s|\$WAKATIME_KEY|$WAKATIME_KEY|g" \
    /home/developer/.wakatime.cfg

/opt/eclipse/eclipse -nosplash \
  -application org.eclipse.equinox.p2.director \
  -repository http://download.eclipse.org/releases/mars/,http://p2-dev.pdt-extensions.org,http://community.polarion.com/projects/subversive/download/eclipse/5.0/mars-site/,http://elt.googlecode.com/git/update-site,https://raw.githubusercontent.com/wakatime/eclipse-wakatime/master/update-site/,http://dadacoalition.org/yedit \
  -destination /opt/eclipse \
  -installIU com.dubture.symfony.feature.feature.group \
  -installIU com.dubture.composer.feature.feature.group \
  -installIU com.dubture.doctrine.feature.feature.group \
  -installIU com.dubture.twig.feature.feature.group \
  -installIU com.wakatime.eclipse.feature.feature.group \
  -installIU org.dadacoalition.yedit.feature.feature.group \
  -installIU org.polarion.eclipse.team.svn.connector.feature.group \
  -installIU org.polarion.eclipse.team.svn.connector.javahl18.feature.group \
  -installIU org.eclipse.mylin.trac_feature.feature.group \
  -installIU org.eclipse.linuxtools.docker.feature.feature.group \
  -installIU com.google.eclipse.elt.feature.group

rsync -rvz /home/developer/metadata/ /home/developer/workspace/.metadata/

/opt/eclipse/eclipse
