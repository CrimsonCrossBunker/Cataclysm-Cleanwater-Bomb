## Using llama to accelerate your build

[llama](https://github.com/nelhage/llama) is a CLI for outsourcing computation to AWS Lambda.

You can use llama to accelerate your CDDA builds.  To help you set that up,
this directory contains a legacy image for terminal compilation.

After bootstrapping llama, you can use for example

```bash
llama update-function --create --timeout=120s --memory=4096 --build=tools/llama/gcc-focal gcc
```

This will configure llama to use the `gcc-focal` image here.  Note that it's
important to have larger-than-default timeout and memory settings.

### SDL3 tiles builds

The legacy `gcc-focal` image is retained for terminal builds only; its SDL2
packages and header workaround have been removed. It does not provide the SDL3
stack required by the current tiles backend.

To use llama for tiles, build a custom compiler image with SDL3 >= 3.4.0,
SDL3_image, SDL3_ttf and SDL3_mixer development libraries matching the local
build environment. Follow the [native build requirements](../../doc/c++/COMPILING-CMAKE.md)
and the pinned Linux SDK recipe in
[setup-sdl3-stack](../../.github/actions/setup-sdl3-stack/action.yml).
The distributed compiler and local linker must use compatible headers,
libraries and compiler versions. This migration has not validated a distributed
SDL3 build.
