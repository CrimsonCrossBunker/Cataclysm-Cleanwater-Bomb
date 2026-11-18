local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "cudgel_plus_one",
        copy_from = "cudgel",
        looks_like = "cudgel",
        name = ccb.content.plural_text("cudgel +1", "cudgels +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cudgel_plus_two",
        copy_from = "cudgel",
        looks_like = "cudgel",
        name = ccb.content.plural_text("cudgel +2", "cudgels +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "q_staff_plus_one",
        copy_from = "q_staff",
        looks_like = "q_staff",
        name = ccb.content.plural_text("quarterstaff +1", "quarterstaves +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "q_staff_plus_two",
        copy_from = "q_staff",
        looks_like = "q_staff",
        name = ccb.content.plural_text("quarterstaff +2", "quarterstaves +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "i_staff_plus_one",
        copy_from = "i_staff",
        looks_like = "i_staff",
        name = ccb.content.plural_text("ironshod quarterstaff +1", "ironshod quarterstaves +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "i_staff_plus_two",
        copy_from = "i_staff",
        looks_like = "i_staff",
        name = ccb.content.plural_text("ironshod quarterstaff +2", "ironshod quarterstaves +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "longsword_plus_one",
        copy_from = "qt_longsword",
        looks_like = "qt_longsword",
        name = ccb.content.plural_text("longsword +1", "longswords +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "longsword_plus_two",
        copy_from = "qt_longsword",
        looks_like = "qt_longsword",
        name = ccb.content.plural_text("longsword +2", "longswords +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "warhammer_plus_one",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("warhammer +1", "warhammers +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "warhammer_plus_two",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("warhammer +2", "warhammers +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_steel_plus_one",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("steel spear +1", "steel spears +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_steel_plus_two",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("steel spear +2", "steel spears +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "qiang_plus_one",
        copy_from = "qiang",
        looks_like = "qiang",
        name = ccb.content.plural_text("qiang +1", "qiang +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "qiang_plus_two",
        copy_from = "qiang",
        looks_like = "qiang",
        name = ccb.content.plural_text("qiang +2", "qiang +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "halberd_plus_one",
        copy_from = "halberd",
        looks_like = "halberd",
        name = ccb.content.plural_text("halberd +1", "halberds +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "halberd_plus_two",
        copy_from = "halberd",
        looks_like = "halberd",
        name = ccb.content.plural_text("halberd +2", "halberds +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "glaive_plus_one",
        copy_from = "glaive",
        looks_like = "glaive",
        name = ccb.content.plural_text("glaive +1", "glaives +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "glaive_plus_two",
        copy_from = "glaive",
        looks_like = "glaive",
        name = ccb.content.plural_text("glaive +2", "glaives +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "naginata_plus_one",
        copy_from = "naginata",
        looks_like = "naginata",
        name = ccb.content.plural_text("naginata +1", "naginata +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "naginata_plus_two",
        copy_from = "naginata",
        looks_like = "naginata",
        name = ccb.content.plural_text("naginata +2", "naginata +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_plus_one",
        copy_from = "qt_mace",
        looks_like = "qt_mace",
        name = ccb.content.plural_text("mace +1", "maces +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_plus_two",
        copy_from = "qt_mace",
        looks_like = "qt_mace",
        name = ccb.content.plural_text("mace +2", "maces +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "morningstar_plus_one",
        copy_from = "morningstar",
        looks_like = "morningstar",
        name = ccb.content.plural_text("morningstar +1", "morningstars +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "morningstar_plus_two",
        copy_from = "morningstar",
        looks_like = "morningstar",
        name = ccb.content.plural_text("morningstar +2", "morningstars +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "jian_plus_one",
        copy_from = "qt_jian",
        looks_like = "qt_jian",
        name = ccb.content.plural_text("jian +1", "jian +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "jian_plus_two",
        copy_from = "qt_jian",
        looks_like = "qt_jian",
        name = ccb.content.plural_text("jian +2", "jian +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "scimitar_plus_one",
        copy_from = "qt_scimitar",
        looks_like = "qt_scimitar",
        name = ccb.content.plural_text("scimitar +1", "scimitars +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "scimitar_plus_two",
        copy_from = "qt_scimitar",
        looks_like = "qt_scimitar",
        name = ccb.content.plural_text("scimitar +2", "scimitars +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "estoc_plus_one",
        copy_from = "qt_estoc",
        looks_like = "qt_estoc",
        name = ccb.content.plural_text("estoc +1", "estocs +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "estoc_plus_two",
        copy_from = "qt_estoc",
        looks_like = "qt_estoc",
        name = ccb.content.plural_text("estoc +2", "estocs +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "arming_sword_plus_one",
        copy_from = "qt_arming_sword",
        looks_like = "qt_arming_sword",
        name = ccb.content.plural_text("arming sword +1", "arming swords +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "arming_sword_plus_two",
        copy_from = "qt_arming_sword",
        looks_like = "qt_arming_sword",
        name = ccb.content.plural_text("arming sword +2", "arming swords +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "broadsword_plus_one",
        copy_from = "qt_broadsword",
        looks_like = "qt_broadsword",
        name = ccb.content.plural_text("broadsword +1", "broadswords +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "broadsword_plus_two",
        copy_from = "qt_broadsword",
        looks_like = "qt_broadsword",
        name = ccb.content.plural_text("broadsword +2", "broadswords +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "battleaxe_plus_one",
        copy_from = "qt_battleaxe",
        looks_like = "qt_battleaxe",
        name = ccb.content.plural_text("battle axe +1", "battle axes +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "battleaxe_plus_two",
        copy_from = "qt_battleaxe",
        looks_like = "qt_battleaxe",
        name = ccb.content.plural_text("battle axe +2", "battle axes +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cavalry_sabre_plus_one",
        copy_from = "qt_cavalry_sabre",
        looks_like = "qt_cavalry_sabre",
        name = ccb.content.plural_text("cavalry saber +1", "cavalry sabers +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cavalry_sabre_plus_two",
        copy_from = "qt_cavalry_sabre",
        looks_like = "qt_cavalry_sabre",
        name = ccb.content.plural_text("cavalry saber +2", "cavalry sabers +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cutlass_plus_one",
        copy_from = "qt_cutlass",
        looks_like = "qt_cutlass",
        name = ccb.content.plural_text("cutlass +1", "cutlasses +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cutlass_plus_two",
        copy_from = "qt_cutlass",
        looks_like = "qt_cutlass",
        name = ccb.content.plural_text("cutlass +2", "cutlasses +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "katana_plus_one",
        copy_from = "qt_katana",
        looks_like = "qt_katana",
        name = ccb.content.plural_text("katana +1", "katana +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "katana_plus_two",
        copy_from = "qt_katana",
        looks_like = "qt_katana",
        name = ccb.content.plural_text("katana +2", "katana +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_combat_plus_one",
        copy_from = "knife_combat",
        looks_like = "knife_combat",
        name = ccb.content.plural_text("combat knife +1", "combat knives +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_combat_plus_two",
        copy_from = "knife_combat",
        looks_like = "knife_combat",
        name = ccb.content.plural_text("combat knife +2", "combat knives +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_rambo_plus_one",
        copy_from = "qt_knife_rambo",
        looks_like = "qt_knife_rambo",
        name = ccb.content.plural_text("survival knife +1", "survival knives +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_rambo_plus_two",
        copy_from = "qt_knife_rambo",
        looks_like = "qt_knife_rambo",
        name = ccb.content.plural_text("survival knife +2", "survival knives +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_trench_plus_one",
        copy_from = "qt_knife_trench",
        looks_like = "qt_knife_trench",
        name = ccb.content.plural_text("trench knife +1", "trench knives +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_trench_plus_two",
        copy_from = "qt_knife_trench",
        looks_like = "qt_knife_trench",
        name = ccb.content.plural_text("trench knife +2", "trench knives +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "kris_plus_one",
        copy_from = "kris",
        looks_like = "kris",
        name = ccb.content.plural_text("kris +1", "krises +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "kris_plus_two",
        copy_from = "kris",
        looks_like = "kris",
        name = ccb.content.plural_text("kris +2", "krises +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "kukri_plus_one",
        copy_from = "qt_kukri",
        looks_like = "qt_kukri",
        name = ccb.content.plural_text("kukri +1", "kukris +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "kukri_plus_two",
        copy_from = "qt_kukri",
        looks_like = "qt_kukri",
        name = ccb.content.plural_text("kukri +2", "kukris +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "nodachi_plus_one",
        copy_from = "qt_nodachi",
        looks_like = "qt_nodachi",
        name = ccb.content.plural_text("nodachi +1", "nodachi +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "nodachi_plus_two",
        copy_from = "qt_nodachi",
        looks_like = "qt_nodachi",
        name = ccb.content.plural_text("nodachi +2", "nodachi +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "pike_plus_one",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("pike +1", "pikes +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "pike_plus_two",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("pike +2", "pikes +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "rapier_plus_one",
        copy_from = "qt_rapier",
        looks_like = "qt_rapier",
        name = ccb.content.plural_text("rapier +1", "rapiers +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "rapier_plus_two",
        copy_from = "qt_rapier",
        looks_like = "qt_rapier",
        name = ccb.content.plural_text("rapier +2", "rapiers +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "tanto_plus_one",
        copy_from = "tanto",
        looks_like = "tanto",
        name = ccb.content.plural_text("tanto +1", "tanto +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "tanto_plus_two",
        copy_from = "tanto",
        looks_like = "tanto",
        name = ccb.content.plural_text("tanto +2", "tanto +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "wakizashi_plus_one",
        copy_from = "qt_wakizashi",
        looks_like = "qt_wakizashi",
        name = ccb.content.plural_text("wakizashi +1", "wakizashi +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "wakizashi_plus_two",
        copy_from = "qt_wakizashi",
        looks_like = "qt_wakizashi",
        name = ccb.content.plural_text("wakizashi +2", "wakizashi +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "zweihander_plus_one",
        copy_from = "qt_zweihander",
        looks_like = "qt_zweihander",
        name = ccb.content.plural_text("zweihänder +1", "zweihänders +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "zweihander_plus_two",
        copy_from = "qt_zweihander",
        looks_like = "qt_zweihander",
        name = ccb.content.plural_text("zweihänder +2", "zweihänders +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "khopesh_plus_one",
        copy_from = "khopesh",
        looks_like = "khopesh",
        name = ccb.content.plural_text("khopesh +1", "khopeshes +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "khopesh_plus_two",
        copy_from = "khopesh",
        looks_like = "khopesh",
        name = ccb.content.plural_text("khopesh +2", "khopeshes +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_xiphos_plus_one",
        copy_from = "sword_xiphos",
        looks_like = "sword_xiphos",
        name = ccb.content.plural_text("xiphos +1", "xiphe +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_xiphos_plus_two",
        copy_from = "sword_xiphos",
        looks_like = "sword_xiphos",
        name = ccb.content.plural_text("xiphos +2", "xiphe +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "dao_plus_one",
        copy_from = "dao",
        looks_like = "dao",
        name = ccb.content.plural_text("dao +1", "dao +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "dao_plus_two",
        copy_from = "dao",
        looks_like = "dao",
        name = ccb.content.plural_text("dao +2", "dao +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "lucerne_plus_one",
        copy_from = "lucern_hammer",
        looks_like = "lucern_hammer",
        name = ccb.content.plural_text("lucerne hammer +1", "lucerne hammers +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "lucerne_plus_two",
        copy_from = "lucern_hammer",
        looks_like = "lucern_hammer",
        name = ccb.content.plural_text("lucerne hammer +2", "lucerne hammers +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    -- Effectively a durable knife spear +1 with IMPALE tech.  based off Wicked Bonespear.  Lorewise, it would make sense for novice Biomancers to be developing their skills in spears so they can adequately use the Bonespear once they're proficient enough to summon one.  Should be weaker than other school weapons DPSwise due to reach.
    local item = content.Item {
        id = "rune_biomancer_weapon",
        copy_from = "spear_knife",
        looks_like = "spear_knife",
        name = ccb.content.plural_text("Biomancer spear", "Biomancer spears"),
        description = ccb.content.text("A grotesque bone spearhead on a stout wooden pole.  There is a Biomancer rune embedded at the base of the head."),
        mass_milligrams = 1388000,
        volume_ml = 1250,
        longest_side_mm = 1300,
        price_cents = 3900,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "IMPALE", "MOUNTED_CHARGE" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("bone", 1)
    item:quality("COOK", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("TRADER_AVOID")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 21)
    content.add(item)
end

do
    -- Combat stats based off crowbar +1, techniques off Halligan bar(closest non-magical substitute), weight based on 16oz clawhammer head, small wrench and crowbar with a small benefit from being magic
    -- Spellcasting aids like these should have some unique faults that could render them unusable as spellcasting aids.
    local item = content.Item {
        id = "rune_technomancer_weapon",
        looks_like = "halligan",
        name = ccb.content.plural_text("Technomancer toolbar", "Technomancer toolbars"),
        description = ccb.content.text("This staff incorporates a sturdy crescent wrench on top of a prybar and a hammer on the other in a convenient package.  There is a Technomancer rune embedded in the hammerhead."),
        mass_milligrams = 995000,
        volume_ml = 440,
        longest_side_mm = 650,
        price_cents = 3900,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        melee_to_hit = -1,
        weapon_categories = { "HOOKING_WEAPONRY" },
    }
    item:material("steel", 1)
    item:quality("PRY", 3)
    item:quality("HAMMER", 3)
    item:quality("HAMMER_FINE", 1)
    item:quality("WRENCH", 2)
    item:quality("WRENCH_FINE", 2)
    item:quality("PRYING_NAIL", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("TRADER_AVOID")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:clear_melee_damage()
    item:melee_damage("bash", 22)
    item:melee_damage("cut", 1)
    item:fault_group("steel_pipe_short", {  })
    content.add(item)
end

do
    -- The classical vision of the wizard gets a classic weapon.  DPS Stats are between the regular and ironshod versions.  Stats are slightly worse than the QS+1 due to the glass weight slowing attack speed.
    local item = content.Item {
        id = "rune_magus_weapon",
        copy_from = "q_staff",
        looks_like = "q_staff",
        name = ccb.content.plural_text("Magus staff", "Magus staves"),
        description = ccb.content.text("A quarterstaff with runes carved into it and two glass jars, heat-tempered and infused with mana for durability, to act as mana receptacles.  There are two Magi runes embedded at the tips."),
        mass_milligrams = 1530000,
        volume_ml = 1550,
        longest_side_mm = 1850,
        price_cents = 3900,
        melee_to_hit = 4,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:material("diamond", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("TRADER_AVOID")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:clear_melee_damage()
    item:melee_damage("bash", 29)
    content.add(item)
end

do
    -- Flame-bladed sword covers half of Kelvinist's heat-cold theme.  Combat stats equivalent to cutlass +1 with BRUTAL technique.
    local item = content.Item {
        id = "rune_kelvinist_weapon",
        looks_like = "longsword",
        copy_from = "hc_cutlass",
        name = ccb.content.plural_text("Kelvinist flamberge", "Kelvinist flamberges"),
        description = ccb.content.text("A sword with an undulating blade, reminiscent of a flame.  There is a Kelvinist rune embedded in the pommel."),
        price_cents = 3900,
        symbol = "/",
        color = "light_gray",
        weapon_categories = { "MEDIUM_SWORDS" },
        techniques = { "WBLOCK_2", "BRUTAL", "MOUNTED_CHARGE" },
        replace_qualities = true,
    }
    item:quality("CUT", 1)
    item:quality("BUTCHER", 9)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:flag("TRADER_AVOID")
    item:flag("MAGIC_FOCUS")
    item:flag("THERMOMETER")
    item:flag("SPELLCASTING_AID")
    item:adjust_measurements { mass_milligrams = { factor = 0.9 }, melee_to_hit = { offset = 1 } }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    -- Tool qualities equivalent to steak knife, combat equiv.  to copper knife + 1 w/ RAPID and BLOCK1, size/weight off combat knife +1
    local item = content.Item {
        id = "rune_animist_weapon",
        name = ccb.content.plural_text("Animist athame", "Animist athames"),
        description = ccb.content.text("A steel ritual knife used by Animists to draw blood for summoning.  Their school rune is embedded in the crossguard."),
        mass_milligrams = 504000,
        volume_ml = 500,
        longest_side_mm = 250,
        price_cents = 3000,
        symbol = ";",
        color = "light_gray",
        techniques = { "WBLOCK_1", "RAPID" },
        replace_qualities = true,
        melee_to_hit = 0,
        weapon_categories = { "KNIVES" },
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:quality("CUT", 1)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 11)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 13)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end
