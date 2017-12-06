#!/bin/bash

FLAG=/home/developer/.setup

if [ ! -f "$FLAG" ]; then

	sed -i \
	    -e "s|\$WAKATIME_KEY|$WAKATIME_KEY|g" \
	    /home/developer/.wakatime.cfg

	if [ "$ECLIPSE_VERSION" = "mars" ]; then
		/opt/eclipse/eclipse -nosplash \
		  -application org.eclipse.equinox.p2.director \
		  -repository http://www.nodeclipse.org/updates/markdown/,http://download.eclipse.org/releases/$ECLIPSE_VERSION/,http://nodj.github.io/AutoDeriv/update,http://p2.pdt-extensions.org,https://raw.githubusercontent.com/wakatime/eclipse-wakatime/master/update-site/ \
		  -destination /opt/eclipse \
		  -installIU markdown.editor.feature.feature.group \
		  -installIU net.nodj.AutoDerivFeature.feature.group \
		  -installIU com.wakatime.eclipse.feature.feature.group \
		  -installIU org.eclipse.tm.terminal.feature.feature.group
	else
		/opt/eclipse/eclipse -nosplash \
		  -application org.eclipse.equinox.p2.director \
		  -repository http://www.nodeclipse.org/updates/markdown/,http://download.eclipse.org/releases/$ECLIPSE_VERSION/,http://nodj.github.io/AutoDeriv/update,http://p2.pdt-extensions.org,https://raw.git$
		  -destination /opt/eclipse \
		  -installIU markdown.editor.feature.feature.group \
		  -installIU net.nodj.AutoDerivFeature.feature.group \
		  -installIU com.dubture.symfony.feature.feature.group \
		  -installIU com.dubture.doctrine.feature.feature.group \
		  -installIU com.dubture.twig.feature.feature.group \
		  -installIU com.wakatime.eclipse.feature.feature.group \
		  -installIU org.eclipse.tm.terminal.feature.feature.group
	fi

	rsync -rvz /home/developer/metadata/ /home/developer/workspace/.metadata/

	touch $FLAG
fi

/opt/eclipse/eclipse
