#include "catalua_ui_modules.h"

#include <algorithm>
#include <cctype>
#include <system_error>
#include <utility>

#include "catalua_ui.h"

namespace cata::lua_ui
{

namespace
{

namespace fs = std::filesystem;

std::string module_relative_path( std::string name )
{
    std::replace( name.begin(), name.end(), '.',
                  static_cast<char>( fs::path::preferred_separator ) );
    return name;
}

bool regular_file( const fs::path &path )
{
    std::error_code error;
    return fs::is_regular_file( path, error ) && !error;
}

} // namespace

script_module_resolver::script_module_resolver(
    std::vector<script_module_source> sources ) :
    sources_( std::move( sources ) )
{
}

std::optional<script_module_resolution> script_module_resolver::resolve_in_source(
    const std::size_t source_index, const std::string_view module_name ) const
{
    if( source_index >= sources_.size() || !is_safe_module_name( module_name ) ) {
        return std::nullopt;
    }

    const std::string relative = module_relative_path( std::string( module_name ) );
    const fs::path direct =
        ( sources_[source_index].root / ( relative + ".lua" ) ).lexically_normal();
    const fs::path package =
        ( sources_[source_index].root / relative / "init.lua" ).lexically_normal();
    const fs::path *resolved = nullptr;
    if( regular_file( direct ) ) {
        resolved = &direct;
    } else if( regular_file( package ) ) {
        resolved = &package;
    }
    if( resolved == nullptr ) {
        return std::nullopt;
    }

    return script_module_resolution{
        source_index,
        *resolved,
        sources_[source_index].manifest.id + ":" + std::string( module_name )
    };
}

std::optional<script_module_resolution> script_module_resolver::resolve_local(
    const std::size_t caller_index, const std::string_view module_name ) const
{
    if( caller_index >= sources_.size() || !is_safe_module_name( module_name ) ) {
        return std::nullopt;
    }

    if( sources_[caller_index].manifest.api_version >= 4 ) {
        return resolve_in_source( caller_index, module_name );
    }

    // Compatibility for API v2/v3: user, later Mods, earlier Mods, built-in.
    for( std::size_t reverse = sources_.size(); reverse > 0; --reverse ) {
        if( const auto result = resolve_in_source( reverse - 1, module_name ) ) {
            return result;
        }
    }
    return std::nullopt;
}

std::optional<std::size_t> script_module_resolver::source_index_for_id(
    const std::string_view id ) const
{
    const auto found = std::find_if(
    sources_.begin(), sources_.end(), [id]( const script_module_source & source ) {
        return source.manifest.id == id;
    } );
    if( found == sources_.end() ) {
        return std::nullopt;
    }
    return static_cast<std::size_t>( std::distance( sources_.begin(), found ) );
}

std::optional<script_module_resolution> script_module_resolver::resolve_import(
    const std::size_t caller_index, const std::string_view provider_id,
    const std::string_view module_name ) const
{
    if( caller_index >= sources_.size() || provider_id.empty() ||
        !is_safe_module_name( module_name ) ) {
        return std::nullopt;
    }
    const std::optional<std::size_t> provider = source_index_for_id( provider_id );
    if( !provider ) {
        return std::nullopt;
    }
    if( *provider != caller_index && provider_id != "builtin" &&
        !sources_[caller_index].manifest.depends_on( provider_id ) ) {
        return std::nullopt;
    }
    return resolve_in_source( *provider, module_name );
}

const std::vector<script_module_source> &script_module_resolver::sources() const
{
    return sources_;
}

bool is_safe_module_name( const std::string_view name )
{
    if( name.empty() || name.front() == '.' || name.back() == '.' ||
        name.find( ".." ) != std::string_view::npos ) {
        return false;
    }
    return std::all_of( name.begin(), name.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-' || ch == '.';
    } );
}

} // namespace cata::lua_ui
