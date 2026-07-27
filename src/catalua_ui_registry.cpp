#include "catalua_ui_registry.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "bionics.h"
#include "item_factory.h"
#include "itype.h"
#include "mapdata.h"
#include "monstergenerator.h"
#include "mtype.h"
#include "mutation.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "skill.h"
#include "translations.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_page_limit = 64;
constexpr int maximum_page_limit = 256;
constexpr int maximum_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;

const std::vector<std::string> &registry_kinds()
{
    static const std::vector<std::string> kinds = {
        "bionic", "furniture", "item", "monster",
        "mutation", "recipe", "skill", "terrain"
    };
    return kinds;
}

bool valid_kind( const std::string_view kind )
{
    const std::vector<std::string> &kinds = registry_kinds();
    return std::find( kinds.begin(), kinds.end(), kind ) != kinds.end();
}

std::string lowercase_ascii( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    return value;
}

bool contains_query( const std::string &id, const std::string &name,
                     const std::string &query )
{
    if( query.empty() ) {
        return true;
    }
    const std::string lowered_query = lowercase_ascii( query );
    return lowercase_ascii( id ).find( lowered_query ) != std::string::npos ||
           lowercase_ascii( name ).find( lowered_query ) != std::string::npos;
}

struct registry_metadata {
    std::string id;
    std::string name;
};

template<typename Range, typename Id, typename Name>
std::vector<registry_metadata> make_index( const Range &range, Id id, Name name )
{
    std::vector<registry_metadata> result;
    for( const auto &entry : range ) {
        result.push_back( { id( entry ), name( entry ) } );
    }
    std::sort( result.begin(), result.end(),
    []( const registry_metadata & lhs, const registry_metadata & rhs ) {
        return lhs.id < rhs.id;
    } );
    return result;
}

sol::table string_array( sol::state_view lua, const std::vector<std::string> &values )
{
    sol::table result = lua.create_table();
    for( std::size_t index = 0; index < values.size(); ++index ) {
        result[index + 1] = values[index];
    }
    return result;
}

template<typename Range, typename Convert>
sol::table converted_array( sol::state_view lua, const Range &values, Convert convert )
{
    sol::table result = lua.create_table();
    std::size_t index = 1;
    for( const auto &value : values ) {
        result[index++] = convert( value );
    }
    return result;
}

sol::table item_snapshot( sol::state_view lua, const itype &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "item";
    result["id"] = definition.id.str();
    result["name"] = definition.nname( 1 );
    result["description"] = definition.description.translated();
    result["weight_grams"] = units::to_gram( definition.weight );
    result["volume_ml"] = units::to_milliliter( definition.volume );
    result["stackable"] = definition.is_stackable();
    result["count_by_charges"] = definition.count_by_charges();
    result["flags"] = converted_array(
    lua, definition.get_flags(), []( const flag_id & flag ) {
        return flag.str();
    } );
    return result;
}

sol::table monster_snapshot( sol::state_view lua, const mtype &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "monster";
    result["id"] = definition.id.str();
    result["name"] = definition.nname();
    result["description"] = definition.get_description();
    result["difficulty"] = definition.get_total_difficulty();
    result["hp"] = definition.hp;
    result["speed"] = definition.speed;
    result["weight_grams"] = units::to_gram( definition.weight );
    result["volume_ml"] = units::to_milliliter( definition.volume );
    return result;
}

sol::table terrain_snapshot( sol::state_view lua, const ter_t &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "terrain";
    result["id"] = definition.id.str();
    result["name"] = definition.name();
    result["description"] = definition.description.translated();
    result["move_cost"] = definition.movecost;
    result["coverage"] = definition.coverage;
    result["transparent"] = definition.transparent;
    result["flags"] = converted_array(
    lua, definition.get_flags(), []( const std::string & flag ) {
        return flag;
    } );
    return result;
}

sol::table furniture_snapshot( sol::state_view lua, const furn_t &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "furniture";
    result["id"] = definition.id.str();
    result["name"] = definition.name();
    result["description"] = definition.description.translated();
    result["move_cost"] = definition.movecost;
    result["coverage"] = definition.coverage;
    result["transparent"] = definition.transparent;
    result["movable"] = definition.is_movable();
    result["flags"] = converted_array(
    lua, definition.get_flags(), []( const std::string & flag ) {
        return flag;
    } );
    return result;
}

sol::table recipe_snapshot( sol::state_view lua, const recipe &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "recipe";
    result["id"] = definition.ident().str();
    result["name"] = definition.result_name();
    result["result"] = definition.result().str();
    result["description"] = definition.description.translated();
    result["difficulty"] = definition.difficulty;
    result["category"] = definition.category.str();
    result["subcategory"] = definition.subcategory;
    result["skill_used"] = definition.skill_used.str();
    result["obsolete"] = definition.obsolete;
    return result;
}

