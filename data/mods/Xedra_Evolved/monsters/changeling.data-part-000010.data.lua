local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_xe_strange_event_brownie",
    name = "household brownie",
    description = "A small humanoid wearing old-fashioned clothing and seemingly covered in thick hair.  It looks at you in shock.",
    copy_from = "mon_changeling",
    symbol = "B",
    volume = "32500 ml",
    mass = "41500 g",
    hp = 62,
    speed = 120,
    melee_dice = 3,
    melee_sides = 6,
    dodge = 6,
    categories = { "XE_CLASSIC" },
    chat_topics = { "XE_STRANGE_EVENT_BROWNIE_MEETS_BROWNIE" },
    armor = {
        stab = 3,
        bash = 6,
        cut = 2,
        xe_cold_iron_cut_damage = 0,
        xe_cold_iron_bash_damage = 0,
        xe_cold_iron_stab_damage = 0,
    },
    attacks = {
        {
            kind = "spell",
            id = "mon_xe_strange_brownie_open_conversation",
            cooldown = 1,
            spell = { id = "mon_xe_strange_brownie_open_conversation" },
            casting_message = "%1$s looks at you in shock.",
            when = "w16b_mon_when_xedra_evolved_faca5845ba63",
        },
    },
    inheritance = {
        add = {
            flags = { "PACIFIST", "CAMOUFLAGE" },
        },
    },
}
