local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

ccb.runtime.handler("gene_sting_mutation", function(impact)
    local target = impact.target
    if impact.dealt_damage <= 0 or not target or target.subtype == "monster" then
        return
    end
    -- The original rule drew a string index even with only one choice.
    services.random.native_int(0, 0)
    local result = services.text.expand_for("<random_category>", impact.source, target, nil, nil, true)
    if not result.ok then
        error(result.error.message)
    end
    local category = services.types.id("mutation_category", result.value)
    local mutation = services.mutations.mutate_category(target, category, false, true)
    if not mutation.ok then
        error(mutation.error.message)
    end
end)

content.add(content.AmmoEffect { id = "GENE_STING_BARB" }
    :impact_policy("gene_sting_mutation"))

content.add(content.AmmoEffect { id = "AE_NULL" }
    :field_burst{ field = "fd_null", intensity_min = 0, intensity_max = 0, radius = 0, height = 0, chance = 100, footprint = 0, passable_only = false }
    :explosion{ power = 0, distance_factor = 0.8, fire = false }
    :shrapnel{ casing_mass = 0, fragment_mass = 0.0025, recovery = 0, drop = "null" })

-- Drops a sling projectile at the first creature or impassable obstacle on its path, even if impact damage is dodged. Hardcoded.
content.add(content.AmmoEffect { id = "STOP_ON_CONTACT" })

-- Prevents a projectile from going through a tile with obstacles, such as chainlink fences or dressers. Hardcoded
content.add(content.AmmoEffect { id = "NO_PENETRATE_OBSTACLES" })

-- Stuns the target. Hardcoded
content.add(content.AmmoEffect { id = "BEANBAG" })

-- Heavily stuns the target. Hardcoded
content.add(content.AmmoEffect { id = "LARGE_BEANBAG" })

-- Doesn't go through regular bullet animation; instead draws a line and the bullet on its end for one frame. Hardcoded
content.add(content.AmmoEffect { id = "DRAW_AS_LINE" })

-- Applies sap-coated effect on hit, used with special hardcoded monster attack. Hardcoded
content.add(content.AmmoEffect { id = "APPLY_SAP" })

-- Blinds the target if it hits the head. Hardcoded
content.add(content.AmmoEffect { id = "BLINDS_EYES" })

-- Projectile with this effect will rebound to a nearby target after hitting the original target. Will not choose targets already hit by this projectile. Hardcoded
content.add(content.AmmoEffect { id = "BOUNCE" })

-- Ammo effect, applied to thrown projectile, when it has 'burst_when_filled' defined, which makes it spills the contents on hit. Hardcoded, and probably can't be used as actual ammo effect
content.add(content.AmmoEffect { id = "BURST" })

-- Ammo item explodes when lit on fire with its ammo_effect. Strength of the explosion does not scale to the amount of ammo. If both COOKOFF and SPECIAL_COOKOFF are used, only SPECIAL_ effect would be used. Hardcoded
content.add(content.AmmoEffect { id = "SPECIAL_COOKOFF" })

-- Ammo item creates an explosion when lit on fire. Strength of the explosion scales to the amount of ammo. Hardcoded
content.add(content.AmmoEffect { id = "COOKOFF" })

-- This ammo may clog up the gun with blackpowder fouling, which will also cause rust. Hardcoded
content.add(content.AmmoEffect { id = "BLACKPOWDER" })

-- Allows projectile to continue through when doing excess damage on hit. Hardcoded
content.add(content.AmmoEffect { id = "EXCESS_PEN" })

-- Automatically applied to any projectile, heavier than 500g, to increase it's noise (currently used only when projectile fall into water). Hardcoded
content.add(content.AmmoEffect { id = "HEAVY_HIT" })

-- Creature, that got hit with this projectile, would be ignited for a short duration, up to 4 seconds, (6 if creature is made out of flammable material or made out of veggy). Hardcoded in projectile::apply_effects_damage
-- 10% chance to start fires on flammable (has flag FLAMMABLE_ASH) furniture/terrain **with defined shoot data**, hardcoded in map::shoot
content.add(content.AmmoEffect { id = "INCENDIARY" })

-- Same as INCENDIARY, creature that got hit with this projectile, would be ignited for a short duration, up to 6 seconds, (10 if creature is made out of flammable material or made out of veggy). Hardcoded
-- Guaranteed to start fires on flammable (has flag FLAMMABLE_ASH) furniture/terrain **with defined shoot data**, hardcoded in map::shoot
content.add(content.AmmoEffect { id = "IGNITE" })

-- For curses build, draws a `*` symbol as a flying projectile (unlike usual `#` symbol). Hardcoded
content.add(content.AmmoEffect { id = "JET" })

