#include "math_parser_jmath.h"

#include <map>
#include <string>
#include <string_view>

#include "catalua_content.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "math_parser.h"
#include "math_parser_diag.h"
#include "string_formatter.h"

namespace cata::lua::detail
{
generic_factory<jmath_func> &jmath_func_registry()
{
    static generic_factory<jmath_func> jmath_func_factory( "jmath_function" );
    return jmath_func_factory;
}
} // namespace cata::lua::detail

/** @relates string_id */
template <>
jmath_func const &string_id<jmath_func>::obj() const
{
    return cata::lua::detail::jmath_func_registry().obj( *this );
}

/** @relates string_id */
template <>
bool string_id<jmath_func>::is_valid() const
{
    return cata::lua::detail::jmath_func_registry().is_valid( *this );
}

void jmath_func::reset()
{
    cata::lua::detail::jmath_func_registry().reset();
}

std::vector<jmath_func> const &jmath_func::get_all()
{
    return cata::lua::detail::jmath_func_registry().get_all();
}

void jmath_func::load_func( const JsonObject &jo, std::string const &src )
{
    cata::lua::detail::jmath_func_registry().load( jo, src );
}

void jmath_func::load( JsonObject const &jo, std::string_view /*src*/ )
{
    _finalized = false;
    optional( jo, was_loaded, "num_args", num_params );
    optional( jo, was_loaded, "return", _str );

    for( auto const &iter : get_all_diag_funcs() ) {
        if( std::string const idstr = id.str(); iter.first == idstr ) {
            jo.throw_error( string_format(
                                R"(jmath function "%s" shadows a built-in function with the same name.  You must rename it.)",
                                idstr ) );
        }
    }
}

void jmath_func::finalize_all()
{
    cata::lua::detail::jmath_func_registry().finalize();
}

void jmath_func::finalize()
{
    if( _finalized ) {
        return;
    }
    _exp.parse( _str );
    _str.clear();
    _finalized = true;
}

double jmath_func::eval( const_dialogue const &d ) const
{
    return _exp.eval( d );
}

double jmath_func::eval( const_dialogue const &d, std::vector<double> const &params ) const
{
    const_dialogue d_next( d );
    for( std::vector<double>::size_type i = 0; i < params.size(); i++ ) {
        d_next.set_value( std::to_string( i ), params[i] );
    }

    return eval( d_next );
}