sol::table mutation_snapshot( sol::state_view lua, const mutation_branch &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "mutation";
    result["id"] = definition.id.str();
    result["name"] = definition.name();
    result["description"] = definition.desc();
    result["points"] = definition.points;
    result["activated"] = definition.activated;
    result["purifiable"] = definition.purifiable;
    result["threshold"] = definition.threshold;
    result["starting_trait"] = definition.startingtrait;
    return result;
}

sol::table bionic_snapshot( sol::state_view lua, const bionic_data &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "bionic";
    result["id"] = definition.id.str();
    result["name"] = definition.name.translated();
    result["description"] = definition.description.translated();
    result["activated"] = definition.activated;
    result["included"] = definition.included;
    result["duplicates_allowed"] = definition.dupes_allowed;
    return result;
}

sol::table skill_snapshot( sol::state_view lua, const Skill &definition )
{
    sol::table result = lua.create_table();
    result["kind"] = "skill";
    result["id"] = definition.ident().str();
    result["name"] = definition.name();
    result["description"] = definition.description();
    result["teachable"] = definition.is_teachable();
    result["obsolete"] = definition.obsolete();
    result["combat"] = definition.is_combat_skill();
    return result;
}

class script_registry_catalog
{
    public:
        const std::vector<registry_metadata> &index( const std::string &kind ) {
            refresh_language();
            const auto existing = indexes_.find( kind );
            if( existing != indexes_.end() ) {
                return existing->second;
            }

            std::vector<registry_metadata> built;
            if( kind == "item" ) {
                if( item_controller ) {
                    const std::vector<const itype *> &items = item_controller->all();
                    built = make_index(
                                items,
                    []( const itype * entry ) {
                        return entry->id.str();
                    },
                    []( const itype * entry ) {
                        return entry->nname( 1 );
                    } );
                }
            } else if( kind == "monster" ) {
                const std::vector<mtype> &monsters =
                    MonsterGenerator::generator().get_all_mtypes();
                built = make_index(
                            monsters,
                []( const mtype & entry ) {
                    return entry.id.str();
                },
                []( const mtype & entry ) {
                    return entry.nname();
                } );
            } else if( kind == "terrain" ) {
                built.reserve( ter_t::count() );
                for( std::size_t index = 0; index < ter_t::count(); ++index ) {
                    const ter_id definition_id( static_cast<int>( index ) );
                    const ter_t &entry = definition_id.obj();
                    built.push_back( { entry.id.str(), entry.name() } );
                }
            } else if( kind == "furniture" ) {
                built.reserve( furn_t::count() );
                for( std::size_t index = 0; index < furn_t::count(); ++index ) {
                    const furn_id definition_id( static_cast<int>( index ) );
                    const furn_t &entry = definition_id.obj();
                    built.push_back( { entry.id.str(), entry.name() } );
                }
            } else if( kind == "recipe" ) {
                built = make_index(
                            recipe_dict,
                []( const auto & entry ) {
                    return entry.second.ident().str();
                },
                []( const auto & entry ) {
                    return entry.second.result_name();
                } );
            } else if( kind == "mutation" ) {
                built = make_index(
                            mutation_branch::get_all(),
                []( const mutation_branch & entry ) {
                    return entry.id.str();
                },
                []( const mutation_branch & entry ) {
                    return entry.name();
                } );
            } else if( kind == "bionic" ) {
                built = make_index(
                            bionic_data::get_all(),
                []( const bionic_data & entry ) {
                    return entry.id.str();
                },
                []( const bionic_data & entry ) {
                    return entry.name.translated();
                } );
            } else if( kind == "skill" ) {
                built = make_index(
                            Skill::skills,
                []( const Skill & entry ) {
                    return entry.ident().str();
                },
                []( const Skill & entry ) {
                    return entry.name();
                } );
            }
            std::sort( built.begin(), built.end(),
            []( const registry_metadata & lhs, const registry_metadata & rhs ) {
                return lhs.id < rhs.id;
            } );
            return indexes_.emplace( kind, std::move( built ) ).first->second;
        }

        int revision() {
            refresh_language();
            return revision_;
        }

    private:
        void refresh_language() {
            const int language_revision = detail::get_current_language_version();
            if( language_revision_ == language_revision ) {
                return;
            }
            language_revision_ = language_revision;
            indexes_.clear();
            ++revision_;
        }

        int language_revision_ = -1;
        int revision_ = 0;
        std::unordered_map<std::string, std::vector<registry_metadata>> indexes_;
};

