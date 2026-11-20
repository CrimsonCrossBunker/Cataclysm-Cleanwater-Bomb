local ccb = require("ccb")
local content = ccb.content
local runtime = ccb.runtime

-- Native end-screen definitions
local function has_trait(payload, id)
    return payload.traits ~= nil and payload.traits[id] == true
end

local function has_effect(payload, id)
    return payload.effects ~= nil and payload.effects[id] == true
end

local function has_item(payload, id)
    return payload.items ~= nil and payload.items[id] == true
end

local MUTAGEN_EFFECTS = {
    "mutagen",
    "mutagen_beast",
    "mutagen_bird",
    "mutagen_cattle",
    "mutagen_cephalopod",
    "mutagen_chimera",
    "mutagen_elfa",
    "mutagen_feline",
    "mutagen_fish",
    "mutagen_insect",
    "mutagen_lizard",
    "mutagen_lupine",
    "mutagen_medical",
    "mutagen_plant",
    "mutagen_raptor",
    "mutagen_rat",
    "mutagen_chiropteran",
    "mutagen_slime",
    "mutagen_spider",
    "mutagen_gastropod",
    "mutagen_batrachian",
    "mutagen_troglobite",
    "mutagen_ursine",
    "mutagen_mouse",
    "mutagen_rabbit",
    "mutagen_crustacean",
    "mutagen_alpha",
}

local function has_any_effect(payload, ids)
    if payload.effects == nil then
        return false
    end
    for i = 1, #ids do
        if payload.effects[ids[i]] == true then
            return true
        end
    end
    return false
end

runtime.handler("end_screen_death_tombstone", function(payload)
    return payload.alive == false
end)

