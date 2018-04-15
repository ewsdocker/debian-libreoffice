# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Libre Office 5.2.7
#		in a Debian 9.2 (Stretch) docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 1.0.1
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

RUN apt-get -y update \
 && apt-get install -y --no-install-recommends \
            libreoffice \
            libreoffice-gtk \
            libreoffice-gtk3 \
            libreoffice-help-en-us \
            libreoffice-style-* \
            fonts-opensymbol \
            hyphen-en-us \
            mythes-en-us \
            unoconv \
            openclipart \
            openclipart-libreoffice \
            openclipart-png \
            openclipart-svg \
 && apt-get -y upgrade  \
 && apt-get clean all
 
# =========================================================================

VOLUME /documents
VOLUME /home/user

# =========================================================================

ENTRYPOINT ["/my_init"]
CMD ["/usr/lib/libreoffice/program/soffice"]
