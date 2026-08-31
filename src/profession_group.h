#pragma once
#ifndef CATA_SRC_PROFESSION_GROUP_H
#define CATA_SRC_PROFESSION_GROUP_H

#include <string>
#include <string_view>
#include <vector>

#include "type_id.h"

class JsonObject;
template<typename T>
class generic_factory;

namespace cata::lua_platform
{
class content_transaction;
class character_content_transaction;
}

struct profession_group {

        static void load_profession_group( const JsonObject &jo, const std::string &src );
        void load( const JsonObject &jo, std::string_view );
        static const std::vector<profession_group> &get_all();
        static void check_profession_group_consistency();
        bool was_loaded = false;

        std::vector<profession_id> get_professions() const;
        profession_group_id get_id() const;

        profession_group_id id;

    private:
        friend class generic_factory<profession_group>;
        friend class cata::lua_platform::content_transaction;
        friend class cata::lua_platform::character_content_transaction;
        std::vector<profession_id> profession_list;

};
#endif // CATA_SRC_PROFESSION_GROUP_H
