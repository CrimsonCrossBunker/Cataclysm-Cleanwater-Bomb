local ccb = require("ccb")

-- A special encounter for tier 5 vampires, dropping the means to become more vampire than vampires.
-- They start slow, as they are too arrogant to go for a quick kill.  This is why they only have the resilience and anti-bleed powers active until hit and that they are this slow.
-- When hit, their speed increases for the rest of the encounter.  They mainly use their axe to fight, but they also have healing abilities and will activate blood haste and shape of the shadowed path when below half health.
-- Intended to be incredibly hard to fight head-on, but manageable with proper planning.
-- An anathema to both vampires and hunters, they will attack or be attacked by mostly everything.
-- They are considered as having every single regular vampire weaknesses except for the need for living blood and picky feeding.
-- They do not appear for non-tier-5 vampires, as their focus is gaining power through vampire blood to be better at killing vampires.  Only tier 5 vampires can encounter them.  Should enough vampire hunter content be added, hunting it down as a non-vampire could be a possibility.  Doing such will only need a description rewrite to remove the mentions about the player being a vampire.
-- This applies the protective effect.  If monsters can someday spawn with an enchantment, remove this attack.
-- Stops working during the final form as they are running out of blood when reaching that point.  This also is why they cannot activate Last Breath's Mist.
-- These two are in case the player manages to injure them without triggering the hit_me.
-- Armor equivalent to a full set of high steel plate armor.
ccb.content.define_monster {
    id = "mon_vampire_anathema",
    name = ccb.content.plural_text("Vampiric Anathema", "Vampiric Anathema"),
    description = ccb.content.text("Your instincts are telling you three things about this armored, axe-wielding humanoid foe: they are a vampire far more powerful than you, they thirst for your blood, and they are a vampire hunter wanting all vampires dead.  You know for certain that you will be quickly killed if you attack them without a proper plan."),
    default_faction = "vampire_anathema",
    body_type = "human",
    species = { "VAMPIRE_ANATHEMA" },
    materials = { "flesh" },
    harvest = "vampire",
    difficulty_adjustment = 500,
    volume = "108500 ml",
    mass = "100 kg",
    hp = 200,
    speed = 60,
    symbol = "@",
    color = "red",
    scents_tracked = { "sc_human", "sc_vampire" },
    regenerates_in_dark = true,
    aggression = 100,
    morale = 300,
    melee_skill = 10,
    melee_dice = 7,
    melee_sides = 9,
    dodge = 5,
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 85,
    pathing = {
        max_distance = 45,
        open_doors = true,
        avoid_traps = true,
        avoid_dangerous_fields = true,
        avoid_sharp = true,
        climb_stairs = true,
    },
    attacks = {
        { id = "salamagman_battleaxe", cooldown = 1 },
        { id = "BIO_OP_BIOJUTSU", cooldown = 2 },
        { id = "PARROT", cooldown = 100 },
        {
            id = "VAMPIRE_ANATHEMA_SETUP",
            spell = { id = "VAMPIRE_ANATHEMA_SETUP", min_level = 1, hit_self = true },
            cooldown = 1,
            allow_no_target = true,
            kind = "spell",
            when = "allow_vampire_anathema_vampire_anathema_setup",
        },
        {
            id = "VAMPIRE_ANATHEMA_HEAL",
            spell = { id = "VAMPIRE_ANATHEMA_HEAL", max_level = 1, hit_self = true },
            allow_no_target = true,
            casting_message = ccb.content.text("%1$s's wounds are closing at a rapid pace!"),
            cooldown = 20,
            kind = "spell",
            when = "allow_vampire_anathema_vampire_anathema_heal",
        },
        {
            id = "VAMPIRE_ANATHEMA_STARTS_BATTLE",
            spell = { id = "VAMPIRE_ANATHEMA_STARTS_BATTLE", min_level = 1, hit_self = true },
            allow_no_target = true,
            casting_message = ccb.content.text("%1$s's movements are much quicker now!"),
            cooldown = 20,
            kind = "spell",
            when = "allow_vampire_anathema_vampire_anathema_starts_battle",
        },
        {
            id = "VAMPIRE_ANATHEMA_FINAL_FORM",
            spell = { id = "VAMPIRE_ANATHEMA_FINAL_FORM", min_level = 1, hit_self = true },
            allow_no_target = true,
            casting_message = ccb.content.text("%1$s accelerates to the point your eyes struggle to follow and heal their wounds as shadows surround their body!"),
            cooldown = 20,
            kind = "spell",
            when = "allow_vampire_anathema_vampire_anathema_final_form",
        },
    },
    anger_triggers = { "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    flags = {
        "SEES", "HEARS", "SMELLS", "BASHES", "NO_BREATHE", "CAN_OPEN_DOORS", "CLIMBS", "DESTROYS",
        "ALWAYS_SEES_YOU", "NEVER_WANDER", "QUIETMOVES", "HAS_MIND", "NO_FUNG_DMG", "NOT_HALLUCINATION",
        "REVIVES", "PATH_AVOID_DANGER", "PATH_AVOID_FIRE", "PATH_AVOID_FALL", "SUNDEATH",
    },
    armor = { cut = 40, stab = 32, bash = 40, bullet = 26 },
    zombify_into = "mon_vampire_strigoi",
    families = { "prof_wp_demihuman" },
    weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
    death = { drops = "vampire_anathema_death_drops" },
}