do
local definition = content.EndScreen {
    id = "death_tombstone",
    priority = 0,
    picture = "ascii_tombstone",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_death_tombstone")
definition:info(6, 8, "In memory of: <u_name>")
definition:info(13, 9, "Survived: <time_survived>")
definition:info(15, 10, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_death_cross", function(payload)
    return payload.alive == false
        and (
            has_item(payload, "holybook_bible1")
            or has_item(payload, "holybook_bible2")
            or has_item(payload, "holybook_bible3")
        )
        and not (has_trait(payload, "CANNIBAL") and has_trait(payload, "PSYCHOPATH"))
end)

do
local definition = content.EndScreen {
    id = "death_cross",
    priority = 100,
    picture = "ascii_rip_cross",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_death_cross")
definition:info(8, 8, "In memory of: <color_green><u_name></color>")
definition:info(15, 9, "Survived: <time_survived>")
definition:info(17, 10, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_death_inverted_cross", function(payload)
    return payload.alive == false
        and (has_trait(payload, "CANNIBAL") or has_trait(payload, "PSYCHOPATH"))
end)

do
local definition = content.EndScreen {
    id = "death_inverted_cross",
    priority = 100,
    picture = "ascii_rip_inverted_cross",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_death_inverted_cross")
definition:info(8, 14, "In memory of: <color_green><u_name></color>")
definition:info(15, 15, "Survived: <time_survived>")
definition:info(17, 16, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_portal_storm_win", function(payload)
    return payload.alive == false and has_effect(payload, "a_winner_is_u")
end)

do
local definition = content.EndScreen {
    id = "portal_storm_win",
    priority = 200,
    picture = "ascii_portal_storm_win",
}
definition:condition("end_screen_portal_storm_win")
definition:info(6, 6, "You <color_pink>won</color>")
definition:info(8, 7, "<u_name>...")
definition:info(4, 10, "...<u_name>, who's that?")
definition:info(15, 11, "Not your problem anymore.")
definition:info(9, 15, "What a <color_pink>success</color>.")
definition:info(4, 21, "Something struggled for: <time_survived>")
content.add(definition)
end

runtime.handler("end_screen_mycus_death", function(payload)
    return payload.alive == false and has_trait(payload, "THRESH_MYCUS")
end)

do
local definition = content.EndScreen {
    id = "mycus_death",
    priority = 150,
    picture = "ascii_mycus_death",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_mycus_death")
definition:info(1, 2, "...<u_name>, do you feel complete?")
definition:info(3, 4, "Of course you do.")
definition:info(4, 5, "It was <color_pink>beautiful</color>.")
definition:info(5, 6, "You spread joy for: <time_survived>")
content.add(definition)
end

runtime.handler("end_screen_marloss_death", function(payload)
    return payload.alive == false
        and (
            has_trait(payload, "THRESH_MARLOSS")
            or has_trait(payload, "MARLOSS")
            or has_trait(payload, "MARLOSS_BLUE")
            or has_trait(payload, "MARLOSS_YELLOW")
        )
end)

do
local definition = content.EndScreen {
    id = "marloss_death",
    priority = 140,
    picture = "ascii_marloss_death",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_marloss_death")
definition:info(1, 2, "...<u_name>, do you feel incomplete?")
definition:info(2, 3, "Of course you do.")
definition:info(3, 4, "what a <color_red>waste</color>.")
definition:info(4, 5, "You wandered for: <time_survived>")
content.add(definition)
end

runtime.handler("end_screen_has_mutagen_death", function(payload)
    return payload.alive == false
        and (
            has_any_effect(payload, MUTAGEN_EFFECTS)
            or has_item(payload, "iv_mutagen")
            or has_item(payload, "iv_mutagen_flavor")
        )
end)

do
local definition = content.EndScreen {
    id = "has_mutagen_death",
    priority = 110,
    picture = "ascii_has_mutagen_death",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_has_mutagen_death")
definition:info(10, 10, "Subject: <color_green><u_name></color>")
definition:info(15, 11, "Survived: <time_survived>")
definition:info(17, 13, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_medical_death", function(payload)
    return payload.alive == false and has_trait(payload, "THRESH_MEDICAL")
end)

do
local definition = content.EndScreen {
    id = "medical_death",
    priority = 150,
    picture = "ascii_thresh_medical_death",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_medical_death")
definition:info(1, 1, "Patient: <color_blue><u_name></color>")
definition:info(28, 4, "Survived: <time_survived>")
definition:info(5, 14, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_lizard_death", function(payload)
    return payload.alive == false and has_trait(payload, "THRESH_LIZARD")
end)

do
local definition = content.EndScreen {
    id = "lizard_death",
    priority = 150,
    picture = "ascii_thresh_lizard_death",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_lizard_death")
definition:info(1, 1, "In memory of: <color_green><u_name></color>")
definition:info(3, 2, "Survived: <time_survived>")
definition:info(5, 3, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_bird_death", function(payload)
    return payload.alive == false and has_trait(payload, "THRESH_BIRD")
end)

do
local definition = content.EndScreen {
    id = "bird_death",
    priority = 150,
    picture = "ascii_thresh_bird_death",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_bird_death")
definition:info(1, 1, "In memory of: <color_light_blue><u_name></color>")
definition:info(3, 2, "Survived: <time_survived>")
definition:info(5, 3, "Kills: <total_kills>")
content.add(definition)
end

runtime.handler("end_screen_botched_exodii_surgery", function(payload)
    return payload.alive == false and has_effect(payload, "a_turncoat_to_the_end")
end)

do
local definition = content.EndScreen {
    id = "botched_exodii_surgery",
    priority = 200,
    picture = "ascii_tombstone",
    last_words_label = "Last Words:",
}
definition:condition("end_screen_botched_exodii_surgery")
definition:info(6, 6, "In memory of: <u_name>")
definition:info(6, 7, "Survived: <time_survived>")
definition:info(6, 8, "Kills: <total_kills>")
definition:info(7, 10, "When the birds and the beasts")
definition:info(7, 11, "had made peace,")
definition:info(7, 12, "the fraud appeared")
definition:info(7, 13, "to both kinds;")
definition:info(7, 14, "therefore,")
definition:info(8, 15, "condemned,")
definition:info(9, 16, "he fled from both,")
definition:info(10, 17, "and from that time on")
definition:info(11, 18, "flew only at night.")
content.add(definition)
end
