# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Libre Office 6.0.3.2 
#		in a Debian 9.4 (Stretch) docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 1.0.4
# @copyright © 2017, 2018. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package debian-libreoffice
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017, 2018. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#		http://opensource.org/licenses/academic.php
#
# =========================================================================
# =========================================================================
FROM earthwalksoftware/debian-base-gui:latest

MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================
#
#     The following must be modified before running a build,
#         as there is no way to specify them in the build 
#         command.
#
# =========================================================================
ENV OFFICE_VER=6.0.3

# =========================================================================
#
# LibreOffice ${OFFICE_VER} for Debian 9 is available from the 
#    LibreOffice download site:
#
# http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/${OFFICE_VER}/deb/x86_64/LibreOffice_${OFFICE_VER}_Linux_x86-64_deb.tar.gz
#
#    HOST: http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/${OFFICE_VER}/deb/x86_64/
#    PKG:  LibreOffice_${OFFICE_VER}_Linux_x86-64_deb.tar.gz
#    DIR:  LibreOffice_${OFFICE_VER}.2_Linux_x86-64_deb
#
# DIR can be determined at the LibreOffice download site or 
#     from inspecting the tarfile (tar -t): it occurs between
#     'libreoffice' and 'DEBS' in the installation directory path
#
# =========================================================================
#ENV OFFICE_HOST=http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/${OFFICE_VER}/deb/x86_64
ENV OFFICE_HOST=http://pkgnginx

# =========================================================================

ENV OFFICE_PKG=LibreOffice_${OFFICE_VER}_Linux_x86-64_deb.tar.gz
ENV OFFICE_DIR=LibreOffice_${OFFICE_VER}.2_Linux_x86-64_deb

ENV OFFICE_URL=${OFFICE_HOST}/${OFFICE_PKG}

# =========================================================================

COPY scripts/. /

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade  \
 && apt-get install -y --no-install-recommends \
            openjdk-8-jre \
 && mkdir -p /usr/local/share/libreoffice \
 && wget -qO- ${OFFICE_URL} | tar xvz -C /usr/local/share/libreoffice \
 && dpkg -i /usr/local/share/libreoffice/${OFFICE_DIR}/DEBS/*.deb \
 && rm -R /usr/local/share/libreoffice/${OFFICE_DIR} \
 && apt-get clean all \
 && PATH=$PATH:/opt/libreoffice${OFFICE_VER}/program

# =========================================================================

VOLUME /documents

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["/usr/bin/libreoffice6.0"]