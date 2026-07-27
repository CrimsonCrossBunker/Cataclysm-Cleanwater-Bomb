#pragma once
#ifndef CATA_SRC_CATALUA_SOL_H
#define CATA_SRC_CATALUA_SOL_H

#ifdef __clang__
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wmissing-noreturn"
    #pragma clang diagnostic ignored "-Wold-style-cast"
    #pragma clang diagnostic ignored "-Wzero-as-null-pointer-constant"
#endif
#if defined(__GNUC__) && !defined(__clang__)
    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Warray-bounds"
#endif

#define CATALUA_SOL_WRAPPED
#include "sol/sol.hpp"
#undef CATALUA_SOL_WRAPPED

#ifdef __clang__
    #pragma clang diagnostic pop
#endif
#if defined(__GNUC__) && !defined(__clang__)
    #pragma GCC diagnostic pop
#endif

#endif // CATA_SRC_CATALUA_SOL_H
