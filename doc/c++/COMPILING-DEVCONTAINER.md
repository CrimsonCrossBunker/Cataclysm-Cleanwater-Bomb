<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `build-devcontainer`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/build/devcontainer/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/build/devcontainer/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
*Contents*

- [Compilation guide for devcontainers in Visual Studio Code](#compilation-guide-for-devcontainers-in-visual-studio-code)
  - [Prerequisites:](#prerequisites)
  - [Installation:](#installation)
- [Cross-compiling from Linux to Windows](#cross-compiling-from-linux-to-windows)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Compilation guide for devcontainers in Visual Studio Code

This guide contains instructions for compiling Cataclysm-DDA in Visual Studio Code using a [Devcontainer](https://code.visualstudio.com/learn/develop-cloud/containers)

The devcontainer was introduced in [#65748](https://github.com/CleverRaven/Cataclysm-DDA/pull/65748). These instructions were written using Visual Studio Code version 1.80.1 on Debian 11

## Prerequisites:

* Visual Studio Code
* [Docker](https://docs.docker.com/engine/install/)


## Installation:

1. Install all prerequisites.
2. Clone your fork of the CleverRaven/Cataclysm-DDA repo and create a branch
3. Add CleverRaven as the remote upstream with git remote add upstream git@github.com:CleverRaven/Cataclysm-DDA.git
4. Open the folder where you cloned your repository in Visual Studio Code via the UI or by navigating to the directory in a terminal and typing Code
5. Visual Studio Code will show a pup-up in the bottom right with recommended extensions. Install those.
6. If you don't plan to cross-compile the game, scroll down to find this section:

  ![Image showing the uncommented part of the dockerfile](../img/Devcontainer-Uncomment-Windows-Part-In-Dockerfile.png)

  comment out that part (select it and press ctrl+/ in vscode) so it looks like this:
  ![Image showing the commented part of the dockerfile](../img/Devcontainer-Find-Commented-Windows-Commands-In-Dockerfile.png)

Next, scroll down to find this section:
  ![Image showing the uncommented part of the dockerfile](../img/Devcontainer-Uncomment-QT5-Part-In-Dockerfile.png)
  
  comment that part out (select it and press ctrl+/ in vscode) so it looks like this:

  ![Image showing the commented part of the dockerfile](../img/Devcontainer-Find-Commented-QT5-Commands-In-Dockerfile.png)

  
7. Now restart visual studio code. When prompted, click "Reopen in container":
   
  ![Re-open devcontainer in vscode](../img/Devcontainer-Re-Open-In-Container.png)

  7.1 Linux only: You may see this message:
  
  ![User does not have access to group, add user to docker group first](../img/Devcontainer-User-Does-Not-Have-Access-Add-To-Group-First.png)
  
  In that case, add the user to the docker group using the terminal:
  
  ![Add user to docker group in terminal](../img/Devcontainer-Add-User-To-Docker-Group.png)

  After that, log out of your account and log back in so the permissions are updated. If that doesn't work, reboot your computer.

  
8. Allow the container to build and for VSCode to Reopen. If everything goes well, you will see the container running:

  ![Image showing the container is running in vscode](../img/Devcontainer-Running-Cataclysm-Devcontainer.png)


9. Select the makefile extension on the bottom left and choose your desired configuration. Press the "Play" button to build the project

  ![Image the buttons to press in the makefile extension](../img/Devcontainer-Make-File-Configs.png)


  
The build result should be located in the folder where you cloned your fork to (e.g. /Documents/git/Cataclysm-DDA)

If you want to run cataclysm-tiles locally, open a terminal on your linux machine and install these packages: `apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get -y install --no-install-recommends libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libsdl2-mixer-dev libfreetype6-dev build-essential astyle ccache`

You can then test your build on your linux machine by opening a terminal in the `/Documents/git/Cataclysm-DDA` folder and using this command:
```bash
./cataclysm-tiles
```



# Cross-compiling from Linux to Windows
1. Follow all of the steps written earlier in this guide

2. Open the Dockerfile in the VSCode file browser and scroll down to find this section:

  ![Image showing the commented part of the dockerfile](../img/Devcontainer-Find-Commented-Windows-Commands-In-Dockerfile.png)

  Uncomment that part (select it and press ctrl+/ in vscode) so it looks like this:
  
  ![Image showing the uncommented part of the dockerfile](../img/Devcontainer-Uncomment-Windows-Part-In-Dockerfile.png)

3. Save the Dockerfile and re-open VSCode. Allow the Devcontainer to rebuild. This is going to take a while (45 minutes depending on the performance of your computer)

  ![Image showing prompt to rebuild the devcontainer](../img/Devcontainer-Dockerfile-Changed-Prompt-Click-Rebuild.png)

4. Go to the makefile extension and set the makefile settings as follows:

  ![Image showing the makefile settings for cross compilation](../img/Devcontainer-Makefile-Settings-Crosscompile-Windows.png)
  
  Next, press the play button to build the game. After it is build, you should see the cataclysm-tiles.exe file in the folder where you cloned your fork to (e.g. /workspaces/Cataclysm-DDA)


