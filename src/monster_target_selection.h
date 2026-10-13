#pragma once
#ifndef CATA_SRC_MONSTER_TARGET_SELECTION_H
#define CATA_SRC_MONSTER_TARGET_SELECTION_H

#include <cfloat>

inline float observed_monster_target_power( float power, bool hostile_to_source )
{
    return hostile_to_source ? power + 2 : power;
}

inline float score_visible_monster_target( int distance, float power )
{
    return power > 0 ? distance / power : FLT_MAX;
}

enum class monster_target_kind {
    npc,
    reachable_monster,
    friendly_monster
};

enum class monster_target_request {
    none,
    tie_attack,
    tie_follow,
    tie_draw,
    replacement_attack
};

struct monster_target_state {
    float best = 0.0f;
    int valid_targets = 0;
    bool fleeing = false;
};

struct monster_target_choice {
    monster_target_state state;
    bool selected = false;
};

// A value-only continuation. Each request is answered by the owner at the old
// query/RNG point; no eager sensing, attitude caching or random pre-drawing.
// Neither inputs nor results contain a world/creature pointer.
class monster_target_selection
{
    public:
        monster_target_selection( monster_target_state current, monster_target_kind kind,
                                  float rating, bool fleeing_from = false, bool faction_hate = false ) :
            result_{ current, false }, kind_( kind ), rating_( rating ),
            fleeing_from_( fleeing_from ), faction_hate_( faction_hate ) {
            if( kind_ == monster_target_kind::friendly_monster ) {
                finish( rating_ < result_.state.best, false );
            } else if( rating_ == result_.state.best ) {
                if( kind_ == monster_target_kind::reachable_monster || current.fleeing ) {
                    tie_draw();
                } else {
                    request_ = monster_target_request::tie_attack;
                }
            } else {
                replacement();
            }
        }

        monster_target_request request() const {
            return request_;
        }
        int tie_chance() const {
            return result_.state.valid_targets;
        }
        monster_target_choice result() const {
            return result_;
        }

        void answer( bool accepted ) {
            switch( request_ ) {
                case monster_target_request::tie_attack:
                    if( accepted ) {
                        tie_draw();
                    } else {
                        request_ = monster_target_request::tie_follow;
                    }
                    break;
                case monster_target_request::tie_follow:
                    if( accepted ) {
                        tie_draw();
                    } else {
                        replacement();
                    }
                    break;
                case monster_target_request::tie_draw:
                    result_.selected = accepted;
                    replacement();
                    break;
                case monster_target_request::replacement_attack:
                    finish( accepted || ( !result_.state.fleeing && fleeing_from_ ) );
                    break;
                case monster_target_request::none:
                    break;
            }
        }
    private:
        void tie_draw() {
            ++result_.state.valid_targets;
            request_ = monster_target_request::tie_draw;
        }
        void replacement() {
            if( kind_ == monster_target_kind::reachable_monster ) {
                finish( rating_ < result_.state.best );
            } else if( ( rating_ < result_.state.best && result_.state.fleeing ) || faction_hate_ ) {
                finish( true );
            } else if( rating_ < result_.state.best ) {
                request_ = monster_target_request::replacement_attack;
            } else {
                finish( !result_.state.fleeing && fleeing_from_ );
            }
        }
        void finish( bool replace, bool reset_targets = true ) {
            if( replace ) {
                result_.selected = true;
                result_.state.best = rating_;
                if( reset_targets ) {
                    result_.state.valid_targets = 1;
                }
            }
            if( kind_ == monster_target_kind::npc ) {
                result_.state.fleeing = result_.state.fleeing || fleeing_from_;
            }
            request_ = monster_target_request::none;
        }
        monster_target_choice result_;
        monster_target_kind kind_;
        float rating_;
        bool fleeing_from_;
        bool faction_hate_;
        monster_target_request request_ = monster_target_request::none;
};

#endif // CATA_SRC_MONSTER_TARGET_SELECTION_H
