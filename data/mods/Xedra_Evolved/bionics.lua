local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("xe_renfield_bionic_activated", function(payload)
    local bionic_id = payload.bionic.value
    if bionic_id == "xe_bio_chiropteran_signal" then
        value(services.characters.cast_spell(
            payload.character,
            services.types.id("spell", "spell_summon_bat_swarm"),
            {
                min_level = 1,
                max_level = 6,
                message = "There is a loud clicking sound as you commune with any nearby bats.",
                targeted = true,
            }
        ))
    elseif bionic_id == "xe_bio_xl_chiropteran_signal" then
        value(services.characters.cast_spell(
            payload.character,
            services.types.id("spell", "spell_summon_bat_giant"),
            {
                min_level = 1,
                max_level = 6,
                message = "A click fires out of the back of your throat like a gunshot.  What could this possibly be speaking to?",
                targeted = true,
            }
        ))
    end
end, 1)
ccb.runtime.hook("on_bionic_activated", "xe_renfield_bionic_activated")

-- Native bionic definitions
content.add(content.Bionic {
    id = "xe_bio_data_shunt",
    name = ccb.content.text("Data Shunt, basic"),
    description = ccb.content.text("CBM which gives you the ability to slot in and out data cores to give yourself proficiencies."),
    cant_remove_reason = ccb.content.text("You'd have an open hole going through your skull to your brain."),
    enchantments = { "ENCH_DATA_SHUNT_BP" },
    passive_pseudo_items = { "data_core_slots" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_giant_hunter",
    name = ccb.content.text("Datacore: Giant Hunting"),
    description = ccb.content.text("A removable data core that can be slotted into a data core for temporary knowledge of a proficiency.  This one teaches you how best to bring down giant humanoids in combat."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_wp_hulk" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 1 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_cyborg_hunting",
    name = ccb.content.text("Datacore: Cyborg Hunting"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the weakpoints of cyborgs."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_wp_cyborg" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 2 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_migo_weakpoints",
    name = ccb.content.text("Datacore: Mi-go Hunting"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the weakpoints of Mi-go."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_wp_mi-go_basic" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 1 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_lockpicking",
    name = ccb.content.text("Datacore: Lockpicking"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the principles of lockpicking."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_lockpicking", "prof_lockpicking_expert" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 2 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_game_ui",
    name = ccb.content.text("Datacore: Trap Highlight UI"),
    description = ccb.content.text("A brain implant causes your visual cortex to highlight likely traps."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_spotting" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 1 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_EOD",
    name = ccb.content.text("Datacore: Trap Disposal"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about how to disarm many types of traps."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_disarming" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 2 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_parkour",
    name = ccb.content.text("Datacore: Parkour"),
    description = ccb.content.text("A brain implant that grants the ability to free run across difficult terrains."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_parkour" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 1 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_muay_thai",
    name = ccb.content.text("Datacore: Muay Thai"),
    description = ccb.content.text("A brain implant that grants the knowledge of Muay Thai martial arts."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    martial_arts = { "style_muay_thai" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 3 } },
})
content.add(content.Bionic {
    id = "xe_bio_dataslot_helicopter_pilot",
    name = ccb.content.text("Datacore: Helicopter Pilot"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the operation of flying machines."),
    installation_requirement = "data_core_install",
    activate_remove_cbm = true,
    proficiencies = { "prof_helicopter_pilot" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "BIONIC_REMOVABLE" },
    occupied_bodyparts = { { bodypart = "data_shunt", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_inventor_mana_kj_penalty_switch",
    name = ccb.content.text("Cyberarcanic Interference Inverter"),
    description = ccb.content.text("Mana and electricity interfere with each other while inside the same thing.  By thoroughly inverting the polarities you switched the interference, prioritizing your inner mana capacity instead of your electrical supply."),
    enchantments = { "BIONIC_ENCH_bio_inventor_mana_kj_penalty_switch_0" },
    occupied_bodyparts = { { bodypart = "torso", slots = 4 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 }, { bodypart = "head", slots = 1 }, { bodypart = "mouth", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_flesh_roots",
    name = ccb.content.text("Fleshy Root Structures"),
    description = ccb.content.text("A fairly disturbing bionic module created by vampires for their servants.  Installed by planting the seed next to the heart inside of the chest, then sealed back up, the remainder of the surgery the seed spreads its root structures across the body and limbs.  The roots large enough to help obstruct damage to the body don't extend into the feet and hands but they do wrap around the skull in places.  They take up very little space for a body plus limbs CBM running mostly along the top layers of the skin.  Rumored to grow denser and thicker as they age over decades and centuries."),
    passive_pseudo_items = { "armor_bio_flesh_roots" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "torso", slots = 4 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_fuel_cell_vamp_blood",
    name = ccb.content.text("Vampire Blood Power Generator"),
    description = ccb.content.text("Embedded into your back and connected to your bionic power supply is a device to convert the blood of vampires to produce a facsimile of bionic power.  It can store up to 100 mL of blood.  For unknown reasons if installed into an active vampire it will not function when filled with its bearers blood.  No one who talks about it knows why."),
    charge_time_turns = 6,
    fuel_efficiency = 0.6,
    exothermic_power_gen = false,
    fuel_options = { "vampire_blood" },
    passive_pseudo_items = { "integrated_vamp_blood_bank" },
    flags = { "BIONIC_TOGGLED", "BIONIC_POWER_SOURCE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 } },
})
content.add(content.Bionic {
    id = "xe_bio_spore_enhancer",
    name = ccb.content.text("Crypt Spore Enhancement System"),
    description = ccb.content.text("There are fungi that grow in the corpse dirt that vampires rest in.  In unexposed humans these fungal spores can cause crippling coughing fits and even death.  But when treated with a solution made of vampire blood or harvested straight from the still-warm lungs of a previous recipient they can be migrated into a living host body where they will speed up reactions and increase strength slightly."),
    enchantments = { "BIONIC_ENCH_xe_bio_spore_enhancer_0" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "xe_bio_chiropteran_signal",
    name = ccb.content.text("Chiropteran Vocal Cords"),
    description = ccb.content.text("Your vocal cords have been enhanced, able to resonate like a bat to draw in a swarm to protect you."),
    activation_energy_millijoules = 100000,
    flags = { "USES_BIONIC_POWER" },
    occupied_bodyparts = { { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "xe_bio_xl_chiropteran_signal",
    name = ccb.content.text("Desmodontinae Gargantua Vocalizer"),
    description = ccb.content.text("Your vocal cords have been reinforced and enlarged.  You can make a strange noise with it, but you don't know what it's supposed to communicate."),
    activation_energy_millijoules = 50000,
    flags = { "USES_BIONIC_POWER" },
    occupied_bodyparts = { { bodypart = "mouth", slots = 2 } },
})
