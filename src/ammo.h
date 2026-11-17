#pragma once
#ifndef CATA_SRC_AMMO_H
#define CATA_SRC_AMMO_H

#include <cstddef>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "translation.h"
#include "type_id.h"

class JsonObject;

namespace cata::lua_platform
{
class content_transaction;
class items_content_transaction;
namespace detail
{
std::vector<std::pair<ammotype, ammunition_type>> ammunition_type_registry_snapshot();
} // namespace detail
} // namespace cata::lua_platform

class ammunition_type
{
        friend class DynamicDataLoader;
        friend class cata::lua_platform::content_transaction;
        friend class cata::lua_platform::items_content_transaction;
        friend std::vector<std::pair<ammotype, ammunition_type>>
                cata::lua_platform::detail::ammunition_type_registry_snapshot();
        template<typename T> friend class string_id;
    public:
        ammunition_type();

        std::string name() const;
        static void set_mod_load_order( const std::vector<mod_id> &mods );

        const itype_id &default_ammotype() const {
            return default_ammotype_;
        }

    private:
        using registry_type = std::unordered_map<ammotype, ammunition_type>;

        translation name_;
        itype_id default_ammotype_;
        // Legacy JSON can supply either field from a different pack. Keep
        // its priority when Lua defines this ammunition type after JSON loads.
        std::size_t json_name_order_ = 0;
        std::size_t json_default_order_ = 0;

        static registry_type &registry();

        static std::size_t mod_load_index( const std::string &source );
        static void load_ammunition_type( const JsonObject &jsobj, const std::string &source );
        static void reset();
        static void check_consistency();
};

#endif // CATA_SRC_AMMO_H
