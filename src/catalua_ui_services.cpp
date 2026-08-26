#include "catalua_ui_services.h"

#include <algorithm>
#include <cctype>
#include <stdexcept>
#include <unordered_set>
#include <utility>

namespace cata::lua
{

bool is_safe_service_identifier( const std::string_view value )
{
    return !value.empty() && value.size() <= 128 &&
    std::all_of( value.begin(), value.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-' || ch == '.';
    } );
}

bool is_safe_service_provider_identifier( const std::string_view value )
{
    return !value.empty() && value.size() <= 128 &&
    std::all_of( value.begin(), value.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-' || ch == '.' || ch == ':';
    } );
}

void script_service_registry::provide( script_service_definition definition )
{
    if( !is_safe_service_provider_identifier( definition.provider_id ) ||
        !is_safe_service_identifier( definition.name ) ) {
        throw std::invalid_argument( "Lua service provider and name must be safe identifiers" );
    }
    if( definition.version < 1 || definition.version > maximum_version ) {
        throw std::invalid_argument( "Lua service version must be within 1..1000000" );
    }
    if( definition.methods.empty() ||
        definition.methods.size() > maximum_methods_per_service ) {
        throw std::invalid_argument( "Lua services require 1..64 methods" );
    }
    std::unordered_set<std::string> unique_methods;
    for( const std::string &method : definition.methods ) {
        if( !is_safe_service_identifier( method ) ||
            !unique_methods.insert( method ).second ) {
            throw std::invalid_argument(
                "Lua service method names must be safe and unique" );
        }
    }
    std::sort( definition.methods.begin(), definition.methods.end() );

    const auto existing = std::find_if(
                              services_.begin(), services_.end(),
    [&definition]( const script_service_definition & service ) {
        return service.provider_id == definition.provider_id &&
               service.name == definition.name;
    } );
    if( existing != services_.end() ) {
        *existing = std::move( definition );
        return;
    }
    if( services_.size() >= maximum_services ) {
        throw std::runtime_error( "Lua service registry limit reached" );
    }
    services_.push_back( std::move( definition ) );
}

const script_service_definition *script_service_registry::find(
    const std::string_view provider_id, const std::string_view name ) const
{
    const auto found = std::find_if(
                           services_.begin(), services_.end(),
    [provider_id, name]( const script_service_definition & service ) {
        return service.provider_id == provider_id && service.name == name;
    } );
    return found == services_.end() ? nullptr : &*found;
}

const std::vector<script_service_definition> &script_service_registry::all() const
{
    return services_;
}

std::size_t script_service_registry::size() const
{
    return services_.size();
}

void script_service_registry::clear()
{
    services_.clear();
}

std::string script_service_registry::method_key(
    const std::string_view provider_id, const std::string_view service_name,
    const std::string_view method_name )
{
    return std::to_string( provider_id.size() ) + ":" + std::string( provider_id ) +
           std::to_string( service_name.size() ) + ":" + std::string( service_name ) +
           std::to_string( method_name.size() ) + ":" + std::string( method_name );
}

} // namespace cata::lua
