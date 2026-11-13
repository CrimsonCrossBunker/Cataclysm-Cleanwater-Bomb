<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `legacy.doc-c-compiling-cmake-vcpkg`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/build/windows-msvc/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/build/windows-msvc/
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

- [Compiling CMAKE VCPKG](#compiling-cmake-vcpkg)
- [Disclaimer](#disclaimer)
- [Contents](#contents)
- [1 Prerequisites](#1-prerequisites)
- [2 Configure](#2-configure)
  - [Presets](#presets)
  - [vcpkg](#vcpkg)
  - [Visual Studio](#visual-studio)
  - [Terminal](#terminal)
- [3 Build](#3-build)
  - [Visual Studio](#visual-studio-1)
  - [Terminal](#terminal-1)
- [4 Install](#4-install)
  - [Visual Studio](#visual-studio-2)
  - [Terminal](#terminal-2)
- [5 Run](#5-run)
  - [Visual Studio](#visual-studio-3)
  - [Terminal](#terminal-3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Compiling CMAKE VCPKG
# Disclaimer

**WARNING**: CMake build is **NOT** officially supported and should be used for *dev purposes ONLY*.

For the official way to build CataclysmDDA, see:
  * [COMPILING.md](COMPILING.md)

# Contents

1. Prerequisites
2. Configure
3. Build
4. Install
5. Run

# 1 Prerequisites

`cmake` >= 3.20.0<br/>
`vcpkg` from [vcpkg.io](https://vcpkg.io/en/getting-started.html)
`msgfmt` (optional) as part of Git Bash or msys2 in the default install paths.

On Linux (for `libxcrypt`):
`autoconf`
`automake`
`libtool`
`pkg-config`

# 2 Configure

## Presets
The file `CMakePresets.json` contains all the presets.<br/>
They will all build the code into the directory `out/build/<preset>/`.

## vcpkg

If vcpkg is checked out in a location different from `C:\vcpkg`, eg. `C:\dev\vcpkg`, you must do one of the following:
  * append `-DVCPKG_ROOT=C:\dev\vcpkg` (or whatever the path is) to any cmake configure commands
  * set the environment variable `VCPKG_ROOT` to the path to the vcpkg checkout.
  * edit the `VCPKG_ROOT` cache variable in `CMakePresets.json` to the appropriate path

## Visual Studio
The Standard toolbar shows the presets in the _Configuration_ drop-down box.<br/>
From the main menu, select _Project -> Configure Cache_

If you do not have `msgfmt` available, or do not want to include translations with the build, you need to additionally set `DLOCALIZE=OFF`. To do this, go to _Project -> CMake Settings_, scroll to the bottom where `"windows-tiles-sounds-x64-msvc"` is defined, and under `"cacheVariables"` change the value from `"LOCALIZE": "True"` to `"LOCALIZE": "OFF"`.
 * Note: doing this will change the `CMakePresets.json` file which is tracked by source control. Do not commit this change.

## Terminal
Run the command
 * `cmake --list-presets`<br/>
It will show the presets available to you.
The list changes based on the environment you are in.
If empty, the environment is not supported.

Run the command
 * `cmake --preset <preset>`
 
 If you do not have `msgfmt` available, or do not want to include translations with the build, you need to additionally pass `-DLOCALIZE=OFF`.
 
 * `cmake --preset <preset> -DLOCALIZE=OFF`
 
# 3 Build

## Visual Studio
From the Standard toolbar's _Build Preset_ drop-down menu select the build preset.<br/>
From the main menu, select _Build -> Build All_

## Terminal
Run the command
 * `cmake --build --preset <preset>`

# 4 Install

## Visual Studio
From the main menu, select _Build -> Install CataclysmDDA_

## Terminal
Run the command
 * `cmake --install out/build/<preset>/ --config RelWithDebInfo`

# 5 Run

 ## Visual Studio
From the Standard toolbar's _Select Startup Item..._ drop-down menu select `cataclysm-tiles.exe (Install)` <br/>
The _Project Configuration_ drop-down menu will show `RelWithDebInfo`.<br/>
You can now _Start Without Debugging_ (default Ctrl+F5) or _Debug -> Start Debugging_ (default F5).

 ## Terminal
 Run the commands
  * `cd out/install/<preset>/`
  * `cataclysm` or `cataclysm-tiles.exe`
