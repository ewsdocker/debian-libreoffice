# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Libre Office 5.4.3 
#		in a Debian 9.2 (Stretch) docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 2.0.1
# @copyright © 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package debian-libreoffice
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#		http://opensource.org/licenses/academic.php
#
# =========================================================================
# =========================================================================
FROM debian-openjre:8
MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================
#
#     The following must be modified before running a build,
#         as there is no way to specify them in the build 
#         command.
#
# =========================================================================

#ENV OFFICE_HOST=http://172.17.0.2
#ENV OFFICE_PKG=LibreOffice_5.4.3_Linux_x86-64_deb.tar.gz
#ENV OFFICE_DIR=LibreOffice_5.4.3.2_Linux_x86-64_deb

# http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/5.4.4/deb/x86_64/LibreOffice_5.4.4_Linux_x86-64_deb.tar.gz

ENV OFFICE_HOST=http://mirror.switch.ch
ENV OFFICE_PKG=LibreOffice_5.4.3_Linux_x86-64_deb.tar.gz
ENV OFFICE_DIR=LibreOffice_5.4.3.2_Linux_x86-64_deb

ENV OFFICE_URL=http://${OFFICE_HOST}/${OFFICE_PKG}

# =========================================================================

RUN mkdir -p /usr/local/share/LibreOffice \
 && wget -qO- ${OFFICE_URL} | tar xvz -C /usr/local/share/LibreOffice \
 && dpkg -i /usr/local/share/LibreOffice/${OFFICE_DIR}/DEBS/*.deb \
 && apt-get -y update \
 && apt-get -y upgrade  \
 && apt-get install -y --no-install-recommends \
            fonts-opensymbol \
            hyphen-en-us \
            mythes-en-us \
            openclipart \
            openclipart-libreoffice \
            openclipart-png \
            openclipart-svg \
 && apt-get clean all \
 && rm -R /usr/local/share/LibreOffice
 
# =========================================================================

VOLUME /documents
VOLUME /home/user

# =========================================================================

ENTRYPOINT ["/my_init"]
CMD ["/usr/bin/libreoffice5.4"]
