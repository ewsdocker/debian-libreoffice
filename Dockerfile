# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Libre Office in a Debian docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 1.1.2
# @copyright © 2017, 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package debian-libreoffice
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017, 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-libreoffice.
#
#   ewsdocker/debian-libreoffice is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-libreoffice is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-libreoffice.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
FROM ewsdocker/debian-openjre:0.1.0

MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================
#
#     The following must be modified before running a build,
#         as there is no way to specify them in the build 
#         command.
#
# =========================================================================
ENV OFFICE_VER=6.0.4 
ENV OFFICE_REL=6.0

# =========================================================================
#
# LibreOffice ${OFFICE_VER} for Debian 9 is available from the 
#    LibreOffice download site:
#
# http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/${OFFICE_VER}/deb/x86_64/LibreOffice_${OFFICE_VER}_Linux_x86-64_deb.tar.gz
#
#    HOST: http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/${OFFICE_VER}/deb/x86_64/
#
#    PKG:  LibreOffice_${OFFICE_VER}_Linux_x86-64_deb.tar.gz
#    DIR:  LibreOffice_${OFFICE_VER}.2_Linux_x86-64_deb
#
# DIR can be determined at the LibreOffice download site or 
#     from inspecting the tarfile (tar -t): it occurs between
#     'libreoffice' and 'DEBS' in the installation directory path
#
# =========================================================================
#
#     help pack for US-en:
# http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/6.0.4/deb/x86_64/LibreOffice_6.0.4_Linux_x86-64_deb_helppack_en-US.tar.gz
#
#    HLP_TAR:  LibreOffice_${OFFICE_VER}_Linux_x86-64_deb_helppack_en-US.tar.gz
#    HLP_PKG:  libobasis${OFFICE_REL}-en-us-help_${OFFICE_VER}.2-2_amd64.deb
#    HLP_DIR:  LibreOffice_${OFFICE_VER}.2_Linux_x86-64_deb_helppack_en-US
#
# =========================================================================

#ENV OFFICE_HOST=http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/${OFFICE_VER}/deb/x86_64
ENV OFFICE_HOST=http://pkgnginx

ENV OFFICE_PKG=LibreOffice_${OFFICE_VER}_Linux_x86-64_deb.tar.gz 
ENV OFFICE_DIR=LibreOffice_${OFFICE_VER}.2_Linux_x86-64_deb 
ENV OFFICE_URL=${OFFICE_HOST}/${OFFICE_PKG} 

ENV HLP_PKG=libobasis${OFFICE_REL}-en-us-help_${OFFICE_VER}.2-2_amd64.deb

ENV HLP_TAR="LibreOffice_${OFFICE_VER}_Linux_x86-64_deb_helppack_en-US.tar.gz"
ENV HLP_DIR="LibreOffice_${OFFICE_VER}.2_Linux_x86-64_deb_helppack_en-US"
ENV HLP_URL="${OFFICE_HOST}/${HLP_TAR}" 

ENV LMSBUILD_VERSION="1.1.2" 
ENV LMSBUILD_NAME="debian-libreoffice" 
ENV LMSBUILD_DOCKER="ewsdocker/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="debian-openjre:2.1.0, LibreOffice v ${OFFICE_VER}"

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && mkdir -p /usr/local/share/libreoffice \
 && cd /usr/local/share/libreoffice \
 && wget ${OFFICE_URL} \ 
 && wget ${HLP_URL} \
 && tar fxvz ${OFFICE_PKG} \
 && dpkg -i /usr/local/share/libreoffice/${OFFICE_DIR}/DEBS/*.deb \
 && tar fxvz ${HLP_TAR} \
 && dpkg -i /usr/local/share/libreoffice/${HLP_DIR}/DEBS/*.deb \
 && rm -R /usr/local/share/libreoffice \
 && apt-get clean all \
 && ln -s /opt/libreoffice${OFFICE_REL}/program/soffice /usr/bin/libreoffice \ 
 && PATH=$PATH:/opt/libreoffice${OFFICE_VER}/program \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt 

# =========================================================================

COPY scripts/. /

# =========================================================================

VOLUME /documents

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["/usr/bin/libreoffice"]
