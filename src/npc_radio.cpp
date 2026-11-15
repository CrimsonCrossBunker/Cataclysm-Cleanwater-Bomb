#include "npc_radio.h"

#include <vector>

#include "basecamp.h"
#include "character.h"
#include "faction_camp.h"
#include "line.h"
#include "map.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "type_id.h"

namespace npc_radio
{
static const flag_id json_flag_TWO_WAY_RADIO( "TWO_WAY_RADIO" );

bool has_radio( const Character &guy )
{
    return guy.cache_has_item_with_flag( json_flag_TWO_WAY_RADIO, true );
}

// is physically close enough to contact the beta without much hassle
// mainly for followers
bool can_contact( const map &here, const Character &alpha, const Character &beta )
{
    const bool too_far_omt = rl_dist( alpha.pos_abs_omt(), beta.pos_abs_omt() ) > 3;
    const bool see_each_other = alpha.sees( here, beta );
    return !too_far_omt || see_each_other ;
}

// opposite to previouis one, far enough to check for radio contact
radio_contact_result can_radio_contact( const Character &alpha, const Character &beta )
{
    bool u_has_radio = has_radio( alpha );
    bool guy_has_radio = has_radio( beta );
    if( u_has_radio && guy_has_radio ) {
        if( !( alpha.posz() >= 0 && beta.posz() >= 0 ) &&
            !( alpha.posz() == beta.posz() ) ) {
            //Early exit
            return radio_contact_result::TOO_FAR;
        } else {
            // TODO: better range calculation than just elevation.
            const int base_range = 200;
            float send_elev_boost = ( 1 + ( alpha.posz() * 0.1 ) );
            float recv_elev_boost = ( 1 + ( beta.posz() * 0.1 ) );
            if( ( square_dist( alpha.pos_abs_sm(),
                               beta.pos_abs_sm() ) <= base_range * send_elev_boost * recv_elev_boost ) ) {
                //Direct radio contact, both of their elevation are in effect
                return radio_contact_result::YES;
            } else {
                //contact via camp radio tower
                int recv_range = base_range * recv_elev_boost;
                int send_range = base_range * send_elev_boost;
                const int radio_tower_boost = 5;
                // find camps that are near player or npc
                const std::vector<camp_reference> &camps_near_player = overmap_buffer.get_camps_near(
                            alpha.pos_abs_sm(), send_range * radio_tower_boost );
                const std::vector<camp_reference> &camps_near_npc = overmap_buffer.get_camps_near(
                            beta.pos_abs_sm(), recv_range * radio_tower_boost );
                bool camp_to_npc = false;
                bool camp_to_camp = false;
                for( const camp_reference &i : camps_near_player ) {
                    if( !i.camp->has_provides( "radio" ) ) {
                        continue;
                    }
                    if( camp_to_camp ||
                        square_dist( i.abs_sm_pos, beta.pos_abs_sm() ) <= recv_range * radio_tower_boost ) {
                        //one radio tower relay
                        camp_to_npc = true;
                        break;
                    }
                    for( const camp_reference &j : camps_near_npc ) {
                        //two radio tower relays
                        if( ( j.camp )->has_provides( "radio" ) &&
                            ( square_dist( i.abs_sm_pos, j.abs_sm_pos ) <= base_range * radio_tower_boost *
                              radio_tower_boost ) ) {
                            camp_to_camp = true;
                            break;
                        }
                    }
                }
                if( camp_to_npc || camp_to_camp ) {
                    return radio_contact_result::YES;
                } else {
                    return radio_contact_result::TOO_FAR;
                }
            }
        }
    }

    if( guy_has_radio && !u_has_radio ) {
        return radio_contact_result::ALPHA_NO_RADIO;
    }

    if( !guy_has_radio && u_has_radio ) {
        return radio_contact_result::BETA_NO_RADIO;
    }

    return radio_contact_result::BOTH_NO_RADIO;
}

bool knows_representative( const Character &who, const npc &representative )
{
    return representative.faction_representative &&
           who.faction_representatives.count( representative.getID() ) > 0;
}
} // namespace npc_radio
