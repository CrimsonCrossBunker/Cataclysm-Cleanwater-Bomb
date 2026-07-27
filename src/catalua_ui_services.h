#pragma once
#ifndef CATA_SRC_CATALUA_UI_SERVICES_H
#define CATA_SRC_CATALUA_UI_SERVICES_H

#include <cstddef>
#include <string>
#include <string_view>
#include <vector>

namespace cata::lua_ui
{

struct script_service_definition {
    std::string provider_id;
    std::string name;
    int version = 1;
    std::size_t source_index = 0;
    std::vector<std::string> methods;
};

class script_service_registry
{
    public:
        static constexpr std::size_t maximum_services = 128;
        static constexpr std::size_t maximum_methods_per_service = 64;
        static constexpr int maximum_version = 1000000;

        void provide( script_service_definition definition );
        const script_service_definition *find(
            std::string_view provider_id, std::string_view name ) const;
        const std::vector<script_service_definition> &all() const;
        std::size_t size() const;
        void clear();

        static std::string method_key( std::string_view provider_id,
                                       std::string_view service_name,
                                       std::string_view method_name );

    private:
        std::vector<script_service_definition> services_;
};

bool is_safe_service_identifier( std::string_view value );
bool is_safe_service_provider_identifier( std::string_view value );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_SERVICES_H
