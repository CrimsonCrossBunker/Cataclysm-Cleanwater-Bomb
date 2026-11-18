local ccb = require("ccb")
local content = ccb.content

-- Defined here because this should be the only time this effect is referenced.
content.add(content.EffectType {
    id = "player_BGSS_SAIDNO",
})

-- Defined here because this should be the only time this effect is referenced.
content.add(content.EffectType {
    id = "player_BGSS_SAIDYES",
})

-- Defined here because this should be the only time this effect is referenced.
content.add(content.EffectType {
    id = "BGSS_Cop_3_earlymeeting",
})

-- Defined here because this should be the only time this effect is referenced.
content.add(content.EffectType {
    id = "BGSS_EVACUEE_1_earlymeeting",
})

-- Defined here because this should be the only time this effect is referenced.
content.add(content.EffectType {
    id = "BGSS_EVACUEE_3_earlymeeting",
})

-- Defined here in the conversation section because this should be the only time this very specific effect is referenced.
-- Religious Offense
-- AI tag used when you offended an NPC with a specific conversation option.  This is a bug if you have it.
content.add(content.EffectType {
    id = "player_rude_BGSS_RELIGIOUS_1_FAITH1",
})

-- Defined here because this should be the only time this effect is referenced.
content.add(content.EffectType {
    id = "BGSS_Merc_haswhisky",
})

-- This flag limits feast offers.
content.add(content.EffectType {
    id = "u_offered_marloss_meal",
})

-- This flag limits given berries to one per 12h.
content.add(content.EffectType {
    id = "u_given_berry",
})

-- Applied as a timer while waiting for sprayable fungicide to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_gas_fungicidal",
})

-- Applied as a timer while waiting for powder fungicide to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_fungicide",
})

-- Applied as a timer while waiting for disinfectant to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_disinfectant",
})

-- Applied as a timer while waiting for antibiotics to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_antibiotics",
})

-- Applied as a timer while waiting for antifungal drugs to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_antifungal",
})

-- Applied as a timer while waiting for black gunpowder to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_chem_black_powder",
})

-- Applied as a timer while waiting for napalm to refresh from the chemist's shop. If you're seeing this, it's a bug.
content.add(content.EffectType {
    id = "chemist_waiting_for_napalm",
})

-- 12-hour period for the player to ask follow up questions about Elvira's initial greeting.
content.add(content.EffectType {
    id = "u_Elvira_onetime_greeting",
})

-- This prevents you from building trust with the Exodii too quickly by just talking to them constantly, and tells Rubik to use a different greeting because he saw you very recently.
content.add(content.EffectType {
    id = "u_exodii_interaction_timer_short",
})

-- This prevents you from building trust with the Exodii too quickly by just talking to them constantly.
content.add(content.EffectType {
    id = "u_exodii_interaction_timer_long",
})

-- Arturo will occaisionall have episodes, this tracks that.
content.add(content.EffectType {
    id = "Arturo_visions_timer",
})

content.add(content.EffectType {
    id = "godco_darryl_bartered",
})

content.add(content.EffectType {
    id = "godco_darryl_mission1",
})

content.add(content.EffectType {
    id = "godco_confessed",
    name = ccb.content.text("Had a Confessional"),
    description = ccb.content.text("You decided to take responsibility for your actions."),
    apply_message = ccb.content.text("You finally got the weight off your chest."),
    rating = "good",
})

content.add(content.EffectType {
    id = "godco_kostas_tea",
})

content.add(content.EffectType {
    id = "failed_persuade",
})

content.add(content.EffectType {
    id = "hunt_godco_russell",
})

content.add(content.EffectType {
    id = "trade_godco_russell",
})

content.add(content.EffectType {
    id = "u_got_meal",
})

content.add(content.EffectType {
    id = "sold_pet",
})

content.add(content.EffectType {
    id = "beggar_has_eaten",
    name = ccb.content.text("Full"),
    description = ccb.content.text("This beggar in the refugee center has had something to eat recently."),
})

content.add(content.EffectType {
    id = "insulted_luo",
    name = ccb.content.text("Insulted"),
    description = ccb.content.text("Oh, you went there."),
})

-- Gates Alonso's fine services behind a mission.
content.add(content.EffectType {
    id = "Alonso_pants_restored",
})

-- No morale_mod is currently possible in effects. As soon as it's implemented, it should go here.
content.add(content.EffectType {
    id = "al_relaxed",
    name = ccb.content.text("Relaxed with Alonso"),
    apply_message = ccb.content.text("You spent some pleasant time relaxing with someone."),
    rating = "good",
}
    :miss_message(ccb.content.text("You feel relaxed."), 1))

-- Applied as a timer to keep Dana from having unlimited bread in stock
content.add(content.EffectType {
    id = "dana_baking_sold",
})

-- Applied as a timer to keep Dana from selling her better bread until it's ready.
content.add(content.EffectType {
    id = "dana_sourdough_revival",
})

-- Applied as a timer to keep Dana's prices low for a day after bartering.
content.add(content.EffectType {
    id = "dana_barter_success",
})

-- Applied as a timer to keep from attempting bartering again too soon.
content.add(content.EffectType {
    id = "dana_barter_fail",
})

-- Use this flag to indicate if the player sold weed recently to Draco.
content.add(content.EffectType {
    id = "u_sold_to_Draco",
})

-- Use this flag to indicate if the player has met this NPC before.
content.add(content.EffectType {
    id = "u_met_Jenny_Forcette",
})

content.add(content.EffectType {
    id = "vanessa_haircut_in_progress",
})

content.add(content.EffectType {
    id = "vanessa_shave_in_progress",
})

-- 12-hour period for the player to ask why his greeting was so blunt (basically 'before you ask, we're full').
content.add(content.EffectType {
    id = "u_Gavin_onetime_greeting",
})
