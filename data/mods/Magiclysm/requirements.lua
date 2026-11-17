local content = require("ccb").content

-- cooking_components.json

content.merge_requirement(
    content.Requirement { id = "eggs_bird" },
    content.Requirement {}
        :component("egg_owlbear", 1)
)

content.merge_requirement(
    content.Requirement { id = "hard_liquor_and_whiskflower" }
        :component_any {
            { id = "hard_liquor_unmixed", count = 1, requirement = true },
            { id = "mixed_alcohol_strong", count = 1 },
            { id = "whiskflower", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "mana_energy_weak" }
        :component_any {
            { id = "lotus", count = 1 },
            { id = "funnelcap_chunk", count = 2 },
            { id = "mana_dust", count = 5 },
            { id = "mossling_fur", count = 8 },
            { id = "dryad_bark", count = 3 },
            { id = "gnome_eye", count = 2 },
            { id = "bracken_eye", count = 1 },
            { id = "dragon_blood", count = 1 },
            { id = "glowing_mushroom", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "mana_energy_strong" }
        :component_any {
            { id = "golden_reed_stalk", count = 1 },
            { id = "funnelcap_chunk", count = 5 },
            { id = "bracken_eye", count = 1 },
            { id = "dryad_bark", count = 10 },
            { id = "dragon_blood", count = 1 },
            { id = "glowing_mushroom", count = 10 },
        }
)

-- Spells/fantasy_species.json

-- meat for Warg-Friend
content.merge_requirement(
    content.Requirement { id = "spell_components_goblin_warg_taming" }
        :component_any {
            { id = "meat", count = 1 },
            { id = "meat_scrap", count = 9 },
            { id = "poultry", count = 1 },
            { id = "poultry_scrap", count = 9 },
        }
)

-- Spells/mana_upgrades.json

content.merge_requirement(
    content.Requirement { id = "spell_components_mana_upgrade_efficiency_01" }
        :component("mana_energy_weak", 5, true)
        :component("mercury", 100)
        :component("crystallized_mana", 25)
        :component_any {
            { id = "copper", count = 250 },
            { id = "scrap_copper", count = 5 },
        }
        :quality("MANA_INFUSE", 1, 1)
        :quality("MANA_FOCUS", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_mana_upgrade_efficiency_02" }
        :component("mana_energy_strong", 5, true)
        :component("mercury", 250)
        :component("mana_infused_blood", 10)
        :component("crystallized_mana", 75)
        :component("silver_small", 250)
        :quality("MANA_INFUSE", 2, 1)
        :quality("MANA_FOCUS", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_mana_upgrade_regeneration_01" }
        :component("mana_energy_weak", 5, true)
        :component("mercury", 100)
        :component("crystallized_mana", 25)
        :component_any {
            { id = "mana_potion_lesser", count = 40 },
            { id = "mana_potion", count = 10 },
            { id = "mana_potion_greater", count = 2 },
        }
        :quality("MANA_INFUSE", 1, 1)
        :quality("MANA_FOCUS", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_mana_upgrade_regeneration_02" }
        :component("mana_energy_strong", 5, true)
        :component("mercury", 250)
        :component("mana_infused_blood", 10)
        :component("crystallized_mana", 75)
        :component_any {
            { id = "mana_potion_lesser", count = 200 },
            { id = "mana_potion", count = 50 },
            { id = "mana_potion_greater", count = 10 },
        }
        :quality("MANA_INFUSE", 2, 1)
        :quality("MANA_FOCUS", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_mana_upgrade_sensitivity_01" }
        :component("mana_energy_weak", 5, true)
        :component("mercury", 100)
        :component("crystallized_mana", 25)
        :component_any {
            { id = "precious_gemstones", count = 5, requirement = true },
            { id = "semiprecious_gemstones", count = 25, requirement = true },
        }
        :quality("MANA_INFUSE", 1, 1)
        :quality("MANA_FOCUS", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_mana_upgrade_sensitivity_02" }
        :component("mana_energy_strong", 5, true)
        :component("mercury", 250)
        :component("mana_infused_blood", 10)
        :component("crystallized_mana", 75)
        :component_any {
            { id = "precious_gemstones", count = 25, requirement = true },
            { id = "semiprecious_gemstones", count = 150, requirement = true },
        }
        :quality("MANA_INFUSE", 2, 1)
        :quality("MANA_FOCUS", 2, 1)
)

-- items/druid_items.json

content.merge_requirement(
    content.Requirement { id = "mag_green_roughage" }
        :component_any {
            { id = "young_leaves", count = 2 },
            { id = "leaves", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "fiddlehead_raw", count = 2 },
            { id = "cattail_rhizome", count = 2 },
            { id = "raw_dandelion", count = 2 },
            { id = "juniper", count = 2 },
        }
)

-- requirements/alchemy.json

-- Dragon scales.  For when any color is interchangeable.
content.merge_requirement(
    content.Requirement { id = "dragon_scale" }
        :component("dragon_black_scale", 1)
)

-- semi-precious gems, for rituals or alchemy 
content.merge_requirement(
    content.Requirement { id = "semiprecious_gemstones" }
        :component_any {
            { id = "garnet", count = 1 },
            { id = "amethyst", count = 1 },
            { id = "aquamarine", count = 1 },
            { id = "alexandrite", count = 1 },
            { id = "malachite", count = 1 },
            { id = "pearl", count = 1 },
            { id = "peridot", count = 1 },
            { id = "opal", count = 1 },
            { id = "tourmaline", count = 1 },
            { id = "citrine", count = 1 },
            { id = "blue_topaz", count = 1 },
            { id = "onyx", count = 1 },
        }
)

-- precious gems, for rituals or alchemy 
content.merge_requirement(
    content.Requirement { id = "precious_gemstones" }
        :component_any {
            { id = "diamond", count = 1 },
            { id = "emerald", count = 1 },
            { id = "ruby", count = 1 },
            { id = "sapphire", count = 1 },
        }
)

-- requirements/cooking_components.json

content.merge_requirement(
    content.Requirement { id = "meat_red_raw_steak" },
    content.Requirement {}
        :component_any {
            { id = "purified_meat", count = 1 },
            { id = "impure_meat", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "meat_red_raw" },
    content.Requirement {}
        :component("purified_meat", 1)
)

content.merge_requirement(
    content.Requirement { id = "hard_liquor_unmixed" },
    content.Requirement {}
        :component_any {
            { id = "dragonfire", count = 1 },
            { id = "goldbrew", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "wash_liquor" },
    content.Requirement {}
        :component_any {
            { id = "wash_dragonfire", count = 1 },
            { id = "wash_goldbrew", count = 1 },
        }
)

-- requirements/crafting.json

content.merge_requirement(
    content.Requirement { id = "welding_standard" },
    content.Requirement {}
        :tool("technomancer_welder", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_standard" },
    content.Requirement {}
        :tool("technomancer_welder", 1)
)

content.merge_requirement(
    content.Requirement { id = "welding_alloys" },
    content.Requirement {}
        :tool("technomancer_welder", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_alloys" },
    content.Requirement {}
        :tool("technomancer_welder", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_rebar" },
    content.Requirement {}
        :tool("technomancer_welder", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_lc_steel" },
    content.Requirement {}
        :tool("technomancer_welder", 1)
)

-- Pickaxe tools
content.merge_requirement(
    content.Requirement { id = "pickaxe_list" },
    content.Requirement {}
        :tool("eshaper_pickaxe", 1)
)

-- Tools and components for wildwood construction. Components ruin appliance construction, keep to tools.
content.merge_requirement(
    content.Requirement { id = "mag_wildwood_construction" }
        :tool_charges("mag_awakened_water", 100)
)

-- requirements/melee.json

-- Any given item that can be used as a spear.  Reserved for crappier things.
content.merge_requirement(
    content.Requirement { id = "basic_spears" },
    content.Requirement {}
        :tool_any {
            { id = "rune_biomancer_weapon", count = 1 },
            { id = "rune_biomancer_weapon_adept", count = 1 },
        }
)

-- Any real, top-heavy bashing weapons with a pointy ball at the end that doesn't independently swing (those are flails).
content.merge_requirement(
    content.Requirement { id = "real_maces" },
    content.Requirement {}
        :tool_any {
            { id = "mace_plus_one", count = 1 },
            { id = "mace_plus_two", count = 1 },
            { id = "morningstar_plus_one", count = 1 },
            { id = "morningstar_plus_two", count = 1 },
        }
)

-- Any basic, easy-to-use bashing weapons.  Like police batons, sticks, or baseball bats.
content.merge_requirement(
    content.Requirement { id = "basic_batons" },
    content.Requirement {}
        :tool_any {
            { id = "cudgel_plus_one", count = 1 },
            { id = "cudgel_plus_two", count = 1 },
            { id = "q_staff_plus_one", count = 1 },
            { id = "q_staff_plus_two", count = 1 },
            { id = "rune_magus_weapon", count = 1 },
            { id = "rune_magus_weapon_adept", count = 1 },
            { id = "springstaff-extended", count = 1 },
        }
)

-- Any real great hammers.  It's got to have a big blunt end on a long pole, directly attached to it.
content.merge_requirement(
    content.Requirement { id = "real_great_hammers" },
    content.Requirement {}
        :tool_any {
            { id = "mjolnir", count = 1 },
            { id = "warhammer_plus_one", count = 1 },
            { id = "warhammer_plus_two", count = 1 },
            { id = "lucerne_plus_one", count = 1 },
            { id = "lucerne_plus_two", count = 1 },
        }
)

-- Any quality weapon designed to hook your opponents and their gear in a fight.  Reserved for the good stuff.
content.merge_requirement(
    content.Requirement { id = "real_hooks" },
    content.Requirement {}
        :tool_any {
            { id = "mjolnir", count = 1 },
            { id = "warhammer_plus_one", count = 1 },
            { id = "warhammer_plus_two", count = 1 },
            { id = "halberd_plus_one", count = 1 },
            { id = "halberd_plus_two", count = 1 },
            { id = "glaive_plus_one", count = 1 },
            { id = "glaive_plus_two", count = 1 },
            { id = "battleaxe_plus_one", count = 1 },
            { id = "battleaxe_plus_two", count = 1 },
            { id = "lucerne_plus_one", count = 1 },
            { id = "lucerne_plus_two", count = 1 },
            { id = "grim_reaper_scythe", count = 1 },
        }
)

-- Any real, top-heavy cutting weapons with a long pole and a blade on the end, designed to swing side-to-side.  Think like a sword with a really long handle.
content.merge_requirement(
    content.Requirement { id = "real_polearms" },
    content.Requirement {}
        :tool_any {
            { id = "halberd_plus_one", count = 1 },
            { id = "halberd_plus_two", count = 1 },
        }
)

-- Any weapon that features a long pole with a pointed tip at the end.  Reserved for quality weapons.
content.merge_requirement(
    content.Requirement { id = "real_spears" },
    content.Requirement {}
        :tool_any {
            { id = "gungnir", count = 1 },
            { id = "wolfsbane", count = 1 },
            { id = "spear_steel_plus_one", count = 1 },
            { id = "spear_steel_plus_two", count = 1 },
            { id = "qiang_plus_one", count = 1 },
            { id = "qiang_plus_two", count = 1 },
            { id = "glaive_plus_one", count = 1 },
            { id = "glaive_plus_two", count = 1 },
            { id = "naginata_plus_one", count = 1 },
            { id = "naginata_plus_two", count = 1 },
            { id = "pike_plus_one", count = 1 },
            { id = "pike_plus_two", count = 1 },
            { id = "lucerne_plus_one", count = 1 },
            { id = "lucerne_plus_two", count = 1 },
        }
)

-- Any real, quality weapon designed to be used in a thrusting fashion.  Needs to be a sword, not a spear.  This includes fencing weaponry.
content.merge_requirement(
    content.Requirement { id = "real_thrusting_swords" },
    content.Requirement {}
        :tool_any {
            { id = "gram", count = 1 },
            { id = "jian_plus_one", count = 1 },
            { id = "jian_plus_two", count = 1 },
            { id = "estoc_plus_one", count = 1 },
            { id = "estoc_plus_two", count = 1 },
            { id = "broadsword_plus_one", count = 1 },
            { id = "broadsword_plus_two", count = 1 },
            { id = "cavalry_sabre_plus_one", count = 1 },
            { id = "cavalry_sabre_plus_two", count = 1 },
            { id = "rapier_plus_one", count = 1 },
            { id = "rapier_plus_two", count = 1 },
        }
)

-- Any real, pole-like weapons designed for bashing and smashing.  Reserved for quality items.
content.merge_requirement(
    content.Requirement { id = "real_quarterstaves" },
    content.Requirement {}
        :tool_any {
            { id = "laevateinn", count = 1 },
            { id = "q_staff_plus_one", count = 1 },
            { id = "q_staff_plus_two", count = 1 },
            { id = "i_staff_plus_one", count = 1 },
            { id = "i_staff_plus_two", count = 1 },
            { id = "rune_magus_weapon", count = 1 },
            { id = "rune_magus_weapon_adept", count = 1 },
        }
)

-- Any small close-range stabbing weapons.  Not explicitly designed for combat.
content.merge_requirement(
    content.Requirement { id = "basic_knives" },
    content.Requirement {}
        :tool_any {
            { id = "rune_animist_weapon", count = 1 },
            { id = "rune_animist_weapon_adept", count = 1 },
        }
)

-- Any real, small weapons meant to stab someone at close range; larger shivs basically.
content.merge_requirement(
    content.Requirement { id = "real_knives" },
    content.Requirement {}
        :tool_any {
            { id = "orich_knife_combat", count = 1 },
            { id = "knife_combat_plus_one", count = 1 },
            { id = "knife_combat_plus_two", count = 1 },
            { id = "knife_rambo_plus_one", count = 1 },
            { id = "knife_rambo_plus_two", count = 1 },
            { id = "knife_trench_plus_one", count = 1 },
            { id = "knife_trench_plus_two", count = 1 },
            { id = "kris_plus_one", count = 1 },
            { id = "kris_plus_two", count = 1 },
            { id = "kukri_plus_one", count = 1 },
            { id = "kukri_plus_two", count = 1 },
            { id = "tanto_plus_one", count = 1 },
            { id = "tanto_plus_two", count = 1 },
        }
)

-- Any real, edged short swords you could practice with, like broadswords.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side can qualify.
content.merge_requirement(
    content.Requirement { id = "real_short_swords" },
    content.Requirement {}
        :tool_any {
            { id = "khopesh_plus_one", count = 1 },
            { id = "khopesh_plus_two", count = 1 },
            { id = "sword_xiphos_plus_one", count = 1 },
            { id = "sword_xiphos_plus_two", count = 1 },
        }
)

-- Any real, edged medium swords you could practice with, like cavalry sabres.  This is any sword that is bigger than a short sword, but shorter than a long sword.
content.merge_requirement(
    content.Requirement { id = "real_medium_swords" },
    content.Requirement {}
        :tool_any {
            { id = "gram", count = 1 },
            { id = "jian_plus_one", count = 1 },
            { id = "jian_plus_two", count = 1 },
            { id = "scimitar_plus_one", count = 1 },
            { id = "scimitar_plus_two", count = 1 },
            { id = "arming_sword_plus_one", count = 1 },
            { id = "arming_sword_plus_two", count = 1 },
            { id = "broadsword_plus_one", count = 1 },
            { id = "broadsword_plus_two", count = 1 },
            { id = "cavalry_sabre_plus_one", count = 1 },
            { id = "cavalry_sabre_plus_two", count = 1 },
            { id = "cutlass_plus_one", count = 1 },
            { id = "cutlass_plus_two", count = 1 },
            { id = "wakizashi_plus_one", count = 1 },
            { id = "wakizashi_plus_two", count = 1 },
            { id = "dao_plus_one", count = 1 },
            { id = "dao_plus_two", count = 1 },
            { id = "rune_kelvinist_weapon", count = 1 },
            { id = "rune_kelvinist_ice_adept_weapon", count = 1 },
        }
)

-- Any real, edged long swords you could practice with, like katanas, longswords, etc.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side can qualify.
content.merge_requirement(
    content.Requirement { id = "real_long_swords" },
    content.Requirement {}
        :tool_any {
            { id = "orich_longsword", count = 1 },
            { id = "longsword_mithril", count = 1 },
            { id = "longsword_plus_one", count = 1 },
            { id = "longsword_plus_two", count = 1 },
            { id = "katana_plus_one", count = 1 },
            { id = "katana_plus_two", count = 1 },
        }
)

-- Any real, edged, big swords you could practice with, like zweihanders, greatswords, or the Dragonslayer, etc.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side, and is large enough to require a normal human to use two hands can qualify.
content.merge_requirement(
    content.Requirement { id = "real_great_swords" },
    content.Requirement {}
        :tool_any {
            { id = "nodachi_plus_one", count = 1 },
            { id = "nodachi_plus_two", count = 1 },
            { id = "zweihander_plus_one", count = 1 },
            { id = "zweihander_plus_two", count = 1 },
        }
)

-- Any real, cutting weapons that can be used like an axe; large, heavy head with two sharp sides on a pole.
content.merge_requirement(
    content.Requirement { id = "real_axes" },
    content.Requirement {}
        :tool_any {
            { id = "rune_stormshaper_weapon", count = 1 },
            { id = "rune_stormshaper_weapon_adept", count = 1 },
        }
)

-- Any real, cutting weapons that can be used like an axe; large, heavy head with two sharp sides on a pole.
content.merge_requirement(
    content.Requirement { id = "real_great_axes" },
    content.Requirement {}
        :tool_any {
            { id = "orich_fire_ax", count = 1 },
            { id = "battleaxe_plus_one", count = 1 },
            { id = "battleaxe_plus_two", count = 1 },
        }
)

-- Any weapon that features a handle and flexible lash.
content.merge_requirement(
    content.Requirement { id = "whips" },
    content.Requirement {}
        :tool_any {
            { id = "tentacle_whip", count = 1 },
            { id = "flarewhip", count = 1 },
            { id = "mwhip_iron", count = 1 },
        }
)

-- requirements/spell_components.json

-- Wooden swords usable for the Flamesword spell
content.merge_requirement(
    content.Requirement { id = "spell_components_flamesword" }
        :component_any {
            { id = "sword_wood", count = 1 },
            { id = "sword_nail", count = 1 },
            { id = "sword_crude", count = 1 },
        }
)

-- 100ml portions of combustible dusts usable for the Flamebreath spell
content.merge_requirement(
    content.Requirement { id = "spell_components_flamebreath" }
        :component_any {
            { id = "sugar", count = 28 },
            { id = "flour", count = 4 },
            { id = "tinder", count = 100 },
            { id = "cinnamon", count = 40 },
            { id = "chilly-p", count = 40 },
        }
)

-- Iron or steel pointed knives suitable for the Knifeshot spell
content.merge_requirement(
    content.Requirement { id = "spell_components_knifeshot" }
        :component_any {
            { id = "xacto", count = 1 },
            { id = "diveknife", count = 1 },
            { id = "knife_huge", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_large", count = 1 },
            { id = "knife_hunting", count = 1 },
            { id = "knife_rambo", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "throwing_knife", count = 1 },
            { id = "knife_baselard", count = 1 },
            { id = "magical_throwing_knife", count = 1 },
            { id = "magical_throwing_knife_fire", count = 1 },
            { id = "magical_throwing_knife_cold", count = 1 },
            { id = "magical_throwing_knife_cut", count = 1 },
            { id = "magical_throwing_knife_biological", count = 1 },
            { id = "magical_throwing_knife_pure_special", count = 1 },
        }
)

-- Weapon materials and 1000 energy from blood suitable for the Decaying Boneclub spell
content.merge_requirement(
    content.Requirement { id = "spell_components_decayingboneclub" }
        :component_any {
            { id = "bone", count = 3 },
            { id = "bone_demihuman", count = 3 },
            { id = "bone_human", count = 3 },
            { id = "bone_tainted", count = 6 },
        }
        :component_any {
            { id = "blood", count = 4 },
            { id = "blood_tainted", count = 1 },
            { id = "dragon_blood", count = 20 },
        }
)

-- Fur and bones suitable for the Feral Form spell
content.merge_requirement(
    content.Requirement { id = "spell_components_feralform" }
        :component_any {
            { id = "fur", count = 3 },
            { id = "hairball", count = 2 },
        }
        :component_any {
            { id = "bone", count = 1 },
            { id = "bone_demihuman", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_tainted", count = 2 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_healing_herb" }
        :component("horn_moss_capsule", 1)
)

-- Feathers and mercury for the Impact Sling spell
content.merge_requirement(
    content.Requirement { id = "spell_components_impactsling" }
        :component_any {
            { id = "feather", count = 5 },
            { id = "down_feather", count = 5 },
        }
        :component("mercury", 3)
)

-- Mercury for the Haste spell
content.merge_requirement(
    content.Requirement { id = "spell_components_haste" }
        :component("mercury", 50)
)

-- Strong acids suitable for the Caustic Aura spell
content.merge_requirement(
    content.Requirement { id = "spell_components_causticaura" }
        :component_any {
            { id = "chem_sulphuric_acid", count = 2 },
            { id = "chem_muriatic_acid", count = 2 },
            { id = "chem_nitric_acid", count = 2 },
        }
)

-- A kilo of metal fragments suitable for the Shardspray spell
content.merge_requirement(
    content.Requirement { id = "spell_components_shardspray" }
        :component_any {
            { id = "scrap", count = 40 },
            { id = "copper", count = 500 },
            { id = "gold_small", count = 200 },
            { id = "silver_small", count = 333 },
            { id = "lead", count = 333 },
        }
)

-- Fire starting items suitable for the Nova Flare spell
content.merge_requirement(
    content.Requirement { id = "spell_components_nova_flare" }
        :component_any {
            { id = "coal_lump", count = 30 },
            { id = "lamp_oil", count = 5 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_reactive_armor" }
        :component("aura_stoneskin", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_rune_animist" }
        :component("rune_animist", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_rune_animist_3" }
        :component("rune_animist", 3)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_potion_starter" }
        :component_any {
            { id = "water", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "water_clean", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_manabomb" }
        :component("potion_starter", 3)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_manatrap" }
        :component_any {
            { id = "potion_starter", count = 6 },
            { id = "alchemist_bomb", count = 2 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_samsara" }
        :component("rune_druid", 1)
)

-- Leaves and bark for the Vegetative Poultice spell
content.merge_requirement(
    content.Requirement { id = "spell_components_druid_bandage" }
        :component_any {
            { id = "young_leaves", count = 2 },
            { id = "leaves", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "fiddlehead_raw", count = 2 },
            { id = "cattail_rhizome", count = 2 },
            { id = "raw_dandelion", count = 2 },
            { id = "juniper", count = 2 },
        }
        :component_any {
            { id = "alder_bark", count = 1 },
            { id = "tanbark", count = 1 },
            { id = "birchbark", count = 1 },
            { id = "willowbark", count = 1 },
        }
)

-- Sticks for the for the Harvest of the Hunter spell
content.merge_requirement(
    content.Requirement { id = "spell_components_druid_arrow" }
        :component_any {
            { id = "pine_bough", count = 2 },
            { id = "stick", count = 1 },
            { id = "stick_long", count = 1 },
            { id = "stick_fiber", count = 2 },
            { id = "alder_bark", count = 5 },
            { id = "tanbark", count = 5 },
            { id = "birchbark", count = 5 },
            { id = "willowbark", count = 5 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_magus_mark" }
        :component("crystallized_mana", 10)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_word_of_recall" }
        :component("crystallized_mana", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_remove_instability" }
        :component("purifier", 1)
)

-- Sticks to turn into a bramble spear
content.merge_requirement(
    content.Requirement { id = "spell_components_druid_bramble_spear" }
        :component_any {
            { id = "stick", count = 1 },
            { id = "stick_long", count = 1 },
        }
)

-- Water for Water's Cooling Touch
content.merge_requirement(
    content.Requirement { id = "spell_components_druid_anti_heat" }
        :component_any {
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 },
            { id = "salt_water", count = 2 },
            { id = "water_mineral", count = 2 },
        }
)

-- Alcohol for Flames of Passion
content.merge_requirement(
    content.Requirement { id = "spell_components_flames_of_passion" }
        :component_any {
            { id = "hard_liquor", count = 1, requirement = true },
            { id = "cheap_wine", count = 1, requirement = true },
            { id = "worthy_wine", count = 1, requirement = true },
        }
)

-- Spell components for the Body of Spirit spell
content.merge_requirement(
    content.Requirement { id = "spell_components_spirit_walking" }
        :component("lead", 1)
        :component("gold_small", 1)
)

-- Water and soap / lye for Freshen Up
content.merge_requirement(
    content.Requirement { id = "spell_components_freshen_up" }
        :component_any {
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "water_mineral", count = 1 },
        }
        :component_any {
            { id = "soap", count = 1 },
            { id = "detergent", count = 5 },
            { id = "liquid_soap", count = 3 },
            { id = "lye", count = 1 },
            { id = "lye_powder", count = 1 },
        }
)

-- glass shard suitable for the Invisibility spell
content.merge_requirement(
    content.Requirement { id = "spell_components_invisibility" }
        :component("glass_shard", 1)
)

-- non-food powder suitable for the Shape of Dust spell
content.merge_requirement(
    content.Requirement { id = "spell_components_shape_of_dust" }
        :component_any {
            { id = "magnesium", count = 5 },
            { id = "chem_aluminium_powder", count = 5 },
            { id = "material_cement", count = 5 },
            { id = "chem_nickel_powder", count = 5 },
            { id = "meal_chitin_piece", count = 5 },
            { id = "chem_nickel_powder", count = 5 },
            { id = "chem_black_powder", count = 5 },
        }
)

-- A bone for the Osseous Luck spell
content.merge_requirement(
    content.Requirement { id = "spell_components_luck_bone" }
        :component_any {
            { id = "bone", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_demihuman", count = 1 },
        }
)

-- Chamomile for the Peaceful Rest spell
content.merge_requirement(
    content.Requirement { id = "spell_components_easy_sleep" }
        :component("chamomile", 1)
)

-- A wire for the Machine Mind spell
content.merge_requirement(
    content.Requirement { id = "spell_components_technomancer_gain_electronics_computer" }
        :component_any {
            { id = "cable", count = 1 },
            { id = "copper_wire", count = 1 },
            { id = "solder_wire", count = 1 },
        }
)

-- Coal or charcoal for the Baking Hands spell
content.merge_requirement(
    content.Requirement { id = "spell_components_baking_hands" }
        :component_any {
            { id = "coal_lump", count = 1 },
            { id = "charcoal", count = 1 },
        }
)

-- Diamonds for the Diamond Imbuement spell
content.merge_requirement(
    content.Requirement { id = "spell_components_diamond_imbuement" }
        :component("diamond", 5)
)

-- Herbs and sulfur for the Abjure Spirits of Rot spell
content.merge_requirement(
    content.Requirement { id = "spell_components_slow_food_rotting" }
        :component("wild_herbs", 15)
        :component("chem_sulphur", 20)
)

-- Metal, stone, and dirt for the Fault-Mending Chant spell
content.merge_requirement(
    content.Requirement { id = "spell_components_repair_metal_stone" }
        :component("material_soil", 1)
        :component("rock", 1)
        :component_any {
            { id = "lead", count = 5 },
            { id = "platinum_small", count = 5 },
            { id = "copper", count = 5 },
            { id = "gold_small", count = 5 },
            { id = "silver_small", count = 5 },
            { id = "scrap_cast_iron", count = 5 },
            { id = "chunk_cast_iron", count = 1 },
        }
)

-- Fuel oils for the Power Linkage spell
content.merge_requirement(
    content.Requirement { id = "spell_components_create_ups_connection" }
        :component_any {
            { id = "crude_lamp_oil", count = 120 },
            { id = "lamp_oil", count = 120 },
            { id = "gasoline", count = 120 },
            { id = "diesel", count = 120 },
        }
)

-- Lens, chisel, and mana focus for the Zoom Lens spell
content.merge_requirement(
    content.Requirement { id = "spell_components_technomancer_far_sight" }
        :component("lens", 1)
        :quality("CHISEL", 3, 1)
        :quality("MANA_FOCUS", 1, 1)
)

-- Crystallized mana for the Mana Extraction spell
content.merge_requirement(
    content.Requirement { id = "spell_components_restore_crystal_mana" }
        :component("crystallized_mana", 5)
)

-- berries for the Goodberry spell
content.merge_requirement(
    content.Requirement { id = "spell_components_goodberry" }
        :component_any {
            { id = "elderberries", count = 1 },
            { id = "mulberries", count = 1 },
            { id = "huckleberries", count = 1 },
            { id = "raspberries", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "grapes", count = 1 },
            { id = "blackberries", count = 1 },
            { id = "wintergreen_berry", count = 1 },
        }
)

-- Precious metals for the Imperishable Light spell
content.merge_requirement(
    content.Requirement { id = "spell_components_magus_permanent_light" }
        :component("gold_small", 5)
        :component("silver_small", 5)
        :component("copper", 5)
)

-- Water for the Carmine Infusion spell
content.merge_requirement(
    content.Requirement { id = "spell_components_biomancer_get_more_blood" }
        :component_any {
            { id = "salt_water", count = 1 },
            { id = "water_clean", count = 1 },
        }
)

-- Ruby for the Flames of the Apocalypse spell.  Add crimsonite once discrete chunks of it exist
content.merge_requirement(
    content.Requirement { id = "spell_components_kelvinist_set_everyone_on_fire" }
        :component("ruby", 1)
)

-- Silver for the Seeing the Unseen spell
content.merge_requirement(
    content.Requirement { id = "spell_components_animist_see_invisibility" }
        :component("silver_small", 5)
)

-- Stone or metal for the for the Enchanted Lamp spell
content.merge_requirement(
    content.Requirement { id = "spell_components_create_atomic_lamp" }
        :component_any {
            { id = "rock", count = 1 },
            { id = "rock_flaking", count = 1 },
            { id = "sharp_rock", count = 1 },
            { id = "lead", count = 1 },
            { id = "platinum_small", count = 1 },
            { id = "copper", count = 1 },
            { id = "gold_small", count = 1 },
            { id = "silver_small", count = 1 },
            { id = "scrap_cast_iron", count = 1 },
            { id = "chunk_cast_iron", count = 1 },
            { id = "steel_chunk", count = 1 },
            { id = "budget_steel_chunk", count = 1 },
            { id = "chunk_cast_iron", count = 1 },
            { id = "lc_steel_chunk", count = 1 },
            { id = "mc_steel_chunk", count = 1 },
            { id = "hc_steel_chunk", count = 1 },
            { id = "ch_steel_chunk", count = 1 },
            { id = "qt_steel_chunk", count = 1 },
        }
)

-- Spells/attunements/Artificer.json

content.merge_requirement(
    content.Requirement { id = "spy_wasp" }
        :component("e_scrap", 2)
)

-- Spells/attunements/Biotek.json

content.merge_requirement(
    content.Requirement { id = "jury_rig" }
        :component_any {
            { id = "e_scrap", count = 2 },
            { id = "scrap", count = 1 },
        }
)

-- Spells/attunements/Golemancer.json

content.merge_requirement(
    content.Requirement { id = "summon_golem" }
        :component("golemcore", 1)
)

-- Spells/attunements/Magnetism_Mage.json

content.merge_requirement(
    content.Requirement { id = "railgun_bullet" }
        :component_any {
            { id = "8mm_caseless", count = 1 },
            { id = "8mm_hvp", count = 1 },
            { id = "8mm_jhp", count = 1 },
            { id = "9mm", count = 1 },
            { id = "9mmfmj", count = 1 },
            { id = "9mmP", count = 1 },
            { id = "9mmP2", count = 1 },
            { id = "bp_9mm", count = 1 },
            { id = "bp_9mmfmj", count = 1 },
            { id = "reloaded_9mm", count = 1 },
            { id = "reloaded_9mmfmj", count = 1 },
            { id = "reloaded_9mmP", count = 1 },
            { id = "reloaded_9mmP2", count = 1 },
            { id = "9x18mm", count = 1 },
            { id = "9x18mmP2", count = 1 },
            { id = "9x18mmfmj", count = 1 },
            { id = "bp_9x18mm", count = 1 },
            { id = "bp_9x18mmfmj", count = 1 },
            { id = "reloaded_9x18mm", count = 1 },
            { id = "reloaded_9x18mmP2", count = 1 },
            { id = "reloaded_9x18mmfmj", count = 1 },
            { id = "10mm_fmj", count = 1 },
            { id = "bp_10mm_fmj", count = 1 },
            { id = "reloaded_10mm_fmj", count = 1 },
            { id = "12mm", count = 1 },
            { id = "reloaded_10mm_fmj", count = 1 },
            { id = "22_cb", count = 1 },
            { id = "22_fmj", count = 1 },
            { id = "22_lr", count = 1 },
            { id = "22_ratshot", count = 1 },
            { id = "bp_22_fmj", count = 1 },
            { id = "bp_22_lr", count = 1 },
            { id = "reloaded_22_lr", count = 1 },
            { id = "reloaded_22_fmj", count = 1 },
            { id = "32_acp", count = 1 },
            { id = "bp_32_acp", count = 1 },
            { id = "reloaded_32_acp", count = 1 },
            { id = "38_fmj", count = 1 },
            { id = "38_special", count = 1 },
            { id = "38_super", count = 1 },
            { id = "reloaded_38_fmj", count = 1 },
            { id = "reloaded_38_special", count = 1 },
            { id = "reloaded_38_super", count = 1 },
            { id = "bp_38_fmj", count = 1 },
            { id = "bp_38_special", count = 1 },
            { id = "38super_fmj", count = 1 },
            { id = "reloaded_38super_fmj", count = 1 },
            { id = "40fmj", count = 1 },
            { id = "40sw", count = 1 },
            { id = "bp_40fmj", count = 1 },
            { id = "bp_40sw", count = 1 },
            { id = "reloaded_40fmj", count = 1 },
            { id = "reloaded_40sw", count = 1 },
            { id = "44fmj", count = 1 },
            { id = "44magnum", count = 1 },
            { id = "reloaded_44fmj", count = 1 },
            { id = "reloaded_44magnum", count = 1 },
            { id = "bp_44magnum", count = 1 },
            { id = "bp_44fmj", count = 1 },
            { id = "45_acp", count = 1 },
            { id = "45_jhp", count = 1 },
            { id = "45_super", count = 1 },
            { id = "bp_45_acp", count = 1 },
            { id = "bp_45_jhp", count = 1 },
            { id = "reloaded_45_acp", count = 1 },
            { id = "reloaded_45_jhp", count = 1 },
            { id = "reloaded_45_super", count = 1 },
            { id = "45colt_jhp", count = 1 },
            { id = "reloaded_45colt_jhp", count = 1 },
            { id = "50bmg", count = 1 },
            { id = "50match", count = 1 },
            { id = "50ss", count = 1 },
            { id = "reloaded_50bmg", count = 1 },
            { id = "reloaded_50ss", count = 1 },
            { id = "57mm", count = 1 },
            { id = "bp_57mm", count = 1 },
            { id = "reloaded_57mm", count = 1 },
            { id = "223", count = 1 },
            { id = "556", count = 1 },
            { id = "bp_223", count = 1 },
            { id = "bp_556", count = 1 },
            { id = "reloaded_223", count = 1 },
            { id = "reloaded_556", count = 1 },
            { id = "270win_jsp", count = 1 },
            { id = "bp_270win_jsp", count = 1 },
            { id = "reloaded_270win_jsp", count = 1 },
            { id = "300_winmag", count = 1 },
            { id = "bp_300_winmag", count = 1 },
            { id = "reloaded_300_winmag", count = 1 },
            { id = "300blk", count = 1 },
            { id = "300blk_ss", count = 1 },
            { id = "bp_300blk", count = 1 },
            { id = "reloaded_300blk", count = 1 },
            { id = "308", count = 1 },
            { id = "762_51", count = 1 },
            { id = "bp_308", count = 1 },
            { id = "bp_762_51", count = 1 },
            { id = "reloaded_308", count = 1 },
            { id = "reloaded_762_51", count = 1 },
            { id = "357mag_fmj", count = 1 },
            { id = "357mag_jhp", count = 1 },
            { id = "bp_357mag_fmj", count = 1 },
            { id = "bp_357mag_jhp", count = 1 },
            { id = "reloaded_357mag_fmj", count = 1 },
            { id = "reloaded_357mag_jhp", count = 1 },
            { id = "357sig_fmj", count = 1 },
            { id = "357sig_jhp", count = 1 },
            { id = "reloaded_357sig_fmj", count = 1 },
            { id = "reloaded_357sig_jhp", count = 1 },
            { id = "380_FMJ", count = 1 },
            { id = "380_JHP", count = 1 },
            { id = "380_p", count = 1 },
            { id = "bp_380_FMJ", count = 1 },
            { id = "bp_380_JHP", count = 1 },
            { id = "reloaded_380_FMJ", count = 1 },
            { id = "reloaded_380_JHP", count = 1 },
            { id = "reloaded_380_p", count = 1 },
            { id = "454_Casull", count = 1 },
            { id = "reloaded_454_Casull", count = 1 },
            { id = "bp_454_Casull", count = 1 },
            { id = "500_Magnum", count = 1 },
            { id = "bp_500_Magnum", count = 1 },
            { id = "reloaded_500_Magnum", count = 1 },
            { id = "545", count = 1 },
            { id = "545_ap", count = 1 },
            { id = "reloaded_545", count = 1 },
            { id = "reloaded_545_ap", count = 1 },
            { id = "762_jhp", count = 1 },
            { id = "762_m87", count = 1 },
            { id = "reloaded_762_jhp", count = 1 },
            { id = "reloaded_762_m87", count = 1 },
            { id = "762_54R", count = 1 },
            { id = "762_25", count = 1 },
            { id = "762_25hot", count = 1 },
            { id = "762_25typeP", count = 1 },
            { id = "bp_762_25", count = 1 },
            { id = "reloaded_762_25", count = 1 },
            { id = "3006", count = 1 },
            { id = "3006fmj", count = 1 },
            { id = "bp_3006", count = 1 },
            { id = "bp_3006fmj", count = 1 },
            { id = "reloaded_3006", count = 1 },
            { id = "reloaded_3006fmj", count = 1 },
            { id = "4570_sp", count = 1 },
            { id = "4570_pen", count = 1 },
            { id = "4570_low", count = 1 },
            { id = "reloaded_4570_sp", count = 1 },
            { id = "reloaded_4570_pen", count = 1 },
            { id = "reloaded_4570_low", count = 1 },
            { id = "reloaded_4570_bp", count = 1 },
            { id = "reloaded_762_jhp", count = 1 },
        }
)
