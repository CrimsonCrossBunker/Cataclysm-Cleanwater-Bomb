#include "lua_platform_content_presentation.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <filesystem>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "activity_handlers.h"
#include "activity_type.h"
#include "ascii_art.h"
#include "clzones.h"
#include "end_screen.h"
#include "enum_conversions.h"
#include "event_statistics.h"
#include "generic_factory.h"
#include "help.h"
#include "lua_platform_content.h"
#include "lua_platform_runtime_internal.h"
#include "overlay_ordering.h"
#include "sounds.h"
#include "speech.h"
#include "text_snippets.h"
#include "translation.h"
#include "type_id.h"

namespace cata::lua_platform
{

namespace
{

enum class definition_operation : int {
    add,
    replace,
    edit
};

enum class handle_lifecycle : int {
    building,
    committed,
    discarded
};

struct owner_token {
    std::string mod_id;
    std::size_t generation = 0;
    handle_lifecycle lifecycle = handle_lifecycle::building;
};

struct score_definition_data {
    std::string id;
    std::string statistic;
    std::string description;
    bool registered = false;
};

struct overlay_order_definition_data {
    std::string id = "global";
    std::map<std::string, std::int64_t> orders;
    bool registered = false;
};

struct zone_type_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string display_field;
    bool can_be_personal = false;
    bool hidden = false;
    bool registered = false;
};

struct speech_pool_definition_data {
    std::string id;
    std::vector<std::pair<std::string, std::int64_t>> lines;
    bool registered = false;
};

struct end_screen_definition_data {
    std::string id;
    std::string picture;
    std::int64_t priority = 0;
    std::vector<std::tuple<std::int64_t, std::int64_t, std::string>> information;
    std::string last_words_label;
    std::string condition_handler;
    bool registered = false;
};

struct activity_type_definition_data {
    std::string id;
    std::string verb;
    bool rooted = false;
    bool interruptable = true;
    bool interruptable_with_keyboard = true;
    std::string based_on = "speed";
    bool can_resume = true;
    bool multi_activity = false;
    bool fetch_items_to_zone = true;
    bool refuel_fires = false;
    bool auto_needs = false;
    double activity_level = NO_EXERCISE;
    std::set<std::string> ignored_distractions;
    std::string do_turn_handler;
    std::string completion_handler;
    bool registered = false;
};

struct help_topic_definition_data {
    std::string id;
    std::string title;
    std::optional<std::int64_t> order;
    std::vector<std::string> paragraphs;
    bool registered = false;
};

struct snippet_entry_definition_data {
    std::string id;
    std::string text;
    std::string name;
    std::int64_t weight = 1;
    std::string examine_handler;
};

struct snippet_category_definition_data {
    std::string id;
    std::vector<snippet_entry_definition_data> entries;
    bool registered = false;
};

struct playlist_definition_data {
    std::string id;
    bool shuffle = false;
    std::vector<std::pair<std::string, std::int64_t>> tracks;
    bool registered = false;
};

struct sound_effect_definition_data {
    std::string id;
    std::string variant = "default";
    std::string season;
    std::optional<bool> indoors;
    std::optional<bool> night;
    std::int64_t volume = 100;
    std::vector<std::string> files;
    bool registered = false;
};

template<typename Definition>
void require_building_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &definition, const char *kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( "stale " ) + kind +
                                  " definition handle" );
    }
    if( definition.registered ) {
        throw std::runtime_error( std::string( kind ) +
                                  " definition is already registered" );
    }
}

template<typename Definition>
void require_readable_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &, const char *kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( "stale " ) + kind +
                                  " definition handle" );
    }
}

struct score_definition_handle {
    std::shared_ptr<score_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "score" );
        return definition->id;
    }
};

struct overlay_order_definition_handle {
    std::shared_ptr<overlay_order_definition_data> definition;
    std::shared_ptr<owner_token> token;

    overlay_order_definition_handle &mutation( const std::string &mutation_id,
            const std::int64_t order ) {
        require_building_handle( token, *definition, "overlay order" );
        if( mutation_id.empty() || !definition->orders.emplace( mutation_id, order ).second ) {
            throw std::runtime_error( "overlay order requires unique non-empty mutation ids" );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overlay order" );
        return definition->id;
    }
};

struct zone_type_definition_handle {
    std::shared_ptr<zone_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "zone type" );
        return definition->id;
    }
};

struct speech_pool_definition_handle {
    std::shared_ptr<speech_pool_definition_data> definition;
    std::shared_ptr<owner_token> token;

    speech_pool_definition_handle &line( const std::string &sound,
                                         const std::int64_t volume ) {
        require_building_handle( token, *definition, "speech pool" );
        if( sound.empty() ) {
            throw std::runtime_error( "speech-pool line cannot be empty" );
        }
        definition->lines.emplace_back( sound, volume );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "speech pool" );
        return definition->id;
    }
};

struct end_screen_definition_handle {
    std::shared_ptr<end_screen_definition_data> definition;
    std::shared_ptr<owner_token> token;

    end_screen_definition_handle &info( const std::int64_t column,
                                        const std::int64_t row,
                                        const std::string &text ) {
        require_building_handle( token, *definition, "end screen" );
        if( text.empty() ) {
            throw std::runtime_error( "end-screen information text cannot be empty" );
        }
        definition->information.emplace_back( column, row, text );
        return *this;
    }

    end_screen_definition_handle &condition( const std::string &handler_id ) {
        require_building_handle( token, *definition, "end screen" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "end-screen condition handler cannot be empty" );
        }
        definition->condition_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "end screen" );
        return definition->id;
    }
};

struct activity_type_definition_handle {
    std::shared_ptr<activity_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    activity_type_definition_handle &ignore( const std::string &distraction ) {
        require_building_handle( token, *definition, "activity type" );
        if( distraction.empty() ||
            !definition->ignored_distractions.insert( distraction ).second ) {
            throw std::runtime_error(
                "activity type requires unique non-empty ignored distractions" );
        }
        return *this;
    }

    activity_type_definition_handle &on_turn( const std::string &handler_id ) {
        require_building_handle( token, *definition, "activity type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "activity-type turn handler cannot be empty" );
        }
        definition->do_turn_handler = handler_id;
        return *this;
    }

    activity_type_definition_handle &on_finish( const std::string &handler_id ) {
        require_building_handle( token, *definition, "activity type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "activity-type completion handler cannot be empty" );
        }
        definition->completion_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "activity type" );
        return definition->id;
    }
};

struct help_topic_definition_handle {
    std::shared_ptr<help_topic_definition_data> definition;
    std::shared_ptr<owner_token> token;

    help_topic_definition_handle &paragraph( const std::string &text ) {
        require_building_handle( token, *definition, "help topic" );
        if( text.empty() ) {
            throw std::runtime_error( "help-topic paragraph cannot be empty" );
        }
        definition->paragraphs.push_back( text );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "help topic" );
        return definition->id;
    }
};

struct snippet_category_definition_handle {
    std::shared_ptr<snippet_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    snippet_category_definition_handle &text( const std::string &value,
            const sol::optional<std::int64_t> &weight ) {
        require_building_handle( token, *definition, "snippet category" );
        if( value.empty() ) {
            throw std::runtime_error( "snippet text cannot be empty" );
        }
        definition->entries.push_back( snippet_entry_definition_data{
            std::string(), value, std::string(), weight.value_or( 1 ), std::string()
        } );
        return *this;
    }

    snippet_category_definition_handle &entry( const sol::table &options ) {
        require_building_handle( token, *definition, "snippet category" );
        snippet_entry_definition_data value;
        value.id = options.get_or( "id", std::string() );
        value.text = options.get_or( "text", std::string() );
        value.name = options.get_or( "name", std::string() );
        value.weight = options.get_or<std::int64_t>( "weight", 1 );
        value.examine_handler = options.get_or( "on_examine", std::string() );
        if( value.id.empty() || value.text.empty() ) {
            throw std::runtime_error(
                "named snippet entries require non-empty id and text" );
        }
        definition->entries.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "snippet category" );
        return definition->id;
    }
};