sol::object definition_snapshot( sol::state_view lua, const std::string &kind,
                                 const std::string &id )
{
    if( kind == "item" ) {
        if( item_controller && item_controller->has_template( itype_id( id ) ) ) {
            return sol::make_object(
                       lua, item_snapshot( lua, *item_controller->find_template( itype_id( id ) ) ) );
        }
    } else if( kind == "monster" ) {
        const mtype_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, monster_snapshot( lua, definition_id.obj() ) );
        }
    } else if( kind == "terrain" ) {
        const ter_str_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, terrain_snapshot( lua, definition_id.obj() ) );
        }
    } else if( kind == "furniture" ) {
        const furn_str_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, furniture_snapshot( lua, definition_id.obj() ) );
        }
    } else if( kind == "recipe" ) {
        const recipe_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, recipe_snapshot( lua, definition_id.obj() ) );
        }
    } else if( kind == "mutation" ) {
        const trait_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, mutation_snapshot( lua, definition_id.obj() ) );
        }
    } else if( kind == "bionic" ) {
        const bionic_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, bionic_snapshot( lua, definition_id.obj() ) );
        }
    } else if( kind == "skill" ) {
        const skill_id definition_id( id );
        if( definition_id.is_valid() ) {
            return sol::make_object( lua, skill_snapshot( lua, definition_id.obj() ) );
        }
    }
    return sol::make_object( lua, sol::nil );
}

struct list_options {
    int offset = 0;
    int limit = default_page_limit;
    std::string query;
    bool details = false;
};

list_options read_list_options( const sol::optional<sol::table> &options )
{
    list_options result;
    if( options ) {
        result.offset = options->get_or( "offset", 0 );
        result.limit = options->get_or( "limit", default_page_limit );
        result.query = options->get_or( "query", std::string() );
        result.details = options->get_or( "details", false );
    }
    if( result.offset < 0 || result.offset > maximum_offset ) {
        throw std::invalid_argument( "registry.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 || result.limit > maximum_page_limit ) {
        throw std::invalid_argument( "registry.list limit must be within 0..256" );
    }
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument( "registry.list query exceeds 128 bytes" );
    }
    return result;
}

} // namespace

void install_registry_api( sol::state &lua, std::function<void()> require_read )
{
    auto catalog = std::make_shared<script_registry_catalog>();
    sol::table registry = lua.create_named_table( "registry" );
    registry.set_function( "kinds", [require_read]( sol::this_state lua_state ) {
        require_read();
        return string_array( sol::state_view( lua_state ), registry_kinds() );
    } );
    registry.set_function(
        "get",
        [require_read]( sol::this_state lua_state, const std::string & kind,
    const std::string & id ) {
        require_read();
        if( !valid_kind( kind ) ) {
            throw std::invalid_argument( "registry.get received an unknown registry kind" );
        }
        if( id.empty() || id.size() > 256 ) {
            throw std::invalid_argument( "registry.get id must contain 1..256 bytes" );
        }
        return definition_snapshot( sol::state_view( lua_state ), kind, id );
    } );
    registry.set_function(
        "list",
        [catalog, require_read]( sol::this_state lua_state, const std::string & kind,
    const sol::optional<sol::table> &raw_options ) {
        require_read();
        if( !valid_kind( kind ) ) {
            throw std::invalid_argument( "registry.list received an unknown registry kind" );
        }
        const list_options options = read_list_options( raw_options );
        sol::state_view state( lua_state );
        const std::vector<registry_metadata> &index = catalog->index( kind );
        std::vector<const registry_metadata *> matches;
        matches.reserve( index.size() );
        for( const registry_metadata &entry : index ) {
            if( contains_query( entry.id, entry.name, options.query ) ) {
                matches.push_back( &entry );
            }
        }

        const std::size_t first = std::min<std::size_t>(
                                      static_cast<std::size_t>( options.offset ), matches.size() );
        const std::size_t last = std::min<std::size_t>(
                                     first + static_cast<std::size_t>( options.limit ), matches.size() );
        sol::table entries = state.create_table();
        for( std::size_t index = first; index < last; ++index ) {
            const registry_metadata &metadata = *matches[index];
            if( options.details ) {
                entries[index - first + 1] =
                    definition_snapshot( state, kind, metadata.id );
            } else {
                sol::table entry = state.create_table();
                entry["id"] = metadata.id;
                entry["name"] = metadata.name;
                entries[index - first + 1] = std::move( entry );
            }
        }

        sol::table result = state.create_table();
        result["kind"] = kind;
        result["revision"] = catalog->revision();
        result["offset"] = options.offset;
        result["limit"] = options.limit;
        result["total"] = matches.size();
        result["returned"] = last - first;
        result["has_more"] = last < matches.size();
        result["entries"] = std::move( entries );
        return result;
    } );
    registry.set_function( "revision", [catalog, require_read]() {
        require_read();
        return catalog->revision();
    } );
}

} // namespace cata::lua_ui
