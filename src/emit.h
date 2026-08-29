#pragma once
#ifndef CATA_SRC_EMIT_H
#define CATA_SRC_EMIT_H

#include <map>
#include <optional>
#include <string>

#include "dialogue_helpers.h"
#include "type_id.h"

class JsonObject;
struct const_dialogue;

namespace cata::lua_platform
{
class content_transaction;
} // namespace cata::lua_platform

class emit
{
    public:
        emit();

        const emit_id &id() const {
            return id_;
        }

        /** When null @ref field is always fd_null */
        bool is_null() const;

        /** When valid @ref field is never fd_null */
        bool is_valid() const;

        /** Type of field to emit @see emit::is_valid */
        field_type_id field( const_dialogue const &d ) const {
            if( native_profile_ ) {
                return native_profile_->field.id();
            }
            return field_type_id( field_.evaluate( d ) );
        }

        /** Intensity of output fields, range [1..maximum_intensity] */
        int intensity( const_dialogue const &d ) const {
            if( native_profile_ ) {
                return native_profile_->intensity;
            }
            return intensity_.evaluate( d );
        }

        /** Units of field to generate per turn subject to @ref chance */
        int qty( const_dialogue const &d ) const {
            if( native_profile_ ) {
                return native_profile_->quantity;
            }
            return qty_.evaluate( d );
        }

        /** Chance to emit each turn, range [1..100] */
        int chance( const_dialogue const &d ) const {
            if( native_profile_ ) {
                return native_profile_->chance;
            }
            return chance_.evaluate( d );
        }

        /** Load emission data from JSON definition */
        static void load_emit( const JsonObject &jo );

        /** Get all currently loaded emission data */
        static const std::map<emit_id, emit> &all();

        /** Check consistency of all loaded emission data */
        static void finalize();

        /** Check consistency of all loaded emission data */
        static void check_consistency();

        /** Clear all loaded emission data (invalidating any pointers) */
        static void reset();

    private:
        struct native_profile {
            field_type_str_id field;
            int intensity = 1;
            int quantity = 1;
            int chance = 100;
        };

        emit_id id_;
        str_or_var field_;
        dbl_or_var intensity_;
        dbl_or_var qty_;
        dbl_or_var chance_;
        std::optional<native_profile> native_profile_;

        friend class cata::lua_platform::content_transaction;
};

#endif // CATA_SRC_EMIT_H