struct playlist_definition_handle {
    std::shared_ptr<playlist_definition_data> definition;
    std::shared_ptr<owner_token> token;

    playlist_definition_handle &track( const std::string &file,
                                       const sol::optional<std::int64_t> &volume ) {
        require_building_handle( token, *definition, "playlist" );
        if( file.empty() ) {
            throw std::runtime_error( "playlist track file cannot be empty" );
        }
        definition->tracks.emplace_back( file, volume.value_or( 100 ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "playlist" );
        return definition->id;
    }
};

struct sound_effect_definition_handle {
    std::shared_ptr<sound_effect_definition_data> definition;
    std::shared_ptr<owner_token> token;

    sound_effect_definition_handle &file( const std::string &path ) {
        require_building_handle( token, *definition, "sound effect" );
        if( path.empty() ) {
            throw std::runtime_error( "sound effect file cannot be empty" );
        }
        definition->files.push_back( path );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "sound effect" );
        return definition->id;
    }
};

template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

using score_registration = catalog_registration<score_definition_data>;
using overlay_order_registration = catalog_registration<overlay_order_definition_data>;
using zone_type_registration = catalog_registration<zone_type_definition_data>;
using speech_pool_registration = catalog_registration<speech_pool_definition_data>;
using end_screen_registration = catalog_registration<end_screen_definition_data>;
using activity_type_registration = catalog_registration<activity_type_definition_data>;
using help_topic_registration = catalog_registration<help_topic_definition_data>;
using snippet_category_registration = catalog_registration<snippet_category_definition_data>;
using playlist_registration = catalog_registration<playlist_definition_data>;
using sound_effect_registration = catalog_registration<sound_effect_definition_data>;
using sound_effect_preload_registration = catalog_registration<sound_effect_definition_data>;

std::string operation_name( const definition_operation operation )
{
    switch( operation ) {
        case definition_operation::add:
            return "add";
        case definition_operation::replace:
            return "replace";
        case definition_operation::edit:
            return "edit";
    }
    return "unknown";
}

std::optional<based_on_type> platform_activity_based_on( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "time" ) {
        return based_on_type::TIME;
    }
    if( value == "speed" ) {
        return based_on_type::SPEED;
    }
    if( value == "neither" ) {
        return based_on_type::NEITHER;
    }
    return std::nullopt;
}

std::uint64_t fnv1a( const std::string_view value,
                     std::uint64_t state = 1469598103934665603ULL )
{
    for( const unsigned char byte : value ) {
        state ^= byte;
        state *= 1099511628211ULL;
    }
    return state;
}

void hash_part( std::uint64_t &state, const std::string_view value )
{
    state = fnv1a( std::to_string( value.size() ), state );
    state = fnv1a( ":", state );
    state = fnv1a( value, state );
    state = fnv1a( ";", state );
}

} // namespace

struct presentation_content_transaction::impl {
    impl( std::string owner_id, const std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;
    bool applied = false;
    mutable bool finalization_validated = false;

    std::vector<score_registration> scores;
    std::vector<overlay_order_registration> overlay_orders;
    std::vector<zone_type_registration> zone_types;
    std::vector<speech_pool_registration> speech_pools;
    std::vector<end_screen_registration> end_screens;
    std::vector<activity_type_registration> activity_types;
    std::vector<help_topic_registration> help_topics;
    std::vector<snippet_category_registration> snippet_categories;
    std::vector<playlist_registration> playlists;
    std::vector<sound_effect_registration> sound_effects;
    std::vector<sound_effect_preload_registration> sound_effect_preloads;

    std::vector<std::pair<score_id, std::optional<score>>> score_undo;
    std::vector<std::pair<std::string, std::optional<int>>> overlay_order_undo;
    std::vector<std::pair<zone_type_id, std::optional<zone_type>>> zone_type_undo;
    std::vector<std::pair<std::string, std::optional<std::vector<SpeechBubble>>>>
    speech_pool_undo;
    std::vector<std::pair<end_screen_id, std::optional<end_screen>>> end_screen_undo;
    std::vector<std::pair<activity_id, std::optional<activity_type>>> activity_type_undo;
    std::optional<help> help_undo;
    std::optional<snippet_library> snippet_library_undo;
    std::vector<std::pair<std::string, std::optional<sfx::playlist_definition>>>
    playlist_undo;
    std::vector<sfx::sound_effect_key> sound_effect_undo;
    std::vector<sfx::sound_effect_key> sound_effect_preload_undo;
};

presentation_content_transaction::presentation_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{
}

presentation_content_transaction::~presentation_content_transaction() = default;

void presentation_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    ccb.new_usertype<score_definition_handle>(
        "ScoreDefinition", sol::no_constructor,
        "id", sol::property( &score_definition_handle::id ) );
    ccb.new_usertype<overlay_order_definition_handle>(
        "OverlayOrderDefinition", sol::no_constructor,
        "id", sol::property( &overlay_order_definition_handle::id ),
        "mutation", &overlay_order_definition_handle::mutation );
    ccb.new_usertype<zone_type_definition_handle>(
        "ZoneTypeDefinition", sol::no_constructor,
        "id", sol::property( &zone_type_definition_handle::id ) );
    ccb.new_usertype<speech_pool_definition_handle>(
        "SpeechPoolDefinition", sol::no_constructor,
        "id", sol::property( &speech_pool_definition_handle::id ),
        "line", &speech_pool_definition_handle::line );
    ccb.new_usertype<end_screen_definition_handle>(
        "EndScreenDefinition", sol::no_constructor,
        "id", sol::property( &end_screen_definition_handle::id ),
        "info", &end_screen_definition_handle::info,
        "condition", &end_screen_definition_handle::condition );
    ccb.new_usertype<activity_type_definition_handle>(
        "ActivityTypeDefinition", sol::no_constructor,
        "id", sol::property( &activity_type_definition_handle::id ),
        "ignore", &activity_type_definition_handle::ignore,
        "on_turn", &activity_type_definition_handle::on_turn,
        "on_finish", &activity_type_definition_handle::on_finish );
    ccb.new_usertype<help_topic_definition_handle>(
        "HelpTopicDefinition", sol::no_constructor,
        "id", sol::property( &help_topic_definition_handle::id ),
        "paragraph", &help_topic_definition_handle::paragraph );
    ccb.new_usertype<snippet_category_definition_handle>(
        "SnippetCategoryDefinition", sol::no_constructor,
        "id", sol::property( &snippet_category_definition_handle::id ),
        "text", &snippet_category_definition_handle::text,
        "entry", &snippet_category_definition_handle::entry );
    ccb.new_usertype<playlist_definition_handle>(
        "PlaylistDefinition", sol::no_constructor,
        "id", sol::property( &playlist_definition_handle::id ),
        "track", &playlist_definition_handle::track );
    ccb.new_usertype<sound_effect_definition_handle>(
        "SoundEffectDefinition", sol::no_constructor,
        "id", sol::property( &sound_effect_definition_handle::id ),
        "file", &sound_effect_definition_handle::file );

