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
// GCC's display names can coincide for distinct same-signature lambdas.  The
// internal callback userdata must instead select __gc by its actual C++ type.
template<typename Func, bool is_yielding, bool no_trampoline>
struct usertype_traits<function_detail::functor_function<Func, is_yielding, no_trampoline>> {
    static const std::string &user_gc_metatable() {
        // One address per storage type, shared across translation units.  This
        // key is process-local; it is neither a public type name nor saved data.
        static char identity;
        static const std::string name = "ccb.callback." +
                                        std::to_string( reinterpret_cast<std::uintptr_t>( &identity ) );
        return name;
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
