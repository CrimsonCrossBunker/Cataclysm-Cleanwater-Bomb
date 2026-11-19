local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_MAIN",
    replies = {
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_animist")), predicates.has_trait("speaker", "ANIMIST") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_animist>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_ANIMIST",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_magus")), predicates.has_trait("speaker", "MAGUS") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_magus>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_MAGUS",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_stormshaper")), predicates.has_trait("speaker", "STORMSHAPER") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_stormshaper>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_STORMSHAPER",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_kelvinist")), predicates.has_trait("speaker", "KELVINIST") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_kelvinist>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_KELVINIST",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_earthshaper")), predicates.has_trait("speaker", "EARTHSHAPER") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_earthshaper>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_EARTHSHAPER",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_technomancer")), predicates.has_trait("speaker", "TECHNOMANCER") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_technomancer>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_TECHNOMANCER",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_druid")), predicates.has_trait("speaker", "DRUID") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_druid>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_DRUID",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "perk_caster_level_up_biomancer")), predicates.has_trait("speaker", "BIOMANCER") }),
            text = ccb.content.text("Gain [<trait_name:perk_caster_level_up_biomancer>]"),
            next_topic = "TALK_PERK_MENU_CASTER_LEVEL_UP_BIOMANCER",
        },
    },
}
