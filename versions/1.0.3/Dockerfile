# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Libre Office 5.4.4.2-2 
#		in a Debian 9.3 (Stretch) docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 1.0.3
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

# =========================================================================
#
# LibreOffice 5.4.4-2 for Debian 9 is available from the 
#    LibreOffice download site:
#
# http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/5.4.4/deb/x86_64/LibreOffice_5.4.4_Linux_x86-64_deb.tar.gz
#
#    HOST: http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/5.4.4/deb/x86_64/
#    PKG:  LibreOffice_5.4.4_Linux_x86-64_deb.tar.gz
#    DIR:  LibreOffice_5.4.4.2_Linux_x86-64_deb 
#
# DIR can be determined at the LibreOffice download site or 
#     from inspecting the tarfile (tar -t): it occurs between
#     'libreoffice' and 'DEBS' in the installation directory path
#
# =========================================================================
#
# The host at 172.17.0.2 is a local ngnix server on a private, internal network
#   which hosts various packages which must be downloaded from a non-repository
#   during installation.
#
# NOTE: these release packages provided by Libre Office contain the complete 
#       Libre Office release and tend to be fairly large. Therefore, if building 
#       this image multiple times, the package should be downloaded once and 
#       accessed localy if it is possible locally, rather than imposing a rather 
#       large load on the internet server(s).
#
#       For one possible solution, refer to the 
#
#          EarthWalkSoftware/alpine-pkgngnix 
#
#       project
#
# =========================================================================
#
# If there are problems building the image with the wget command 
#   in the run script below, perform the following:
#
#   replace the following line in the script
#
#      && wget -qO- ${OFFICE_URL} | tar xvz -C /usr/local/share/libreoffice \
#
#   with the following lines
#
#      && wget -q ${OFFICE_URL} -O tar xvf /usr/local/share/libreoffice/${OFFICE_PKG} \
#      && cd /usr/local/share/libreoffice \
#      && tar -xvf ${OFFICE_PKG} \
#
#   and repeat the build (this will leave behind the .tar.gz file).
#
# =========================================================================

##############################################################################################
#                                                                                            #
#                                NO LONGER AVAILABLE                                         #
#                             Refer to Docker tag 1.0.3                                      #
#                                For pre-built image                                         #
#                                                                                            #
##############################################################################################
#ENV OFFICE_HOST=http://mirror.switch.ch/ftp/mirror/tdf/libreoffice/stable/5.4.4/deb/x86_64

ENV OFFICE_HOST=http://pkgnginx

##############################################################################################
#                                                                                            #
#                                                                                            #
#                                                                                            #
##############################################################################################

ENV OFFICE_PKG=LibreOffice_5.4.4_Linux_x86-64_deb.tar.gz
ENV OFFICE_DIR=LibreOffice_5.4.4.2_Linux_x86-64_deb

ENV OFFICE_URL=${OFFICE_HOST}/${OFFICE_PKG}

# =========================================================================

COPY scripts/. /

RUN apt-get -y update \
 && apt-get -y upgrade  \
 && apt-get install -y --no-install-recommends \
            openjdk-8-jre \
 && mkdir -p /usr/local/share/libreoffice \
 && wget -qO- ${OFFICE_URL} | tar xvz -C /usr/local/share/libreoffice \
 && dpkg -i /usr/local/share/libreoffice/${OFFICE_DIR}/DEBS/*.deb \
 && rm -R /usr/local/share/libreoffice/${OFFICE_DIR} \
 && apt-get clean all \
 && PATH=$PATH:/opt/libreoffice5.4/program

# =========================================================================

VOLUME /documents

ENTRYPOINT ["/my_init"]
CMD ["/usr/bin/libreoffice5.4"]
