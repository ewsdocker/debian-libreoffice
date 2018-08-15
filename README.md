## ewsdocker/debian-libreoffice:9.5.3  

**Libre Office 6.1.0 (complete) in a Debian 9.5 Docker image.**  

____  

**NOTE**  
**ewsdocker/debian-libreoffice** is designed to be used on a Linux system configured to support **Docker user namespaces** .  Refer to [ewsdocker Containers and Docker User Namespaces](https://github.com/ewsdocker/ewsdocker.github.io/wiki/UserNS-Overview) for an overview and information on running **ewsdocker/debian-libreoffice** on a system not configured for **Docker user namespaces**.
____  

**Visit the [ewsdocker/debian-libreoffice Wiki](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart) for complete documentation of this docker image.**  
____  

**Installing ewsdocker/debian-libreoffice**  

The following scripts will download the the selected **ewsdocker/debian-libreoffice** image, create a container, setup and populate the directory structures, create the run-time scripts, and install the application's desktop file(s).  

The _default_ values will install all directories and contents in the **docker host** user's home directory (refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart#mapping)),  

**ewsdocker/debian-libreoffice:9.5.3**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-libreoffice-9.5.3:/root \
               --name=debian-libreoffice-9.5.3 \
           ewsdocker/debian-libreoffice:9.5.3 lms-setup  

____  

Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart#mapping) for a discussion of **lms-setup** and what it does.  

____  

**Running the installed scripts**

After running the above command script, and using the settings indicated, the docker host directories, mapped as shown in the above tables, will be configured as follows:

+ the executable scripts have been copied to **~/bin**;  
+ the application desktop file(s) have been copied to **~/.local/share/applications**, and are availablie in any _task bar_ menu;  
+ the associated **debian-libreoffice-"version"** executable script (shown below) will be found in **~/.local/bin**, and _should_ be customized with proper local volume names;  

____  

**Executable scripts**  

**ewsdocker/debian-libreoffice:9.5.3**
  
    docker run -v /etc/localtime:/etc/localtime:ro \
           -e DISPLAY=unix${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
           -v ${HOME}/Documents:/documents \
           -v ${HOME}/Stories:/stories \
           -v ${HOME}/.config/docker/debian-libreoffice-9.5.3:/root \
           --name=debian-libreoffice-9.5.3 \
       ewsdocker/debian-libreoffice:9.5.3  

____  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart#mapping) for a discussion of customizing the executable scripts..  

____  

**Bleeding-edge Testing**  

The _bleeding-edge_ development tag **edge** is the next **Docker** tag release.  This means that, during its lifetime, the **edge** source will undergo many modifications before it becomes useful.  

For the _very brave_, if an _edge_ tag is available, the following  instructions will download, rename and install the _edge_ version.  

Good luck.  Please remember that just because it is named **9.5.4** does **not** mean that it is no longer bleeding-**edge**. Don't expect it to work.

____  

**ewsdocker/debian-libreoffice:edge**  

**edge** is the **Docker** tag for the **GitHub** development version, and future **Docker** release tag, **9.5.4**.

    docker pull ewsdocker/debian-libreoffice:edge
    docker tag ewsdocker/debian-libreoffice:edge ewsdocker/debian-libreoffice:9.5.4
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-libreoffice-9.5.4:/root \
               --name=debian-libreoffice-9.5.4 \
           ewsdocker/debian-libreoffice:9.5.4 lms-setup  

optional step (clean up the **docker images**):

    docker rmi ewsdocker/debian-libreoffice:edge  

To create and run the container, run **Libre Office 9.5.4** from the _Office_ category of any desktop menu, or the following should work from the command-line:

    ~/.local/bin/debian-libreoffice-9.5.4  

____  

**About the size of the image**  

The main design specifications of the **ewsdocker** desktop application images are:  

  - Provide the same desktop experience as the user would have on a full application installation on a host desktop (including desktop menu interface, audio, video, multimedia, ...);  
  - Install the latest release directly from the software vendor's repository, or a certified mirror, reducing dependencies on host operating system implementations of the application;  
  - Leverage **Docker** container capabilities to  
   + provide isolation of the **Docker** container applications from the **Docker** host;  
   + provide persistence of application settings between **docker run** commands, and between future releases, allowing fast container deletion and re-creation; and  
   + quickly perform container replications, container updates, and recovery from software malfunction/corruption.  

Most of the **ewsdocker** desktop application images are based on the latest **Debian** docker image, since fewer problems have been encountered when implementing the desktop applications on that platform.  

Obviously, these **Docker** images tend to be rather large compared to most **Docker** images. It may take a bit longer to download, but the convenience of having the application in a **docker image** is worth the small, (usually) one time investment in download time.  

____  

**Copyright © 2018. EarthWalk Software.**  
**Licensed under the GNU General Public License, GPL-3.0-or-later.**  

This file is part of **ewsdocker/debian-libreoffice**.  

**ewsdocker/debian-libreoffice** is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.  

**ewsdocker/debian-libreoffice** is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License
along with **ewsdocker/debian-libreoffice**.  If not, see 
<http://www.gnu.org/licenses/>.  

