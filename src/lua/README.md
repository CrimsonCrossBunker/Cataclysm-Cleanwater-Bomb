This folder contains the Lua 5.4.8 library source code, compiled into builds
that enable the CCB Lua runtime.  Only redundant blank lines at the ends of
upstream files are normalized for the repository's whitespace checks.

The source archive is published at
<https://www.lua.org/ftp/lua-5.4.8.tar.gz> and has SHA-256:

```text
4f18ddae154e793e46eeab727c59ef1c0c0c2b744e7b94219710d76f530629ae
```

The standalone `lua.c` and `luac.c` front ends are intentionally not vendored;
CCB embeds the library and does not ship a separate unrestricted interpreter.