    impl *const transaction = pimpl_.get();
    content.set_function( "Score", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<score_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->statistic = options.get_or( "statistic", std::string() );
        definition->description = options.get_or( "description", std::string() );
        return score_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "OverlayOrder", [transaction]() {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        return overlay_order_definition_handle{
            std::make_shared<overlay_order_definition_data>(), transaction->token
        };
    } );
    content.set_function( "ZoneType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<zone_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->display_field = options.get_or( "display_field", std::string() );
        definition->can_be_personal = options.get_or( "can_be_personal", false );
        definition->hidden = options.get_or( "hidden", false );
        return zone_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "SpeechPool", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<speech_pool_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return speech_pool_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "EndScreen", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<end_screen_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->picture = options.get_or( "picture", std::string() );
        definition->priority = options.get_or<std::int64_t>( "priority", 0 );
        definition->last_words_label = options.get_or(
                                           "last_words_label", std::string() );
        return end_screen_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ActivityType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<activity_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->verb = options.get_or( "verb", std::string() );
        definition->rooted = options.get_or( "rooted", false );
        definition->interruptable = options.get_or( "interruptable", true );
        definition->interruptable_with_keyboard = options.get_or(
                    "interruptable_with_keyboard", true );
        definition->based_on = options.get_or( "based_on", std::string( "speed" ) );
        definition->can_resume = options.get_or( "can_resume", true );
        definition->multi_activity = options.get_or( "multi_activity", false );
        definition->fetch_items_to_zone = options.get_or( "fetch_items_to_zone", true );
        definition->refuel_fires = options.get_or( "refuel_fires", false );
        definition->auto_needs = options.get_or( "auto_needs", false );
        definition->activity_level = options.get_or( "activity_level", 1.0 );
        return activity_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "HelpTopic", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<help_topic_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->title = options.get_or( "title", std::string() );
        if( const sol::optional<std::int64_t> order =
                options.get<sol::optional<std::int64_t>>( "order" ) ) {
            definition->order = *order;
        }
        return help_topic_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "SnippetCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<snippet_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return snippet_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Playlist", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<playlist_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->shuffle = options.get_or( "shuffle", false );
        return playlist_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "SoundEffect", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<sound_effect_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->variant = options.get_or( "variant", std::string( "default" ) );
        definition->season = options.get_or( "season", std::string() );
        if( const sol::optional<bool> indoors =
                options.get<sol::optional<bool>>( "is_indoors" ) ) {
            definition->indoors = *indoors;
        }
        if( const sol::optional<bool> night =
                options.get<sol::optional<bool>>( "is_night" ) ) {
            definition->night = *night;
        }
        definition->volume = options.get_or<std::int64_t>( "volume", 100 );
        return sound_effect_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "SoundEffectPreload", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<sound_effect_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->variant = options.get_or( "variant", std::string( "default" ) );
        definition->season = options.get_or( "season", std::string() );
        if( const sol::optional<bool> indoors =
                options.get<sol::optional<bool>>( "is_indoors" ) ) {
            definition->indoors = *indoors;
        }
        if( const sol::optional<bool> night =
                options.get<sol::optional<bool>>( "is_night" ) ) {
            definition->night = *night;
        }
        return sound_effect_definition_handle{ std::move( definition ), transaction->token };
    } );

    auto edit_catalog = [transaction]( const std::string & id, auto & registrations,
    const char *kind ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if( registrations.rbegin(), registrations.rend(),
        [&id]( const auto & entry ) {
            return entry.definition->id == id;
        } );
        if( found == registrations.rend() ) {
            throw std::runtime_error( std::string( "edit_" ) + kind +
                                      " requires a definition staged earlier by this Mod" );
        }
        auto definition = std::make_shared < std::decay_t < decltype( *found->definition ) >> (
                              *found->definition );
        definition->registered = false;
        return definition;
    };
    content.set_function( "edit_score", [transaction, edit_catalog]( const std::string & id ) {
        return score_definition_handle{
            edit_catalog( id, transaction->scores, "score" ), transaction->token
        };
    } );
    content.set_function( "edit_overlay_order", [transaction, edit_catalog]() {
        return overlay_order_definition_handle{
            edit_catalog( "global", transaction->overlay_orders, "overlay_order" ),
            transaction->token
        };
    } );
    content.set_function( "edit_zone_type", [transaction, edit_catalog]( const std::string & id ) {
        return zone_type_definition_handle{
            edit_catalog( id, transaction->zone_types, "zone_type" ), transaction->token
        };
    } );
    content.set_function( "edit_speech_pool", [transaction, edit_catalog]( const std::string & id ) {
        return speech_pool_definition_handle{
            edit_catalog( id, transaction->speech_pools, "speech_pool" ), transaction->token
        };
    } );
    content.set_function( "edit_end_screen", [transaction, edit_catalog]( const std::string & id ) {
        return end_screen_definition_handle{
            edit_catalog( id, transaction->end_screens, "end_screen" ), transaction->token
        };
    } );
    content.set_function( "edit_activity_type", [transaction, edit_catalog]( const std::string & id ) {
        return activity_type_definition_handle{
            edit_catalog( id, transaction->activity_types, "activity_type" ), transaction->token
        };
    } );
    content.set_function( "edit_help_topic", [transaction, edit_catalog]( const std::string & id ) {
        return help_topic_definition_handle{
            edit_catalog( id, transaction->help_topics, "help_topic" ), transaction->token
        };
    } );
    content.set_function( "edit_snippet_category", [transaction,
    edit_catalog]( const std::string & id ) {
        return snippet_category_definition_handle{
            edit_catalog( id, transaction->snippet_categories, "snippet_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_playlist", [transaction, edit_catalog]( const std::string & id ) {
        return playlist_definition_handle{
            edit_catalog( id, transaction->playlists, "playlist" ), transaction->token
        };
    } );

    static_cast<void>( lua );
}

bool presentation_content_transaction::register_definition( const sol::object &value,
        const int raw_operation )
{
    if( raw_operation < 0 || raw_operation > 2 ) {
        throw std::runtime_error( "invalid Platform content operation" );
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( "content transaction is no longer building" );
    }
    const definition_operation operation = static_cast<definition_operation>( raw_operation );
    const auto register_catalog = [this, operation]( auto handle, auto & registrations,
    const char *kind ) {
        if( handle.token != pimpl_->token ) {
            throw std::runtime_error( std::string( "cannot register a " ) + kind +
                                      " definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, kind );
        handle.definition->registered = true;
        if( operation == definition_operation::edit ) {
            const auto target = std::find_if( registrations.rbegin(), registrations.rend(),
            [&handle]( const auto & entry ) {
                return entry.definition->id == handle.definition->id;
            } );
            if( target == registrations.rend() ) {
                handle.definition->registered = false;
                throw std::runtime_error( std::string( "edit requires a " ) + kind +
                                          " staged earlier by this Mod" );
            }
            target->definition = handle.definition;
            return;
        }
        registrations.push_back( { operation, handle.definition } );
    };

    if( value.is<score_definition_handle>() ) {
        register_catalog( value.as<score_definition_handle>(), pimpl_->scores, "score" );
        return true;
    }
    if( value.is<overlay_order_definition_handle>() ) {
        register_catalog( value.as<overlay_order_definition_handle>(), pimpl_->overlay_orders,
                          "overlay order" );
        return true;
    }
    if( value.is<zone_type_definition_handle>() ) {
        register_catalog( value.as<zone_type_definition_handle>(), pimpl_->zone_types,
                          "zone type" );
        return true;
    }
    if( value.is<speech_pool_definition_handle>() ) {
        register_catalog( value.as<speech_pool_definition_handle>(), pimpl_->speech_pools,
                          "speech pool" );
        return true;
    }
    if( value.is<end_screen_definition_handle>() ) {
        register_catalog( value.as<end_screen_definition_handle>(), pimpl_->end_screens,
                          "end screen" );
        return true;
    }
    if( value.is<activity_type_definition_handle>() ) {
        register_catalog( value.as<activity_type_definition_handle>(), pimpl_->activity_types,
                          "activity type" );
        return true;
    }
    if( value.is<help_topic_definition_handle>() ) {
        register_catalog( value.as<help_topic_definition_handle>(), pimpl_->help_topics,
                          "help topic" );
        return true;
    }
    if( value.is<snippet_category_definition_handle>() ) {
        register_catalog( value.as<snippet_category_definition_handle>(),
                          pimpl_->snippet_categories, "snippet category" );
        return true;
    }
    if( value.is<playlist_definition_handle>() ) {
        register_catalog( value.as<playlist_definition_handle>(), pimpl_->playlists,
                          "playlist" );
        return true;
    }
    if( value.is<sound_effect_definition_handle>() ) {
        sound_effect_definition_handle handle = value.as<sound_effect_definition_handle>();
        if( handle.token != pimpl_->token ) {
            throw std::runtime_error(
                "cannot register a sound effect definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "sound effect" );
        handle.definition->registered = true;
        if( operation == definition_operation::edit ) {
            throw std::runtime_error( "sound effects cannot be edited" );
        }
        if( handle.definition->files.empty() ) {
            pimpl_->sound_effect_preloads.push_back( { operation, handle.definition } );
        } else {
            pimpl_->sound_effects.push_back( { operation, handle.definition } );
        }
        return true;
    }
    return false;
}

bool presentation_content_transaction::validate( const runtime &owner_runtime,
        const bool check_engine_state,
        const std::set<std::string> &staged_event_statistics,
        const std::set<std::string> &staged_field_types,
        const std::set<std::string> &staged_ascii_arts,
        std::string &error ) const
{
    try {
        const auto require_valid_id = []( const std::string & id, const char *kind ) {
            if( id.empty() || id.find( '#' ) != std::string::npos ||
                id.find( '\0' ) != std::string::npos || id.size() > 256 ) {
                throw std::runtime_error( std::string( "invalid " ) + kind + " id '" + id + "'" );
            }
        };
        const auto validate_operation = [check_engine_state](
                                            const definition_operation operation, const bool exists,
        const std::string & id, const char *kind ) {
            if( !check_engine_state ) {
                return;
            }
            if( operation == definition_operation::add && exists ) {
                throw std::runtime_error( std::string( "add would overwrite existing " ) +
                                          kind + " '" + id + "'; use replace explicitly" );
            }
            if( operation == definition_operation::replace && !exists ) {
                throw std::runtime_error( std::string( "replace requires existing " ) +
                                          kind + " '" + id + "'" );
            }
        };

        std::set<std::string> score_ids;
        for( const score_registration &entry : pimpl_->scores ) {
            const score_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "score" );
            if( !score_ids.insert( definition.id ).second || definition.statistic.empty() ||
                ( check_engine_state &&
                  staged_event_statistics.count( definition.statistic ) == 0 &&
                  !event_statistic_id( definition.statistic ).is_valid() ) ) {
                throw std::runtime_error( "score '" + definition.id +
                                          "' has an invalid statistic or duplicate registration" );
            }
            validate_operation( entry.operation, score_id( definition.id ).is_valid(),
                                definition.id, "score" );
        }

        if( pimpl_->overlay_orders.size() > 1 ) {
            throw std::runtime_error(
                "overlay order singleton is registered more than once per transaction" );
        }
        for( const overlay_order_registration &entry : pimpl_->overlay_orders ) {
            const overlay_order_definition_data &definition = *entry.definition;
            if( definition.id != "global" || definition.orders.empty() ) {
                throw std::runtime_error(
                    "overlay order requires the global singleton and at least one mutation" );
            }
            for( const auto &[mutation_id, order] : definition.orders ) {
                if( mutation_id.empty() || order < std::numeric_limits<int>::min() ||
                    order > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "overlay order for mutation '" + mutation_id +
                                              "' is outside the native integer range" );
                }
                validate_operation( entry.operation,
                                    base_mutation_overlay_ordering.count( mutation_id ) != 0,
                                    mutation_id, "mutation overlay order" );
            }
        }

        std::set<std::string> zone_type_ids;
        for( const zone_type_registration &entry : pimpl_->zone_types ) {
            const zone_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "zone type" );
            if( !zone_type_ids.insert( definition.id ).second || definition.name.empty() ||
                definition.display_field.empty() ||
                ( check_engine_state && staged_field_types.count( definition.display_field ) == 0 &&
                  !field_type_str_id( definition.display_field ).is_valid() ) ) {
                throw std::runtime_error( "zone type '" + definition.id +
                                          "' has invalid presentation or a duplicate registration" );
            }
            validate_operation( entry.operation, zone_type_id( definition.id ).is_valid(),
                                definition.id, "zone type" );
        }

        std::set<std::string> speech_pool_ids;
        for( const speech_pool_registration &entry : pimpl_->speech_pools ) {
            const speech_pool_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "speech pool" );
            if( !speech_pool_ids.insert( definition.id ).second || definition.lines.empty() ) {
                throw std::runtime_error( "speech pool '" + definition.id +
                                          "' requires lines and one registration per transaction" );
            }
            for( const auto &[sound, volume] : definition.lines ) {
                if( sound.empty() || volume < std::numeric_limits<int>::min() ||
                    volume > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "speech pool '" + definition.id +
                                              "' has an invalid line" );
                }
            }
            validate_operation( entry.operation,
                                detail::speech_registry_find( definition.id ) != nullptr,
                                definition.id, "speech pool" );
        }

        std::set<std::string> end_screen_ids;
        for( const end_screen_registration &entry : pimpl_->end_screens ) {
            const end_screen_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "end screen" );
            const bool staged_picture = staged_ascii_arts.count( definition.picture ) != 0;
            if( !end_screen_ids.insert( definition.id ).second || definition.picture.empty() ||
                definition.condition_handler.empty() ||
                definition.priority < std::numeric_limits<int>::min() ||
                definition.priority > std::numeric_limits<int>::max() ||
                ( check_engine_state && !staged_picture &&
                  !ascii_art_id( definition.picture ).is_valid() ) ) {
                throw std::runtime_error( "end screen '" + definition.id +
                                          "' has invalid presentation, policy, or a duplicate registration" );
            }
            for( const auto &[column, row, text] : definition.information ) {
                if( text.empty() || column < std::numeric_limits<int>::min() ||
                    column > std::numeric_limits<int>::max() ||
                    row < std::numeric_limits<int>::min() ||
                    row > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "end screen '" + definition.id +
                                              "' has invalid positioned information" );
                }
            }
            if( owner_runtime.handlers.count( definition.condition_handler ) == 0 ) {
                throw std::runtime_error( "end screen '" + definition.id +
                                          "' references missing condition handler '" +
                                          definition.condition_handler + "'" );
            }
            validate_operation( entry.operation, end_screen_id( definition.id ).is_valid(),
                                definition.id, "end screen" );
        }

        std::set<std::string> activity_type_ids;
        for( const activity_type_registration &entry : pimpl_->activity_types ) {
            const activity_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "activity type" );
            const std::optional<based_on_type> based_on =
                platform_activity_based_on( definition.based_on );
            if( !activity_type_ids.insert( definition.id ).second || definition.verb.empty() ||
                !based_on || !std::isfinite( definition.activity_level ) ||
                definition.activity_level <= 0.0 ||
                definition.activity_level > std::numeric_limits<float>::max() ) {
                throw std::runtime_error( "activity type '" + definition.id +
                                          "' has invalid timing, exertion, presentation, or a duplicate registration" );
            }
            for( const std::string &distraction : definition.ignored_distractions ) {
                if( !io::enum_is_valid<distraction_type>( distraction ) ) {
                    throw std::runtime_error( "activity type '" + definition.id +
                                              "' has an invalid ignored distraction '" +
                                              distraction + "'" );
                }
            }
            if( !definition.do_turn_handler.empty() &&
                owner_runtime.handlers.count( definition.do_turn_handler ) == 0 ) {
                throw std::runtime_error( "activity type '" + definition.id +
                                          "' references missing turn handler '" +
                                          definition.do_turn_handler + "'" );
            }
            if( !definition.completion_handler.empty() &&
                owner_runtime.handlers.count( definition.completion_handler ) == 0 ) {
                throw std::runtime_error( "activity type '" + definition.id +
                                          "' references missing completion handler '" +
                                          definition.completion_handler + "'" );
            }
            const activity_id id( definition.id );
            const bool has_actor = activity_actors::deserialize_functions.count( id ) != 0;
            const bool has_native_turn = activity_handlers::do_turn_functions.count( id ) != 0;
            if( *based_on == based_on_type::NEITHER &&
                definition.do_turn_handler.empty() && !has_actor && !has_native_turn ) {
                throw std::runtime_error( "activity type '" + definition.id +
                                          "' is based on neither time nor speed and requires a Lua turn policy, native actor, or native turn handler" );
            }
            validate_operation( entry.operation, id.is_valid(), definition.id,
                                "activity type" );
        }

        std::set<std::string> help_topic_ids;
        std::set<int> help_topic_orders;
        for( const help_topic_registration &entry : pimpl_->help_topics ) {
            const help_topic_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "help topic" );
            if( !help_topic_ids.insert( definition.id ).second || definition.title.empty() ||
                definition.paragraphs.empty() ||
                ( definition.order &&
                  ( *definition.order < std::numeric_limits<int>::min() ||
                    *definition.order > std::numeric_limits<int>::max() ||
                    !help_topic_orders.insert( static_cast<int>( *definition.order ) ).second ) ) ) {
                throw std::runtime_error( "help topic '" + definition.id +
                                          "' has invalid presentation, order, or a duplicate registration" );
            }
            if( std::any_of( definition.paragraphs.begin(), definition.paragraphs.end(),
            []( const std::string & paragraph ) {
            return paragraph.empty();
            } ) ) {
                throw std::runtime_error( "help topic '" + definition.id +
                                          "' has an empty paragraph" );
            }
            const auto existing_id = get_help().platform_help_topic_orders.find( definition.id );
            const bool exists = existing_id != get_help().platform_help_topic_orders.end();
            if( check_engine_state && definition.order ) {
                const auto existing_order = get_help().help_texts.find(
                                                static_cast<int>( *definition.order ) );
                const bool order_owned_by_self = exists &&
                                                 existing_id->second == *definition.order;
                if( existing_order != get_help().help_texts.end() && !order_owned_by_self ) {
                    throw std::runtime_error( "help topic '" + definition.id +
                                              "' collides with an existing display order" );
                }
            }
            validate_operation( entry.operation, exists, definition.id, "help topic" );
        }

        std::set<std::string> snippet_category_ids;
        std::set<std::string> staged_snippet_ids;
        for( const snippet_category_registration &entry : pimpl_->snippet_categories ) {
            const snippet_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "snippet category" );
            if( !snippet_category_ids.insert( definition.id ).second ||
                definition.entries.empty() ) {
                throw std::runtime_error( "snippet category '" + definition.id +
                                          "' requires entries and one registration per transaction" );
            }
            std::set<snippet_id> existing_category_ids;
            const auto existing_category = SNIPPET.snippets_by_category.find( definition.id );
            if( existing_category != SNIPPET.snippets_by_category.end() ) {
                for( const snippet_library::weighted_id &value : existing_category->second.ids ) {
                    existing_category_ids.insert( value.value );
                }
            }
            std::uint64_t category_weight = 0;
            for( const snippet_entry_definition_data &snippet : definition.entries ) {
                if( snippet.text.empty() || snippet.weight <= 0 ) {
                    throw std::runtime_error( "snippet category '" + definition.id +
                                              "' has an invalid text or weight" );
                }
                const std::uint64_t weight = static_cast<std::uint64_t>( snippet.weight );
                if( category_weight > std::numeric_limits<std::uint64_t>::max() - weight ) {
                    throw std::runtime_error( "snippet category '" + definition.id +
                                              "' cumulative weight overflows" );
                }
                category_weight += weight;
                if( snippet.id.empty() ) {
                    if( !snippet.name.empty() || !snippet.examine_handler.empty() ) {
                        throw std::runtime_error( "anonymous snippet in category '" +
                                                  definition.id +
                                                  "' cannot have a name or examine policy" );
                    }
                    continue;
                }
                require_valid_id( snippet.id, "snippet" );
                if( !staged_snippet_ids.insert( snippet.id ).second ) {
                    throw std::runtime_error( "snippet id '" + snippet.id +
                                              "' is registered more than once per transaction" );
                }
                const snippet_id id( snippet.id );
                if( check_engine_state && id.is_valid() &&
                    ( entry.operation == definition_operation::add ||
                      existing_category_ids.count( id ) == 0 ) ) {
                    throw std::runtime_error( "snippet id '" + snippet.id +
                                              "' would duplicate an existing snippet" );
                }
                if( !snippet.examine_handler.empty() &&
                    owner_runtime.handlers.count( snippet.examine_handler ) == 0 ) {
                    throw std::runtime_error( "snippet '" + snippet.id +
                                              "' references missing examine handler '" +
                                              snippet.examine_handler + "'" );
                }
            }
            if( check_engine_state && entry.operation == definition_operation::replace &&
                existing_category == SNIPPET.snippets_by_category.end() ) {
                throw std::runtime_error( "replace requires existing snippet category '" +
                                          definition.id + "'" );
            }
        }

        std::set<std::string> playlist_ids;
        for( const playlist_registration &entry : pimpl_->playlists ) {
            const playlist_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "playlist" );
            if( !playlist_ids.insert( definition.id ).second || definition.tracks.empty() ) {
                throw std::runtime_error( "playlist '" + definition.id +
                                          "' requires tracks and one registration per transaction" );
            }
            for( const auto &[file, volume] : definition.tracks ) {
                const std::filesystem::path path( file );
                const bool traverses_parent = std::any_of(
                path.begin(), path.end(), []( const auto & part ) {
                    return part == "..";
                } );
                if( file.empty() || file.size() > 4096 || file.find( '\0' ) != std::string::npos ||
                    path.is_absolute() || traverses_parent || volume < 0 || volume > 128 ) {
                    throw std::runtime_error( "playlist '" + definition.id +
                                              "' has an invalid relative track or volume" );
                }
            }
            validate_operation( entry.operation,
                                sfx::playlist_registry_get( definition.id ).has_value(),
                                definition.id, "playlist" );
        }

        for( const sound_effect_registration &entry : pimpl_->sound_effects ) {
            const sound_effect_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "sound effect" );
            require_valid_id( definition.variant, "sound effect variant" );
            if( definition.volume < 0 || definition.volume > 128 ) {
                throw std::runtime_error( "sound effect '" + definition.id +
                                          "' has a volume outside 0..128" );
            }
            for( const std::string &file : definition.files ) {
                const std::filesystem::path path( file );
                const bool traverses_parent = std::any_of(
                path.begin(), path.end(), []( const auto & part ) {
                    return part == "..";
                } );
                if( file.empty() || file.size() > 4096 || file.find( '\0' ) != std::string::npos ||
                    path.is_absolute() || traverses_parent ) {
                    throw std::runtime_error( "sound effect '" + definition.id +
                                              "' has an invalid relative file" );
                }
            }
            validate_operation( entry.operation, false, definition.id, "sound effect" );
        }
        for( const sound_effect_preload_registration &entry : pimpl_->sound_effect_preloads ) {
            const sound_effect_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "sound effect preload" );
            require_valid_id( definition.variant, "sound effect variant" );
            validate_operation( entry.operation, false, definition.id,
                                "sound effect preload" );
        }
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
    error.clear();
    return true;
}

