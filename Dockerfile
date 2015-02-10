FROM ubuntu:trusty
MAINTAINER Nick Østergaard <oe.nick@gmail.com>

ENV TEMPDIR   /tmp

RUN apt-get -qq update
RUN apt-get install -qqy software-properties-common
RUN add-apt-repository ppa:adamwolf/kicad-trusty-backports
RUN apt-get -qq update
RUN apt-get install -qqy mingw-w64 g++-mingw-w64 git-core make wget cmake swig
RUN apt-get install -qqy build-essential checkinstall cmake doxygen zlib1g-dev libwebkitgtk-dev
RUN apt-get install -qqy libglew-dev libcairo2-dev libbz2-dev libssl-dev libwxgtk-webview3.0-dev
RUN wx-config --version
RUN echo "==========================="
#ssh_config
#RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
#RUN echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

WORKDIR /build

ADD Toolchain-cross-mingw32-linux.cmake /build/Toolchain-cross-mingw32-linux.cmake

RUN mkdir /build/mingw
RUN mkdir /build/w32
RUN mkdir /build/w64


#build =============> 64bit
ENV HOST x86_64-w64-mingw32
ENV ARCH w64
ENV CROSSPREFIX x86_64-w64-mingw32-

#compile leveldb
RUN { \
  cd /build && pwd \
	&& echo "64bit";\
}

#build =============> 32bit
ENV HOST i686-w64-mingw32
ENV ARCH w32
ENV CROSSPREFIX i686-w64-mingw32-

#compile leveldb
RUN { \
  cd /build && pwd \
  && echo "32bit";\
}


WORKDIR /build/workdir

ADD compile.sh /compile.sh
