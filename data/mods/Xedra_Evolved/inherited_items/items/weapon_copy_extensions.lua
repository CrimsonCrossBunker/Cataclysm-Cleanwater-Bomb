local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "sword_wood",
        copy_from = "sword_wood",
        looks_like = "sword_wood",
        name = ccb.content.plural_text("2-by-sword", "2-by-swords"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "bwirebat",
        copy_from = "bwirebat",
        looks_like = "bwirebat",
        name = ccb.content.plural_text("barbed wire bat", "barbed wire bats"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "bat",
        copy_from = "bat",
        looks_like = "bat",
        name = ccb.content.plural_text("baseball bat", "baseball bats"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "spear_steel_crude",
        copy_from = "spear_steel_crude",
        looks_like = "spear_steel_crude",
        name = ccb.content.plural_text("crude steel spear", "crude steel spears"),
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "digging_stick",
        copy_from = "digging_stick",
        looks_like = "digging_stick",
        name = ccb.content.plural_text("digging stick", "digging sticks"),
    }
    item:clear_flags()
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "spear_dory",
        copy_from = "spear_dory",
        looks_like = "spear_dory",
        name = ccb.content.plural_text("dory", "dories"),
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "spear_wood_simple",
        copy_from = "spear_wood_simple",
        looks_like = "spear_wood_simple",
        name = ccb.content.plural_text("wooden spear", "wooden spears"),
    }
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "hockey_stick",
        copy_from = "hockey_stick",
        looks_like = "hockey_stick",
        name = ccb.content.plural_text("hockey stick", "hockey sticks"),
    }
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "ji",
        copy_from = "ji",
        looks_like = "ji",
        name = ccb.content.plural_text("ji", "ji"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "spear_knife_proper",
        copy_from = "spear_knife_proper",
        looks_like = "spear_knife_proper",
        name = ccb.content.plural_text("knife spear", "knife spears"),
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "club_wooden_large",
        copy_from = "club_wooden_large",
        looks_like = "club_wooden_large",
        name = ccb.content.plural_text("large wooden club", "large wooden clubs"),
    }
    item:clear_flags()
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "shillelagh_weighted",
        copy_from = "shillelagh_weighted",
        looks_like = "shillelagh_weighted",
        name = ccb.content.plural_text("loaded stick", "loaded sticks"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "pointy_stick_long",
        copy_from = "pointy_stick_long",
        looks_like = "pointy_stick_long",
        name = ccb.content.plural_text("long pointy stick", "long pointy sticks"),
    }
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "naginata_inferior",
        copy_from = "naginata_inferior",
        looks_like = "naginata_inferior",
        name = ccb.content.plural_text("naginata", "naginata"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "nailbat",
        copy_from = "nailbat",
        looks_like = "nailbat",
        name = ccb.content.plural_text("nail bat", "nail bats"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "2h_flail_wood",
        copy_from = "2h_flail_wood",
        looks_like = "2h_flail_wood",
        name = ccb.content.plural_text("peasant flail", "peasant flails"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "pike_inferior",
        copy_from = "pike_inferior",
        looks_like = "pike_inferior",
        name = ccb.content.plural_text("pike", "pikes", "weapon"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH3")
    item:flag("REACH_ATTACK")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "2x4",
        copy_from = "2x4",
        looks_like = "2x4",
        name = ccb.content.plural_text("plank", "planks"),
    }
    item:clear_flags()
    item:flag("FIREWOOD")
    item:flag("FRAGILE_MELEE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "qiang",
        copy_from = "qiang",
        looks_like = "qiang",
        name = ccb.content.plural_text("qiang", "qiang"),
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "rolling_pin",
        copy_from = "rolling_pin",
        looks_like = "rolling_pin",
        name = ccb.content.plural_text("rolling pin", "rolling pins"),
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "shillelagh",
        copy_from = "shillelagh",
        looks_like = "shillelagh",
        name = ccb.content.plural_text("shillelagh", "shillelaghs"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "shillelagh_fake",
        copy_from = "shillelagh_fake",
        looks_like = "shillelagh_fake",
        name = ccb.content.plural_text("shillelagh", "shillelaghs"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "plank_short",
        copy_from = "plank_short",
        looks_like = "plank_short",
        name = ccb.content.plural_text("short plank", "short planks"),
    }
    item:clear_flags()
    item:flag("FIREWOOD")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "makeshift_halberd",
        copy_from = "makeshift_halberd",
        looks_like = "makeshift_halberd",
        name = ccb.content.plural_text("simple makeshift glaive", "simple makeshift glaives"),
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "2h_club_kanabo_spiked",
        copy_from = "2h_club_kanabo_spiked",
        looks_like = "2h_club_kanabo_spiked",
        name = ccb.content.plural_text("spiked kanabō", "spiked kanabō"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:flag("SHEATH_SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "spear_stone",
        copy_from = "spear_stone",
        looks_like = "spear_stone",
        name = ccb.content.plural_text("stone spear", "stone spears"),
    }
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "spear_stone_simple",
        copy_from = "spear_stone_simple",
        looks_like = "spear_stone_simple",
        name = ccb.content.plural_text("simple stone spear", "simple stone spears"),
    }
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "2h_club_kanabo_studded",
        copy_from = "2h_club_kanabo_studded",
        looks_like = "2h_club_kanabo_studded",
        name = ccb.content.plural_text("studded kanabō", "studded kanabō"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "tonfa_wood",
        copy_from = "tonfa_wood",
        looks_like = "tonfa_wood",
        name = ccb.content.plural_text("wooden tonfa", "wooden tonfas"),
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end

do
    local item = content.Item {
        id = "sword_wood_large",
        copy_from = "sword_wood_large",
        looks_like = "sword_wood_large",
        name = ccb.content.plural_text("zweitimber", "zweitimbers"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("BELT_CLIP")
    item:flag("WOODEN_WEAPON")
    content.replace(item)
end
