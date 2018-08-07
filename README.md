## ewsdocker/debian-libreoffice  

**LibreOffice (complete) in a Debian-based Docker image.**  

____  

**NOTE**  
**ewsdocker/debian-libreoffice** is designed to be used on a Linux system configured to support **Docker user namespaces** .  Refer to [ewsdocker Containers and Docker User Namespaces](https://github.com/ewsdocker/ewsdocker.github.io/wiki/UserNS-Overview) for an overview and information on running **ewsdocker/debian-libreoffice** on a system not configured for **Docker user namespaces**.
____  

**Visit the [ewsdocker/debian-libreoffice Wiki](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart) for complete documentation of this docker image.**  
____  

**Installing ewsdocker/debian-libreoffice**  

The following scripts will download the the selected **ewsdocker/debian-libreoffice** image, create a container, setup and populate the directory structures, create the run-time scripts, and install the application's desktop file(s).  

The _default_ values will install all directories and contents in the **docker host** user's home directory (refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart#mapping)),  

**ewsdocker/debian-libreoffice:9.5.0**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-libreoffice-9.5.0:/root \
               --name=debian-libreoffice-9.5.0 \
           ewsdocker/debian-libreoffice:9.5.0 lms-setup  

____  

Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart#mapping) for a discussion of **lms-setup** and what it does.  

____  

**Running the installed scripts**

After running the above command script, and using the settings indicated, the docker host directories, mapped as shown in the above tables, will be configured as follows:

+ the executable scripts have been copied to **~/bin**;  
+ the application desktop file(s) have been copied to **~/.local/share/applications**, and are availablie in any _task bar_ menu;  
+ the associated **debian-libreoffice-"branch"-"version"** executable script (shown below) will be found in **~/.local/bin**, and _should_ be customized with proper local volume names;  

____  

**Executable scripts**  

**ewsdocker/debian-libreoffice:9.5.0**
  
    docker run -v /etc/localtime:/etc/localtime:ro \
           -e DISPLAY=unix${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
           -v ${HOME}/Documents:/documents \
           -v ${HOME}/Stories:/stories \
           -v ${HOME}/.config/docker/debian-libreoffice-9.5.0:/root \
           --name=debian-libreoffice-9.5.0 \
       ewsdocker/debian-libreoffice:9.5.0  

____  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-libreoffice/wiki/QuickStart#mapping) for a discussion of customizing the executable scripts..  

____  

**Bleeding-edge Testing**  

The _bleeding-edge_ development tag **edge** is the next **Docker** tag release.  This means that, during its lifetime, the **edge** source will undergo many modifications before it becomes useful.  

For the _very brave_, if an _edge_ tag is available, the following  instructions will download, rename and install the _edge_ version.  

Good luck.  Please remember that just because it is named **9.5.1** does **not** mean that it is no longer bleeding-**edge**. Don't expect it to work.

____  

**ewsdocker/debian-libreoffice:edge**  

**edge** is the **Docker** tag for the **GitHub** development version, and future **Docker** release tag, **9.5.1**.

    docker pull ewsdocker/debian-libreoffice:edge
    docker tag ewsdocker/debian-libreoffice:edge ewsdocker/debian-libreoffice:9.5.1
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-libreoffice-9.5.1:/root \
               --name=debian-libreoffice-9.5.1 \
           ewsdocker/debian-libreoffice:9.5.1 lms-setup  

optional step (clean up the **docker images**):

    docker rmi ewsdocker/debian-libreoffice:edge  

To create and run the container, run **LibreOffice 9.5.1** from the _Office_ category of any desktop menu, or the following should work from the command-line:

    ~/.local/bin/debian-libreoffice:9.5.1  

____  

**Persistence**  
In order to persist the Eclipse application state, a location on the docker _host_ must be provided to store the necessary information.  This can be accomplished with the following volume option in the run command:

    -v ${HOME}/.config/docker/debian-libreoffice-"version":/root  

Since the information is stored in the docker _container_ **/root** directory, this statement maps the user's **~/.config/docker/debian-libreoffice-"version"** docker _host_ directory to the **/root** directory in the docker _container_.  
____  
**Timestamps**  
It is important to keep the time and date on docker _host_ files that have been created and/or modified by the docker _containter_ synchronized with the docker _host_'s settings. This can be accomplished as follows:

    -v /etc/localtime:/etc/localtime:ro  

____  
**About the X11 Server / GUI Stack**  
The **ewsdocker/debian-libreoffice** image is built on the [ewsdocker/debian-openjre](https://github.com/ewsdocker/debian-openjre/wiki) docker image, which is built on the [ewsdocker/debian-base-gui](https://github.com/ewsdocker/debian-base-gui/wiki) docker image. These two docker images provide the **X11-Server** stack and several **GUI** system elements.  The **X11-Server** stack is configured in the _docker run_ command as follows:

    docker run -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \

Since these options are _the same for all gui containers_, they should probably be the first options in the docker run command.  

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

