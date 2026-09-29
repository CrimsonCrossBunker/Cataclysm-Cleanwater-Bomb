#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_SOL_H
#define CATA_SRC_LUA_PLATFORM_SOL_H

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

#include <cstdint>
#include <string>

namespace sol
{

// GCC can give distinct lambdas in one function the same demangled name. sol2
// uses user_gc_metatable() to select the userdata's destructor, so give each
// callable wrapper type a unique key without relying on RTTI.
template<typename Func, bool IsYielding, bool NoTrampoline>
struct usertype_traits<function_detail::functor_function<Func, IsYielding, NoTrampoline>> {
        using functor_type = function_detail::functor_function<Func, IsYielding, NoTrampoline>;

        static const std::string &name() {
            static const std::string &n = detail::short_demangle<functor_type>();
            return n;
        }

        static const std::string &qualified_name() {
            static const std::string &q_n = detail::demangle<functor_type>();
            return q_n;
        }

        static const std::string &metatable() {
            static const std::string m = std::string( "sol." ).append( detail::demangle<functor_type>() );
            return m;
        }

        static const std::string &user_metatable() {
            static const std::string u_m = std::string( "sol." ).append(
                                               detail::demangle<functor_type>() ).append( ".user" );
            return u_m;
        }

        static const std::string &user_gc_metatable() {
            static const std::string u_g_m = [] {
                std::string key = std::string( "sol." ).append( detail::demangle<functor_type>() )
                .append( ".user\xE2\x99\xBB#" );
                key.append( std::to_string( reinterpret_cast<std::uintptr_t>( &gc_type_token ) ) );
                return key;
            }();
            return u_g_m;
        }

        static const std::string &gc_table() {
            static const std::string g_t = std::string( "sol." ).append(
                                               detail::demangle<functor_type>() ).append( ".\xE2\x99\xBB" );
            return g_t;
        }

    private:
        static inline unsigned char gc_type_token = 0;
};

} // namespace sol

#ifdef __clang__
    #pragma clang diagnostic pop
#endif
#if defined(__GNUC__) && !defined(__clang__)
    #pragma GCC diagnostic pop
#endif

#endif // CATA_SRC_LUA_PLATFORM_SOL_H