-- Bullet has a chance of damaging the gun from overpressure regardless of fouling level, used in rounds, reloaded with matches. Hardcoded
content.add(content.AmmoEffect { id = "MATCHHEAD" })

-- Always best possible hit, no damage multipliers. Hardcoded
content.add(content.AmmoEffect { id = "MAGIC" })

-- Generate a small cloud of smoke at the source. Hardcoded
content.add(content.AmmoEffect { id = "MUZZLE_SMOKE" })

-- Always set 100% damage due to hit in the weakpoint. Hardcoded
content.add(content.AmmoEffect { id = "NO_DAMAGE_SCALING" })

-- When an item would be spawned from the projectile, it will always be spawned on the ground rather than in a monster's inventory. Implied for active thrown items. Doesn't do anything on projectiles that do not drop items. Hardcoded
content.add(content.AmmoEffect { id = "NO_EMBED" })

-- Prevents overkill damage on the target (target won't explode into gibs, same as monster's flag `NOGIB`). Hardcoded
content.add(content.AmmoEffect { id = "NOGIB" })

-- Will not damage items on the map even when it otherwise would try to. Hardcoded
content.add(content.AmmoEffect { id = "NO_ITEM_DAMAGE" })

-- Disables misfires.
content.add(content.AmmoEffect { id = "NEVER_MISFIRES" })

-- This ammo does not cause dirtying or blackpowder fouling on the gun when fired. Hardcoded
content.add(content.AmmoEffect { id = "NON_FOULING" })

-- Projectiles with this effect won't fly farther than player's set target tile. Hardcoded
content.add(content.AmmoEffect { id = "NO_OVERSHOOT" })

-- NPCs won't use guns or gunmods loaded with ammo with this effect. Hardcoded
content.add(content.AmmoEffect { id = "NPC_AVOID" })

-- Projectiles with this effect doesn't have a creature who fired them; applied only to explosives' shrapnel. Hardcoded
content.add(content.AmmoEffect { id = "NULL_SOURCE" })

-- Applies paralyzing poison effect on damaging hit. Hardcoded
content.add(content.AmmoEffect { id = "PARALYZEPOISON" })

-- Applies sensor-stunning effect to robots.  Only intended to affect ROBOTs not CYBORGs. Hardcoded
content.add(content.AmmoEffect { id = "ROBOT_DAZZLE" })

-- Causes the gun to misfire sometimes, used in handloaded ammo; this is independent of the weapon flags. Hardcoded
content.add(content.AmmoEffect { id = "RECYCLED" })

-- Destroys itself and creates shards on hit. Applied to any projectile (usually throwing one), if it has glass as material, and not active. Hardcoded
content.add(content.AmmoEffect { id = "SHATTER_SELF" })

-- Multiple smaller pellets; less effective against armor but increases chance to hit and no point-blank penalty. Hardcoded
content.add(content.AmmoEffect { id = "SHOT" })

-- Prevent HARDTOSHOOT monster flag from having any effect; automatically applied to ammo with `SHOT` flag or which have liquid phase. Hardcoded
content.add(content.AmmoEffect { id = "WIDE" })

-- Is applied on projectiles made out of items with ACT_ON_RANGED_HIT flag. Hardcoded
content.add(content.AmmoEffect { id = "ACT_ON_RANGED_HIT" })

-- Is applied on projectiles made out of items with HURT_WHEN_WIELDED flag. Hardcoded
content.add(content.AmmoEffect { id = "HURT_WHEN_WIELDED" })

-- Very small explosion that lights fires
content.add(content.AmmoEffect { id = "FLAME" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1, footprint = 3 })

-- Explosion that spreads fire
content.add(content.AmmoEffect { id = "NAPALM" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1, footprint = 3 }
    :explosion{ power = 60, distance_factor = 0.7, fire = true, light = "incendiary_blast" })

-- Large explosion that spreads fire of high intensity
content.add(content.AmmoEffect { id = "PYROPHORIC" }
    :field_burst{ field = "fd_fire", intensity_min = 2, intensity_max = 2, radius = 3 }
    :explosion{ power = 360, distance_factor = 0.8, fire = true, light = "incendiary_blast" })

-- Main damage is not from fire on the ground, but from fire sticking to enemies
content.add(content.AmmoEffect { id = "MOLOTOV" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1, chance = 50, footprint = 1 }
    :field_burst{ field = "fd_smoke", intensity_min = 1, intensity_max = 1, chance = 25, footprint = 1 }
    :area_effect{ effect = "onfire", duration_turns = 60, intensity_min = 1, chance = 50, hits_min = 1, hits_max = 3 })

-- Fire is not stronger, but much stickier
content.add(content.AmmoEffect { id = "GELLED_MOLOTOV" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1, chance = 60, footprint = 1 }
    :field_burst{ field = "fd_smoke", intensity_min = 1, intensity_max = 2, chance = 70, footprint = 1 }
    :area_effect{ effect = "onfire", duration_turns = 60, intensity_min = 2, chance = 80, hits_min = 2, hits_max = 6 })

