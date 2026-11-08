#include <memory>
#include <optional>
#include <stdexcept>
#include <type_traits>
#include <utility>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "current_map.h"
#include "game.h"
#include "map.h"

static_assert( !std::is_copy_constructible_v<current_map> );
static_assert( !std::is_move_constructible_v<current_map> );
static_assert( !std::is_copy_constructible_v<swap_map> );
static_assert( !std::is_move_constructible_v<swap_map> );

TEST_CASE( "unbound_map_context_is_only_selected_inside_its_override", "[current_map]" )
{
    map temporary;
    current_map context;
    CHECK_THROWS_AS( context.get_map(), std::logic_error );
    {
        swap_map selection( context, temporary );
        CHECK( &context.get_map() == &temporary );
    }
    CHECK_THROWS_AS( context.get_map(), std::logic_error );
}

TEST_CASE( "independent_map_contexts_restore_nested_scopes_on_exception", "[current_map]" )
{
    map first_base;
    map second_base;
    map outer;
    map inner;
    current_map first( first_base );
    current_map second( second_base );
    map *active = &get_map();
    {
        swap_map first_scope( first, outer );
        CHECK( &first.get_map() == &outer );
        CHECK( &second.get_map() == &second_base );
        CHECK_THROWS_AS( [&]() {
            swap_map second_scope( second, inner );
            swap_map nested( first, inner );
            CHECK( &first.get_map() == &inner );
            CHECK( &second.get_map() == &inner );
            throw std::runtime_error( "cancel operation" );
        }
        (), std::runtime_error );
        CHECK( &first.get_map() == &outer );
        CHECK( &second.get_map() == &second_base );
        CHECK( &get_map() == active );
    }
    CHECK( &first.get_map() == &first_base );
    CHECK( &second.get_map() == &second_base );
}

TEST_CASE( "cancelling_an_older_map_override_preserves_the_current_selection", "[current_map]" )
{
    map base;
    map first;
    map second;
    map third;
    current_map context( base );
    auto outer = std::make_unique<swap_map>( context, first );
    auto middle = std::make_unique<swap_map>( context, second );
    auto inner = std::make_unique<swap_map>( context, third );
    middle.reset();
    CHECK( &context.get_map() == &third );
    outer.reset();
    CHECK( &context.get_map() == &third );
    inner.reset();
    CHECK( &context.get_map() == &base );
    {
        swap_map again( context, second );
        CHECK( &context.get_map() == &second );
    }
    CHECK( &context.get_map() == &base );
}

TEST_CASE( "late_map_scope_cannot_restore_into_a_replacement_owner", "[current_map]" )
{
    map first;
    map second;
    map temporary;
    std::optional<current_map> owner;
    owner.emplace( first );
    auto scope = std::make_unique<swap_map>( *owner, temporary );
    auto inner = std::make_unique<swap_map>( *owner, second );
    owner.reset();
    // Reuse the exact owner address. A pointer/address-only check is insufficient.
    owner.emplace( second );
    scope.reset();
    inner.reset();
    CHECK( &owner->get_map() == &second );
}

TEST_CASE( "legacy_map_scope_restores_its_captured_owner_without_active_game", "[current_map]" )
{
    map temporary;
    map *original = &get_map();
    auto scope = std::make_unique<swap_map>( temporary );
    REQUIRE( &get_map() == &temporary );
    {
        std::unique_ptr<game> original_game = std::move( g );
        on_out_of_scope restore( [&]() {
            g = std::move( original_game );
        } );
        scope.reset();
    }
    CHECK( &get_map() == original );
}

TEST_CASE( "explicit_map_scopes_do_not_require_an_active_game", "[current_map]" )
{
    map base;
    map temporary;
    current_map context( base );
    std::unique_ptr<game> original_game = std::move( g );
    on_out_of_scope restore( [&]() {
        g = std::move( original_game );
    } );
    CHECK_THROWS_AS( swap_map( temporary ), std::logic_error );
    {
        swap_map scope( context, temporary );
        CHECK( &context.get_map() == &temporary );
    }
    CHECK( &context.get_map() == &base );
}