bool presentation_content_transaction::apply( std::string &error )
{
    if( pimpl_->applied ) {
        error = "presentation content transaction for '" + pimpl_->owner +
                "' was already applied";
        return false;
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "presentation content transaction for '" + pimpl_->owner +
                "' is no longer building";
        return false;
    }
    try {
        for( const score_registration &entry : pimpl_->scores ) {
            const score_id id( entry.definition->id );
            pimpl_->score_undo.emplace_back(
                id, id.is_valid() ? std::optional<score>( id.obj() ) : std::nullopt );
            const score_definition_data &source = *entry.definition;
            score native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.stat_ = event_statistic_id( source.statistic );
            native.description_ = source.description.empty() ? translation() :
                                  no_translation( source.description );
            detail::score_registry().insert( native );
        }
        if( !pimpl_->scores.empty() ) {
            detail::score_registry().finalize();
        }

        for( const overlay_order_registration &entry : pimpl_->overlay_orders ) {
            for( const auto &[mutation_id, order] : entry.definition->orders ) {
                const auto existing = base_mutation_overlay_ordering.find( mutation_id );
                pimpl_->overlay_order_undo.emplace_back(
                    mutation_id,
                    existing == base_mutation_overlay_ordering.end() ? std::nullopt :
                    std::optional<int>( existing->second ) );
                base_mutation_overlay_ordering[mutation_id] = static_cast<int>( order );
            }
        }

        for( const zone_type_registration &entry : pimpl_->zone_types ) {
            const zone_type_id id( entry.definition->id );
            pimpl_->zone_type_undo.emplace_back(
                id, id.is_valid() ? std::optional<zone_type>( id.obj() ) : std::nullopt );
            const zone_type_definition_data &source = *entry.definition;
            const translation description = source.description.empty() ? translation() :
                                            no_translation( source.description );
            zone_type native( no_translation( source.name ), description,
                              field_type_str_id( source.display_field ) );
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.can_be_personal = source.can_be_personal;
            native.hidden = source.hidden;
            detail::zone_type_registry().insert( native );
        }
        if( !pimpl_->zone_types.empty() ) {
            detail::zone_type_registry().finalize();
        }

        for( const speech_pool_registration &entry : pimpl_->speech_pools ) {
            const speech_pool_definition_data &source = *entry.definition;
            const std::vector<SpeechBubble> *const previous =
                detail::speech_registry_find( source.id );
            pimpl_->speech_pool_undo.emplace_back(
                source.id, previous == nullptr ? std::nullopt :
                std::optional<std::vector<SpeechBubble>>( *previous ) );
            std::vector<SpeechBubble> native;
            native.reserve( source.lines.size() );
            for( const auto &[sound, volume] : source.lines ) {
                native.push_back( SpeechBubble{ no_translation( sound ),
                                                static_cast<int>( volume ) } );
            }
            detail::speech_registry_set( source.id, std::move( native ) );
        }

        for( const end_screen_registration &entry : pimpl_->end_screens ) {
            const end_screen_id id( entry.definition->id );
            pimpl_->end_screen_undo.emplace_back(
                id, id.is_valid() ? std::optional<end_screen>( id.obj() ) : std::nullopt );
            const end_screen_definition_data &source = *entry.definition;
            end_screen native;
            native.id = id;
            native.picture_id = ascii_art_id( source.picture );
            native.priority = static_cast<int>( source.priority );
            native.last_words_label = source.last_words_label;
            for( const auto &[column, row, text] : source.information ) {
                native.added_info.push_back( {
                    { static_cast<int>( column ), static_cast<int>( row ) }, text
                } );
            }
            native.condition = []( const const_dialogue & ) {
                return false;
            };
            native.was_loaded = true;
            detail::end_screen_registry().insert( native );
        }
        if( !pimpl_->end_screens.empty() ) {
            detail::end_screen_registry().finalize();
        }

        for( const activity_type_registration &entry : pimpl_->activity_types ) {
            const activity_id id( entry.definition->id );
            pimpl_->activity_type_undo.emplace_back(
                id, detail::activity_type_registry_get( id ) );
            const activity_type_definition_data &source = *entry.definition;
            activity_type native;
            native.id_ = id;
            native.rooted_ = source.rooted;
            native.verb_ = no_translation( source.verb );
            native.interruptable_ = source.interruptable;
            native.interruptable_with_kb_ = source.interruptable_with_keyboard;
            native.based_on_ = *platform_activity_based_on( source.based_on );
            native.can_resume_ = source.can_resume;
            native.multi_activity_ = source.multi_activity;
            native.fetch_items_to_zone_ = source.fetch_items_to_zone;
            native.refuel_fires = source.refuel_fires;
            native.auto_needs = source.auto_needs;
            native.activity_level = static_cast<float>( source.activity_level );
            for( const std::string &distraction : source.ignored_distractions ) {
                native.default_ignored_distractions_.insert(
                    io::string_to_enum<distraction_type>( distraction ) );
            }
            native.completion_EOC = effect_on_condition_id();
            native.do_turn_EOC = effect_on_condition_id();
            native.was_loaded = true;
            detail::activity_type_registry_set( native );
        }

        if( !pimpl_->help_topics.empty() ) {
            pimpl_->help_undo = get_help();
        }
        for( const help_topic_registration &entry : pimpl_->help_topics ) {
            const help_topic_definition_data &source = *entry.definition;
            help &registry = get_help();
            const auto previous = registry.platform_help_topic_orders.find( source.id );
            if( previous != registry.platform_help_topic_orders.end() ) {
                registry.help_texts.erase( previous->second );
            }
            std::vector<translation> paragraphs;
            paragraphs.reserve( source.paragraphs.size() );
            for( const std::string &paragraph : source.paragraphs ) {
                paragraphs.push_back( no_translation( paragraph ) );
            }
            int order = 0;
            if( source.order ) {
                order = static_cast<int>( *source.order );
            } else if( previous != registry.platform_help_topic_orders.end() ) {
                order = previous->second;
            } else if( !registry.help_texts.empty() ) {
                if( registry.help_texts.crbegin()->first == std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "automatic help-topic display order is exhausted" );
                }
                order = registry.help_texts.crbegin()->first + 1;
            }
            registry.help_texts[order] = std::make_pair(
                                             no_translation( source.title ),
                                             std::move( paragraphs ) );
            registry.platform_help_topic_orders[source.id] = order;
        }

        if( !pimpl_->snippet_categories.empty() ) {
            pimpl_->snippet_library_undo = SNIPPET;
            SNIPPET.hash_to_id_migration.reset();
        }
        for( const snippet_category_registration &entry : pimpl_->snippet_categories ) {
            const snippet_category_definition_data &source = *entry.definition;
            auto previous = SNIPPET.snippets_by_category.find( source.id );
            if( entry.operation == definition_operation::replace &&
                previous != SNIPPET.snippets_by_category.end() ) {
                for( const snippet_library::weighted_id &value : previous->second.ids ) {
                    SNIPPET.snippets_by_id.erase( value.value );
                    SNIPPET.name_by_id.erase( value.value );
                    SNIPPET.EOC_by_id.erase( value.value );
                }
            }
            snippet_library::category_snippets &category =
                SNIPPET.snippets_by_category[source.id];
            if( entry.operation == definition_operation::replace ) {
                category.ids.clear();
                category.no_id.clear();
            }
            for( const snippet_entry_definition_data &snippet : source.entries ) {
                const std::uint64_t weight = static_cast<std::uint64_t>( snippet.weight );
                if( snippet.id.empty() ) {
                    const std::uint64_t accumulated = category.no_id.empty() ? weight :
                                                      category.no_id.back().weight_acc + weight;
                    category.no_id.push_back( snippet_library::weighted_translation{
                        accumulated, no_translation( snippet.text )
                    } );
                } else {
                    const snippet_id id( snippet.id );
                    const std::uint64_t accumulated = category.ids.empty() ? weight :
                                                      category.ids.back().weight_acc + weight;
                    category.ids.push_back( snippet_library::weighted_id{ accumulated, id } );
                    SNIPPET.snippets_by_id[id] = no_translation( snippet.text );
                    SNIPPET.name_by_id[id] = snippet.name.empty() ? translation() :
                                             no_translation( snippet.name );
                    // Lua-authored snippets deliberately do not populate EOC_by_id.
                    SNIPPET.EOC_by_id.erase( id );
                }
            }
        }

        for( const playlist_registration &entry : pimpl_->playlists ) {
            const playlist_definition_data &source = *entry.definition;
            pimpl_->playlist_undo.emplace_back(
                source.id, sfx::playlist_registry_get( source.id ) );
            sfx::playlist_definition native;
            native.id = source.id;
            native.shuffle = source.shuffle;
            for( const auto &[file, volume] : source.tracks ) {
                native.entries.push_back( sfx::playlist_entry_definition{
                    file, static_cast<int>( volume )
                } );
            }
            sfx::playlist_registry_set( native );
        }

        for( const sound_effect_registration &entry : pimpl_->sound_effects ) {
            const sound_effect_definition_data &source = *entry.definition;
            sfx::sound_effect_key key{
                source.id, source.variant, source.season, source.indoors, source.night
            };
            pimpl_->sound_effect_undo.push_back( key );
            sfx::register_sound_effect( key, static_cast<int>( source.volume ), source.files );
        }
        for( const sound_effect_preload_registration &entry : pimpl_->sound_effect_preloads ) {
            const sound_effect_definition_data &source = *entry.definition;
            sfx::sound_effect_key key{
                source.id, source.variant, source.season, source.indoors, source.night
            };
            pimpl_->sound_effect_preload_undo.push_back( key );
            sfx::register_sound_effect_preload( key );
        }

        pimpl_->applied = true;
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool presentation_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "presentation content transaction is not applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "presentation content finalization was already validated";
        return false;
    }
    for( const score_registration &entry : pimpl_->scores ) {
        if( !score_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first score '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const overlay_order_registration &entry : pimpl_->overlay_orders ) {
        for( const auto &[mutation_id, order] : entry.definition->orders ) {
            const auto found = base_mutation_overlay_ordering.find( mutation_id );
            if( found == base_mutation_overlay_ordering.end() ||
                found->second != static_cast<int>( order ) ) {
                error = "Lua-first overlay order for mutation '" + mutation_id +
                        "' did not survive global finalization";
                return false;
            }
        }
    }
    for( const zone_type_registration &entry : pimpl_->zone_types ) {
        if( !zone_type_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first zone type '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const speech_pool_registration &entry : pimpl_->speech_pools ) {
        const std::vector<SpeechBubble> *const found =
            detail::speech_registry_find( entry.definition->id );
        if( found == nullptr || found->size() != entry.definition->lines.size() ) {
            error = "Lua-first speech pool '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
        for( std::size_t index = 0; index < found->size(); ++index ) {
            if( ( *found )[index].text.translated() !=
                entry.definition->lines[index].first ||
                ( *found )[index].volume != entry.definition->lines[index].second ) {
                error = "Lua-first speech pool '" + entry.definition->id +
                        "' changed during global finalization";
                return false;
            }
        }
    }
    for( const end_screen_registration &entry : pimpl_->end_screens ) {
        if( !end_screen_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first end screen '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const activity_type_registration &entry : pimpl_->activity_types ) {
        if( !activity_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first activity type '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const help_topic_registration &entry : pimpl_->help_topics ) {
        const auto found = get_help().platform_help_topic_orders.find( entry.definition->id );
        if( found == get_help().platform_help_topic_orders.end() ||
            ( entry.definition->order && found->second != *entry.definition->order ) ||
            get_help().help_texts.count( found->second ) == 0 ) {
            error = "Lua-first help topic '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const snippet_category_registration &entry : pimpl_->snippet_categories ) {
        const auto found = SNIPPET.snippets_by_category.find( entry.definition->id );
        if( found == SNIPPET.snippets_by_category.end() ) {
            error = "Lua-first snippet category '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
        for( const snippet_entry_definition_data &snippet : entry.definition->entries ) {
            if( !snippet.id.empty() && !snippet_id( snippet.id ).is_valid() ) {
                error = "Lua-first snippet '" + snippet.id +
                        "' did not survive global finalization";
                return false;
            }
        }
    }
    for( const playlist_registration &entry : pimpl_->playlists ) {
        const std::optional<sfx::playlist_definition> found =
            sfx::playlist_registry_get( entry.definition->id );
        if( !found || found->entries.size() != entry.definition->tracks.size() ) {
            error = "Lua-first playlist '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void presentation_content_transaction::rollback()
{
    for( auto it = pimpl_->playlist_undo.rbegin();
         it != pimpl_->playlist_undo.rend(); ++it ) {
        if( it->second ) {
            sfx::playlist_registry_set( *it->second );
        } else {
            sfx::playlist_registry_erase( it->first );
        }
    }
    pimpl_->playlist_undo.clear();

    for( auto it = pimpl_->sound_effect_undo.rbegin();
         it != pimpl_->sound_effect_undo.rend(); ++it ) {
        sfx::erase_sound_effect( *it );
    }
    pimpl_->sound_effect_undo.clear();

    for( auto it = pimpl_->sound_effect_preload_undo.rbegin();
         it != pimpl_->sound_effect_preload_undo.rend(); ++it ) {
        sfx::erase_sound_effect_preload( *it );
    }
    pimpl_->sound_effect_preload_undo.clear();

    if( pimpl_->snippet_library_undo ) {
        SNIPPET = *pimpl_->snippet_library_undo;
    }
    pimpl_->snippet_library_undo.reset();

    if( pimpl_->help_undo ) {
        get_help() = *pimpl_->help_undo;
    }
    pimpl_->help_undo.reset();

    for( auto it = pimpl_->activity_type_undo.rbegin();
         it != pimpl_->activity_type_undo.rend(); ++it ) {
        if( it->second ) {
            detail::activity_type_registry_set( *it->second );
        } else {
            detail::activity_type_registry_erase( it->first );
        }
    }
    pimpl_->activity_type_undo.clear();

    for( auto it = pimpl_->end_screen_undo.rbegin();
         it != pimpl_->end_screen_undo.rend(); ++it ) {
        if( it->second ) {
            detail::end_screen_registry().restore( *it->second );
        } else {
            detail::end_screen_registry().erase( it->first );
        }
    }
    if( !pimpl_->end_screen_undo.empty() ) {
        detail::end_screen_registry().finalize();
    }
    pimpl_->end_screen_undo.clear();

    for( auto it = pimpl_->speech_pool_undo.rbegin();
         it != pimpl_->speech_pool_undo.rend(); ++it ) {
        if( it->second ) {
            detail::speech_registry_set( it->first, *it->second );
        } else {
            detail::speech_registry_erase( it->first );
        }
    }
    pimpl_->speech_pool_undo.clear();

    for( auto it = pimpl_->zone_type_undo.rbegin();
         it != pimpl_->zone_type_undo.rend(); ++it ) {
        if( it->second ) {
            detail::zone_type_registry().restore( *it->second );
        } else {
            detail::zone_type_registry().erase( it->first );
        }
    }
    if( !pimpl_->zone_type_undo.empty() ) {
        detail::zone_type_registry().finalize();
    }
    pimpl_->zone_type_undo.clear();

    for( auto it = pimpl_->overlay_order_undo.rbegin();
         it != pimpl_->overlay_order_undo.rend(); ++it ) {
        if( it->second ) {
            base_mutation_overlay_ordering[it->first] = *it->second;
        } else {
            base_mutation_overlay_ordering.erase( it->first );
        }
    }
    pimpl_->overlay_order_undo.clear();

    for( auto it = pimpl_->score_undo.rbegin(); it != pimpl_->score_undo.rend(); ++it ) {
        if( it->second ) {
            detail::score_registry().restore( *it->second );
        } else {
            detail::score_registry().erase( it->first );
        }
    }
    if( !pimpl_->score_undo.empty() ) {
        detail::score_registry().finalize();
    }
    pimpl_->score_undo.clear();

    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void presentation_content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->score_undo.clear();
    pimpl_->overlay_order_undo.clear();
    pimpl_->zone_type_undo.clear();
    pimpl_->speech_pool_undo.clear();
    pimpl_->end_screen_undo.clear();
    pimpl_->activity_type_undo.clear();
    pimpl_->help_undo.reset();
    pimpl_->snippet_library_undo.reset();
    pimpl_->playlist_undo.clear();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void presentation_content_transaction::seal()
{
    if( !pimpl_->applied ) {
        return;
    }
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void presentation_content_transaction::discard()
{
    rollback();
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void presentation_content_transaction::append_fingerprint( std::uint64_t &state ) const
{
    for( const score_registration &entry : pimpl_->scores ) {
        hash_part( state, "score" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->statistic );
        hash_part( state, entry.definition->description );
    }
    for( const overlay_order_registration &entry : pimpl_->overlay_orders ) {
        hash_part( state, "overlay_order" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const auto &[mutation_id, order] : entry.definition->orders ) {
            hash_part( state, mutation_id );
            hash_part( state, std::to_string( order ) );
        }
    }
    for( const zone_type_registration &entry : pimpl_->zone_types ) {
        hash_part( state, "zone_type" );
        hash_part( state, operation_name( entry.operation ) );
        const zone_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.display_field );
        hash_part( state, value.can_be_personal ? "personal" : "faction_only" );
        hash_part( state, value.hidden ? "hidden" : "visible" );
    }
    for( const speech_pool_registration &entry : pimpl_->speech_pools ) {
        hash_part( state, "speech_pool" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const auto &[sound, volume] : entry.definition->lines ) {
            hash_part( state, sound );
            hash_part( state, std::to_string( volume ) );
        }
    }
    for( const end_screen_registration &entry : pimpl_->end_screens ) {
        hash_part( state, "end_screen" );
        hash_part( state, operation_name( entry.operation ) );
        const end_screen_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.picture );
        hash_part( state, std::to_string( value.priority ) );
        hash_part( state, value.last_words_label );
        hash_part( state, value.condition_handler );
        for( const auto &[column, row, text] : value.information ) {
            hash_part( state, std::to_string( column ) );
            hash_part( state, std::to_string( row ) );
            hash_part( state, text );
        }
    }
    for( const activity_type_registration &entry : pimpl_->activity_types ) {
        hash_part( state, "activity_type" );
        hash_part( state, operation_name( entry.operation ) );
        const activity_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.verb );
        hash_part( state, value.rooted ? "rooted" : "mobile" );
        hash_part( state, value.interruptable ? "interruptable" : "uninterruptable" );
        hash_part( state, value.interruptable_with_keyboard ?
                   "keyboard_interruptable" : "keyboard_uninterruptable" );
        hash_part( state, value.based_on );
        hash_part( state, value.can_resume ? "resumable" : "not_resumable" );
        hash_part( state, value.multi_activity ? "multi" : "single" );
        hash_part( state, value.fetch_items_to_zone ? "fetch" : "no_fetch" );
        hash_part( state, value.refuel_fires ? "refuel" : "no_refuel" );
        hash_part( state, value.auto_needs ? "auto_needs" : "manual_needs" );
        hash_part( state, std::to_string( value.activity_level ) );
        for( const std::string &distraction : value.ignored_distractions ) {
            hash_part( state, distraction );
        }
        hash_part( state, value.do_turn_handler );
        hash_part( state, value.completion_handler );
    }
    for( const help_topic_registration &entry : pimpl_->help_topics ) {
        hash_part( state, "help_topic" );
        hash_part( state, operation_name( entry.operation ) );
        const help_topic_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.title );
        hash_part( state, value.order ? std::to_string( *value.order ) : "automatic" );
        for( const std::string &paragraph : value.paragraphs ) {
            hash_part( state, paragraph );
        }
    }
    for( const snippet_category_registration &entry : pimpl_->snippet_categories ) {
        hash_part( state, "snippet_category" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const snippet_entry_definition_data &snippet : entry.definition->entries ) {
            hash_part( state, snippet.id );
            hash_part( state, snippet.text );
            hash_part( state, snippet.name );
            hash_part( state, std::to_string( snippet.weight ) );
            hash_part( state, snippet.examine_handler );
        }
    }
    for( const playlist_registration &entry : pimpl_->playlists ) {
        hash_part( state, "playlist" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->shuffle ? "shuffle" : "ordered" );
        for( const auto &[file, volume] : entry.definition->tracks ) {
            hash_part( state, file );
            hash_part( state, std::to_string( volume ) );
        }
    }
}

bool presentation_content_transaction::find_end_screen_handler(
    const std::string_view end_screen_id_value, std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->end_screens.rbegin(), pimpl_->end_screens.rend(),
    [end_screen_id_value]( const end_screen_registration & entry ) {
        return entry.definition->id == end_screen_id_value;
    } );
    if( found == pimpl_->end_screens.rend() ) {
        return false;
    }
    handler_id = found->definition->condition_handler;
    return true;
}

bool presentation_content_transaction::find_activity_type_handler(
    const std::string_view activity_type_id_value, const std::string_view phase,
    std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->activity_types.rbegin(),
                                     pimpl_->activity_types.rend(),
    [activity_type_id_value]( const activity_type_registration & entry ) {
        return entry.definition->id == activity_type_id_value;
    } );
    if( found == pimpl_->activity_types.rend() ) {
        return false;
    }
    if( phase == "do_turn" ) {
        handler_id = found->definition->do_turn_handler;
    } else if( phase == "completion" ) {
        handler_id = found->definition->completion_handler;
    } else {
        handler_id.clear();
    }
    return true;
}

bool presentation_content_transaction::find_snippet_handler(
    const std::string_view snippet_id_value, std::string &category_id,
    std::string &handler_id ) const
{
    for( auto category = pimpl_->snippet_categories.rbegin();
         category != pimpl_->snippet_categories.rend(); ++category ) {
        const auto found = std::find_if( category->definition->entries.begin(),
                                         category->definition->entries.end(),
        [snippet_id_value]( const snippet_entry_definition_data & entry ) {
            return entry.id == snippet_id_value;
        } );
        if( found != category->definition->entries.end() ) {
            category_id = category->definition->id;
            handler_id = found->examine_handler;
            return true;
        }
    }
    return false;
}

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct presentation_content_transaction::impl {};

presentation_content_transaction::presentation_content_transaction( std::string,
        std::size_t ) : pimpl_( std::make_unique<impl>() )
{
}

presentation_content_transaction::~presentation_content_transaction() = default;

bool presentation_content_transaction::validate( const runtime &, bool,
        const std::set<std::string> &, const std::set<std::string> &,
        const std::set<std::string> &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool presentation_content_transaction::apply( std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool presentation_content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void presentation_content_transaction::rollback() {}
void presentation_content_transaction::commit() {}
void presentation_content_transaction::seal() {}
void presentation_content_transaction::discard() {}
void presentation_content_transaction::append_fingerprint( std::uint64_t & ) const {}

bool presentation_content_transaction::find_end_screen_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

bool presentation_content_transaction::find_activity_type_handler( std::string_view,
        std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

bool presentation_content_transaction::find_snippet_handler( std::string_view,
        std::string &category_id, std::string &handler_id ) const
{
    category_id.clear();
    handler_id.clear();
    return false;
}

} // namespace cata::lua_platform

#endif