-- Leaves a pool of acid on detonation
content.add(content.AmmoEffect { id = "ACIDBOMB" }
    :field_burst{ field = "fd_acid", intensity_min = 3, intensity_max = 3 })

-- Creates a cloud of toxic gas on hit
content.add(content.AmmoEffect { id = "TOXICGAS" }
    :field_burst{ field = "fd_toxic_gas", intensity_min = 3, intensity_max = 3 })

-- Creates a cloud of fungicidal gas on hit
content.add(content.AmmoEffect { id = "GAS_FUNGICIDAL" }
    :field_burst{ field = "fd_fungicidal_gas", intensity_min = 3, intensity_max = 3 })

-- Creates a cloud of insecticidal gas on hit
content.add(content.AmmoEffect { id = "GAS_INSECTICIDAL" }
    :field_burst{ field = "fd_insecticidal_gas", intensity_min = 3, intensity_max = 3 })

-- Generates a cloud of smoke at the target
content.add(content.AmmoEffect { id = "SMOKE" }
    :field_burst{ field = "fd_smoke", intensity_min = 3, intensity_max = 3 })

-- Generates a large cloud of smoke at the target
content.add(content.AmmoEffect { id = "SMOKE_BIG" }
    :field_burst{ field = "fd_smoke", intensity_min = 3, intensity_max = 3, radius = 6 })

-- Lights the target tile on fire
content.add(content.AmmoEffect { id = "FLARE" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1 })

-- Creates a trail of lightning
content.add(content.AmmoEffect { id = "LIGHTNING" }
    :field_burst{ field = "fd_electricity", intensity_min = 6, intensity_max = 10, chance = 25 })

-- Creates a trail of superheated plasma
content.add(content.AmmoEffect { id = "PLASMA" }
    :field_burst{ field = "fd_plasma", intensity_min = 2, intensity_max = 3, chance = 50 }
    :trail{ field = "fd_plasma", intensity_min = 1, intensity_max = 2, chance = 50 })

-- Creates a cloud of superheated plasma
content.add(content.AmmoEffect { id = "PLASMA_BUBBLE" }
    :field_burst{ field = "fd_plasma", intensity_min = 1, intensity_max = 3, radius = 1, chance = 10 })

content.add(content.AmmoEffect { id = "PLASMA_FAN" }
    :cast_spells_on_miss(true)
    :spell("spell_plasma_fan"))

