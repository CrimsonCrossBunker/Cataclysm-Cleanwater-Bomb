#pragma once
#ifndef CATA_SRC_GUN_MODE_H
#define CATA_SRC_GUN_MODE_H

#include <set>
#include <string>

#include "translations.h"

class item;
class time_point;

class gun_mode
{
    private:
        translation name_;

    public:
        /** pointer to item providing this mode - base gun or attached gunmod */
        item *target = nullptr;
        /** Fixed shot count or melee reach. Zero for RPM modes with no fixed count. */
        int qty = 0;
        /** Cyclic rate in rounds per game minute, when firing is timed by RPM. */
        int rpm = 0;
        /** flags change behavior of gun mode, e.g. MELEE for bayonets that make a reach attack instead of firing - these are **not** equivalent to item flags! */
        std::set<std::string> flags;

        gun_mode() = default;
        gun_mode( const translation &n, item *target, int qty, const std::set<std::string> &flags,
                  int rpm = 0 ) :
            name_( n ),
            target( target ),
            qty( qty ),
            rpm( rpm ),
            flags( flags ) {}

        bool fixed_burst() const {
            return rpm > 0 && qty > 0;
        }

        bool full_auto() const {
            return rpm > 0 && qty == 0;
        }

        /** Get or reserve the shot count. Only full auto uses a per-second allowance. */
        int shots_available( time_point when ) const;
        int start_firing( time_point when ) const;

        /** Format a translated mode name with its RPM or fixed shot count. */
        std::string firing_label( const std::string &name ) const;

        /** if true perform a melee attach as opposed to shooting */
        bool melee() const {
            return flags.count( "MELEE" );
        }

        explicit operator bool() const {
            return target != nullptr;
        }

        // NOLINTNEXTLINE(readability-make-member-function-const)
        item &operator*() {
            return *target;
        }
        const item &operator*() const {
            return *target;
        }

        // NOLINTNEXTLINE(readability-make-member-function-const)
        item *operator->() {
            return target;
        }
        const item *operator->() const {
            return target;
        }

        std::string tname() const {
            return name_.translated();
        }
};

#endif // CATA_SRC_GUN_MODE_H
