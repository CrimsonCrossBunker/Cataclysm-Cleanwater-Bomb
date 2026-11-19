local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and a low-resolution version of Pat's computer desktop becomes visible.  \"I've flagged a bunch of places you've been, eh?  Take a look.\""),
        no = ccb.content.text("&Pat starts to scroll through photos and spreadsheets on their personal device, inviting you over to look with them.  \"I've flagged a bunch of places you've been, eh?  Take a look.\""),
    },
    replies = {
        {
            text = ccb.content.text("[Photos of the LIXA facility] What about that place?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_LIXA",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_lixa" } }),
        },
        {
            text = ccb.content.text("[Photos of the strange temple] No doubt that place has some strange shit in it, right?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_STRANGE_TEMPLE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_strange_temple" } }),
        },
        {
            text = ccb.content.text("[Photos of the castle] What about that castle?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_EXODII",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_exodii" } }),
        },
        {
            text = ccb.content.text("[Photos of the farmstead] That farm was odd, to say the least.  Maybe there?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_VITRIFIED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_vitrified" } }),
        },
        {
            text = ccb.content.text("[Photos of the mine entrance] Looks like you flagged that mine."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_AMIGARA",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_amigara" } }),
        },
        {
            text = ccb.content.text("[Photos of the alien highlands] Well, that's a no brainer."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_HIGHLANDS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_highlands" } }),
        },
        {
            text = ccb.content.text("[Photos of the physics laboratory] That freaky lab?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_PHYSICS_LAB",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_physics_lab" } }),
        },
        {
            text = ccb.content.text("[Photos of dead monster corpse] I guess if anything is gonna work, it'd be that dead creature?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_MONSTER_CORPSE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_monster_corpse" } }),
        },
        {
            text = ccb.content.text("[Photos of the glowing church] That place was full of something unreal.  What do you think?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RURAL_CHURCH",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_rural_church" } }),
        },
        {
            text = ccb.content.text("[Photos of the fenced-off forest] What was that place called again?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_MORGANTOWN",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_morgantown" } }),
        },
        {
            text = ccb.content.text("[Distorted images of the boarded up cabin] Ah, that place.  What do you think?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_CABIN_REVERB_HINT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_cabin_reverb_hint" } }),
        },
        {
            text = ccb.content.text("[An audio recording] Ah, that place near the radio tower.  What do you think?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RADIO_TOWER_REVERBERATION_MP3",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_radio_tower_reverberation_mp3" } }),
        },
        {
            text = ccb.content.text("[Photos of the repeating alien cabins] That's a no brainer."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_CABIN_REVERB",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_cabin_reverb" } }),
        },
        {
            text = ccb.content.text("[Photos of the repeating alien radio towers] That's gotta be a no brainer."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RADIOSPHERE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_radiosphere" } }),
        },
        {
            text = ccb.content.text("[Photos of the glowing strings] That place was odd, to say the least."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_STRING_DIMENSION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_string_dimension" } }),
        },
        {
            text = ccb.content.text("[Photos of the spiral rock formations] How about that 'mine?'"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_SPIRAL_MINE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_spiral_mine" } }),
        },
        {
            text = ccb.content.text("[Distorted images of the spider's lair] Well, I guess that might've been a good place."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_VOID_SPIDER_LAIR",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_spider_dimension" } }),
        },
        {
            text = ccb.content.text("[Twisted images of the otherworldly, shifting tunnels] Ah, that place.  Duh."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_PORTAL_STORM_DUNGEON",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_portal_storm_dungeon" } }),
        },
        {
            text = ccb.content.text("[Snapshots of the scarlet storm] That storm?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_SCARLET_STORM",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_scarlet_storm" } }),
        },
        {
            text = ccb.content.text("Hmm.  Well, I guess we'll just see what I can find."),
            next_topic = "TALK_DONE",
        },
    },
}