content.add(content.AmmoEffect { id = "EXPLOSIVE" }
    :explosion{ power = 360, distance_factor = 0.75 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_SMALL" }
    :explosion{ power = 360, distance_factor = 0.4 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_RAUFOSS" }
    :explosion{ power = 2.4, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 28, fragment_mass = 7 })

-- Small explosion that spreads shrapnel
content.add(content.AmmoEffect { id = "FRAG_20x66" }
    :explosion{ power = 40, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 15, fragment_mass = 0.08 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_GRENADE" }
    :explosion{ power = 240, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 217, fragment_mass = 0.08 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_SMALL_HOMEMADE_GRENADE_1" }
    :explosion{ power = 150, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 200, fragment_mass = 0.4 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_HOMEMADE_GRENADE_1" }
    :explosion{ power = 300, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 400, fragment_mass = 0.4 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_SMALL_HOMEMADE_GRENADE_2" }
    :explosion{ power = 460, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 200, fragment_mass = 0.4 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_HOMEMADE_GRENADE_2" }
    :explosion{ power = 920, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 400, fragment_mass = 0.4 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_20x66" }
    :explosion{ power = 60, distance_factor = 0.75 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_EXODII_THERMOBARIC" }
    :explosion{ power = 66, distance_factor = 0.75 })

-- a large, shockwave like explosion with no shrapnel.
content.add(content.AmmoEffect { id = "EXPLOSIVE_EXODII_FIREWORK" }
    :explosion{ power = 318, distance_factor = 0.75 })

content.add(content.AmmoEffect { id = "CORROSIVE" }
    :cast_spells_on_miss(true)
    :spell("spell_corrosive_spray"))

content.add(content.AmmoEffect { id = "GLUE_FOAM" }
    :cast_spells_on_miss(true)
    :spell("spell_adhesive_spray"))

content.add(content.AmmoEffect { id = "EXPLOSIVE_HESHOT" }
    :explosion{ power = 60, distance_factor = 0.75 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_m430a1" }
    :explosion{ power = 72, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 250, fragment_mass = 0.08 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_m433" }
    :explosion{ power = 42, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 198, fragment_mass = 0.08 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_66mmHEAT" }
    :explosion{ power = 400, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 680, fragment_mass = 0.15 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_84x246HE" }
    :explosion{ power = 665, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 1500, fragment_mass = 0.08 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_84x246HEDP" }
    :explosion{ power = 798, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 1500, fragment_mass = 0.15 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_ATGMHEAT" }
    :explosion{ power = 3400, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 2810, fragment_mass = 0.5 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_120mmHEAT" }
    :explosion{ power = 7980, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 8725, fragment_mass = 0.5 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_60mmHE" }
    :explosion{ power = 250, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 500 })

content.add(content.AmmoEffect { id = "EXPLOSIVE_60mmHE2" }
    :explosion{ power = 358, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 430 })

-- Blinds and deafens nearby targets
content.add(content.AmmoEffect { id = "FLASHBANG" }
    :flashbang())

-- Damages 'electronic' terrain types (such as consoles or card readers) In rare cases might make card readers open doors. Damages and destroys robotic enemies. Drains bionic power and power from any electronic equipment in player possession
content.add(content.AmmoEffect { id = "EMP" }
    :emp())

-- Creates a trail of smoke
content.add(content.AmmoEffect { id = "TRAIL" }
    :trail{ field = "fd_smoke", intensity_min = 1, intensity_max = 2, chance = 75 })

-- Sometimes leaves a trail of small fire fields. All of these STREAM_XXXXXX effects have hardcoded interactions in projectile_attack (ballistics.cpp)
content.add(content.AmmoEffect { id = "STREAM_TINY" }
    :trail{ field = "fd_fire", intensity_min = 1, intensity_max = 1, chance = 10 })

-- Leaves a trail of fire fields
content.add(content.AmmoEffect { id = "STREAM" }
    :trail{ field = "fd_fire", intensity_min = 1, intensity_max = 2, chance = 66 })

-- Leaves a trail of intense fire fields
content.add(content.AmmoEffect { id = "STREAM_BIG" }
    :trail{ field = "fd_fire", intensity_min = 2, intensity_max = 2, chance = 75 })

-- Looks like huge fires, but doesn't actually burn stuff.
content.add(content.AmmoEffect { id = "PYROTECHNIC_DISPLAY" }
    :trail{ field = "fd_fire_FAKE", intensity_min = 1, intensity_max = 3, chance = 85 })

-- Leaves a trail of fungicidal gas
content.add(content.AmmoEffect { id = "STREAM_GAS_FUNGICIDAL" }
    :trail{ field = "fd_fungicidal_gas", intensity_min = 1, intensity_max = 2, chance = 66 })

-- Creates a trail of laser
content.add(content.AmmoEffect { id = "LASER" }
    :trail{ field = "fd_laser", intensity_min = 2, intensity_max = 2 })

-- This is basically a flag for liquid ammo, it is set automatically when the material of the ammo is liquid
content.add(content.AmmoEffect { id = "LIQUID" })

content.add(content.AmmoEffect { id = "NL_DESTRUCTION_RAY" }
    :cast_spells_on_miss(true)
    :spell("nl_destruction_ray"))

content.add(content.AmmoEffect { id = "NL_PHASE_GOO" }
    :cast_spells_on_miss(true)
    :spell("nl_phase_goo"))

-- Leaves a pool of bile on detonation
content.add(content.AmmoEffect { id = "BILE_BOMB" }
    :field_burst{ field = "fd_bile", intensity_min = 3, intensity_max = 3 })

-- Creates a trail of bile
content.add(content.AmmoEffect { id = "BILE_JET" }
    :trail{ field = "fd_bile", intensity_min = 1, intensity_max = 2, chance = 75 })

-- Creates a trail of advanced bile
content.add(content.AmmoEffect { id = "BILE_JET_ADV" }
    :trail{ field = "fd_bile_adv", intensity_min = 1, intensity_max = 2, chance = 75 })

-- Leaves a pool of advanced bile on detonation
content.add(content.AmmoEffect { id = "BILE_BOMB_ADV" }
    :field_burst{ field = "fd_bile_adv", intensity_min = 3, intensity_max = 3 })

content.add(content.AmmoEffect { id = "BILE_GLOW" }
    :on_hit{ effect = "glowing", duration_turns = 300, intensity = 1 })

content.add(content.AmmoEffect { id = "BILE_STINK" }
    :on_hit{ effect = "bile_stink", duration_turns = 300, intensity = 1, touch_skin = true })

content.add(content.AmmoEffect { id = "BILE_IRRITATE" }
    :on_hit{ effect = "bile_irritant", duration_turns = 300, intensity = 1, touch_skin = true })

content.add(content.AmmoEffect { id = "BILE_BLIND" }
    :on_hit{ effect = "boomered", duration_turns = 30, intensity = 1, touch_skin = true })
