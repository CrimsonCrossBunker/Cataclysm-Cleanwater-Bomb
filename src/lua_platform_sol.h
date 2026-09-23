#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_SOL_H
#define CATA_SRC_LUA_PLATFORM_SOL_H

#include <cstdint>
#include <string>

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

#define LUA_PLATFORM_SOL_WRAPPED
#include "sol/sol.hpp"
#undef LUA_PLATFORM_SOL_WRAPPED

namespace sol
{
// GCC can give distinct captured lambdas the same pretty-printed type name.
// These opaque callback userdata need a per-type GC key so each capture is
// destroyed with its own layout.  Keep this adaptation outside vendored Sol.
template<typename Func, bool IsYielding, bool NoTrampoline>
struct usertype_traits<function_detail::functor_function<Func, IsYielding, NoTrampoline>> {
    static const std::string &user_gc_metatable() {
        static char type_key;
        static const std::string key = "ccb.sol.functor." +
                                       std::to_string( reinterpret_cast<std::uintptr_t>( &type_key ) );
        return key;
    }
};
} // namespace sol

#ifdef __clang__
    #pragma clang diagnostic pop
#endif
#if defined(__GNUC__) && !defined(__clang__)
    #pragma GCC diagnostic pop
#endif

#endif // CATA_SRC_LUA_PLATFORM_SOL_H
