#pragma once
#ifndef CATA_SRC_AMMO_H
#define CATA_SRC_AMMO_H

#include <string>
#include <unordered_map>

#include "translation.h"
#include "type_id.h"

class JsonObject;

namespace cata::lua_platform
{
class content_transaction;
} // namespace cata::lua_platform

class ammunition_type
{
        friend class DynamicDataLoader;
        friend class cata::lua_platform::content_transaction;
        template<typename T> friend class string_id;
    public:
        ammunition_type();

        std::string name() const;

        const itype_id &default_ammotype() const {
            return default_ammotype_;
        }

    private:
        using registry_type = std::unordered_map<ammotype, ammunition_type>;

        translation name_;
        itype_id default_ammotype_;

        static registry_type &registry();

        static void load_ammunition_type( const JsonObject &jsobj );
        static void reset();
        static void check_consistency();
};

#endif // CATA_SRC_AMMO_H
