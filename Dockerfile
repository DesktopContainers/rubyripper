FROM desktopcontainers/base-mate

MAINTAINER MarvAmBass (https://github.com/DesktopContainers)

ENV rubyripper_version 0.6.2

RUN apt-get -q -y update && \
    apt-get -q -y install wget \
                          make \
                          cd-discid \
                          cdparanoia \
                          cdrdao \
                          flac \
                          lame \
                          easymp3gain-gtk \
                          normalize-audio \
                          ruby-gnome2 \
                          ruby-gettext \
                          ruby \
                          sox \
                          vorbisgain \
                          libcanberra-gtk-module && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/rubyripper/rubyripper-$rubyripper_version.tar.bz2"; \
    tar xvf rubyripper-*.tar.bz2; \
    mv rubyripper*/ rubyripper; \
    cd /rubyripper/ && \
    sed -i "s,require 'gtk2',#require 'gtk2',g" configure; \
    ./configure --enable-gtk2 --enable-cli && \
    make install && \
    echo "#!/bin/bash\nrrip_gui \$*\n" > /bin/ssh-app.sh

RUN mkdir -p /home/app/.config/rubyripper /rips
ADD settings /home/app/.config/rubyripper/settings
RUN chown app.app -R /home/app/.config/rubyripper /rips && \
    usermod -aG cdrom app

VOLUME ["/rips"]
