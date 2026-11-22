local ccb = require("ccb")

local content = ccb.content
local runtime = ccb.runtime
local services = ccb.services

-- Native JSON-flag definitions
do
local definition = content.JsonFlag {
    id = "SONAR_DETECTABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONVECTS_TEMPERATURE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNDODGEABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "W_LABEL_NONE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "W_DISABLED_WHEN_EMPTY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "W_DISABLED_BY_DEFAULT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "W_DYNAMIC_HEIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "W_NO_PADDING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DEBUG_ONLY",
    info = "This is not intended to be visible during normal gameplay.  <bad>Please file a bug report</bad> unless you are seeing this in the debug menu.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_PAINT",
    info = "This vehicle part keeps its own sprite colors and is never tinted by a vehicle color palette.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SWIM_UNDER",
    info = "Terrain with this flag is treated as having water beneath a covering (e.g. ice); entities may be considered under water for swimming and related mechanics.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_ARMS",
    info = "You can use this armor <info>with chainmail</info> without encumbrance penalty.",
    restriction = "Item must be a chainmail compatible armor piece",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_ELBOWS",
    info = "You can use this armor <info>with chainmail</info> without encumbrance penalty.",
    restriction = "Item must be a chainmail compatible armor piece",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_LEGS",
    info = "You can use this armor <info>with chainmail</info> without encumbrance penalty.",
    restriction = "Item must be a chainmail compatible armor piece",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_KNEES",
    info = "You can use this armor <info>with chainmail</info> without encumbrance penalty.",
    restriction = "Item must be a chainmail compatible armor piece",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_TORSO",
    info = "You can use this armor <info>with chainmail</info> without encumbrance penalty.",
    restriction = "Item must be a chainmail compatible armor piece",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_LARGE",
    info = "This plate will fit in <info>large</info> armor pockets.",
    restriction = "Item must be a large ablative plate",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_MANTLE",
    info = "This will hook to a <info>Hub 01 proprietary</info> mantle connector.",
    restriction = "Item must be an armored mantle",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STAR_PLATE",
    info = "This can be supported by the ryūsei battle kit.",
    restriction = "Item must be resonance plate",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STAR_SHOULDER",
    info = "This can be supported by the ryūsei battle kit.",
    restriction = "Item must be resonance shoulder",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STAR_SKIRT",
    info = "This can be supported by the ryūsei battle kit.",
    restriction = "Item must be resonance skirt",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_MEDIUM",
    info = "This plate will fit in <info>medium</info> armor pockets.",
    restriction = "Item must be a medium ablative plate",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_SKIRT",
    info = "This will hook to a <info>Hub 01 proprietary</info> skirt connector.",
    restriction = "Item must be an armored skirt",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ABLATIVE_HELMET",
    info = "This will hook to a <info>Hub 01 proprietary</info> helmet connector.",
    restriction = "Item must be an armored helmet",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ACTIVE_CLOAKING",
    info = "This gear has <info>cloaking tech</info> that will <good>make you invisible</good> when active, at the cost of <info>power from a UPS</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_TAIL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_GASTROPOD_FOOT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_LEG_TENTACLES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_WING_ARMS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_WINGS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_TALONS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALARMCLOCK",
    info = "This gear has an <info>alarm clock</info> feature.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_BODY_BLOCK",
    info = "This item <info>won't prevent you from blocking with your body, such as arms or legs</info> when wielded as a weapon.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_NATURAL_ATTACKS",
    info = "This clothing won't hinder special attacks that involve <info>mutated or cybernetic anatomy</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLOWS_REMOTE_USE",
    info = "This item can be activated or reloaded from an adjacent tile without picking it up.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CAN_USE_IN_DARK",
    info = "This item can use all of its features in darkness.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALWAYS_AIMED",
    info = "This gun is <good>always fully aimed</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AURA",
    info = "This is in your <info>outer aura</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BAROMETER",
    info = "This gear is equipped with an accurate barometer (which is used to measure atmospheric pressure).",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BELT_CLIP",
    info = "This item can be <info>clipped onto a belt loop</info> of the appropriate size.",
    restriction = "Item must clip onto a belt loop",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BELTED",
    info = "This gear is <info>strapped</info> onto you.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_INSTALLATION_DATA",
    info = "This item <info>provides</info> instructions and other required data for several bionics, allowing installation of them with <good>minimal failure chance</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_NPC_USABLE",
    info = "A <good>follower</good> could <info>make use of this CBM</info> if installed properly.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BLIND",
    info = "This gear <bad>prevents</bad> you from <info>seeing</info> anything.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BLOCK_WHILE_WORN",
    info = "This item can be used to block attacks when worn.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CALORIES_INTAKE",
    info = "This item enables you to keep track of calorie intake.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CALORIE_BURN",
    info = "This item enables you to keep track of calorie consumption.  Includes CALORIES_INTAKE.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CRYOGENIC_ROT",
    info = "This item <info>requires specialized cryogenic preservation</info> and will <bad>spoil rapidly</bad> even at subzero temperatures.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CASELESS_ROUNDS",
    info = "Being caseless rounds, these <bad>cannot be disassembled or reloaded</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CBM",
    info = "This item is a Compact Bionic Module.  You'll need to <info>use specialized machinery</info> or <info>ask a surgeon</info> to install it into your body.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COLLAR",
    info = "This clothing has a <info>wide collar</info> that can keep your mouth warm if it is unencumbered.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COLLAPSE_CONTENTS",
    info = "Contents are hidden by default in inventory view.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DEAF",
    info = "This gear <bad>prevents</bad> you from <info>hearing any sounds</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("PARTIAL_DEAF")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DESTROY_ON_CHARGE_USE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OVERHEATS",
    info = "Continuously firing this weapon will cause it to <bad>overheat</bad> and <info>can potentially damage it</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DIAMOND",
    info = "This item has a <good>diamond coating</good> improving its <info>cutting or piercing damage</info>.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GEMSTONE",
    info = "This item is a precious gemstone, used for ornamentation.  This is mostly useless post-Cataclysm.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DIG_TOOL",
    info = "While wielded, this item allows you to mine through rocks and other hard obstacles by moving into tiles with them.  Note that automatic mining option should be set to true for this to work.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DURABLE_MELEE",
    info = "As a weapon, this item is <good>well-made</good> and will <info>withstand the punishment of combat</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("FRAGILE_MELEE")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EASY_CLEAN",
    info = "This gun is made of <info>relatively simple parts</info> which makes powder fouling <good>easier to clean</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIELD_DRESS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIELD_DRESS_FAILED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HIDDEN",
    info = "You have marked this article to not display a sprite when worn.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "QUARTERED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD",
    info = "You could probably use this to get into a secure science facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MILITARY_CARD",
    info = "You could probably use this to get into a secure military facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INDUSTRIAL_CARD",
    info = "You could probably use this to get into a secure industrial facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANDURIL_AR_CARD",
    info = "You could probably use this to get into a secure Anduril Industries facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXODII_STRING_DIMENSION_CARD",
    info = "You could probably use this to open some lock.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COOP_CARD",
    info = "Gives you access to the artisans workshop.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SKINNED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BLED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANT_HEAL_EVERYONE",
    info = "This med can't be used by everyone, it requires a special mutation.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANT_WEAR",
    info = "This armor can't be worn directly.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DECAY_EXPOSED_ATMOSPHERE",
    info = "If exposed to the atmosphere, it will <bad>start to go bad</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DIRTY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EATEN_COLD",
    info = "This tastes <good>better</good> while <color_light_cyan>cold</color>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EATEN_HOT",
    info = "This tastes <good>better</good> while <color_red>hot</color>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HUNGER_DISRUPTION",
    info = "You don't know how hungry you are when you are effected by this.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ELECTRIC_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>electric discharges</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIO_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>biological damage</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BASH_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>bash damage</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EMP_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>EMP blasts</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CUT_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>cut damage</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BULLET_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>bullet damage</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ACID_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>acid damage</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STAB_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>stab damage</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HEAT_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>high temperatures</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_FACE_SHIELD",
    info = "This item is attachable in the front of <info>hard hats and helmets</info> to protect your eyes or face.",
    restriction = "Item must be some kind of face shield",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_FRONT_ATTACHMENT",
    info = "This item is attachable in the front of <info>military helmets</info>.",
    restriction = "Item must be some kind of frontal helmet attachment",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_EAR_ATTACHMENT",
    info = "This item is attachable in <info>hard hats and helmets</info> to cover the ears.",
    restriction = "Item must be some kind of ear attachment",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_NAPE_PROTECTOR",
    info = "This item is attachable in <info>hard hats and helmets</info> as a nape protector.",
    restriction = "Item must be some kind of nape protector",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_MANDIBLE_GUARD",
    info = "This item is attachable as a mandible guard in military <info>helmets</info> or headgear specifically adapted with rails for attachments.",
    restriction = "Item must be some kind of rail-mounted mandible guard",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_MANDIBLE_GUARD_STRAPPED",
    info = "This item is attachable as a mandible guard in <info>hard hats and helmets</info>.",
    restriction = "Item must be some kind of strapped mandible guard",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_BACK_POUCH",
    info = "This item is attachable in the back of <info>hard hats and helmets</info> as a counterweight pouch.",
    restriction = "Item must be some kind of back pouch",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_HEAD_ATTACHMENT",
    info = "This item is attachable in <info>tactical helmets</info> as a flashlight.",
    restriction = "Item must be some kind of flashlight",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HELMET_AVENTAIL",
    info = "This item is attachable to metal cap helmets as a face and neck protective layer.",
    restriction = "Item must be some kind of chainmail veil",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BOOT_FINS",
    info = "This item is attachable to commercial diving boots as fins.",
    restriction = "Item must be some kind of fins",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BOOT_FINS_CUSTOM",
    info = "This item is attachable to custom diving boots as fins.",
    restriction = "Item must be some kind of custom fins",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HEAD_STRAP_MOUNT",
    info = "This item is attachable to straps and mountings on some masks and hoods.",
    restriction = "Item must be some kind of item that can be attached to straps on masks and hoods",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WRIST_MOUNT_ATTACHMENT",
    info = "This item is attachable to a proprietary wrist mount.",
    restriction = "Item must be some kind of item that can be attached to a proprietary wrist mount",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXTRA_PLATING",
    info = "This item is wearable over some armors as an extra layer of plating.",
    restriction = "Item must be some kind of strapped additional plating",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_WING_GLIDING",
    info = "This item <bad>prevents using wings to glide</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COLD_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>low temperatures</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ACID",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CORROSIVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COSPLAY_COSTUME",
    info = "This clothing is <info>cosplay costume</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("COSPLAY_PROPS")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COSPLAY_PROPS",
    info = "This item is <info>cosplay prop</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("COSPLAY_COSTUME")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ONE_PER_LAYER",
    info = "<info>Only one</info> item can be worn on this clothing layer.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIRE",
    info = "This item counts as <color_red>fire</color> for crafting purposes.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIRESTARTER",
    info = "This item can start <color_red>fire</color>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIREWOOD",
    info = "This item can serve as a firewood.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIX_FARSIGHT",
    info = "This gear <good>corrects farsightedness</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIX_NEARSIGHT",
    info = "This gear <good>corrects nearsightedness</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MYOPIC_SUPERNATURAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MYOPIC_IN_LIGHT_SUPERNATURAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BLOCK_SUPERNATURAL_HEALING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FILTHY",
    info = "This item is <bad>filthy</bad>.",
    inherit = true,
    craft_inherit = true,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLASH_PROTECTION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLOTATION",
    info = "This clothing <info>prevents going underwater</info> including both <good>drowning</good> and <bad>diving</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIN",
    info = "This clothing has fins that <good>improve swimming speed</good>, but <bad>reduce movement speed</bad> on land.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FRAGILE",
    info = "This gear is <bad>fragile</bad> and <info>won't protect you for long</info>.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("STURDY")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FRAGILE_MELEE",
    info = "As a weapon, this item is <bad>flimsy</bad> and <info>won't last long in combat</info> before breaking apart.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("DURABLE_MELEE")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GAS_PROOF",
    info = "This gear <good>completely protects</good> you from <info>any gas</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HOOD",
    info = "This clothing has a <info>hood</info> to keep your head warm if your head is unencumbered.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HYGROMETER",
    info = "This gear is equipped with an accurate hygrometer (which is used to measure humidity).",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BURNOUT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BRASS_CATCHER",
    info = "This gun mod catches ejected casings.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IRREMOVABLE",
    info = "This item is a component of the gun it is attached to.  It can't be removed without destroying it.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NORMAL",
    info = "This gear <info>fits like</info> normal clothing.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_CVD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_REPAIR",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_CLEAN",
    info = "This item is impossible to clean.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NUTRIENT_OVERRIDE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OBSOLETE",
    info = "This thing no longer spawns naturally and has been obsoleted.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PLANTABLE_SEED",
    info = "You could probably <color_brown>plant</color> these.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "POST_UP",
    info = "This item can be put up on a wall, like a poster.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MELTS",
    info = "This food <neutral>melts when not in a very cold climate</neutral>, and tastes much <good>better</good> when <color_light_cyan>frozen</color>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAG_DESTROY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MOP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ARM_PROSTHETIC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LEG_PROSTHETIC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OUTER",
    info = "This gear is generally <info>worn over</info> clothing.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OVERSIZE",
    info = "This clothing is large enough to accommodate <info>abnormally large mutated anatomy</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNDERSIZE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PARTIAL_DEAF",
    info = "This gear <good>reduces</good> the volume of <info>sounds</info> to a safe level.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("DEAF")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PERSONAL",
    info = "This is in your <info>personal aura</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "POCKETS",
    info = "This clothing has <info>pockets</info> to warm your hands when you are wielding nothing.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "POLEARM",
    info = "As a weapon, this item needs considerable space to use properly and does 70% of its normal damage to adjacent enemies.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PREDATOR_FUN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PRESERVE_SPAWN_LOC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HINT_THE_LOCATION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LOCATION_PRECISE_CLOSEST_CITY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PROVIDES_TECHNIQUES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPAWN_ACTIVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STAB",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPEAR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PRIMITIVE_RANGED_WEAPON",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SOLARPACK_ON",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PSEUDO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIOSIGNAL_1",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIOSIGNAL_2",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIOSIGNAL_3",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIO_ACTIVATION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIO_MOD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIOCARITEM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DISCOUNT_VALUE_1",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DISCOUNT_VALUE_2",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DISCOUNT_VALUE_3",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MC_MOBILE",
    info = "Can be used to <info>store data</info> for other devices.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MC_HAS_DATA",
    info = "Some of your data is <info>stored</info> here.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_PARASITES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUSHY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IRRADIATED",
    info = "This food item has been irradiated, and will spoil 4 times slower.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FREEZERBURN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OLD_CURRENCY",
    info = "This item used to be legal tender before the Cataclysm.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_AUTO_CONSUME",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_WEAR_EFFECT",
    info = "This item can be worn, but it <neutral>won't provide any effects</neutral>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PADDED",
    info = "This item has notable padding and will be comfortable worn without clothing under it.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PALS_SMALL",
    info = "This item will <good>attach directly</good> to <info>load bearing vests</info>, taking a <good>small amount of space</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PALS_MEDIUM",
    info = "This item will <good>attach directly</good> to <info>load bearing vests</info>, taking an average amount of space.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PALS_LARGE",
    info = "This item will <good>attach directly</good> to <info>load bearing vests</info>, taking a <bad>large amount of space</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PSYSHIELD_PARTIAL",
    info = "This gear <good>keeps out</good> the <info>mind control rays</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAD_DETECT",
    info = "This item can <good>detect</good> dangerous levels of <info>radiation</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAD_PROOF",
    info = "This clothing <good>completely protects</good> you from <info>radiation</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("RAD_RESIST")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAD_RESIST",
    info = "This clothing <good>partially protects</good> you from <info>radiation</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("RAD_PROOF")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAD_STERILIZED",
    info = "Sterilized using radiation, so it's <good>safe to eat</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REQUIRES_BALANCE",
    info = "This gear requires careful balance to use.  Being hit while wearing it could make you <bad>fall down</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROLLER_ONE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROLLER_INLINE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROLLER_QUAD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TWO_WAY_RADIO",
    info = "This item can be used to communicate with radio waves.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PERFECT_LOCKPICK",
    info = "This item can be used to <info>pick locks</info> with <good>zero effort</good>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAINPROOF",
    info = "This clothing is designed to keep you <info>dry</info> in the rain.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RESTRICT_HANDS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SEMITANGIBLE",
    info = "It seems <info>partially intangible</info>, and can occupy the same space as other things when worn.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHEATH_AXE",
    info = "This item can <info>fit in an axe sheath</info> of the appropriate size.",
    restriction = "Item must fit in an axe sheath",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHEATH_KNIFE",
    info = "This item can <info>fit in a sheath</info> of the appropriate size.",
    restriction = "Item must fit in a sheath",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHEATH_SWORD",
    info = "This item can <info>fit in a scabbard</info> of the appropriate size.",
    restriction = "Item must fit in a scabbard",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHEATH_SPEAR",
    info = "This item can <info>attach to a spear strap</info> of the appropriate size.",
    restriction = "Item must attach to a spear strap",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHEATH_BOW",
    info = "This item can <info>fit in a bow sling</info> of the appropriate size.",
    restriction = "Item must fit in a bow sling",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHEATH_GOLF",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SKINTIGHT",
    info = "This clothing <info>lies close</info> to the skin.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SLEEP_AID",
    info = "This item provides comfort during sleep.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SLEEP_AID_CONTAINER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REVIVE_SPECIAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STURDY",
    info = "This clothing will <good>protect</good> you from harm and withstand <info>a lot of abuse</info>.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("FRAGILE")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FAULT_ON_COMPLETION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SUN_GLASSES",
    info = "This clothing keeps the <info>glare</info> out of your eyes.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SWIM_GOGGLES",
    info = "This clothing allows you to <good>see much further</good> <info>under water</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "THERMOMETER",
    info = "This gear is equipped with an <info>accurate thermometer</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VARSIZE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WAIST",
    info = "This gear is worn on or around your <info>waist</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATCH",
    info = "This gear allows to see <info>actual time</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATERPROOF",
    info = "This clothing <info>won't let water through</info>.  Even if you jump into a river.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATER_FRIENDLY",
    info = "This clothing <good>performs well</good> even when <info>soaking wet</info>.  This can feel good.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HIGH_GLARE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ITEM_BROKEN",
    info = "This item was broken and <bad>won't activate anymore</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATER_BREAK",
    info = "This item <bad>will get broken</bad> by water.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATER_BREAK_ACTIVE",
    info = "This item <bad>will get broken</bad> by water if it gets <info>submerged while active</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATER_DISSOLVE",
    info = "This item <bad>will get dissolved</bad> in water.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WET",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "POWERARMOR_COMPATIBLE",
    info = "This item can be worn simultaneously with power armor.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ZERO_WEIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ZOOM",
    info = "This item can be used to <good>better</good> see <info>things far away</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "furred",
    info = "This clothing has a fur lining sewn into it to <good>increase</good> its overall <info>warmth</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "kevlar_padded",
    info = "This gear has Kevlar inserted into strategic locations to <good>increase protection</good> with some <bad>increase to encumbrance</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "leather_padded",
    info = "This gear has certain parts padded with leather to <good>increase protection</good> with moderate <bad>increase to encumbrance</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "steel_padded",
    info = "This gear has certain parts padded with steel to <good>increase protection</good> with moderate <bad>increase to encumbrance</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "wooled",
    info = "This clothing has a wool lining sewn into it to <good>increase</good> its overall <info>warmth</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WONT_TRAIN_MARKSMANSHIP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GENE_TECH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NANOFAB_REPAIR",
    info = "This item has a holographic patch that reflects the light oddly.  It was constructed in a nanofabricator and can be <info>repaired in one</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NANOFAB_TEMPLATE",
    info = "This item contains a nanofabricator recipe.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NANOFAB_TEMPLATE_SINGLE_USE",
    info = "This template is copy protected and will be <bad>destroyed</bad> after a single use.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_FAULTY",
    info = "This bionic is <bad>faulty</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_POWER_SOURCE",
    info = "This bionic provides power.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_TOGGLED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_GUN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_WEAPON",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_ARMOR_INTERFACE",
    info = "This bionic can provide power to powered armor.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PERMANENT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_FAIL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HIDDEN_SPELL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IGNORE_WALLS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAGIC_FOCUS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HOSTILE_SUMMON",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HOSTILE_50",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SILENT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LOUD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VERBAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SOMATIC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_HANDS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_LEGS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONCENTRATE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WONDER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXTRA_EFFECTS_FIRST",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAIN_NORESIST",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPAWN_WITH_DEATH_DROPS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TEMPORARY_SHAPESHIFT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHAPESHIFT_SIZE_TINY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHAPESHIFT_SIZE_SMALL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHAPESHIFT_SIZE_LARGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHAPESHIFT_SIZE_HUGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TEMPORARY_SHAPESHIFT_NO_HANDS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHAPESHIFTED_ARMOR",
    info = "This item is currently <good>part of your form</good> and <bad>will not protect you</bad>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INTANGIBLE_ARMOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HANDS_CANNOT_USE_FIREARMS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NON_THRESH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBUST_GENETIC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_USE_COMPUTERS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SKIP_HEALTH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HIDDEN_HALLU",
    inherit = true,
    craft_inherit = true,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HIDDEN_POISON",
    inherit = true,
    craft_inherit = true,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BAD_TASTE",
    info = "This food is <bad>unappetizing</bad> in a way that <bad>can't be covered up by most cooking</bad>.",
    inherit = true,
    craft_inherit = true,
    taste_modifier = -5,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAW",
    info = "This food is <info>raw</info>, and will be <good>more nutritious</good> if cooked.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNIBALISM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STRICT_HUMANITARIANISM",
    inherit = true,
    craft_inherit = true,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_BREAD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_CHEESE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_DRIED_VEGETABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_EGG",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_FRUIT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_JUNK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_MEAT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_MILK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_NUT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_VEGGY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_WHEAT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALLERGEN_WOOL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANIMAL_PRODUCT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALWAYS_TWOHAND",
    info = "<bad>You must</bad> have two free hands to wield this item.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "APPLIANCE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIPOD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIRD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BOMB",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BYPRODUCT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CABLE_SPOOL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CAMERA_PRO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNIBAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CARDIO_MIN_GUARANTE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CARNIVORE_OK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CASING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CATTLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CHALLENGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CHARGEDIM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CITY_START",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COLD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COLLAPSIBLE_STOCK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REMOVED_STOCK",
    info = "This item has had its stock removed, it will be hard to shoot with.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FOLDED_STOCK",
    info = "This items stock is folded it will be hard to shoot with.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COLLAPSED_STOCK",
    info = "This items stock is collapsed it will be hard to shoot with.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONDUCTIVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONSUMABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COOKED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CORPSE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CRUTCHES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CUSTOM_EXPLOSION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DANGEROUS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DIMENSIONAL_ANCHOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PORTAL_PROOF",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TELEPORT_LOCK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DISABLE_SIGHTS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DROP_ACTION_ONLY_IF_LIQUID",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EDIBLE_FROZEN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EFFECT_IMPEDING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EFFECT_LUA_ON_ADDED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EFFECT_LUA_ON_TICK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EFFECT_LUA_ON_REMOVED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ENCUMBRANCE_UPDATE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ETHEREAL_ITEM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_COMBUSTION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FAKE_MILL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FAKE_SMOKE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLAT_TIRE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FELINE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FERTILIZER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLAMING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FORAGE_HALLU",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FORAGE_POISON",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FROZEN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FUNGAL_VECTOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GAS_DISCOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GIBBED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GNV_EFFECT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HIDDEN_ITEM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HOT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HURT_WHEN_WIELDED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IMPERIAL_ROAD_KEY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IMPERIAL_ROAD_TRAVELER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INEDIBLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INITIAL_PART",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INSPIRATIONAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INSTALL_DIFFICULT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INTEGRATED",
    info = "This is <info>integrated into the body</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUTATED_ANATOMY_ONLY",
    info = "This can only be worn by those with <info>particular mutated anatomy</info> ",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MORPHIC",
    info = "This is <info>naturally sized to the body</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IS_ARMOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IS_PET_ARMOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IS_UPS",
    info = "This item provides power to <info>UPS compatible items</info>.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LEAK_DAM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LITCIG",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LUPINE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAG_BELT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAG_BULKY",
    info = "This item is <bad>bulky</bad> and may not fit in all magazine pockets.",
    restriction = "Item must be a bulky magazine",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAG_EJECT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MANUAL_CBM_INSTALLATION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MECH_BAT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MESSY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MISSION_ITEM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MODULE_HOLDER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MOUNTED_GUN",
    info = "This weapon is <bad>too unwieldy</bad> to fire on its own and <info>must be mounted</info> on a vehicle or furniture (window, table, mound of dirt, etc.) before use.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MULTI_DRILL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUNDANE",
    info = "This item is designed to have special effects",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RELIC_PINK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUTAGEN_SAMPLE",
    info = "Used in the <neutral>creation of mutagenic drugs</neutral>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUTAGEN_CATALYST",
    info = "Injecting it will <neutral>jumpstart mutation</neutral>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUTAGEN_PRIMER",
    info = "Injecting it will <neutral>prime your body for mutation</neutral>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MYCUS_OK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_NO_LUBE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_SUNLIGHT",
    info = "This tool only functions in strong direct sunlight.  It will not work indoors, underground, at night, or in overcast weather.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAGICAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_UNFOLD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEGATIVE_MONOTONY_OK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEVER_JAMS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NONCONDUCTIVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NON_FOULING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_DROP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_INGEST",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_PACKED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_RELOAD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_SALVAGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_STERILE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_TAKEOFF",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_TEMP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_TURRET",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_UNLOAD",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_UNWIELD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NPC_ACTIVATE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NPC_ALT_ATTACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NPC_SAFE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NPC_THROWN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NPC_THROW_NOW",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NVG_GREEN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ORGANIC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PERPETUAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PLACE_RANDOMLY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "POWERED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PROCESSING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PROCESSING_RESULT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PULPED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PUMP_RAIL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LEVER_ACTION",
    info = "This weapon uses a manual lever to load each round into the chamber, forcing you to cock the lever after each shot, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SINGLE_ACTION",
    info = "This weapon requires you to cock the hammer of a firearm manually, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PUMP_ACTION",
    info = "This weapon requires you to manually pull and insert cartridge into the chamber by sliding a handguard, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BOLT_ACTION",
    info = "This weapon requires you to manually pull and insert cartridge into the chamber using a turn-bolt, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIOACTIVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIOCAR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIO_CONTAINER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIO_INVOKE_PROC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAIN_PROTECT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REACH3",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REACH_ATTACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REBREATHER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REBREATHER_INTERNAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RECHARGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REDUCED_BASHING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REDUCED_WEIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RELOAD_AND_SHOOT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RELOAD_EJECT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RELOAD_ONE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REQUIRES_TINDER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SAFECRACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SLEEP_IGNORE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SLOW_WIELD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SMOKED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SOLARPACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPEEDLOADER",
    info = "This item can quickly reload rounds into gun or magazine that <info>have enough space</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("SPEEDLOADER_CLIP")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPEEDLOADER_CLIP",
    info = "This item can quickly reload rounds into gun or magazine that <info>don't have enough space</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
definition:conflicts_with("SPEEDLOADER")
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPLINT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STR_RELOAD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TANGLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TARDIS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "THROW_KEEP_WIELDED",
    info = "Can be kept wielded while throwing another item, boosting the throw.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TIE_UP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TINDER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TOBACCO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TOUGH_FEET",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAIN_IMMUNE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TOURNIQUET",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TOW_CABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRADER_AVOID",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRADER_KEEP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRADER_KEEP_EQUIPPED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNDERWATER_GUN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNRECOVERABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "URSINE_HONEY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USES_BIONIC_POWER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIRING_EXT_POWER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USES_NEARBY_AMMO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USE_EAT_VERB",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USE_PLAYER_ENERGY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USE_UPS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VEHICLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATER_EXTINGUISH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHIP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WIND_EXTINGUISH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WRITE_MESSAGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUTE",
    info = "This gear <bad>prevents</bad> you from <info>speaking</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IRREPLACEABLE_CONSUMABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ACTIVATE_ON_PLACE",
    info = "This item will be activated when it is placed in mapgen.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ACT_IN_FIRE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ACT_ON_RANGED_HIT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_MANUAL_ACTIVATION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BACKBLAST",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CAN_HAVE_CHARGES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DETERGENT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FIRE_TWOHAND",
    info = "<bad>You must</bad> have two free hands to fire this item.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GRENADE",
    restriction = "Item must be a grenade",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "JAVELIN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LEAK_ALWAYS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MAG_COMPACT",
    info = "This item has a small profile consistent with a compact magazine.",
    restriction = "Item must be a compact magazine",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NOGIB",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PUMP_RAIL_COMPATIBLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RADIO_MODABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STR_DRAW",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNBREAKABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNBREAKABLE_MELEE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATERPROOF_GUN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "no_auto_equip",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "auto_wield",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SOFT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HARD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PUNCTURE_VEHICLE_WHEELS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_VISITOR",
    info = "You could probably use this to get into a science facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MAINTENANCE_GREEN",
    info = "You could probably use this to get into a science facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MAINTENANCE_YELLOW",
    info = "You could probably use this to get into a secured maintenance area.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MAINTENANCE_BLUE",
    info = "You could probably use this to get into a secured maintenance area.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_TRANSPORT_1",
    info = "You could probably use this to get into a science facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_SECURITY_YELLOW",
    info = "You could probably use this to get into a secured law enforcement area.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_SECURITY_MAGENTA",
    info = "You could probably use this to get into a secured law enforcement area.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_SECURITY_BLACK",
    info = "You could probably use this to get into a secured law enforcement area.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MUTAGEN_GREEN",
    info = "You could probably use this to access a secure zone of a facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MUTAGEN_PINK",
    info = "You could probably use this to access a secure zone of a facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MUTAGEN_CYAN",
    info = "You could probably use this to access a secure zone of a facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MEDICAL_RED",
    info = "You could probably use this to access a secure zone of a facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCIENCE_CARD_MU_UNIVERSAL",
    info = "You could probably use this to access a secure zone of a facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BATTERY_ULTRA_LIGHT",
    info = "This item fits in items that use ultra-light batteries.",
    name = "ultra-light battery",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BATTERY_LIGHT",
    info = "This item fits in items that use light batteries.",
    name = "light battery",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BATTERY_MEDIUM",
    info = "This item fits in items that use medium batteries.",
    name = "medium battery",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BATTERY_HEAVY",
    info = "This item fits in items that use tool batteries.",
    name = "tool battery",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "METHANOL_TANK",
    info = "This item fits in items that use methanol fuel cells.",
    name = "methanol fuel cell",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COMBAT_TOGGLEABLE",
    info = "This item is meant to be toggled during combat.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CHOKE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GAS_TANK",
    info = "Airtight tanks for propane, natural gas, etc.",
    name = "gas tank",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LASER_SIGHT",
    info = "Laser sights are invalid when the target position is <bad>too far</bad> or <bad>too bright</bad>.",
    name = "laser sight",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "JETPACK",
    info = "This item is a jetpack.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LEVITATION",
    info = "Allows movement in open air.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SNOWWALKING",
    info = "Your movement is not slowed regardless of snow depth.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_BODY_HEAT",
    info = "The character produces no body heat and is not visible on infrared (for characters only, for monsters use the WARM flag to enable infrared visibility).",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALL_TERRAIN_NAVIGATION",
    info = "Allows movement over rough and sharp terrain without penalty.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_SMALL",
    info = "This is meant for a small exosuit hardpoint.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_LARGE",
    info = "This is meant for a large exosuit hardpoint.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_PSU",
    info = "This is meant for an exosuit PSU hardpoint.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_SMALL_GADGET",
    info = "This is meant for small exosuit gadgets, 1 L or less.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_HELMET_GADGET",
    info = "This is meant for helmet-specific gadgets.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_MEDIUM_GADGET",
    info = "This is meant for medium exosuit gadgets, between 1 L and 5 L.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_LARGE_GADGET",
    info = "This is meant for large exosuit gadgets, larger than 5 L.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_UNDERLAYER",
    info = "This is meant for exosuit underlayers.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_HELMET_PLATE",
    info = "This is meant for exoskeleton helmet plating.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_TORSO_PLATE",
    info = "This is meant for exoskeleton torso plating.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_ARM_PLATE",
    info = "This is meant for exoskeleton arm plating.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_GLOVE_PLATE",
    info = "This is meant for exoskeleton arm plating.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_LEG_PLATE",
    info = "This is meant for exoskeleton leg plating.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXO_BOOT_PLATE",
    info = "This is meant for exoskeleton foot plating.",
    inherit = false,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ENERGY_SHIELD",
    info = "This piece of armor is an energy barrier and will break after absorbing a certain amount of damage.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_ROBOT_MEDIUM",
    info = "A medium drone sold by Hub 01.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_ROBOT_SMALL",
    info = "A small drone sold by Hub 01.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VOLTMETER",
    info = "This tool can test for voltage.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SUNBURN_SUPERNATURAL",
    info = "You burn in the sunlight like a vampire.  Probably because you're a vampire.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SUNBURN_SUPERNATURAL_REDUCTION",
    info = "You burn in the sunlight like a vampire, but not quite as badly.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHREDDED",
    info = "This is a small fragment.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FROM_FROZEN_LIQUID",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SINGLE_USE",
    info = "This item is removed after use.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_FUEL_SOURCE",
    info = "Contents of this item are used for fueling bionics.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIONIC_WEAPON_MELEE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ELECTRONIC",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_FILE_DEVICE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_STORABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_STORABLE_EXCLUSIVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_COPIABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_FILE_COLLECTION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_FILE_DEVICE_UNREAD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VIEW_RECIPES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VIEW_PHOTOS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AFS_CS_LOCKER_CARD",
    info = "ID card granting access to the crashing ship's locker room.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AFS_CS_ARMORY_CARD",
    info = "ID card granting access to the crashing ship's armory.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AFS_CS_EXOBAY_CARD",
    info = "ID card granting access to the crashing ship's exobay.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAPER_SHAPED",
    restriction = "Item must be shaped like paper",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CREDIT_CARD_SHAPED",
    restriction = "Item must be shaped like a credit card",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BANK_NOTE_SHAPED",
    restriction = "Item must be shaped like a bank note",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COIN_SHAPED",
    restriction = "Item must be shaped like a coin",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BANK_NOTE_STRAP_SHAPED",
    restriction = "Item must be shaped like a bank note strap",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FRESH_GRAIN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CUT_HARVEST",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GASFILTER_SM",
    info = "A small-sized gas mask filter.",
    name = "filter mask cartridge",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GASFILTER_MED",
    info = "A medium-sized gas mask filter.",
    name = "CBRN filter canister",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PANORAMIC_OUTSERT",
    info = "This item is meant to be externally attached to the eyepiece of a single-lens gas mask.",
    restriction = "Item must be designed to clip onto the external Lenz brackets of a panoramic-view gas mask.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PANORAMIC_INSERT",
    info = "This item is intended to be inserted behind the visor of a single-lens gas mask.",
    restriction = "Item must be able to clip into place within a gas mask that has a single, panoramic eyepiece.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAPR_MASK",
    info = "This item functions as a powered air purifying respirator.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAPR_BLOWER",
    info = "This item functions as a powered air purifying respirator blower.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REBREATHER_CART",
    info = "A filter for a rebreather.",
    name = "rebreather cartridge",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OLD_GUN",
    info = "An old gun, WWII or earlier.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USE_POWER_WHEN_HIT",
    info = "This armor <info>expends energy when hit</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MOUSE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RABBIT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ETHEREAL",
    info = "You feel like you would keep all your items if you somehow became incorporeal.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CLIMB_FLYING",
    info = "You can ascend straight up even with no physical surface to climb on.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HERITAGE",
    info = "You have nonhuman ancestry or are not human",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BLOCK_HUGE_ATTACKS",
    info = "You are capable of blocking attacks from targets of any size",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SUFFOCATION_IMMUNE",
    info = "You are immune to being crowd-crushed",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INHALED_TOXIN_IMMUNE",
    info = "You are immune to gaseous toxins",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INFECTION_RECOVERY",
    info = "You have greater odds to recover from infections (equivalent to taking antibiotics)",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TREE_COMMUNION_PLUS",
    info = "You gain greatly enhanced effects from the Mycorrhizal Communion mutation",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROOTS2",
    info = "The character has roots, which helps with the TREE_COMMUNION mutation.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROOTS3",
    info = "The character has extensive roots, which helps with the TREE_COMMUNION mutation.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VINE_RAPPEL",
    info = "The character can use vines to safely rappel down sheer drops.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANIMALDISCORD",
    info = "The character is disliked by natural animals.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANIMALDISCORD2",
    info = "The character is intensely disliked by natural animals.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANIMALEMPATH",
    info = "The character is liked by natural animals.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRUE_SEEING",
    info = "The character can see through CAMOUFLAGE, NIGHT_INVISIBILITY, or the invisibility effect.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SUPPRESS_INVISIBILITY",
    info = "If you're invisible, now you're not",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAUSE_INFECTIONS",
    info = "Infections cannot progress to a fatal stage while you have this flag.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PAUSE_BODYPART_INFECTION",
    info = "Prevents infection on a bodypart with this flag from progressing to death, though does not relieve symptoms",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANIMALEMPATH2",
    info = "The character is intensely liked by natural animals.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNDERFED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNRESTRICTED",
    info = "This clothing is able to <info>accommodate even mutated anatomy</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PSEUDOPOD_GRASP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HEMOVORE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BLOODFEEDER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HEMOVORE_FUN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "QUADRUPED_CROUCH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "QUADRUPED_RUN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HEARING_PROTECTION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LIXA_SCIENCE_CARD",
    info = "This grants access to the LIXA facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LIXA_SCIENCE_CARD_2",
    info = "This grants access to the experiment chamber of the LIXA facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LIXA_SCIENCE_CARD_3",
    info = "This grants access to the experiment chamber and PPE lockup for the LIXA facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LIXA_MILITARY_CARD",
    info = "This grants access to locked-down areas of the LIXA facility.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DRACULIN_VENOM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PREFIX_XL",
    item_prefix = "XL ",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PREFIX_XS",
    item_prefix = "XS ",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DECAYS_IN_AIR",
    info = "This will eventually <bad>go bad</bad> if left in the open air too long.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IRRITANT_IMMUNE",
    info = "This gear <good>completely protects</good> you from <info>skin irritants</info>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ITEM_WATERPROOFING",
    info = "Something is preventing your worn and carried items from being effected by water.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATERWALKING",
    info = "You can walk across the surface of water.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CRAFT_IN_DARKNESS",
    info = "You can craft at 100% speed in any level of light.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_ATTACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_MOVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_TAKE_DAMAGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_CHANGE_TEMPERATURE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FREEZE_EFFECTS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_GAIN_EFFECTS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NUMB",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PSYCHOPATH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INSENSITIVITY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BANK_NETWORKED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NATURAL_UNDERGROUND",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INSTANT_BLEED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ONE_STORY_FALL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CYLINDER_GRENADE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BARRICADABLE_DOOR_DAMAGED",
    name = "Damaged Barricadable Door",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BARRICADABLE_DOOR_REINFORCED_DAMAGED",
    name = "Damaged Barricadable Reinforced Door",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BARRICADABLE_DOOR_REINFORCED",
    name = "Barricadable Reinforced Door",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BARRICADABLE_DOOR",
    name = "Barricadable Door",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BARRICADABLE_WINDOW_CURTAINS",
    name = "Barricadable Window with Curtains",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BARRICADABLE_WINDOW",
    name = "Barricadable Window",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CHIP",
    info = "A paint chipper can be used to remove paint from this.",
    name = "Chip",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DIGGABLE",
    info = "A hole can be dug here.",
    name = "Diggable",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EASY_DECONSTRUCT",
    name = "Simple",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLAT",
    name = "Flat",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PIT_FILLABLE",
    name = "Fillable pit",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PLOWABLE",
    name = "Plowable",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RUBBLE",
    name = "Rubble",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SUPPORTS_ROOF",
    info = "A roof can be built above this without other support.",
    name = "Supports roof",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TREE",
    name = "Tree",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WALL",
    name = "Wall",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WIRED_WALL",
    name = "Wired Wall",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MWS_PORTAL_STORM_DATA",
    info = "This ongoing report has a series of odd recordings, as if the instruments malfunctioned.",
    name = "Odd recordings",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PHASE_BACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_ARM",
    info = "This item is a Hub 01 ARM exoskeleton.  It requires an implanted XM-ARM interface to function.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_LEG",
    info = "This item is a Hub 01 LEG exoskeleton.  It requires an implanted XM-LEG interface to function.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_BACK",
    info = "This item is a Hub 01 BACK exoskeleton.  It requires an implanted XM-LEG interface and it must be worn with ARM and LEG exoskeletons to function.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_LENS_ACCESSORY",
    info = "This item is an accessory for a Hub 01 LENS helmet, and can only be worn with that helmet.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROBOFAC_LENS_HELMET",
    info = "This item allows you to wear Hub 01 LENS accessories.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CANNOT_GAIN_WEARINESS",
    info = "You have a seemingly inexhaustible supply of energy.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GENDER_FLUIDITY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GENDER_INVARIANCE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_CROP_OVERGROWTH",
    info = "This planting facility can prevent crops from over-ripening and wilting.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ALTERNATOR",
    info = "When mounted on an engine and the engine is on it will provide up to <color_green>%dW</color> of electrical power to the vehicle.",
    requires_flag = "E_ALTERNATOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AISLE",
    info = "You can move through this vehicle frame without being slowed down.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AISLE_LIGHT",
    info = "A bright light that illuminates several squares inside the vehicle.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ARMOR",
    info = "Armor plate.  Will partially protect other components on the same frame from damage from direct attacks but not from the shock damage of a distant collision.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BED",
    info = "You can sleep here comfortably.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BELTABLE",
    info = "You can install a seat belt or five part harness here to help keep you in your seat during a collision.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BOARD_INTERNAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CABLE_PORTS",
    info = "You can connect electrical cables to this part.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CARGO",
    info = "You can store items here.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CTRL_ELECTRONIC",
    info = "You can 'e'xamine the tile to access the electronic controls.  If there are vehicle controls installed in the same spot, you can also use the vehicle control key (default '^').",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONTROLS",
    info = "With a seat or saddle, you drive from here.  You can 'e'xamine the tile to access the controls, or use the vehicle control key (default '^').",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EOC_ACTIVATION",
    info = "Enables an associated EOC to be triggered from the vehicle control menu.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SMART_ENGINE_CONTROLLER",
    info = "When active, turns engines on and off automatically.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COVERED",
    info = "Illuminated items in this space will not illuminate nearby squares.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CURTAIN",
    info = "Closed, it prevents people from seeing through the curtain.  A door motor allows you to remotely open or close it from the vehicle controls.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_WINDOW",
    requires_flag = "WINDOW",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DOOR",
    info = "When open, this part lets you move from inside the vehicle to outside or vice versa.  When closed, it prevents people from entering or leaving the vehicle.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ENABLED_DRAINS_EPOWER",
    info = "When turned on, this device drains <color_red>%dW</color> from the vehicle's batteries.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SOLAR_PANEL",
    info = "Provides up to <color_green>%dW</color> of electrical power to the vehicle when exposed to the sun.  Weather and clouds will affect power generation.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ENGINE",
    info = "Provides motive power to move the vehicle if the vehicle has sufficient wheels.  Requires controls to turn on.  If it drains power, also requires a charged battery to start.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_ALTERNATOR",
    info = "An alternator can be attached, and it will generate electrical power while the engine is on at the cost of some motive power.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXTRA_DRAG",
    info = "When turned on, it will stop the vehicle unless it has a strong engine.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLOATS",
    info = "Each boat hull will reduce the draft of your vehicle and increase the height sealed against water.  If the draft is less than the sealed height, your vehicle will float if placed in water.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FRAGILE_COMPONENTS",
    info = "Some components of this part are <color_red>fragile</color> and might be damaged even if the part itself isn't.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FURNITURE_TIEDOWN",
    info = "You can tie down a furniture here.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FURNITURE_LIFT_ASSIST",
    info = "It's much easier to tie down a furniture here.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_LEAK",
    info = "Causes a boat hull to float even when damaged.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NONBELTABLE",
    info = "There's no place to attach a seat belt, so you get thrown from the vehicle in a crash.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROOF",
    info = "Keeps the rain out of the interior of the vehicle.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RESIST_RUNOVER_DAMAGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SEAT",
    info = "You need to be in a seat or saddle to operate vehicle controls.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ENHANCED_VISION",
    info = "Can be used to <color_cyan>scout things far away</color> when seated.",
    requires_flag = "SEAT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SEATBELT",
    info = "This part will help prevent you from being thrown from the vehicle in a collision.  You will automatically enable this part when you move into a tile with it.",
    requires_flag = "BELTABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHOCK_ABSORBER",
    info = "Armor plate.  Will partially protect other components on the same frame from the shock damage of a distant collision but not from direct attacks.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STABLE",
    info = "If your vehicle consists of a single tile, this wheel is enough to allow it to move.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNSTABLE_WHEEL",
    info = "This wheel requires another wheel to be installed to be functional.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STEERABLE",
    info = "Your vehicle needs at least one set of steerable wheels to turn.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRACKED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRAP_PROOF",
    info = "This wheel <info>hovers</info> and will <good>not set off traps</good> such as deep pits or landmines.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TURRET",
    info = "This weapon is mounted in a turret.  It can be fired from the vehicle controls.",
    requires_flag = "TURRET_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TURRET_CONTROLS",
    requires_flag = "TURRET_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHEEL",
    info = "If the center of balance of your vehicle is between all the wheels, the vehicle will be able to move, provided it has an active engine or motor with enough power to move the vehicle.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WIND_TURBINE",
    info = "Provides <color_green>%dW</color> of electrical power to the vehicle for every 1 m/s of wind the vehicle is exposed to.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WATER_WHEEL",
    info = "Provides up to <color_green>%dW</color> of electrical power to the vehicle when built over shallow moving water.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLAT_SURF",
    info = "This has a flat surface.  It would be a nice place to eat.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WORKBENCH",
    info = "You can craft here.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_LIGHT",
    requires_flag = "WHEEL_MOUNT_LIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_MEDIUM",
    requires_flag = "WHEEL_MOUNT_MEDIUM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_HEAVY",
    requires_flag = "WHEEL_MOUNT_HEAVY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_BATTERY_MOUNT",
    requires_flag = "BATTERY_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_HANDHELD_BATTERY_MOUNT",
    requires_flag = "HANDHELD_BATTERY_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ON_CONTROLS",
    requires_flag = "CONTROLS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INTERNAL",
    requires_flag = "CARGO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CARGO_LOCKING",
    info = "Attached to a suitable cargo space, it will prevent other people from accessing the cargo and taking your stuff.",
    requires_flag = "LOCKABLE_CARGO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DOOR_LOCKING",
    info = "Attached to a door or a hatch, it can be used to lock it.",
    requires_flag = "LOCKABLE_DOOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DOOR_MOTOR",
    requires_flag = "OPENABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ON_ROOF",
    requires_flag = "ROOF",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ADVANCED_PLANTER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AIRCRAFT_REPAIRABLE_NOPROF",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ANIMAL_CTRL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ATOMIC_LIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AUTOCLAVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AUTO_COOKER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "AUTOPILOT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BATTERY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BATTERY_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HANDHELD_BATTERY_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ARCADE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BEEPER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BIKE_RACK_VEH",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BOARDABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CAMERA",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CAMERA_CONTROL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CAPTURE_MONSTER_VEH",
    info = "You can 'e'xamine it to capture an animal next to you, or to release the animal currently contained.  When selecting an animal to capture, choose its tile relative to you, not the part.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CHIMES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CIRCLE_LIGHT",
    info = "A bright light that <color_yellow>illuminates a circular area</color> outside the vehicle when turned on.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONE_LIGHT",
    info = "A bright, directed light that <color_yellow>illuminates a narrow cone</color> outside the vehicle when turned on.  During installation, you can choose what direction to point the light.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CONTROL_ANIMAL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "COOLER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DISHWASHER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "DOME_LIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_COLD_START",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_DIESEL_FUEL",
    info = "Burns diesel or JP8 fuel from a tank in the vehicle.  Can also burn biodiesel or kerosene, though somewhat less efficiently.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_HEATER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_HIGHER_SKILL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "E_STARTS_INSTANTLY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EVENTURN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FLUIDTANK",
    info = "If filled with the <color_light_red>appropriate fuel</color> for the vehicle's engine, the engine will automatically draw fuel from the tank when the engine is on.  If filled with <color_light_blue>water</color>, you can access the water from a water faucet, if one is installed in the vehicle.  You can also use a rubber hose to siphon liquids out of a tank.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "GASTANK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FREEZER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FRIDGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FULL_BOARD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FUNNEL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HALF_BOARD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HALF_CIRCLE_LIGHT",
    info = "A bright, directed light that <color_yellow>illuminates a half-circular area</color> outside the vehicle when turned on.  During installation, you can choose what direction to point the light.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HARNESS_any",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HARNESS_human",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HEATED_TANK",
    info = "When turned on, it will <color_light_cyan>prevent the content from freezing</color>.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HORN",
    info = "Use the vehicle controls and select the honk option to make noise.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LOCKABLE_CARGO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LOCKABLE_DOOR",
    info = "This can be locked if equipped with a locking mechanism, preventing access from outside the vehicle.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LOW_FINAL_AIR_DRAG",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MOUNTABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUFFLER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MULTISQUARE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUSCLE_ARMS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MUSCLE_LEGS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MWS",
    info = "This part functions as a mobile weather station.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ADVANCED_MWS",
    info = "This part functions as an advanced mobile weather station.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_JACKING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_INSTALL_PLAYER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_INSTALL_HIDDEN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_ROOF_NEEDED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NO_UNINSTALL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OBSTACLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ODDTURN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OPAQUE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OPENABLE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "OPENCLOSE_INSIDE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PLANTER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PLOW",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "POWER_TRANSFER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PROTRUSION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "RAIL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REACTOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REAPER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "REMOTE_CONTROLS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROCKWHEEL",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "ROTOR",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SCOOP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SECURITY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SELF_JACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHARP",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SIMPLE_PART",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SMASH_REMOVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SPACE_HEATER",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "STEREO",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRACK",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TRANSFORM_TERRAIN",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "TURRET_MOUNT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNMOUNT_ON_DAMAGE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "UNMOUNT_ON_MOVE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USE_BATTERIES",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "USE_TANKS",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VARIABLE_SIZE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VEH_TOOLS",
    info = "You can 'e'xamine the tile to <color_cyan>connect tools</color> to the vehicle's batteries and tanks.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "VISION",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WALL_MOUNTED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WASHING_MACHINE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHEEL_MOUNT_HEAVY",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHEEL_MOUNT_LIGHT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHEEL_MOUNT_MEDIUM",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WIDE_CONE_LIGHT",
    info = "A bright, directed light that <color_yellow>illuminates a wide cone</color> outside the vehicle when turned on.  During installation, you can choose what direction to point the light.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WIND_POWERED",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WINDOW",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WINDSHIELD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WIRING",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SEAT_REQUIRES_BALANCE",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHEEL_MOUNT_SKATEBOARD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_SKATEBOARD",
    requires_flag = "WHEEL_MOUNT_SKATEBOARD",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "CARGO_PASSABLE",
    info = "Items stored here won't get in the way of any passengers.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "HUGE_OK",
    info = "Even when roofed, this part is roomy enough to comfortably admit very large creatures, like cows and horses.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IGNORE_LEG_REQUIREMENT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEED_LEG",
    info = "Operating this part will require at least one working leg.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "INOPERABLE_SMALL",
    info = "People who are very short may be unable to make use of this part.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "IGNORE_HEIGHT_REQUIREMENT",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "WHEEL_MOUNT_CONCRETE_MIX",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NEEDS_WHEEL_MOUNT_CONCRETE_MIX",
    requires_flag = "WHEEL_MOUNT_CONCRETE_MIX",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NL_BOILER",
    info = "This part functions as a boiler from the nether.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "BALLOON",
    info = "This part is a gas balloon that provides lift to keep an airship aloft.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "PROPELLER",
    info = "This part is a propeller that provides thrust to move an airship.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "EXTENDABLE",
    info = "This part can be extended into adjacent tiles of the same part.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHOCK_IMMUNE",
    info = "This part is immune to shock damage from collisions.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "SHOCK_RESISTANT",
    info = "This part is resistant to shock damage from collisions.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NOCOLLIDE",
    info = "This part does not collide with anything.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "NOCOLLIDEBELOW",
    info = "This part does not collide with terrain on the z-level below it.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "FOLDABLE",
    info = "This part can be folded up for storage and transport.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "MANUAL",
    info = "This part lacks the electronics for remote operation and must be operated by hand.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end
do
local definition = content.JsonFlag {
    id = "LADDER",
    info = "This part is a ladder, letting you climb down from the vehicle.",
    inherit = true,
    craft_inherit = false,
    taste_modifier = 0,
}
content.replace(definition)
end

-- Native tool-quality definitions
do
local definition = content.ToolQuality {
    id = "CUT",
    name = "cutting",
}
definition:usage(1, "salvage")
definition:usage(1, "inscribe")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "GRASS_CUT",
    name = "grass cutting",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CUT_FINE",
    name = "fine cutting",
}
definition:usage(1, "salvage")
definition:usage(1, "inscribe")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "GLARE",
    name = "glare protection",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SHEAR",
    name = "shearing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CHURN",
    name = "churn",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "LEATHER_AWL",
    name = "awl",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SEW_CURVED",
    name = "curved needle",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "ANESTHESIA",
    name = "anesthesia",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FISHING_ROD",
    name = "fishing",
}
definition:usage(1, "FISH_ROD")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FISH_TRAP",
    name = "fish trapping",
}
definition:usage(1, "FISH_TRAP")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "TREE_TAP",
    name = "tree tapping",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SMOOTH",
    name = "smoothing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "WELD",
    name = "welding",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "HACK",
    name = "hacking",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "HAMMER",
    name = "hammering",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "HAMMER_FINE",
    name = "fine hammering",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "HAMMER_SOFT",
    name = "soft hammering",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SAW_W",
    name = "wood sawing",
}
definition:usage(2, "LUMBER")
definition:usage(2, "saw_stock")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SAW_M",
    name = "metal sawing",
}
definition:usage(2, "HACKSAW")
definition:usage(2, "saw_barrel")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SAW_M_FINE",
    name = "fine metal sawing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "COOK",
    name = "food cooking",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "HOTPLATE",
    name = "hotplate",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "BOIL",
    name = "boiling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CONTAIN",
    name = "containing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CHEM",
    name = "chemical making",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SIEVE",
    name = "sieving",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "WINNOW",
    name = "winnowing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "STRAIN",
    name = "straining",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SMOKE_PIPE",
    name = "smoking",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "DISTILL",
    name = "distilling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "AXE",
    name = "tree cutting",
}
definition:usage(1, "CHOP_TREE")
definition:usage(1, "CHOP_LOGS")
definition:usage(2, "LUMBER")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "DIG",
    name = "digging",
}
definition:usage(1, "MAKEMOUND")
definition:usage(1, "DIG")
definition:usage(1, "FILL_PIT")
definition:usage(1, "DIG_CHANNEL")
definition:usage(2, "CLEAR_RUBBLE")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "WRENCH",
    name = "bolt turning",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "WRENCH_FINE",
    name = "fine bolt turning",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SCREW",
    name = "screw driving",
}
definition:usage(1, "REMOVE_ALL_MODS")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SCREW_FINE",
    name = "fine screw driving",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "BUTCHER",
    name = "butchering",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "DRILL",
    name = "drilling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "DRILL_ROCK",
    name = "rock drilling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "PRY",
    name = "prying",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "PRYING_NAIL",
    name = "nail prying",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "PUNCH",
    name = "punch",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "WRITE",
    name = "pencil",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "LIFT",
    name = "lifting",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "JACK",
    name = "jacking",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SELF_JACK",
    name = "self jacking",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "HOSE",
    name = "siphoning",
}
definition:usage(1, "SIPHON")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CHISEL",
    name = "chiseling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CHISEL_WOOD",
    name = "wood chiseling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SEW",
    name = "sewing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "KNIT",
    name = "knitting",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "PULL",
    name = "bullet pulling",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "ANVIL",
    name = "anvil",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "ANALYSIS",
    name = "analysis",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CONCENTRATE",
    name = "concentration",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SEPARATE",
    name = "separation",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FINE_DISTILL",
    name = "fine distillation",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CHROMATOGRAPHY",
    name = "chromatography",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "LUTHIER",
    name = "luthier",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SNOW_MAKING",
    name = "snow making",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "GRIND",
    name = "grinding",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FINE_GRIND",
    name = "fine grinding",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "REAM",
    name = "reaming",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FILE",
    name = "filing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "VISE",
    name = "clamping",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "PRESSURIZATION",
    name = "pressurizing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "LOCKPICK",
    name = "lockpicking",
}
definition:usage(1, "PICK_LOCK")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "EXTRACT",
    name = "extraction",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FILTER",
    name = "filtration",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SUSPENDING",
    name = "suspending",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "ROPE",
    name = "rope",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SURFACE",
    name = "clean surface",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "WHEEL_FAST",
    name = "wheel fastening",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "JUMPSTART",
    name = "jump starting",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "FABRIC_CUT",
    name = "fabric cutting",
}
definition:usage(1, "salvage")
definition:usage(1, "inscribe")
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "OVEN",
    name = "oven cooking",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "GUN",
    name = "firearm practice",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "RIFLE",
    name = "rifle practice",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SHOTGUN",
    name = "shotgun practice",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "SMG",
    name = "submachine gun practice",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "PISTOL",
    name = "pistol practice",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "CUT_GLASS",
    name = "glass cutting",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "MOP",
    name = "mopping",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "BLOW_HOT_AIR",
    name = "hot air blowing",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "THREAD_CUT",
    name = "thread cutting",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "THREAD_TAP",
    name = "thread tapping",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "STRIKING_SURFACE",
    name = "striking surface",
}
content.replace(definition)
end
do
local definition = content.ToolQuality {
    id = "TEMPER",
    name = "tempering",
}
content.replace(definition)
end

-- Native damage-info presentation order
do
local definition = content.DamageInfoOrder {
    id = "bash",
    display = "detailed",
    verb = "bashing",
}
definition:section("bionic", 100, true)
definition:section("protection", 100, true)
definition:section("pet_protection", 100, true)
definition:section("melee", 100, true)
definition:section("ablative", 100, true)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "cut",
    display = "detailed",
    verb = "cutting",
}
definition:section("bionic", 200, true)
definition:section("protection", 200, true)
definition:section("pet_protection", 200, true)
definition:section("melee", 200, true)
definition:section("ablative", 200, true)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "stab",
    display = "detailed",
    verb = "piercing",
}
definition:section("bionic", 300, true)
definition:section("protection", 400, true)
definition:section("pet_protection", 400, false)
definition:section("melee", 300, true)
definition:section("ablative", 400, true)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "bullet",
    display = "detailed",
    verb = "shooting",
}
definition:section("bionic", 400, true)
definition:section("protection", 300, true)
definition:section("pet_protection", 300, true)
definition:section("melee", 400, false)
definition:section("ablative", 300, true)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "acid",
    display = "basic",
    verb = "corroding",
}
definition:section("bionic", 500, true)
definition:section("protection", 800, true)
definition:section("pet_protection", 500, true)
definition:section("melee", 500, false)
definition:section("ablative", 500, false)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "electric",
    display = "detailed",
    verb = "shocking",
}
definition:section("bionic", 600, true)
definition:section("protection", 700, true)
definition:section("pet_protection", 700, false)
definition:section("melee", 600, false)
definition:section("ablative", 600, false)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "heat",
    display = "basic",
    verb = "burning",
}
definition:section("bionic", 700, true)
definition:section("protection", 900, true)
definition:section("pet_protection", 600, true)
definition:section("melee", 700, false)
definition:section("ablative", 700, false)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "cold",
    display = "detailed",
    verb = "freezing",
}
definition:section("bionic", 800, true)
definition:section("protection", 500, true)
definition:section("pet_protection", 800, false)
definition:section("melee", 800, false)
definition:section("ablative", 800, false)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "biological",
    display = "detailed",
}
definition:section("bionic", 900, true)
definition:section("protection", 600, true)
definition:section("pet_protection", 900, false)
definition:section("melee", 900, false)
definition:section("ablative", 900, false)
content.replace(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "pure",
    display = "none",
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.replace(definition)
end

-- Native proficiency categories
do
local definition = content.ProficiencyCategory {
    id = "prof_weakpoint",
    name = "Weakpoint",
    description = "Proficiencies that help target weak points on specific creatures.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_combat",
    name = "Weapons Proficiencies",
    description = "Proficiencies for various weapons.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_chem",
    name = "Applied Science",
    description = "Proficiencies for scientific understanding and working with certain chemicals and substances.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_food",
    name = "Food Handling",
    description = "Proficiencies for cooking and food preparation, as well as experience with food handling tools.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_butchering",
    name = "Butchering",
    description = "Proficiencies for carving and proper dressing of meat and skin of animals.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_electronic",
    name = "Electronics",
    description = "Proficiencies for building and maintaining electronics and powered devices.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_gunmaking",
    name = "Projectile Weaponry",
    description = "Proficiencies for creating and modifying projectile weapons.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_firstaid",
    name = "Health Care",
    description = "Proficiencies for treating injuries and general health care knowledge.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_mechanic",
    name = "Mechanics",
    description = "Proficiencies for building and maintaining vehicles, engines, and similar equipment.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_smithing",
    name = "Metalworking",
    description = "Proficiencies for welding, casting and shaping metal.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_woodworking",
    name = "Woodworking",
    description = "Proficiencies for creating and modifying wood-based crafts.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_devices",
    name = "Device Manipulation",
    description = "Proficiencies for lockpicking, cracking safes, and general tinkering.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_survival",
    name = "Wilderness",
    description = "Proficiencies for surviving out in the wild.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_archery",
    name = "Archery",
    description = "Proficiencies for all things bow and arrows.  Includes knowledge and experience of making and modifying bows, as well as archery form and posture.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_misc_craft",
    name = "Miscellaneous Crafts",
    description = "Proficiencies for various domain-specific crafts.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_tailoring",
    name = "Fabrics and Tailoring",
    description = "Proficiencies for sewing, binding and mending fabrics and clothing materials.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_vehicles",
    name = "Vehicles",
    description = "Proficiencies for driving, piloting, and general vehicle operations.",
}
content.replace(definition)
end
do
local definition = content.ProficiencyCategory {
    id = "prof_athletics",
    name = "Athletics",
    description = "Proficiencies for various athletic activities.",
}
content.replace(definition)
end

-- Native ammunition types
do
local definition = content.AmmunitionType {
    id = "bolt_heavy",
    name = "ballista bolts",
    default_item = "ammo_ballista_iron",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "c_hydrogen",
    name = "hydrogen gas",
    default_item = "c_hydrogen_gas",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "458wm",
    name = ".458 Winchester Magnum",
    default_item = "458wm",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "50",
    name = ".50 BMG",
    default_item = "50bmg",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "4570",
    name = ".45-70",
    default_item = "4570_sp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "50ae",
    name = ".50 AE",
    default_item = "50ae_jhp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "50beowulf",
    name = ".50 Beowulf",
    default_item = "50beowulf_xtp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "450",
    name = ".450 Bushmaster",
    default_item = "450_ftx",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "338lapua",
    name = ".338 Lapua",
    default_item = "338lapua_hpbt",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "77mm_arisaka",
    name = "7.7x58mm Arisaka",
    default_item = "77mm_arisaka_jsp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "nail",
    name = "nails",
    default_item = "nail",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "barb",
    name = "barb",
    default_item = "barb_paralysis",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "gene_sting",
    name = "yugg stinger",
    default_item = "gene_sting_barb",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "nether_huntsman_javelin_ammo",
    name = "alien outgrowth",
    default_item = "nether_huntsman_javelin",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "BB",
    name = "BBs",
    default_item = "bb",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "bolt_ballista",
    name = "ballista bolts",
    default_item = "bolt_ballista_steel",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "bolt",
    name = "bolts",
    default_item = "bolt_wood",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "arrow",
    name = "arrows",
    default_item = "arrow_wood",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "strange_arrow",
    name = "strange arrows",
    default_item = "arrow_meteor",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "atlatl",
    name = "atlatl spears",
    default_item = "steel_atlatl_spear",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "pebble",
    name = "pebbles",
    default_item = "pebble",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "rock",
    name = "rocks",
    default_item = "rock",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "shot",
    name = "12 gauge",
    default_item = "shot_00",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "410shot",
    name = ".410",
    default_item = "410shot_000",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "blunderbuss",
    name = "blunderbuss",
    default_item = "blun_shot",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "22",
    name = ".22 LR",
    default_item = "22_lr",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "powder_blank",
    name = "powder blank",
    default_item = "22_blank",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "9mm",
    name = "9x19mm",
    default_item = "9mm",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "357sig",
    name = ".357 SIG",
    default_item = "357sig_jhp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "357mag",
    name = ".357 Magnum",
    default_item = "357mag_jhp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "9x18",
    name = "9x18mm Makarov",
    default_item = "9x18mm",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "380",
    name = ".380 ACP",
    default_item = "380_JHP",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "38",
    name = ".38 Special",
    default_item = "38_special",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "38super",
    name = ".38 Super",
    default_item = "38super_fmj",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "40",
    name = ".40 S&W",
    default_item = "40sw",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "10mm",
    name = "10mm Auto",
    default_item = "10mm_fmj",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "44",
    name = ".44 Magnum",
    default_item = "44magnum",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "45",
    name = ".45 ACP",
    default_item = "45_acp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "454",
    name = ".454 Casull",
    default_item = "454_Casull",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "460sw",
    name = ".460 S&W Magnum",
    default_item = "460sw",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "45colt",
    name = ".45 Colt",
    default_item = "45colt_cowboy",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "500",
    name = ".500 S&W Magnum",
    default_item = "500_Magnum",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "57",
    name = "5.7x28mm",
    default_item = "57mm",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "762",
    name = "7.62x39mm",
    default_item = "762_m87",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "545x39",
    name = "5.45x39mm",
    default_item = "545",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "223",
    name = ".223",
    default_item = "556",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "303",
    name = ".303 British",
    default_item = "303_fmjbt",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "3006",
    name = ".30-06",
    default_item = "3006",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "30carbine",
    name = ".30 Carbine",
    default_item = "30carbine",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "270win",
    name = ".270 Winchester",
    default_item = "270win_jsp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "308",
    name = ".308",
    default_item = "762_51",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "40x46mm",
    name = "40x46mm grenade",
    default_item = "40x46mm_m433",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "40x53mm",
    name = "40x53mm grenade",
    default_item = "40x53mm_m430a1",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "66mm",
    name = "66mm HEAT",
    default_item = "66mm_HEAT",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "120mm",
    name = "120mm HEAT",
    default_item = "120mm_HEAT",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "84x246mm",
    name = "84x245mm cartridge",
    default_item = "84x246mm_he",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "m235",
    name = "M235 66mm Incendiary TPA",
    default_item = "m235tpa",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "mortar_60mm",
    name = "60 mm mortar cartridge",
    default_item = "60mm_shell_m720a1",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "sling-ready_grenade",
    name = "sling-ready grenades",
    default_item = "sling-ready_molotov",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "gasoline",
    name = "gasoline",
    default_item = "gasoline",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "jp8",
    name = "jp8",
    default_item = "jp8",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "avgas",
    name = "avgas",
    default_item = "avgas",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "diesel",
    name = "diesel",
    default_item = "diesel",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "lamp_oil",
    name = "kerosene",
    default_item = "lamp_oil",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "crude_lamp_oil",
    name = "crude lamp oil",
    default_item = "crude_lamp_oil",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "butane",
    name = "butane",
    default_item = "butane",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "aerosol_paint",
    name = "paint",
    default_item = "aerosol_paint",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "permanent_ink",
    name = "ink",
    default_item = "permanent_ink",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "candle_wax",
    name = "wax",
    default_item = "candle_wax",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "flare_nitrate",
    name = "flare pyrotechnic",
    default_item = "flare_nitrate",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "match",
    name = "match",
    default_item = "match",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "incense",
    name = "incense",
    default_item = "incense",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "oxygen",
    name = "oxygen",
    default_item = "oxygen",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "hydrogen",
    name = "hydrogen",
    default_item = "hydrogen",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "nitrogen",
    name = "nitrogen",
    default_item = "nitrogen",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "motor_oil",
    name = "motor oil",
    default_item = "motor_oil",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "crude_oil",
    name = "crude oil",
    default_item = "crude_oil",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "thread",
    name = "thread",
    default_item = "thread",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "anesthetic",
    name = "anesthetic",
    default_item = "anesthetic",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "soap",
    name = "soap",
    default_item = "soap",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "tape",
    name = "duct tape",
    default_item = "duct_tape",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "battery",
    name = "kJ",
    default_item = "battery",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "money",
    name = "cents",
    default_item = "money",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "plutonium",
    name = "plutonium",
    default_item = "plut_cell",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "uranium",
    name = "uranium",
    default_item = "uran_cell",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "reactor_slurry",
    name = "plutonium slurry",
    default_item = "plut_slurry",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "12mm",
    name = "12mm slug",
    default_item = "12mm",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "plasma",
    name = "solid hydrogen",
    default_item = "plasma",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "flammable",
    name = "flammable liquid",
    default_item = "napalm",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "weldgas",
    name = "welding gas",
    default_item = "oxyacetylene",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "propane",
    name = "propane",
    default_item = "propane",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "biogas",
    name = "biogas",
    default_item = "biogas",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "conc_alcohol",
    name = "concentrated alcohol",
    default_item = "denat_alcohol",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "methanol_fuelcell",
    name = "methanol",
    default_item = "chem_methanol_fuelcell",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "8x40mm",
    name = "8x40mm caseless",
    default_item = "8mm_caseless",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "20x66mm",
    name = "20x66mm caseless shotgun",
    default_item = "20x66_shot",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "signal_flare",
    name = "signal flare",
    default_item = "signal_flare",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "charcoal",
    name = "charcoal",
    default_item = "charcoal",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "coal",
    name = "coal",
    default_item = "coal_lump",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "thrown",
    name = "throwing weapon",
    default_item = "thrown",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "ampoule",
    name = "chemical ampoule",
    default_item = "ampoule",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "albuterol",
    name = "albuterol",
    default_item = "albuterol",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "liq_bandage",
    name = "liquid bandage",
    default_item = "liq_bandage",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "stimpack_ammo",
    name = "stimulant module",
    default_item = "stimpack_ammo",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "components",
    name = "components",
    default_item = "components",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "rebreather_filter",
    name = "rebreather CO2 scrubber",
    default_item = "rebreather_filler_soda_lime",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "rebreather_o2_regenerator",
    name = "rebreather O2 regenerator",
    default_item = "rebreather_filler_ko2",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "gasfilter_s",
    name = "filter mask cartridge",
    default_item = "gasfilter_s",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "gasfilter_m",
    name = "gas mask cartridge",
    default_item = "gasfilter_m",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "300",
    name = ".300 Winchester Magnum",
    default_item = "300_winmag",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "32",
    name = ".32 ACP",
    default_item = "32_acp",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "762x25",
    name = "7.62x25mm Tokarev",
    default_item = "762_25",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "flintlock",
    name = "paper cartridge",
    default_item = "flintlock_ammo",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "36paper",
    name = ".36 paper cartridge",
    default_item = "36navy",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "44paper",
    name = ".44 cap & ball",
    default_item = "44army",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "762R",
    name = "7.62x54mmR",
    default_item = "762_54R",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "fishspear",
    name = "speargun spear",
    default_item = "fishspear",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "fish_bait",
    name = "fish bait",
    default_item = "fish_bait",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "homebrew_rocket",
    name = "homebrew rocket",
    default_item = "spiked_rocket",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "atgm",
    name = "152mm anti-tank guided missile",
    default_item = "atgm_heat",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "unfinished_char",
    name = "semi-charred fuel",
    default_item = "unfinished_charcoal",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "chemical_spray",
    name = "sprayable chemical",
    default_item = "gas_fungicidal",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "milk",
    name = "milk",
    default_item = "milk",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "milk_raw",
    name = "raw milk",
    default_item = "milk_raw",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "paintball",
    name = "paintball",
    default_item = "paintball",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "nitrox",
    name = "compressed air",
    default_item = "nitrox",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "paper",
    name = "paper",
    default_item = "paper",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "extinguishing_agent",
    name = "extinguishing agent",
    default_item = "extinguishing_agent",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "teargas_spray",
    name = "tear gas spray",
    default_item = "teargas_spray",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "tinder",
    name = "tinder",
    default_item = "tinder",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "esbit",
    name = "hexamine",
    default_item = "chem_hexamine",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "water",
    name = "water",
    default_item = "water",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "300blk",
    name = ".300 AAC Blackout",
    default_item = "300blk",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "123ln",
    name = "12.3ln",
    default_item = "123ln",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "273x110",
    name = "27.3x110 Diyua shotshell",
    default_item = "273x110canister",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "273x44",
    name = "27.3x44 Diyua grenade",
    default_item = "273x44HE",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "273x44RG",
    name = "27.3x44 Diyua rocket",
    default_item = "273x44RG",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "33naval",
    name = "3.3 naval cartridge",
    default_item = "33naval_ball",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "caotel_cell",
    name = "Caotel cell",
    default_item = "caotel_cell",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "khuunaofaai_payload",
    name = "Khuunäöfaai firework payload",
    default_item = "khuunaofaai_ammo_firework",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "khuunaofaai_payload_fire",
    name = "Khuunäöfaai incendiary payload",
    default_item = "khuunaofaai_ammo_incendiary",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "khuunaofaai_payload_acid",
    name = "Khuunäöfaai corrosive payload",
    default_item = "khuunaofaai_ammo_corrosive",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "khuunaofaai_payload_glue",
    name = "Khuunäöfaai adhesive payload",
    default_item = "khuunaofaai_ammo_foam",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "glowstick_juice",
    name = "glowstick juice",
    default_item = "glowstick_juice",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "cannon",
    name = "cannon ball",
    default_item = "cannon_shot",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "quill_ink",
    name = "quill ink",
    default_item = "quill_ink",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "black_pen_ink",
    name = "black pen ink",
    default_item = "black_pen_ink",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "red_pen_ink",
    name = "red pen ink",
    default_item = "red_pen_ink",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "blue_pen_ink",
    name = "blue pen ink",
    default_item = "blue_pen_ink",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "green_pen_ink",
    name = "green pen ink",
    default_item = "green_pen_ink",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "ammonia_liquid",
    name = "ammonia",
    default_item = "ammonia_liquid",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "notch",
    name = "notch",
    default_item = "notch",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "turpentine",
    name = "turpentine",
    default_item = "chem_turpentine",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "airgun_pellet",
    name = "airgun pellet",
    default_item = "airgun_pellet_target",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "rivets",
    name = "rivets",
    default_item = "rivets",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "3030",
    name = ".30-30 Winchester",
    default_item = "3030",
}
content.replace(definition)
end
do
local definition = content.AmmunitionType {
    id = "bone_dart",
    name = "bone dart",
    default_item = "bone_dart",
}
content.replace(definition)
end

-- Native item-action definitions
do
local definition = content.ItemAction {
    id = "repair_fabric",
    name = "Repair cotton/leather/wool/Nomex/fur",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "repair_metal",
    name = "Repair metal/plastic/Kevlar",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "sew_advanced",
    name = "Modify clothing",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "firestarter",
    name = "Start a fire quickly",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PICK_LOCK",
    name = "Pick a lock",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "deploy_furn",
    name = "Deploy item",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "deploy_appliance",
    name = "Deploy item",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CROWBAR_WEAK",
    name = "Pry crate or nails",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CROWBAR",
    name = "Pry crate, window, door or nails",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MAKEMOUND",
    name = "Upturn earth",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DIG_CHANNEL",
    name = "Dig water channel here",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PICKAXE",
    name = "Dig through rock",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PACK_CBM",
    name = "Pack CBM in pouch",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "GEIGER",
    name = "Use Geiger counter",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HACKSAW",
    name = "Cut metal",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BOLTCUTTERS",
    name = "Cut bolts or wires",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HOTPLATE",
    name = "Heat up food (with it)",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HOTPLATE_ATOMIC",
    name = "Heat up food (with it)",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "TOOLMOD_ATTACH",
    name = "Attach as toolmod",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "GUNMOD_ATTACH",
    name = "Attach as gunmod",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "GUN_REPAIR",
    name = "Repair a gun",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DIRECTIONAL_HOLOGRAM",
    name = "Create a moving hologram",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ROBOTCONTROL",
    name = "Hack a robot",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "METH",
    name = "Smoke/snort meth",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "TAZER",
    name = "Taze something",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ANTICONVULSANT",
    name = "Take anticonvulsant",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "LUMBER",
    name = "Cut a log into planks",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "REMOVE_ALL_MODS",
    name = "Remove tool mods",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "salvage",
    name = "Cut up an item",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "inscribe",
    name = "Write on an item",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "fireweapon_off",
    name = "Turn on",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "fireweapon_on",
    name = "Turn off",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CHANGE_EYES",
    name = "Change the eye color",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CHANGE_SKIN",
    name = "Change skin color",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "transform",
    name = "Turn on",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "message",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "learn_spell",
    name = "Learn spell",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "cast_spell",
    name = "Cast spell",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "holster",
    name = "Use holster",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "attach_molle",
    name = "Attach pockets",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "detach_molle",
    name = "Remove pockets",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "saw_barrel",
    name = "Saw down barrel",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "saw_stock",
    name = "Saw down stock",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ACIDBOMB_ACT",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ADRENALINE_INJECTOR",
    name = "Inject",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "AFS_TRANSLOCATOR",
    name = "Create a buoy",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ANTIBIOTIC",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ANTIFUNGAL",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ANTIPARASITIC",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BELL",
    name = "Ring",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BLECH",
    name = "Drink",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BLECH_BECAUSE_UNCLEAN",
    name = "Drink",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CAMERA",
    name = "Use camera",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CAN_GOO",
    name = "Pour out",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CAPTURE_MONSTER_ACT",
    name = "Capture/place",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CAPTURE_MONSTER_VEH",
    name = "Capture/place",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CHEW",
    name = "Chew",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CLEAR_RUBBLE",
    name = "Clear rubble",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "COIN_FLIP",
    name = "Flip",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BINDER_ADD_RECIPE",
    name = "Copy a recipe",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BINDER_MANAGE_RECIPE",
    name = "Remove a recipe",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "COKE",
    name = "Snort coke",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DATURA",
    name = "Eat",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DIG",
    name = "Dig pit here",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DIRECTIONAL_ANTENNA",
    name = "Find direction",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DOG_WHISTLE",
    name = "Blow",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CALL_OF_TINDALOS",
    name = "Blow",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DOLLCHAT",
    name = "Make it talk",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ECIG",
    name = "Smoke",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "EHANDCUFFS",
    name = "Take off",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "EBOOKSAVE",
    name = "Store books",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "EMF_PASSIVE_ON",
    name = "Turn off",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "EXTINGUISHER",
    name = "Spray",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MACE",
    name = "Spray",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "EYEDROPS",
    name = "Use",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FILL_PIT",
    name = "Fill pit / tamp ground",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FIRECRACKER_PACK_ACT",
    name = "Light up",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FISH_ROD",
    name = "Fish",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FISH_TRAP",
    name = "Set",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FLUMED",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FLUSLEEP",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FLU_VACCINE",
    name = "Inject",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FOODPERSON",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FUNGICIDE",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "GRANADE_ACT",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "GRENADE_INC_ACT",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "detach_gunmods",
    name = "Detach gunmods",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "modify_gunmods",
    name = "Modify attached equipment",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HEATPACK",
    name = "Use",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HEAT_FOOD",
    name = "Heat up food (in it)",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HEAT_LIQUID_ITEMS",
    name = "Heat up liquid items",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HEAT_SOLID_ITEMS",
    name = "Heat up solid items",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HEAT_ALL_ITEMS",
    name = "Heat up solid or liquid items",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HONEYCOMB",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "INHALER",
    name = "Inhale",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "JACKHAMMER",
    name = "Drill",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "JET_INJECTOR",
    name = "Inject",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MAGIC_8_BALL",
    name = "Ask",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MEASURE_RESONANCE",
    name = "Measure artifact resonance",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CHANGE_OUTFIT",
    name = "Swap outfits",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PLAY_GAME",
    name = "Play",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MARLOSS",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MARLOSS_GEL",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MARLOSS_SEED",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MA_MANUAL",
    name = "Read",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MEDITATE",
    name = "Meditate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MININUKE",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MOP",
    name = "Mop",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "mp3",
    name = "mp3",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "RPGDIE",
    name = "Roll die",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "GASMASK_ACTIVATE",
    name = "Pressurise and suction test",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PAPR_MASK_ACTIVATE",
    name = "Attach to PAPR blower, pressurise, and suction test",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SOLARPACK",
    name = "Unfold",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SOLARPACK_OFF",
    name = "Fold",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MULTICOOKER",
    name = "Cook",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MYCUS",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "NOISE_EMITTER_ON",
    name = "Turn off",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "OXYGEN_BOTTLE",
    name = "Inhale",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "OXYTORCH",
    name = "Cut up metal",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PACK_ITEM",
    name = "Pack an item",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PETFOOD",
    name = "Feed an animal",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PLANTBLECH",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "POISON",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PORTABLE_GAME",
    name = "Play a game",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "FITNESS_CHECK",
    name = "Check health metrics",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "deploy_tent",
    name = "Put up",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PORTAL",
    name = "Place",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "POST_UP",
    name = "Put up",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PROZAC",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "E_FILE_DEVICE",
    name = "Manage files",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "VIEW_RECIPES",
    name = "View recipes",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "VIEW_PHOTOS",
    name = "View photos",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "PURIFY_SMART",
    name = "Inject",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "RADGLOVE",
    name = "Measure radiation",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "RADIOCAR",
    name = "…",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "RADIOCONTROL",
    name = "Control an RC car",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "RADIO_MOD",
    name = "Modify an item",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "RADIO_ON",
    name = "Scan",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "REMOTEVEH",
    name = "Control a vehicle",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "MANAGE_EXOSUIT",
    name = "Manage exosuit modules",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SEED",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SEWAGE",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SIPHON",
    name = "Siphon",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SMOKING",
    name = "Smoke",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SPRAY_CAN",
    name = "Write something",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "paint_vehicle",
    name = "Paint vehicle",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "STIMPACK",
    name = "Inject",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "TELEPORT",
    name = "Teleport yourself",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "THORAZINE",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "TOWEL",
    name = "Dry/clean yourself",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "UNFOLD_GENERIC",
    name = "Unfold",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BLOOD_DRAW",
    name = "Draw some blood",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "HAND_CRANK",
    name = "Recharge a battery",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "VIBE",
    name = "Well, you know",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "VORTEX",
    name = "Use",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "WASH_SOFT_ITEMS",
    name = "Wash soft items",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "WASH_HARD_ITEMS",
    name = "Wash hard items",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "WASH_ALL_ITEMS",
    name = "Wash items",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "WATER_PURIFIER",
    name = "Purify some water",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "WEATHER_TOOL",
    name = "Check weather information",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "XANAX",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "ammobelt",
    name = "Reload",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "consume_drug",
    name = "Consume",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "delayed_transform",
    name = "Use",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "explosion",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "heal",
    name = "Apply to wound",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "link_up",
    name = "Plug in / Manage cables",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "manualnoise",
    name = "Make some noise",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "musical_instrument",
    name = "Play instrument",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "place_monster",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "place_npc",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "place_trap",
    name = "Place",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "reveal_map",
    name = "Read",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "change_scent",
    name = "Mask scent",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "install_bionic",
    name = "Install bionic",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CHOP_TREE",
    name = "Chop down a tree",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CHOP_LOGS",
    name = "Chop a Tree Trunk into logs",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "BREAK_STICK",
    name = "Break stick",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "WEAK_ANTIBIOTIC",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DISASSEMBLE",
    name = "Get content",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "STRONG_ANTIBIOTIC",
    name = "Take",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "weigh_self",
    name = "Use Scale",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CRAFT",
    name = "Work on craft",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "effect_on_conditions",
    name = "Activate",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "SEXTANT",
    name = "Measure Sun altitude",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "LUX_METER",
    name = "Measure light level",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "DBG_LUX_METER",
    name = "Measure light level",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "CALORIES_INTAKE_TRACKER",
    name = "Calories intake tracker",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "VOLTMETER",
    name = "Test for voltage",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "play_instrument",
    name = "Play instrument",
}
content.replace(definition)
end
do
local definition = content.ItemAction {
    id = "sound",
    name = "Make sound",
}
content.replace(definition)
end

-- Native scenario definitions
do
local definition = content.Scenario {
    id = "defense_mode_fortified",
    name = "Fortified",
    description = "",
    start_name = "",
    points = 0,
    blacklist = false,
    extra_professions = false,
    reveal_locale = true,
    distance_initial_visibility = 15,
}
definition:location("sloc_bar")
content.replace(definition)
end

-- Native morale types
do
local definition = content.MoraleType {
    id = "morale_food_good",
    text = "Enjoyed %s",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_food_hot",
    text = "Enjoyed a hot meal",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_chat",
    text = "Enjoyed a conversation",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_chat_uncaring",
    text = "Had to suffer through an inane conversation",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_ate_with_table",
    text = "Ate with a table and chair",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_ate_without_table",
    text = "Ate like an animal",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_music",
    text = "Music",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_honey",
    text = "Enjoyed honey",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_game",
    text = "Played a game",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_marloss",
    text = "Marloss bliss",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_mutagen",
    text = "Mutagenic anticipation",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_feeling_good",
    text = "Feeling good",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_support",
    text = "Supported",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_photos",
    text = "Looked at photos",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_nicotine",
    text = "Craving nicotine",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_caffeine",
    text = "Craving caffeine",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_alcohol",
    text = "Craving alcohol",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_opiate",
    text = "Craving opiates",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_speed",
    text = "Craving speed",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_cocaine",
    text = "Craving cocaine",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_crack",
    text = "Craving crack cocaine",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_mutagen",
    text = "Craving mutagen",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_diazepam",
    text = "Craving prescription sedatives",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_craving_marloss",
    text = "Craving Marloss",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_food_bad",
    text = "Disliked %s",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_cannibal",
    text = "Ate human flesh",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_demicannibal",
    text = "Ate demihuman flesh",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_vegetarian",
    text = "Ate vegetables",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_antiveggy",
    text = "Ate vegetables",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_meatarian",
    text = "Ate meat",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_antimeat",
    text = "Ate meat",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_antifruit",
    text = "Ate fruit",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_lactose",
    text = "Lactose intolerance",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_antijunk",
    text = "Ate junk food",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_antiwheat",
    text = "Grain intolerance",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_sweettooth",
    text = "Enjoyed something sugary",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_no_digest",
    text = "Ate indigestible food",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_wet",
    text = "Wet",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_dried_off",
    text = "Dried off",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_cold",
    text = "Cold",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_hot",
    text = "Hot",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_feeling_bad",
    text = "Feeling bad",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_bad_protein_bar",
    text = "Demoralizing food",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_killed_innocent",
    text = "Killed an innocent person",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_killed_friend",
    text = "Killed a friend",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_killed_monster",
    text = "Guilty about killing",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_mutilate_corpse",
    text = "Guilty about mutilating a corpse",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_mutagen_elf",
    text = "Fey mutation",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_mutagen_chimera",
    text = "Chimerical mutation",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_mutagen_mutation",
    text = "Mutation",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_moodswing",
    text = "Mood swing",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_book",
    text = "Read %s",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_comfy",
    text = "Got comfy",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_scream",
    text = "Heard a disturbing scream",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_masochist",
    text = "Masochism",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_radiophile",
    text = "Tingly feeling",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_noface",
    text = "You have no face!",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_fpmode_on",
    text = "You feel pumped!",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_hoarder",
    text = "Hoarder",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_optimist",
    text = "Optimist",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_badtemper",
    text = "Bad Tempered",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_numb",
    text = "Numb",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_emotionalvolatility",
    text = "Emotional Volatility",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_emotionalflatness",
    text = "Emotional Flatness",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_constrained",
    text = "Uncomfortable gear",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_nomad",
    text = "Nomadic restlessness",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_game_found_kitten",
    text = "Found kitten <3",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_haircut",
    text = "Got a haircut",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_shave",
    text = "Freshly shaven",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_vomited",
    text = "Threw up",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_play_with_pet",
    text = "Spent time playing with a pet",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_pyromania_startfire",
    text = "Lit a fire",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_pyromania_nearfire",
    text = "Spent time close to fire",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_pyromania_nofire",
    text = "Craving fire",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_killer_has_killed",
    text = "Killed recently",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_killer_need_to_kill",
    text = "Longing to kill",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_filthy",
    text = "Filthy gear",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_butcher",
    text = "Anguished by memories of butchering a person's corpse",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_gravedigger",
    text = "Dug out a grave",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_funeral",
    text = "Conducted a funeral",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_tree_communion",
    text = "Communed with the trees",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_accomplishment",
    text = "Accomplishment",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_failure",
    text = "Failure",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_fun_craft",
    text = "Got to enjoy crafting",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_shitty_craft",
    text = "Forced themself to work on crafting",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_perm_debug",
    text = "Debug morale",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_nightmare",
    text = "Had a vivid nightmare",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_migo_bio_tech",
    text = "Used mi-go biotech",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_impossible_shape",
    text = "Saw something that hurts to remember",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_afs_drugs",
    text = "Chemical enhancement moodswing",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_social",
    text = "Spent time around allies",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_asocial",
    text = "Spent time alone",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_bile",
    text = "Covered in bile",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_sunrise",
    text = "Saw the sun rise",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_sunset",
    text = "Saw the sun set",
    permanent = false,
}
content.replace(definition)
end
do
local definition = content.MoraleType {
    id = "morale_applied_makeup",
    text = "Applied makeup",
    permanent = false,
}
content.replace(definition)
end

-- Native monster flags
do
local definition = content.MonsterFlag {
    id = "SEES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "HEARS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GOODHEARING",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SMELLS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "KEENNOSE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "STUMBLES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CLUMSY_ATTACKS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "WARM",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NEMESIS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "HAS_MIND",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NOHEAD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "HARDTOSHOOT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GRABS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "BASHES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DESTROYS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "BORES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "POISON",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "VENOM",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "BADVENOM",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PARALYZEVENOM",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "WEBWALK",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DIGS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CAN_DIG",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FLIES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "AQUATIC",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SWIMS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ATTACKMON",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ANIMAL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PLASTIC",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SUNDEATH",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PHOTOPHOBIC",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "TRUESIGHT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PLANT_BLOOD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PERMANENT_INVISIBILITY",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ELECTRIC",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ACIDPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ACIDTRAIL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SHORTACIDTRAIL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FIREPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "IRONWROUGHT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SLUDGEPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FAE_CREATURE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SLUDGETRAIL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SMALLSLUDGETRAIL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "BULLETPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "COLDPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "BIOLOGICALPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "COMBAT_MOUNT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FIREY",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FLASHBANGPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "QUEEN",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ELECTRONIC",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CONSOLE_DESPAWN",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "IMMOBILE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ID_CARD_DESPAWN",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "RIDEABLE_MECH",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "MILITARY_MECH",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "MECH_RECON_VISION",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "MECH_DEFENSIVE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "HIT_AND_RUN",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PAY_BOT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "HUMAN",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NO_BREATHE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FLAMMABLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "REVIVES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DORMANT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GEN_DORMANT",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "QUIETDEATH",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NOGIB",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ARTHROPOD_BLOOD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ACID_BLOOD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "BILE_BLOOD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FILTHY",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "FISHABLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GROUP_BASH",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SWARMS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GROUP_MORALE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "INTERIOR_AMMO",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CLIMBS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PACIFIST",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "KEEP_DISTANCE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PUSH_MON",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PUSH_VEH",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "UNBREAKABLE_MORALE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NIGHT_INVISIBILITY",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "REVIVES_HEALTHY",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NO_NECRO",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PATH_AVOID_DANGER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PATH_AVOID_FIRE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PATH_AVOID_FALL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PRIORITIZE_TARGETS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NOT_HALLUCINATION",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CANPLAY",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CAN_BE_CULLED",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PET_MOUNTABLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PET_HARNESSABLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DOGFOOD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "MILKABLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SHEARABLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NO_BREED",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NO_FUNG_DMG",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PET_WONT_FOLLOW",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DRIPS_NAPALM",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DRIPS_GASOLINE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ELECTRIC_FIELD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "LOUDMOVES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "QUIETMOVES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SILENTMOVES",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CAN_OPEN_DOORS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "STUN_IMMUNE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DROPS_AMMO",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "WIELDED_WEAPON",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "INSECTICIDEPROOF",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "RANGED_ATTACKER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CAMOUFLAGE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "WATER_CAMOUFLAGE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ATTACK_UPPER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ATTACK_LOWER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DEADLY_VIRUS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "VAMP_VIRUS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "COPY_SUMMONER_LOOK",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "COPY_AVATAR_LOOK",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ALWAYS_VISIBLE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "APPEARS_NEUTRAL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ALWAYS_SEES_YOU",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "LOCKS_ON",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ALL_SEEING",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "MIND_SEEING",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "INFRARED_VISION",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "NEVER_WANDER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CONVERSATION",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SILENT_DISAPPEAR",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "EATS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "CORNERED_FIGHTER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "SMALL_HIDER",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GUILT_ANIMAL",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GUILT_CHILD",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GUILT_HUMAN",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "GUILT_OTHERS",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "DRACULIN_IMMUNE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "TEEP_IMMUNE",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "PULP_PRYING",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ONE_DIMENSIONAL_X",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ONE_DIMENSIONAL_Y",
}
content.replace(definition)
end
do
local definition = content.MonsterFlag {
    id = "ONE_DIMENSIONAL_Z",
}
content.replace(definition)
end

-- Native weighted vehicle groups
do
local definition = content.VehicleGroup {
    id = "city_vehicles",
}
definition:vehicle("car", 700)
definition:vehicle("car_diesel", 350)
definition:vehicle("car_anmlcmpt", 250)
definition:vehicle("car_hatch", 200)
definition:vehicle("car_hatch_diesel", 100)
definition:vehicle("car_luxury", 200)
definition:vehicle("electric_car", 175)
definition:vehicle("car_micro", 300)
definition:vehicle("car_micro_hybrid", 300)
definition:vehicle("car_micro_electric", 300)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 150)
definition:vehicle("scompact_tandem_hboard", 150)
definition:vehicle("scompact_tandem_electric_stow", 150)
definition:vehicle("scompact_tandem_electric_hboard", 150)
definition:vehicle("scompact_tandem_2wheel_stow", 150)
definition:vehicle("scompact_tandem_2wheel_hboard", 150)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 150)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 150)
definition:vehicle("scompact_tandem_3wheel_stow", 150)
definition:vehicle("scompact_tandem_3wheel_hboard", 150)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 150)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 150)
definition:vehicle("car_shootingbrake_v8", 150)
definition:vehicle("car_shootingbrake_v12", 150)
definition:vehicle("car_shootingbrake_electric", 150)
definition:vehicle("car_shootingbrake_long_v8", 150)
definition:vehicle("car_shootingbrake_long_v12", 150)
definition:vehicle("car_shootingbrake_long_electric", 150)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 200)
definition:vehicle("car_sedan_diesel_v6", 150)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 150)
definition:vehicle("car_sedan_sports_v6", 200)
definition:vehicle("car_sedan_luxury_v6", 200)
definition:vehicle("car_sedan_electric", 200)
definition:vehicle("car_sedan_luxury_electric", 50)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 300)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 300)
definition:vehicle("car_coupe_diesel_i4", 150)
definition:vehicle("car_coupe_diesel_v6", 150)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 150)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 200)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 200)
definition:vehicle("car_super_v12", 150)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 120)
definition:vehicle("car_mini", 400)
definition:vehicle("car_hybrid", 500)
definition:vehicle("beetle", 500)
definition:vehicle("bicycle", 800)
definition:vehicle("bicycle_dirt", 200)
definition:vehicle("bicycle_electric", 100)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_cross", 20)
definition:vehicle("motorcycle_enduro", 50)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 200)
definition:vehicle("scooter_electric", 300)
definition:vehicle("skateboard", 100)
definition:vehicle("policecar", 250)
definition:vehicle("policecar_k9", 3)
definition:vehicle("policesuv", 250)
definition:vehicle("policesuv_k9", 5)
definition:vehicle("police_k9tpt", 1)
definition:vehicle("truck_swat", 200)
definition:vehicle("prisoner_van_1", 50)
definition:vehicle("ambulance", 500)
definition:vehicle("fire_truck", 300)
definition:vehicle("fire_engine", 200)
definition:vehicle("flatbed_truck", 800)
definition:vehicle("pickup", 800)
definition:vehicle("road_roller", 200)
definition:vehicle("autosweeper", 200)
definition:vehicle("hippie_van", 200)
definition:vehicle("van_full-size", 800)
definition:vehicle("van_full-size_hybrid", 200)
definition:vehicle("van_mini", 1000)
definition:vehicle("van_mini_hybrid", 250)
definition:vehicle("van_cargo", 600)
definition:vehicle("cube_van_cheap", 400)
definition:vehicle("cube_van", 300)
definition:vehicle("fridge_van", 300)
definition:vehicle("security_van", 500)
definition:vehicle("schoolbus", 100)
definition:vehicle("bus", 300)
definition:vehicle("bus_rack", 200)
definition:vehicle("bus_tour", 50)
definition:vehicle("rv", 500)
definition:vehicle("limousine", 200)
definition:vehicle("lux_rv", 100)
definition:vehicle("meth_lab", 200)
definition:vehicle("armored_car", 200)
definition:vehicle("apc", 100)
definition:vehicle("apc-gl", 50)
definition:vehicle("humvee", 150)
definition:vehicle("humvee_gl", 50)
definition:vehicle("icecream_truck", 50)
definition:vehicle("food_truck", 50)
definition:vehicle("food_truck_taco", 50)
definition:vehicle("wienermobile", 5)
definition:vehicle("tatra_truck", 100)
definition:vehicle("4seat_pickup", 125)
definition:vehicle("extended_pickup", 65)
definition:vehicle("4x4_car", 250)
definition:vehicle("4x4_car_diesel", 250)
definition:vehicle("underlift_tow_truck", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "boatrent",
}
definition:vehicle("canoe", 2000)
definition:vehicle("kayak", 1500)
definition:vehicle("kayak_racing", 500)
definition:vehicle("raft", 2000)
definition:vehicle("wood_rowboat_double", 1500)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "food_trucks",
}
definition:vehicle("icecream_truck", 10)
definition:vehicle("food_truck", 10)
definition:vehicle("food_truck_taco", 10)
definition:vehicle("wienermobile", 1)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "lake",
}
definition:vehicle("cabin_cruiser_wood", 1500)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "boats_narrow",
}
definition:vehicle("canoe", 2000)
definition:vehicle("kayak", 1500)
definition:vehicle("kayak_racing", 500)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "boats_shore",
}
definition:vehicle("canoe", 2)
definition:vehicle("kayak", 2)
definition:vehicle("wood_rowboat_double", 6)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "jetskis",
}
definition:vehicle("jetski", 2)
definition:vehicle("jetski_electric", 1)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "trains_and_cars",
}
definition:vehicle("train_car_passenger", 250)
definition:vehicle("train_electrical_loco1300", 500)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "city_pileup",
}
definition:vehicle("car", 950)
definition:vehicle("car_diesel", 275)
definition:vehicle("car_anmlcmpt", 600)
definition:vehicle("car_hatch", 300)
definition:vehicle("car_hatch_diesel", 200)
definition:vehicle("car_luxury", 650)
definition:vehicle("electric_car", 350)
definition:vehicle("car_micro", 450)
definition:vehicle("car_micro_hybrid", 450)
definition:vehicle("car_micro_electric", 450)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 200)
definition:vehicle("scompact_tandem_hboard", 200)
definition:vehicle("scompact_tandem_electric_stow", 200)
definition:vehicle("scompact_tandem_electric_hboard", 200)
definition:vehicle("scompact_tandem_2wheel_stow", 200)
definition:vehicle("scompact_tandem_2wheel_hboard", 200)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 200)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 200)
definition:vehicle("scompact_tandem_3wheel_stow", 200)
definition:vehicle("scompact_tandem_3wheel_hboard", 200)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 200)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 200)
definition:vehicle("car_shootingbrake_v8", 200)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 200)
definition:vehicle("car_sedan_diesel_i4", 200)
definition:vehicle("car_sedan_diesel_v6", 200)
definition:vehicle("car_sedan_v8", 200)
definition:vehicle("car_sedan_sports_v12", 200)
definition:vehicle("car_sedan_sports_v6", 200)
definition:vehicle("car_sedan_luxury_v6", 200)
definition:vehicle("car_sedan_electric", 200)
definition:vehicle("car_sedan_luxury_electric", 200)
definition:vehicle("car_sedan_sports_electric", 200)
definition:vehicle("car_town", 300)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 400)
definition:vehicle("car_coupe_diesel_i4", 200)
definition:vehicle("car_coupe_diesel_v6", 200)
definition:vehicle("car_coupe_muscle", 200)
definition:vehicle("car_coupe_sports_v12", 200)
definition:vehicle("car_coupe_sports_v6", 200)
definition:vehicle("car_coupe_luxury_v6", 200)
definition:vehicle("car_coupe_electric", 200)
definition:vehicle("car_coupe_luxury_electric", 200)
definition:vehicle("car_coupe_sports_electric", 200)
definition:vehicle("car_super_v12", 100)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 150)
definition:vehicle("car_mini", 500)
definition:vehicle("beetle", 500)
definition:vehicle("pickup", 600)
definition:vehicle("flatbed_truck", 400)
definition:vehicle("cube_van", 500)
definition:vehicle("cube_van_cheap", 500)
definition:vehicle("fridge_van", 500)
definition:vehicle("hippie_van", 200)
definition:vehicle("van_full-size", 200)
definition:vehicle("van_mini", 300)
definition:vehicle("van_cargo", 400)
definition:vehicle("4x4_car", 250)
definition:vehicle("4x4_car_diesel", 250)
definition:vehicle("extended_pickup", 65)
definition:vehicle("car_hybrid", 500)
definition:vehicle("underlift_tow_truck", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "police_pileup",
}
definition:vehicle("policecar", 400)
definition:vehicle("policesuv", 400)
definition:vehicle("policecar_k9", 2)
definition:vehicle("policesuv_k9", 3)
definition:vehicle("police_k9tpt", 1)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "highway",
}
definition:vehicle("car", 1000)
definition:vehicle("car_diesel", 500)
definition:vehicle("car_anmlcmpt", 250)
definition:vehicle("car_hatch", 300)
definition:vehicle("car_hatch_diesel", 500)
definition:vehicle("car_luxury", 200)
definition:vehicle("electric_car", 175)
definition:vehicle("car_hybrid", 300)
definition:vehicle("car_shootingbrake_v8", 500)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 500)
definition:vehicle("car_sedan_diesel_i4", 400)
definition:vehicle("car_sedan_diesel_v6", 300)
definition:vehicle("car_sedan_v8", 200)
definition:vehicle("car_sedan_sports_v12", 200)
definition:vehicle("car_sedan_sports_v6", 200)
definition:vehicle("car_sedan_luxury_v6", 200)
definition:vehicle("car_sedan_electric", 200)
definition:vehicle("car_sedan_luxury_electric", 200)
definition:vehicle("car_sedan_sports_electric", 200)
definition:vehicle("car_town", 300)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 200)
definition:vehicle("car_coupe_diesel_v6", 200)
definition:vehicle("car_coupe_muscle", 200)
definition:vehicle("car_coupe_sports_v12", 200)
definition:vehicle("car_coupe_sports_v6", 200)
definition:vehicle("car_coupe_luxury_v6", 200)
definition:vehicle("car_coupe_electric", 200)
definition:vehicle("car_coupe_luxury_electric", 200)
definition:vehicle("car_coupe_sports_electric", 200)
definition:vehicle("car_super_v12", 800)
definition:vehicle("pickup", 600)
definition:vehicle("flatbed_truck", 500)
definition:vehicle("semi_truck", 600)
definition:vehicle("humvee", 600)
definition:vehicle("humvee_gl", 150)
definition:vehicle("military_cargo_truck", 300)
definition:vehicle("military_cargo_truck_b", 300)
definition:vehicle("policecar", 400)
definition:vehicle("policecar_k9", 2)
definition:vehicle("policesuv", 400)
definition:vehicle("policesuv_k9", 3)
definition:vehicle("police_k9tpt", 1)
definition:vehicle("car_fbi", 300)
definition:vehicle("truck_swat", 200)
definition:vehicle("hippie_van", 200)
definition:vehicle("van_full-size", 600)
definition:vehicle("van_cargo", 400)
definition:vehicle("van_camper", 200)
definition:vehicle("apc", 300)
definition:vehicle("apc-gl", 100)
definition:vehicle("aapc-mg", 100)
definition:vehicle("aapc-gl", 50)
definition:vehicle("schoolbus", 50)
definition:vehicle("bus", 225)
definition:vehicle("bus_rack", 125)
definition:vehicle("bus_tour", 25)
definition:vehicle("rv", 800)
definition:vehicle("limousine", 200)
definition:vehicle("lux_rv", 100)
definition:vehicle("surv_rv", 1)
definition:vehicle("meth_lab", 300)
definition:vehicle("armored_car", 300)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("surv_car", 2)
definition:vehicle("wienermobile", 5)
definition:vehicle("tatra_truck", 300)
definition:vehicle("4x4_car", 200)
definition:vehicle("4x4_car_diesel", 200)
definition:vehicle("extended_pickup", 65)
definition:vehicle("underlift_tow_truck", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "suburban_home",
}
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_rack", 700)
definition:vehicle("car_anmlcmpt", 150)
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_hatch_rack", 500)
definition:vehicle("car_luxury", 150)
definition:vehicle("car_mini", 250)
definition:vehicle("electric_car", 175)
definition:vehicle("car_hybrid", 200)
definition:vehicle("car_hybrid_rack", 400)
definition:vehicle("beetle", 300)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 200)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_coupe", 100)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("car_super_v12", 100)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_cross", 25)
definition:vehicle("motorcycle_enduro", 50)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 100)
definition:vehicle("scooter_electric", 100)
definition:vehicle("suv", 500)
definition:vehicle("suv_electric", 120)
definition:vehicle("suv_electric_rack", 120)
definition:vehicle("pickup", 300)
definition:vehicle("4seat_pickup", 125)
definition:vehicle("bicycle", 200)
definition:vehicle("bicycle_dirt", 150)
definition:vehicle("bicycle_electric", 100)
definition:vehicle("tricycle", 5)
definition:vehicle("skateboard", 100)
definition:vehicle("4x4_car", 100)
definition:vehicle("4x4_car_diesel", 100)
definition:vehicle("wheelbarrow", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "suburban_home_compact",
}
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_hatch_rack", 500)
definition:vehicle("car_mini", 250)
definition:vehicle("beetle", 300)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 100)
definition:vehicle("car_shootingbrake_v12", 100)
definition:vehicle("car_shootingbrake_electric", 100)
definition:vehicle("car_super_v12", 100)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_cross", 25)
definition:vehicle("motorcycle_enduro", 50)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 100)
definition:vehicle("scooter_electric", 100)
definition:vehicle("bicycle", 200)
definition:vehicle("bicycle_dirt", 150)
definition:vehicle("bicycle_electric", 100)
definition:vehicle("tricycle", 5)
definition:vehicle("skateboard", 100)
definition:vehicle("wheelbarrow", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "dirtlot",
}
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("quad_bike", 100)
definition:vehicle("pickup", 300)
definition:vehicle("bicycle_dirt", 100)
definition:vehicle("motorcycle_cross", 75)
definition:vehicle("motorcycle_enduro", 150)
definition:vehicle("wheelbarrow", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "parkinglot",
}
definition:vehicle("humvee", 100)
definition:vehicle("humvee_gl", 50)
definition:vehicle("rv", 200)
definition:vehicle("limousine", 100)
definition:vehicle("schoolbus", 200)
definition:vehicle("bus_tour", 50)
definition:vehicle("fire_truck", 200)
definition:vehicle("policecar", 100)
definition:vehicle("policecar_k9", 1)
definition:vehicle("policesuv", 100)
definition:vehicle("policesuv_k9", 1)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("quad_bike", 100)
definition:vehicle("semi_truck", 500)
definition:vehicle("cube_van", 400)
definition:vehicle("fridge_van", 800)
definition:vehicle("flatbed_truck", 400)
definition:vehicle("car_mini", 375)
definition:vehicle("beetle", 350)
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_anmlcmpt", 100)
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_luxury", 100)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 200)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 300)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 10)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("car_super_v12", 100)
definition:vehicle("electric_car", 350)
definition:vehicle("car_hybrid", 250)
definition:vehicle("extended_pickup", 95)
definition:vehicle("4seat_pickup", 125)
definition:vehicle("hippie_van", 750)
definition:vehicle("van_full-size", 600)
definition:vehicle("van_mini", 400)
definition:vehicle("van_cargo", 100)
definition:vehicle("golf_cart", 300)
definition:vehicle("scooter", 300)
definition:vehicle("bicycle", 1000)
definition:vehicle("unicycle", 100)
definition:vehicle("bicycle_electric", 200)
definition:vehicle("motorcycle", 500)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle_sidecart", 300)
definition:vehicle("shopping_cart", 1000)
definition:vehicle("icecream_truck", 50)
definition:vehicle("food_truck", 20)
definition:vehicle("wienermobile", 5)
definition:vehicle("4x4_car", 100)
definition:vehicle("4x4_car_diesel", 100)
definition:vehicle("underlift_tow_truck", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "garage",
}
definition:vehicle("car", 5)
definition:vehicle("car_diesel", 2)
definition:vehicle("car_hatch", 2)
definition:vehicle("car_hatch_diesel", 1)
definition:vehicle("car_sedan", 5)
definition:vehicle("car_sedan_diesel_i4", 5)
definition:vehicle("car_sedan_diesel_v6", 5)
definition:vehicle("car_sedan_v8", 5)
definition:vehicle("car_sedan_sports_v12", 5)
definition:vehicle("car_sedan_sports_v6", 5)
definition:vehicle("car_sedan_luxury_v6", 5)
definition:vehicle("car_sedan_electric", 5)
definition:vehicle("car_sedan_luxury_electric", 5)
definition:vehicle("car_sedan_sports_electric", 5)
definition:vehicle("car_town", 1)
definition:vehicle("car_town_diesel", 1)
definition:vehicle("car_town_budget", 1)
definition:vehicle("car_town_budget_superior", 1)
definition:vehicle("car_town_diesel_budget", 1)
definition:vehicle("car_coupe", 5)
definition:vehicle("car_coupe_diesel_i4", 5)
definition:vehicle("car_coupe_diesel_v6", 5)
definition:vehicle("car_coupe_muscle", 5)
definition:vehicle("car_coupe_sports_v12", 5)
definition:vehicle("car_coupe_sports_v6", 5)
definition:vehicle("car_coupe_luxury_v6", 5)
definition:vehicle("car_coupe_electric", 5)
definition:vehicle("car_coupe_luxury_electric", 5)
definition:vehicle("car_coupe_sports_electric", 5)
definition:vehicle("car_super_v12", 1)
definition:vehicle("car_chassis", 20)
definition:vehicle("engine_crane", 40)
definition:vehicle("motorcycle", 10)
definition:vehicle("motorcycle_chassis", 20)
definition:vehicle("motorcycle_3wheel", 5)
definition:vehicle("motorcycle_3wheel_super", 5)
definition:vehicle("quad_bike", 10)
definition:vehicle("quad_bike_chassis", 20)
definition:vehicle("car_racing_electric", 5)
definition:vehicle("superbike", 5)
definition:vehicle("welding_cart", 20)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "military_vehicles",
}
definition:vehicle("military_cargo_truck", 1000)
definition:vehicle("military_cargo_truck_b", 1000)
definition:vehicle("humvee", 500)
definition:vehicle("humvee_gl", 250)
definition:vehicle("humvee_tow", 125)
definition:vehicle("apc", 500)
definition:vehicle("apc-gl", 250)
definition:vehicle("aapc-mg", 250)
definition:vehicle("aapc-gl", 125)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "military_cargo_trucks",
}
definition:vehicle("military_cargo_truck", 500)
definition:vehicle("military_cargo_truck_b", 500)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "farm_vehicles",
}
definition:vehicle("tractor_plow", 1000)
definition:vehicle("tractor_seed", 1000)
definition:vehicle("tractor_reaper", 1000)
definition:vehicle("oldtractor", 100)
definition:vehicle("autotractor", 1000)
definition:vehicle("excavator", 500)
definition:vehicle("wheelbarrow", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "farm_horse_vehicles",
}
definition:vehicle("tractor_plow", 250)
definition:vehicle("tractor_seed", 250)
definition:vehicle("tractor_reaper", 250)
definition:vehicle("oldtractor", 250)
definition:vehicle("horse_trailer", 1000)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "industrial_vehicles",
}
definition:vehicle("autosweeper", 20)
definition:vehicle("excavator", 120)
definition:vehicle("flatbed_truck", 40)
definition:vehicle("pickup", 20)
definition:vehicle("road_roller", 80)
definition:vehicle("tatra_truck", 20)
definition:vehicle("trencher", 40)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "warehouse_vehicles",
}
definition:vehicle("engine_crane", 50)
definition:vehicle("handjack", 150)
definition:vehicle("wheelbarrow", 100)
definition:vehicle("forklift", 100)
definition:vehicle("forklift_diesel", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "forklift_vehicles",
}
definition:vehicle("forklift", 100)
definition:vehicle("forklift_diesel", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "school_vehicles",
}
definition:vehicle("schoolbus", 50)
definition:vehicle("fire_truck", 70)
definition:vehicle("bus", 30)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "bandit_vehicles",
}
definition:vehicle("pickup_technical", 150)
definition:vehicle("quad_bike", 150)
definition:vehicle("motorcycle", 300)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "junkyard_vehicles",
}
definition:vehicle("car", 750)
definition:vehicle("car_diesel", 350)
definition:vehicle("car_hatch", 750)
definition:vehicle("car_hatch_diesel", 400)
definition:vehicle("car_luxury", 100)
definition:vehicle("car_chassis", 2000)
definition:vehicle("electric_car", 200)
definition:vehicle("car_hybrid", 400)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 200)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("car_super_v12", 100)
definition:vehicle("extended_pickup", 25)
definition:vehicle("4seat_pickup", 50)
definition:vehicle("suv", 500)
definition:vehicle("suv_electric", 120)
definition:vehicle("car_mini", 300)
definition:vehicle("beetle", 500)
definition:vehicle("pickup", 600)
definition:vehicle("hippie_van", 200)
definition:vehicle("van_full-size", 500)
definition:vehicle("van_mini", 300)
definition:vehicle("4x4_car", 250)
definition:vehicle("4x4_car_diesel", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "dumpsite_vehicles",
}
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_luxury", 100)
definition:vehicle("car_chassis", 1200)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 200)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 300)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("car_super_v12", 100)
definition:vehicle("suv", 400)
definition:vehicle("car_mini", 250)
definition:vehicle("car_hybrid", 200)
definition:vehicle("rv", 250)
definition:vehicle("meth_lab", 50)
definition:vehicle("beetle", 400)
definition:vehicle("schoolbus", 100)
definition:vehicle("flatbed_truck", 200)
definition:vehicle("cube_van_cheap", 400)
definition:vehicle("pickup", 500)
definition:vehicle("hippie_van", 350)
definition:vehicle("4x4_car", 250)
definition:vehicle("4x4_car_diesel", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "campground_vehicles",
}
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_hatch", 475)
definition:vehicle("car_hatch_diesel", 225)
definition:vehicle("car_anmlcmpt", 150)
definition:vehicle("electric_car", 100)
definition:vehicle("car_hybrid", 100)
definition:vehicle("car_luxury", 50)
definition:vehicle("car_shootingbrake_v8", 50)
definition:vehicle("car_shootingbrake_v12", 50)
definition:vehicle("car_shootingbrake_electric", 50)
definition:vehicle("car_shootingbrake_long_v8", 50)
definition:vehicle("car_shootingbrake_long_v12", 50)
definition:vehicle("car_shootingbrake_long_electric", 50)
definition:vehicle("car_sedan", 250)
definition:vehicle("car_sedan_diesel_i4", 150)
definition:vehicle("car_sedan_diesel_v6", 150)
definition:vehicle("car_sedan_v8", 150)
definition:vehicle("car_sedan_sports_v12", 150)
definition:vehicle("car_sedan_sports_v6", 150)
definition:vehicle("car_sedan_luxury_v6", 150)
definition:vehicle("car_sedan_electric", 150)
definition:vehicle("car_sedan_luxury_electric", 150)
definition:vehicle("car_sedan_sports_electric", 150)
definition:vehicle("car_town", 250)
definition:vehicle("car_town_diesel", 150)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 150)
definition:vehicle("car_town_diesel_budget", 150)
definition:vehicle("car_coupe", 250)
definition:vehicle("car_coupe_diesel_i4", 150)
definition:vehicle("car_coupe_diesel_v6", 150)
definition:vehicle("car_coupe_muscle", 150)
definition:vehicle("car_coupe_sports_v12", 150)
definition:vehicle("car_coupe_sports_v6", 150)
definition:vehicle("car_coupe_luxury_v6", 150)
definition:vehicle("car_coupe_electric", 150)
definition:vehicle("car_coupe_luxury_electric", 150)
definition:vehicle("car_coupe_sports_electric", 150)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 100)
definition:vehicle("suv_electric_rack", 100)
definition:vehicle("bicycle_dirt", 50)
definition:vehicle("motorcycle_cross", 75)
definition:vehicle("motorcycle_enduro", 150)
definition:vehicle("extended_pickup", 15)
definition:vehicle("4seat_pickup", 35)
definition:vehicle("car_mini", 100)
definition:vehicle("beetle", 200)
definition:vehicle("pickup", 700)
definition:vehicle("hippie_van", 200)
definition:vehicle("van_camper", 200)
definition:vehicle("van_motorhome", 50)
definition:vehicle("4x4_car", 400)
definition:vehicle("4x4_car_diesel", 400)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "forgotten_vehicles",
}
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_luxury", 100)
definition:vehicle("car_shootingbrake_v8", 50)
definition:vehicle("car_shootingbrake_v12", 50)
definition:vehicle("car_shootingbrake_electric", 50)
definition:vehicle("car_shootingbrake_long_v8", 50)
definition:vehicle("car_shootingbrake_long_v12", 50)
definition:vehicle("car_shootingbrake_long_electric", 50)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 150)
definition:vehicle("car_sedan_diesel_v6", 150)
definition:vehicle("car_sedan_v8", 150)
definition:vehicle("car_sedan_sports_v12", 150)
definition:vehicle("car_sedan_sports_v6", 150)
definition:vehicle("car_sedan_luxury_v6", 150)
definition:vehicle("car_sedan_electric", 150)
definition:vehicle("car_sedan_luxury_electric", 50)
definition:vehicle("car_sedan_sports_electric", 50)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 250)
definition:vehicle("car_coupe_diesel_i4", 150)
definition:vehicle("car_coupe_diesel_v6", 150)
definition:vehicle("car_coupe_muscle", 150)
definition:vehicle("car_coupe_sports_v12", 150)
definition:vehicle("car_coupe_sports_v6", 150)
definition:vehicle("car_coupe_luxury_v6", 150)
definition:vehicle("car_coupe_electric", 150)
definition:vehicle("car_coupe_luxury_electric", 150)
definition:vehicle("car_coupe_sports_electric", 150)
definition:vehicle("car_super_v12", 100)
definition:vehicle("car_anmlcmpt", 100)
definition:vehicle("suv", 400)
definition:vehicle("rv", 200)
definition:vehicle("van_motorhome", 50)
definition:vehicle("car_hybrid", 200)
definition:vehicle("cube_van_cheap", 200)
definition:vehicle("pickup", 500)
definition:vehicle("hippie_van", 300)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "parkinglotbasic",
}
definition:vehicle("cube_van", 1000)
definition:vehicle("fridge_van", 750)
definition:vehicle("car_mini", 375)
definition:vehicle("beetle", 750)
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_luxury", 200)
definition:vehicle("car_anmlcmpt", 150)
definition:vehicle("electric_car", 250)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 200)
definition:vehicle("car_shootingbrake_v12", 200)
definition:vehicle("car_shootingbrake_electric", 200)
definition:vehicle("car_shootingbrake_long_v8", 200)
definition:vehicle("car_shootingbrake_long_v12", 200)
definition:vehicle("car_shootingbrake_long_electric", 200)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("car_super_v12", 100)
definition:vehicle("car_hybrid", 500)
definition:vehicle("hippie_van", 250)
definition:vehicle("pickup", 25)
definition:vehicle("van_full-size", 400)
definition:vehicle("van_mini", 300)
definition:vehicle("motorcycle", 500)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle_sidecart", 300)
definition:vehicle("underlift_tow_truck", 250)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "golf_carts",
}
definition:vehicle("golf_cart", 100)
definition:vehicle("golf_cart_4seat", 65)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "workshop_vehicles",
}
definition:vehicle("welding_cart", 30)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "crashed_helicopters",
}
definition:vehicle("helicopter_apache_1a", 1)
definition:vehicle("helicopter_apache_1b", 4)
definition:vehicle("helicopter_apache_1c", 2)
definition:vehicle("helicopter_osprey_2a", 1)
definition:vehicle("helicopter_osprey_2b", 4)
definition:vehicle("helicopter_osprey_2c", 2)
definition:vehicle("helicopter_blackhawk_3a", 10)
definition:vehicle("helicopter_blackhawk_3b", 40)
definition:vehicle("helicopter_blackhawk_3c", 20)
definition:vehicle("2seater2_Wreck", 4000)
definition:vehicle("SmallFlier3_Wreck", 4000)
definition:vehicle("Smallflier1_Wreck", 4000)
definition:vehicle("SmallFlier2_Wreck", 4000)
definition:vehicle("Medevac1_Wreck", 400)
definition:vehicle("Medevac2_Wreck", 400)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "crashed_helicopters_small",
}
definition:vehicle("helicopter_apache_1a", 1)
definition:vehicle("helicopter_apache_1b", 4)
definition:vehicle("helicopter_apache_1c", 2)
definition:vehicle("helicopter_blackhawk_3a", 10)
definition:vehicle("helicopter_blackhawk_3b", 40)
definition:vehicle("helicopter_blackhawk_3c", 20)
definition:vehicle("2seater2_Wreck", 4000)
definition:vehicle("SmallFlier3_Wreck", 4000)
definition:vehicle("Smallflier1_Wreck", 4000)
definition:vehicle("SmallFlier2_Wreck", 4000)
definition:vehicle("Medevac1_Wreck", 400)
definition:vehicle("Medevac2_Wreck", 400)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "helicopters",
}
definition:vehicle("2seater2", 100)
definition:vehicle("SmallFlier1", 400)
definition:vehicle("2seater2_Wreck", 200)
definition:vehicle("SmallFlier3_Wreck", 100)
definition:vehicle("SmallFlier2", 400)
definition:vehicle("Medevac1", 10)
definition:vehicle("Smallflier1_Wreck", 200)
definition:vehicle("SmallFlier2_Wreck", 200)
definition:vehicle("Medevac1_Wreck", 10)
definition:vehicle("SmallFlier3", 400)
definition:vehicle("Medevac2", 20)
definition:vehicle("Medevac2_Wreck", 20)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "helicopters_no_wreck",
}
definition:vehicle("2seater2", 100)
definition:vehicle("SmallFlier1", 400)
definition:vehicle("SmallFlier2", 400)
definition:vehicle("Medevac1", 10)
definition:vehicle("SmallFlier3", 400)
definition:vehicle("Medevac2", 20)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "mil_helicopters",
}
definition:vehicle("Medevac1", 200)
definition:vehicle("Medevac2", 200)
definition:vehicle("Medevac1_Wreck", 200)
definition:vehicle("Medevac2_Wreck", 200)
definition:vehicle("helicopter_apache_1a", 2)
definition:vehicle("helicopter_apache_1b", 4)
definition:vehicle("helicopter_apache_1c", 2)
definition:vehicle("helicopter_osprey_2a", 1)
definition:vehicle("helicopter_osprey_2b", 4)
definition:vehicle("helicopter_osprey_2c", 2)
definition:vehicle("helicopter_blackhawk_3a", 10)
definition:vehicle("helicopter_blackhawk_3b", 40)
definition:vehicle("helicopter_blackhawk_3c", 20)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "mil_helicopters_small",
}
definition:vehicle("Medevac1", 200)
definition:vehicle("Medevac2", 200)
definition:vehicle("Medevac1_Wreck", 200)
definition:vehicle("Medevac2_Wreck", 200)
definition:vehicle("helicopter_apache_1a", 2)
definition:vehicle("helicopter_apache_1b", 4)
definition:vehicle("helicopter_apache_1c", 2)
definition:vehicle("helicopter_blackhawk_3a", 10)
definition:vehicle("helicopter_blackhawk_3b", 40)
definition:vehicle("helicopter_blackhawk_3c", 20)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "bikeshop",
}
definition:vehicle("bicycle", 1000)
definition:vehicle("bicycle_electric", 600)
definition:vehicle("bicycle_dirt", 750)
definition:vehicle("unicycle", 50)
definition:vehicle("scooter", 100)
definition:vehicle("scooter_electric", 50)
definition:vehicle("tandem", 300)
definition:vehicle("tricycle", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "back_alley",
}
definition:vehicle("bicycle", 800)
definition:vehicle("autosweeper", 100)
definition:vehicle("bicycle_electric", 600)
definition:vehicle("bicycle_dirt", 750)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 50)
definition:vehicle("scompact_tandem_hboard", 50)
definition:vehicle("scompact_tandem_electric_stow", 50)
definition:vehicle("scompact_tandem_electric_hboard", 50)
definition:vehicle("scompact_tandem_2wheel_stow", 50)
definition:vehicle("scompact_tandem_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_3wheel_stow", 50)
definition:vehicle("scompact_tandem_3wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 50)
definition:vehicle("unicycle", 50)
definition:vehicle("scooter", 100)
definition:vehicle("scooter_electric", 50)
definition:vehicle("tandem", 300)
definition:vehicle("tricycle", 20)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_cross", 150)
definition:vehicle("motorcycle_enduro", 100)
definition:vehicle("superbike", 100)
definition:vehicle("skateboard", 75)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("golf_cart", 10)
definition:vehicle("golf_cart_4seat", 10)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "oa_vg_cs_vehicles",
}
definition:vehicle("electric_car", 100)
definition:vehicle("suv_electric", 70)
definition:vehicle("car_luxury", 40)
definition:vehicle("car_micro", 40)
definition:vehicle("car_micro_hybrid", 40)
definition:vehicle("car_micro_electric", 40)
definition:vehicle("scompact", 40)
definition:vehicle("scompact_hybrid", 40)
definition:vehicle("scompact_electric", 40)
definition:vehicle("scompact_tandem_stow", 40)
definition:vehicle("scompact_tandem_hboard", 40)
definition:vehicle("scompact_tandem_electric_stow", 40)
definition:vehicle("scompact_tandem_electric_hboard", 40)
definition:vehicle("scompact_tandem_2wheel_stow", 40)
definition:vehicle("scompact_tandem_2wheel_hboard", 40)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 40)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 40)
definition:vehicle("scompact_tandem_3wheel_stow", 40)
definition:vehicle("scompact_tandem_3wheel_hboard", 40)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 40)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 40)
definition:vehicle("car_super_v12", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "showroom_small_vehicles",
}
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_cross", 150)
definition:vehicle("motorcycle_enduro", 100)
definition:vehicle("superbike", 100)
definition:vehicle("motorcycle_3wheel", 100)
definition:vehicle("motorcycle_3wheel_super", 100)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 200)
definition:vehicle("scooter_electric", 200)
definition:vehicle("golf_cart", 200)
definition:vehicle("golf_cart_4seat", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "industrial_transport",
}
definition:vehicle("semi_truck", 200)
definition:vehicle("truck_trailer", 200)
definition:vehicle("cube_van", 400)
definition:vehicle("cube_van_cheap", 500)
definition:vehicle("fridge_van", 400)
definition:vehicle("van_cargo", 300)
definition:vehicle("flatbed_truck", 300)
definition:vehicle("tatra_truck", 200)
definition:vehicle("pickup", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "industrial_transport_no_truck",
}
definition:vehicle("cube_van", 400)
definition:vehicle("cube_van_cheap", 500)
definition:vehicle("fridge_van", 400)
definition:vehicle("van_cargo", 300)
definition:vehicle("tatra_truck", 200)
definition:vehicle("pickup", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "oa_vg_cd_vehicles",
}
definition:vehicle("car", 1000)
definition:vehicle("car_diesel", 500)
definition:vehicle("car_hatch", 1000)
definition:vehicle("car_hatch_diesel", 500)
definition:vehicle("car_luxury", 1000)
definition:vehicle("electric_car", 500)
definition:vehicle("car_hybrid", 500)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 100)
definition:vehicle("scompact_hybrid", 100)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 100)
definition:vehicle("car_town_budget", 150)
definition:vehicle("car_town_budget_superior", 100)
definition:vehicle("car_town_diesel_budget", 100)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 200)
definition:vehicle("car_mini", 400)
definition:vehicle("beetle", 500)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 200)
definition:vehicle("scooter_electric", 300)
definition:vehicle("pickup", 800)
definition:vehicle("hippie_van", 200)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "buses",
}
definition:vehicle("bus", 900)
definition:vehicle("bus_rack", 100)
definition:vehicle("schoolbus", 100)
definition:vehicle("bus_tour", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "VETS",
}
definition:vehicle("car", 300)
definition:vehicle("pickup", 100)
definition:vehicle("suv", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "parking_garage",
}
definition:vehicle("4x4_car", 100)
definition:vehicle("4x4_car_diesel", 100)
definition:vehicle("car_sports_electric", 100)
definition:vehicle("car_mini", 375)
definition:vehicle("car_hybrid", 200)
definition:vehicle("beetle", 250)
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_micro", 100)
definition:vehicle("car_micro_hybrid", 100)
definition:vehicle("car_micro_electric", 100)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 50)
definition:vehicle("scompact_electric", 50)
definition:vehicle("scompact_tandem_stow", 50)
definition:vehicle("scompact_tandem_hboard", 50)
definition:vehicle("scompact_tandem_electric_stow", 50)
definition:vehicle("scompact_tandem_electric_hboard", 50)
definition:vehicle("scompact_tandem_2wheel_stow", 50)
definition:vehicle("scompact_tandem_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_3wheel_stow", 50)
definition:vehicle("scompact_tandem_3wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 50)
definition:vehicle("car_shootingbrake_v8", 50)
definition:vehicle("car_shootingbrake_v12", 50)
definition:vehicle("car_shootingbrake_electric", 50)
definition:vehicle("car_shootingbrake_long_v8", 50)
definition:vehicle("car_shootingbrake_long_v12", 50)
definition:vehicle("car_shootingbrake_long_electric", 50)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("car_super_v12", 50)
definition:vehicle("car_hatch", 750)
definition:vehicle("car_hatch_diesel", 400)
definition:vehicle("car_luxury", 175)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 100)
definition:vehicle("suv_electric_rack", 100)
definition:vehicle("pickup", 50)
definition:vehicle("4seat_pickup", 25)
definition:vehicle("extended_pickup", 15)
definition:vehicle("car_anmlcmpt", 150)
definition:vehicle("electric_car", 250)
definition:vehicle("hippie_van", 250)
definition:vehicle("motorcycle", 500)
definition:vehicle("motorcycle_enduro", 50)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle_sidecart", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "parking_garage_short",
}
definition:vehicle("car_sports_electric", 100)
definition:vehicle("car_mini", 375)
definition:vehicle("car_hybrid", 200)
definition:vehicle("beetle", 750)
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 100)
definition:vehicle("scompact_hybrid", 100)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 50)
definition:vehicle("car_shootingbrake_v12", 50)
definition:vehicle("car_shootingbrake_electric", 50)
definition:vehicle("car_shootingbrake_long_v8", 50)
definition:vehicle("car_shootingbrake_long_v12", 50)
definition:vehicle("car_shootingbrake_long_electric", 50)
definition:vehicle("car_sedan", 350)
definition:vehicle("car_sedan_diesel_i4", 150)
definition:vehicle("car_sedan_diesel_v6", 150)
definition:vehicle("car_sedan_v8", 150)
definition:vehicle("car_sedan_sports_v12", 150)
definition:vehicle("car_sedan_sports_v6", 150)
definition:vehicle("car_sedan_luxury_v6", 150)
definition:vehicle("car_sedan_electric", 150)
definition:vehicle("car_sedan_luxury_electric", 150)
definition:vehicle("car_sedan_sports_electric", 150)
definition:vehicle("car_coupe", 250)
definition:vehicle("car_coupe_diesel_i4", 150)
definition:vehicle("car_coupe_diesel_v6", 150)
definition:vehicle("car_coupe_muscle", 150)
definition:vehicle("car_coupe_sports_v12", 150)
definition:vehicle("car_coupe_sports_v6", 150)
definition:vehicle("car_coupe_luxury_v6", 150)
definition:vehicle("car_coupe_electric", 150)
definition:vehicle("car_coupe_luxury_electric", 150)
definition:vehicle("car_coupe_sports_electric", 150)
definition:vehicle("car_super_v12", 50)
definition:vehicle("car_hatch", 350)
definition:vehicle("car_hatch_diesel", 400)
definition:vehicle("car_luxury", 175)
definition:vehicle("car_anmlcmpt", 150)
definition:vehicle("electric_car", 250)
definition:vehicle("motorcycle", 500)
definition:vehicle("motorcycle_enduro", 50)
definition:vehicle("superbike", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("motorcycle_sidecart", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "trains_draisine",
}
definition:vehicle("motorized_draisine_6seats", 500)
definition:vehicle("motorized_draisine_2seats", 2000)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "oa_vg_wreck",
}
definition:vehicle("car", 1000)
definition:vehicle("car_diesel", 500)
definition:vehicle("car_hatch", 500)
definition:vehicle("car_hatch_diesel", 250)
definition:vehicle("car_luxury", 100)
definition:vehicle("electric_car", 500)
definition:vehicle("car_hybrid", 400)
definition:vehicle("car_micro", 100)
definition:vehicle("car_micro_hybrid", 100)
definition:vehicle("car_micro_electric", 100)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 50)
definition:vehicle("scompact_electric", 50)
definition:vehicle("scompact_tandem_stow", 50)
definition:vehicle("scompact_tandem_hboard", 50)
definition:vehicle("scompact_tandem_electric_stow", 50)
definition:vehicle("scompact_tandem_electric_hboard", 50)
definition:vehicle("scompact_tandem_2wheel_stow", 50)
definition:vehicle("scompact_tandem_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_3wheel_stow", 50)
definition:vehicle("scompact_tandem_3wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 50)
definition:vehicle("car_sedan", 300)
definition:vehicle("car_sedan_diesel_i4", 100)
definition:vehicle("car_sedan_diesel_v6", 100)
definition:vehicle("car_sedan_v8", 100)
definition:vehicle("car_sedan_sports_v12", 100)
definition:vehicle("car_sedan_sports_v6", 100)
definition:vehicle("car_sedan_luxury_v6", 100)
definition:vehicle("car_sedan_electric", 100)
definition:vehicle("car_sedan_luxury_electric", 100)
definition:vehicle("car_sedan_sports_electric", 100)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 200)
definition:vehicle("car_town_budget", 200)
definition:vehicle("car_town_budget_superior", 200)
definition:vehicle("car_town_diesel_budget", 200)
definition:vehicle("car_coupe", 200)
definition:vehicle("car_coupe_diesel_i4", 100)
definition:vehicle("car_coupe_diesel_v6", 100)
definition:vehicle("car_coupe_muscle", 100)
definition:vehicle("car_coupe_sports_v12", 100)
definition:vehicle("car_coupe_sports_v6", 100)
definition:vehicle("car_coupe_luxury_v6", 100)
definition:vehicle("car_coupe_electric", 100)
definition:vehicle("car_coupe_luxury_electric", 100)
definition:vehicle("car_coupe_sports_electric", 100)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 200)
definition:vehicle("car_mini", 400)
definition:vehicle("beetle", 500)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 200)
definition:vehicle("scooter_electric", 300)
definition:vehicle("pickup", 800)
definition:vehicle("hippie_van", 200)
definition:vehicle("schoolbus", 800)
definition:vehicle("lux_rv", 800)
definition:vehicle("meth_lab", 800)
definition:vehicle("road_roller", 800)
definition:vehicle("truck_trailer", 800)
definition:vehicle("semi_truck", 800)
definition:vehicle("flatbed_truck", 800)
definition:vehicle("semi_truck", 800)
definition:vehicle("military_cargo_truck", 800)
definition:vehicle("military_cargo_truck_b", 800)
definition:vehicle("humvee_gl", 800)
definition:vehicle("humvee", 800)
definition:vehicle("security_van", 800)
definition:vehicle("tractor_seed", 800)
definition:vehicle("tractor_reaper", 800)
definition:vehicle("tractor_plow", 800)
definition:vehicle("cube_van", 800)
definition:vehicle("fridge_van", 800)
definition:vehicle("car_mini", 800)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "oa_vg_ts_vehicles",
}
definition:vehicle("car", 2000)
definition:vehicle("car_diesel", 1000)
definition:vehicle("car_luxury", 200)
definition:vehicle("car_hatch", 1000)
definition:vehicle("car_hatch_diesel", 500)
definition:vehicle("electric_car", 500)
definition:vehicle("car_hybrid", 400)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 200)
definition:vehicle("car_mini", 400)
definition:vehicle("beetle", 500)
definition:vehicle("motorcycle", 200)
definition:vehicle("motorcycle_cross", 50)
definition:vehicle("motorcycle_enduro", 50)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 200)
definition:vehicle("scooter_electric", 300)
definition:vehicle("pickup", 800)
definition:vehicle("hippie_van", 1000)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "sugar_house_vehicles",
}
definition:vehicle("water_cart", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "pump_station_vehicles",
}
definition:vehicle("car", 750)
definition:vehicle("car_diesel", 350)
definition:vehicle("car_luxury", 150)
definition:vehicle("car_hatch", 1000)
definition:vehicle("car_hatch_diesel", 500)
definition:vehicle("electric_car", 175)
definition:vehicle("car_micro", 100)
definition:vehicle("car_micro_hybrid", 100)
definition:vehicle("car_micro_electric", 100)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 50)
definition:vehicle("scompact_electric", 50)
definition:vehicle("scompact_tandem_stow", 50)
definition:vehicle("scompact_tandem_hboard", 50)
definition:vehicle("scompact_tandem_electric_stow", 50)
definition:vehicle("scompact_tandem_electric_hboard", 50)
definition:vehicle("scompact_tandem_2wheel_stow", 50)
definition:vehicle("scompact_tandem_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 50)
definition:vehicle("scompact_tandem_3wheel_stow", 50)
definition:vehicle("scompact_tandem_3wheel_hboard", 50)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 50)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 50)
definition:vehicle("car_sedan", 350)
definition:vehicle("car_sedan_diesel_i4", 150)
definition:vehicle("car_sedan_diesel_v6", 150)
definition:vehicle("car_sedan_v8", 150)
definition:vehicle("car_sedan_sports_v12", 150)
definition:vehicle("car_sedan_sports_v6", 150)
definition:vehicle("car_sedan_luxury_v6", 150)
definition:vehicle("car_sedan_electric", 150)
definition:vehicle("car_sedan_luxury_electric", 150)
definition:vehicle("car_sedan_sports_electric", 150)
definition:vehicle("car_town", 200)
definition:vehicle("car_town_diesel", 200)
definition:vehicle("car_town_budget", 200)
definition:vehicle("car_town_budget_superior", 200)
definition:vehicle("car_town_diesel_budget", 200)
definition:vehicle("car_coupe", 250)
definition:vehicle("car_coupe_diesel_i4", 150)
definition:vehicle("car_coupe_diesel_v6", 150)
definition:vehicle("car_coupe_muscle", 150)
definition:vehicle("car_coupe_sports_v12", 150)
definition:vehicle("car_coupe_sports_v6", 150)
definition:vehicle("car_coupe_luxury_v6", 150)
definition:vehicle("car_coupe_electric", 150)
definition:vehicle("car_coupe_luxury_electric", 150)
definition:vehicle("car_coupe_sports_electric", 150)
definition:vehicle("car_hybrid", 150)
definition:vehicle("car_mini", 250)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 200)
definition:vehicle("suv_electric", 50)
definition:vehicle("flatbed_truck", 800)
definition:vehicle("cube_van_cheap", 800)
definition:vehicle("cube_van", 600)
definition:vehicle("fridge_van", 600)
definition:vehicle("pickup", 1000)
definition:vehicle("policecar", 400)
definition:vehicle("ambulance", 300)
definition:vehicle("fire_truck", 150)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "dealership",
}
definition:vehicle("car", 500)
definition:vehicle("car_diesel", 250)
definition:vehicle("car_luxury", 500)
definition:vehicle("electric_car", 100)
definition:vehicle("car_hybrid", 100)
definition:vehicle("car_micro", 200)
definition:vehicle("car_micro_hybrid", 200)
definition:vehicle("car_micro_electric", 200)
definition:vehicle("scompact", 100)
definition:vehicle("scompact_hybrid", 100)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 100)
definition:vehicle("scompact_tandem_hboard", 100)
definition:vehicle("scompact_tandem_electric_stow", 100)
definition:vehicle("scompact_tandem_electric_hboard", 100)
definition:vehicle("scompact_tandem_2wheel_stow", 100)
definition:vehicle("scompact_tandem_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 100)
definition:vehicle("scompact_tandem_3wheel_stow", 100)
definition:vehicle("scompact_tandem_3wheel_hboard", 100)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 100)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 100)
definition:vehicle("car_shootingbrake_v8", 50)
definition:vehicle("car_shootingbrake_v12", 50)
definition:vehicle("car_shootingbrake_electric", 50)
definition:vehicle("car_shootingbrake_long_v8", 50)
definition:vehicle("car_shootingbrake_long_v12", 50)
definition:vehicle("car_shootingbrake_long_electric", 50)
definition:vehicle("car_sedan", 350)
definition:vehicle("car_sedan_diesel_i4", 150)
definition:vehicle("car_sedan_diesel_v6", 150)
definition:vehicle("car_sedan_v8", 150)
definition:vehicle("car_sedan_sports_v12", 150)
definition:vehicle("car_sedan_sports_v6", 150)
definition:vehicle("car_sedan_luxury_v6", 150)
definition:vehicle("car_sedan_electric", 150)
definition:vehicle("car_sedan_luxury_electric", 150)
definition:vehicle("car_sedan_sports_electric", 150)
definition:vehicle("car_town", 250)
definition:vehicle("car_town_diesel", 250)
definition:vehicle("car_town_budget", 250)
definition:vehicle("car_town_budget_superior", 250)
definition:vehicle("car_town_diesel_budget", 250)
definition:vehicle("car_coupe", 150)
definition:vehicle("car_coupe_diesel_i4", 50)
definition:vehicle("car_coupe_diesel_v6", 50)
definition:vehicle("car_coupe_muscle", 50)
definition:vehicle("car_coupe_sports_v12", 50)
definition:vehicle("car_coupe_sports_v6", 50)
definition:vehicle("car_coupe_luxury_v6", 50)
definition:vehicle("car_coupe_electric", 50)
definition:vehicle("car_coupe_luxury_electric", 50)
definition:vehicle("car_coupe_sports_electric", 50)
definition:vehicle("car_super_v12", 400)
definition:vehicle("suv", 500)
definition:vehicle("suv_electric", 500)
definition:vehicle("car_mini", 500)
definition:vehicle("beetle", 200)
definition:vehicle("motorcycle", 200)
definition:vehicle("superbike", 200)
definition:vehicle("motorcycle_3wheel", 150)
definition:vehicle("motorcycle_3wheel_super", 150)
definition:vehicle("motorcycle_sidecart", 100)
definition:vehicle("scooter", 100)
definition:vehicle("scooter_electric", 150)
definition:vehicle("pickup", 800)
definition:vehicle("4seat_pickup", 125)
definition:vehicle("extended_pickup", 85)
definition:vehicle("hippie_van", 200)
definition:vehicle("van_full-size", 100)
definition:vehicle("van_full-size_hybrid", 50)
definition:vehicle("van_mini", 200)
definition:vehicle("van_mini_hybrid", 50)
definition:vehicle("rv", 50)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "park_playground_vehicles",
}
definition:vehicle("ice_cream_cart", 100)
definition:vehicle("food_cart", 200)
definition:vehicle("bicycle", 150)
definition:vehicle("bicycle_dirt", 125)
definition:vehicle("tricycle", 5)
definition:vehicle("skateboard", 25)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "food_carts",
}
definition:vehicle("ice_cream_cart", 100)
definition:vehicle("food_cart", 200)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "wagons_all",
}
definition:vehicle("gig_carriage", 100)
definition:vehicle("stagecoach", 100)
definition:vehicle("covered_wagon", 100)
definition:vehicle("uncovered_wagon", 100)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "prison_vehicles",
}
definition:vehicle("policecar", 15)
definition:vehicle("policesuv", 15)
definition:vehicle("truck_swat", 5)
definition:vehicle("bus_prison", 25)
definition:vehicle("ambulance", 10)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "cars_only",
}
definition:vehicle("4x4_car", 100)
definition:vehicle("4x4_car_diesel", 100)
definition:vehicle("car_sports_electric", 100)
definition:vehicle("car_mini", 375)
definition:vehicle("car_hybrid", 200)
definition:vehicle("beetle", 750)
definition:vehicle("car", 1500)
definition:vehicle("car_diesel", 750)
definition:vehicle("car_hatch", 750)
definition:vehicle("car_hatch_diesel", 400)
definition:vehicle("car_hatch_rack", 200)
definition:vehicle("car_luxury", 500)
definition:vehicle("suv", 800)
definition:vehicle("suv_electric", 100)
definition:vehicle("suv_electric_rack", 100)
definition:vehicle("car_anmlcmpt", 150)
definition:vehicle("electric_car", 750)
definition:vehicle("hippie_van", 250)
definition:vehicle("car_sports", 30)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "small_cars_only",
}
definition:vehicle("car_sports_electric", 50)
definition:vehicle("car_mini", 375)
definition:vehicle("beetle", 250)
definition:vehicle("car_hatch", 350)
definition:vehicle("car_hatch_diesel", 150)
definition:vehicle("car_hatch_rack", 100)
definition:vehicle("car_sports", 50)
definition:vehicle("motorcycle_3wheel", 50)
definition:vehicle("motorcycle_3wheel_super", 50)
definition:vehicle("car_micro", 300)
definition:vehicle("car_micro_hybrid", 300)
definition:vehicle("car_micro_electric", 300)
definition:vehicle("scompact", 50)
definition:vehicle("scompact_hybrid", 150)
definition:vehicle("scompact_electric", 100)
definition:vehicle("scompact_tandem_stow", 150)
definition:vehicle("scompact_tandem_hboard", 150)
definition:vehicle("scompact_tandem_electric_stow", 150)
definition:vehicle("scompact_tandem_electric_hboard", 150)
definition:vehicle("scompact_tandem_2wheel_stow", 150)
definition:vehicle("scompact_tandem_2wheel_hboard", 150)
definition:vehicle("scompact_tandem_electric_2wheel_stow", 150)
definition:vehicle("scompact_tandem_electric_2wheel_hboard", 150)
definition:vehicle("scompact_tandem_3wheel_stow", 150)
definition:vehicle("scompact_tandem_3wheel_hboard", 150)
definition:vehicle("scompact_tandem_electric_3wheel_stow", 150)
definition:vehicle("scompact_tandem_electric_3wheel_hboard", 150)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "personal_aircraft_small",
}
definition:vehicle("aircanoe", 60)
definition:vehicle("airboat", 40)
content.replace(definition)
end
do
local definition = content.VehicleGroup {
    id = "personal_aircraft_large",
}
definition:vehicle("airship", 100)
content.replace(definition)
end

-- Native composable start locations
do
local definition = content.StartLocation {
    id = "sloc_fort",
    name = "Bastion Fort",
}
definition:terrain("fort", {
    match = "prefix",
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_shelter_safe",
    name = "Evacuation Shelter",
}
definition:terrain("shelter", {
    match = "type",
    parameters = {
        ["shelter_palette"] = "shelter_basic",
    },
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_shelter_vandal",
    name = "Vandalized Evacuation Shelter",
}
definition:terrain("shelter", {
    match = "type",
    parameters = {
        ["shelter_palette"] = "shelter_vandal",
    },
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_shelter_under_infested",
    name = "Infested Evacuation Shelter Basement",
}
definition:terrain("shelter_under", {
    match = "type",
    parameters = {
        ["shelter_palette"] = "shelter_infested_scenario",
    },
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_town_hall",
    name = "Town Hall",
}
definition:terrain("town_hall_0_0_0")
definition:terrain("town_hall_1_0_0")
definition:terrain("town_hall_0_1_0")
definition:terrain("town_hall_1_1_0")
definition:terrain("town_hall_0_0_1")
definition:terrain("town_hall_1_0_1")
definition:terrain("town_hall_0_1_1")
definition:terrain("town_hall_1_1_1")
definition:terrain("town_hall_0_0_roof")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_refugee_center",
    name = "Refugee Center",
}
definition:terrain("evac_center_18")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_exodii_castle",
    name = "Exodii castle",
}
definition:terrain("exodii_base_x0y3z0")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_house_boarded",
    name = "House (boarded up)",
}
definition:terrain("house_w_1")
definition:terrain("house_2story_basement")
definition:terrain("house_crack1")
definition:terrain("house_crack2")
definition:terrain("house_crack3")
definition:terrain("house_wooded")
definition:terrain("house_prepper")
definition:terrain("house_prepper2")
definition:terrain("house_fortified")
definition:terrain("duplex")
definition:terrain("house_duplex2")
definition:terrain("house_duplex3")
definition:terrain("house_duplex4")
definition:terrain("house_duplex5")
definition:terrain("house_duplex6")
definition:terrain("house_duplex7")
definition:terrain("house_duplex8")
definition:terrain("house_duplex9")
definition:terrain("house_duplex10")
definition:terrain("house_duplex11")
definition:terrain("house_w_2")
definition:terrain("house_w_3")
definition:terrain("house_w_4")
definition:terrain("house_w_5")
definition:terrain("house_w_6")
definition:terrain("house_01")
definition:terrain("house_02")
definition:terrain("house_03")
definition:terrain("house_04")
definition:terrain("house_05")
definition:terrain("house_06")
definition:terrain("house_07")
definition:terrain("house_08")
definition:terrain("house_09")
definition:terrain("house_10")
definition:terrain("house_11")
definition:terrain("house_12")
definition:terrain("house_13")
definition:terrain("house_14")
definition:terrain("house_15")
definition:terrain("house_16")
definition:terrain("house_17")
definition:terrain("house_18")
definition:terrain("house_19")
definition:terrain("house_20")
definition:terrain("house_21")
definition:terrain("house_22")
definition:terrain("house_23")
definition:terrain("house_24")
definition:terrain("house_25")
definition:terrain("house_26")
definition:terrain("house_27")
definition:terrain("house_28")
definition:terrain("house_29")
definition:terrain("house_30")
definition:terrain("house_31")
definition:terrain("house_32")
definition:terrain("house_garage")
definition:terrain("house_garage2")
definition:terrain("house_garage3")
definition:terrain("house_garage4")
definition:terrain("house_garage5")
definition:terrain("house_garage6")
definition:terrain("house_garage7")
definition:terrain("house_garage8")
definition:terrain("rural_house1")
definition:terrain("rural_house2")
definition:terrain("house_toolshed")
definition:terrain("house_suicide")
definition:terrain("house_quiverfull")
definition:terrain("house_rv")
definition:terrain("house_porch")
definition:terrain("house_patio")
definition:terrain("house_modern_1")
definition:terrain("house_library")
definition:terrain("house_detatched1")
definition:terrain("house_detatched2")
definition:terrain("house_detatched3")
definition:terrain("house_detatched4")
definition:terrain("house_detatched5")
definition:terrain("house_detatched6")
definition:terrain("house_detatched7")
definition:terrain("house_detatched8")
definition:terrain("house_detatched9")
definition:terrain("house_detatched10")
definition:terrain("house_dogs")
definition:terrain("house_gardener")
definition:terrain("house_inner_garden")
definition:terrain("house_vacant")
definition:terrain("house_vacant2")
definition:flag("BOARDED")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_field",
    name = "Field",
}
definition:terrain("field")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_ocean_shore",
    name = "Beach",
}
definition:terrain("ocean_shore")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_house",
    name = "House",
}
definition:terrain("house_w_1")
definition:terrain("house_2story_basement")
definition:terrain("house_crack1")
definition:terrain("house_crack2")
definition:terrain("house_crack3")
definition:terrain("house_wooded")
definition:terrain("house_prepper")
definition:terrain("house_prepper2")
definition:terrain("house_fortified")
definition:terrain("duplex")
definition:terrain("house_duplex2")
definition:terrain("house_duplex3")
definition:terrain("house_duplex4")
definition:terrain("house_duplex5")
definition:terrain("house_duplex6")
definition:terrain("house_duplex7")
definition:terrain("house_duplex8")
definition:terrain("house_duplex9")
definition:terrain("house_duplex10")
definition:terrain("house_duplex11")
definition:terrain("house_w_2")
definition:terrain("house_w_3")
definition:terrain("house_w_4")
definition:terrain("house_w_5")
definition:terrain("house_w_6")
definition:terrain("house_01")
definition:terrain("house_02")
definition:terrain("house_03")
definition:terrain("house_04")
definition:terrain("house_05")
definition:terrain("house_06")
definition:terrain("house_07")
definition:terrain("house_08")
definition:terrain("house_09")
definition:terrain("house_10")
definition:terrain("house_11")
definition:terrain("house_12")
definition:terrain("house_13")
definition:terrain("house_14")
definition:terrain("house_15")
definition:terrain("house_16")
definition:terrain("house_17")
definition:terrain("house_18")
definition:terrain("house_19")
definition:terrain("house_20")
definition:terrain("house_21")
definition:terrain("house_22")
definition:terrain("house_23")
definition:terrain("house_24")
definition:terrain("house_25")
definition:terrain("house_26")
definition:terrain("house_27")
definition:terrain("house_28")
definition:terrain("house_29")
definition:terrain("house_30")
definition:terrain("house_31")
definition:terrain("house_32")
definition:terrain("house_garage")
definition:terrain("house_garage2")
definition:terrain("house_garage3")
definition:terrain("house_garage4")
definition:terrain("house_garage5")
definition:terrain("house_garage6")
definition:terrain("house_garage7")
definition:terrain("house_garage8")
definition:terrain("rural_house1")
definition:terrain("rural_house2")
definition:terrain("house_toolshed")
definition:terrain("house_suicide")
definition:terrain("house_quiverfull")
definition:terrain("house_rv")
definition:terrain("house_porch")
definition:terrain("house_patio")
definition:terrain("house_modern_1")
definition:terrain("house_library")
definition:terrain("house_detatched1")
definition:terrain("house_detatched2")
definition:terrain("house_detatched3")
definition:terrain("house_detatched4")
definition:terrain("house_detatched5")
definition:terrain("house_detatched6")
definition:terrain("house_detatched7")
definition:terrain("house_detatched8")
definition:terrain("house_detatched9")
definition:terrain("house_detatched10")
definition:terrain("house_dogs")
definition:terrain("house_gardener")
definition:terrain("house_inner_garden")
definition:terrain("house_vacant")
definition:terrain("house_vacant2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_grocery_store",
    name = "Grocery Store",
}
definition:terrain("s_grocery")
definition:terrain("s_grocery_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_gun_store",
    name = "Gun Store",
}
definition:terrain("s_gun_a")
definition:terrain("s_gun_b_store")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_garage",
    name = "Garage",
}
definition:terrain("s_garage")
definition:terrain("s_garage_1")
definition:terrain("s_garage_2")
definition:terrain("garage_gas_1")
definition:terrain("garage_gas_2")
definition:terrain("garage_gas_3")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_pawn_shop",
    name = "Pawn Shop",
}
definition:terrain("pawn")
definition:terrain("pawn_1")
definition:terrain("pawn_pf")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_bank",
    name = "Bank",
}
definition:terrain("bank")
definition:terrain("bank_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_pharm",
    name = "Pharmacy",
}
definition:terrain("s_pharm")
definition:terrain("s_pharm_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_hardware",
    name = "Hardware Store",
}
definition:terrain("s_hardware")
definition:terrain("s_hardware_1")
definition:terrain("s_hardware_2")
definition:terrain("s_hardware_3")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_dojo",
    name = "Dojo",
}
definition:terrain("dojo")
definition:terrain("dojo_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_gym",
    name = "Gym",
}
definition:terrain("gym")
definition:terrain("gym_fitness")
definition:terrain("gym_fitness_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_clothes",
    name = "Clothing Store",
}
definition:terrain("s_clothes")
definition:terrain("s_clothes_1")
definition:terrain("s_clothes_2")
definition:terrain("s_clothes_3")
definition:terrain("s_clothes_4")
definition:terrain("s_clothes_5")
definition:terrain("s_clothes_6")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_restaurant",
    name = "Restaurant",
}
definition:terrain("s_restaurant")
definition:terrain("s_restaurant_1")
definition:terrain("s_restaurant_2")
definition:terrain("s_restaurant_3")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_bar",
    name = "Bar",
}
definition:terrain("bar")
definition:terrain("bar_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_electronics",
    name = "Electronics Store",
}
definition:terrain("s_electronics")
definition:terrain("s_electronics_1")
definition:terrain("s_electronicstore")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_arcade",
    name = "Arcade",
}
definition:terrain("s_arcade")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_animalshelter",
    name = "Animal Shelter",
}
definition:terrain("animalshelter")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_laundromat",
    name = "Laundromat",
}
definition:terrain("s_laundromat")
definition:terrain("s_laundromat_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_stripclub",
    name = "Strip Club",
}
definition:terrain("stripclub")
definition:terrain("stripclub_1")
definition:terrain("stripclub_2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_sexshop",
    name = "Sex Shop",
}
definition:terrain("cs_sex_shop")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_candyshop",
    name = "Candy Shop",
}
definition:terrain("candy_shop")
definition:terrain("candy_shop_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_bikeshop",
    name = "Bike Shop",
}
definition:terrain("s_bike_shop")
definition:terrain("s_bike_shop_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_petstore",
    name = "Pet Store",
}
definition:terrain("s_petstore")
definition:terrain("s_petstore_1")
definition:terrain("s_petstore_2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_military_surplus",
    name = "Military Surplus",
}
definition:terrain("mil_surplus")
definition:terrain("mil_surplus_1")
definition:terrain("mil_surplus_2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_furniture_store",
    name = "Furniture Store",
}
definition:terrain("furniture")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_library",
    name = "Library",
}
definition:terrain("s_library")
definition:terrain("s_library_1")
definition:terrain("s_library_2")
definition:terrain("s_library_3")
definition:terrain("urban_library", {
    match = "prefix",
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_bookstore",
    name = "Bookstore",
}
definition:terrain("s_bookstore")
definition:terrain("s_bookstore_1")
definition:terrain("s_bookstore_2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_cabin",
    name = "Cabin",
}
definition:terrain("cabin_3")
definition:terrain("cabin_4")
definition:terrain("cabin_5")
definition:terrain("cabin_6")
definition:terrain("cabin_7")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_liam_cabin",
    name = "Liam's Cabin",
}
definition:terrain("cabin_liam")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_hospital",
    name = "Hospital",
}
definition:terrain("hospital_5")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lmoe",
    name = "LMOE shelter (surface)",
}
definition:terrain("lmoe")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lmoe_under",
    name = "LMOE shelter (underground)",
}
definition:terrain("lmoe_under")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_forest",
    name = "Middle of Nowhere",
}
definition:terrain("forest")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_river",
    name = "River",
}
definition:terrain("river")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_bridge",
    name = "Bridge",
}
definition:terrain("bridgehead_ground")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_desert_island",
    name = "Desert Island",
}
definition:terrain("island_sand")
definition:terrain("island_forest")
definition:terrain("island_forest_thick")
definition:terrain("island_forest_water")
definition:terrain("island_field")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lab_concourse_area",
    name = "Cargo area Trans-Coast Logistics",
}
definition:terrain("lab_CORE_2x1_1DN")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lab_medical",
    name = "Medical area Trans-Coast Logistics",
}
definition:terrain("lab_health_z-3_B")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_mall_loading_area",
    name = "Mall (loading area)",
}
definition:terrain("mall_a_12")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_mall_food_court",
    name = "Mall (food court)",
}
definition:terrain("mall_a_30")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_fire_station",
    name = "Fire Station",
}
definition:terrain("fire_station")
definition:terrain("fire_station_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_police",
    name = "Police Station",
}
definition:terrain("police")
definition:terrain("police_1")
definition:terrain("police_2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_restaraunt_foodplace_break_room",
    name = "Foodplace Break Room",
}
definition:terrain("s_restaurant_foodplace_roof")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_school",
    name = "School",
}
definition:terrain("school_1", {
    match = "prefix",
})
definition:terrain("school_2", {
    match = "prefix",
})
definition:terrain("school_3", {
    match = "prefix",
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_school_rooftop",
    name = "School Rooftop",
}
definition:terrain("school_4_6")
definition:terrain("school_4_5")
definition:terrain("school_4_4")
definition:terrain("school_4_9")
definition:terrain("school_4_8")
definition:terrain("school_4_7")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_mine_finale",
    name = "Bottom of a mine",
}
definition:terrain("mine_finale")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_prison",
    name = "Prison",
}
definition:terrain("prison_1_5")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_prison_alcatraz",
    name = "Island prison type A",
}
definition:terrain("prison_alcatraz_3")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_prison_island",
    name = "Island prison type B",
}
definition:terrain("prison_island_1_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_mi-go_camp",
    name = "Mi-go camp",
}
definition:terrain("mi-go_camp1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_hermit_shack",
    name = "Hermit Shack",
}
definition:terrain("hunter_shack")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_campsite",
    name = "Campsite",
}
definition:terrain("campsite", {
    match = "contains",
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_campground",
    name = "Campground",
}
definition:terrain("campground_1a")
definition:terrain("campground_1b")
definition:terrain("campground_2a")
definition:terrain("campground_2b")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_farm_survivalist",
    name = "Farm",
}
definition:terrain("farm_2")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_church",
    name = "Church",
}
definition:terrain("church_3rdfloor_1")
definition:terrain("church_1")
definition:terrain("church_steeple_end")
definition:terrain("church")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_cemetery",
    name = "Cemetery",
}
definition:terrain("cemetery_4square", {
    match = "prefix",
})
definition:terrain("Cemetery", {
    match = "prefix",
})
definition:terrain("cemetery_small", {
    match = "prefix",
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_zoo_cafeteria",
    name = "Zoo (Cafeteria)",
}
definition:terrain("zoo_0_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_golfcourse_mid_course",
    name = "Golf Course (mid course)",
}
definition:terrain("golfcourse_11")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_golfcourse_clubhouse",
    name = "Golf Course (clubhouse)",
}
definition:terrain("golfcourse_31")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_apartments_rooftop",
    name = "Apartment Building (rooftop)",
}
definition:terrain("apartments_con_tower_114")
definition:terrain("apartments_con_tower_014")
definition:terrain("apartments_con_tower_104")
definition:terrain("apartments_con_tower_004")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_apartments_rooftop2",
    name = "Apartment Building Alternate (rooftop)",
}
definition:terrain("apartments_mod_tower_113")
definition:terrain("apartments_mod_tower_013")
definition:terrain("apartments_mod_tower_103")
definition:terrain("apartments_mod_tower_003")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_apartment_complex_roof",
    name = "Apartment Complex (rooftop)",
}
definition:terrain("apartment_complex_corner_roof")
definition:terrain("apartment_complex_corner_inner_roof")
definition:terrain("apartment_complex_straight_roof")
definition:terrain("apartment_complex_straight_stairs_even_roof")
definition:terrain("apartment_complex_straight_stairs_odd_roof")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_convention_center_rooftop",
    name = "Convention Center Rooftop",
}
definition:terrain("convention_0_0_2")
definition:terrain("convention_1_0_2")
definition:terrain("convention_2_0_2")
definition:terrain("convention_3_0_2")
definition:terrain("convention_4_0_2")
definition:terrain("convention_0_1_2")
definition:terrain("convention_1_1_2")
definition:terrain("convention_2_1_2")
definition:terrain("convention_3_1_2")
definition:terrain("convention_4_1_2")
definition:terrain("convention_0_2_2")
definition:terrain("convention_1_2_2")
definition:terrain("convention_2_2_2")
definition:terrain("convention_3_2_2")
definition:terrain("convention_4_2_2")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_horse_ranch",
    name = "Horse Ranch",
}
definition:terrain("farm_horse_stable_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_cabin_lake",
    name = "Lake Cabin",
}
definition:terrain("cabin_lake")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_freshwater_research_station",
    name = "Freshwater Research Station",
}
definition:terrain("sealab_small_surface")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lodge_ground",
    name = "Hunting Lodge",
}
definition:terrain("lodge_ground1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_gas_station",
    name = "Gas Station",
}
definition:terrain("s_gas_rural")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lighthouse_ground",
    name = "Lighthouse Island",
}
definition:terrain("lighthouse_ground")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_lighthouse_small_ground",
    name = "Small lighthouse island",
}
definition:terrain("lighthouse_small_ground")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_military_base_warehouse",
    name = "Military Base Warehouse",
}
definition:terrain("mil_base_2g")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "aircraft_carrier_berth",
    name = "Aircraft Carrier Berth",
}
definition:terrain("aircraft_carrier_1b")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "aircraft_carrier_bridge",
    name = "Aircraft Carrier Captain's Bridge",
}
definition:terrain("aircraft_carrier_1b")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_private_resort",
    name = "Private resort",
}
definition:terrain("p_resort_2ss")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_road",
    name = "Road",
}
definition:terrain("road")
definition:city_distance(10, 2147483647)
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_light_industry_scen",
    name = "Industrial Offices",
}
definition:terrain("s_lightindustry_10", {
    match = "type",
    parameters = {
        ["safe"] = "true",
    },
})
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_mansion_basement",
    name = "Normal Mansion Basement (Random)",
}
definition:terrain("mansion_t2d")
definition:terrain("mansion_t6d")
definition:terrain("mansion_+2d")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_enclosed_mansion_panic_room",
    name = "Enclosed Mansion Panic Room",
}
definition:terrain("mansion_boarded_t2_start")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_enclosed_mansion_sex_lair",
    name = "Enclosed Mansion Sex Lair",
}
definition:terrain("mansion_boarded_t2d_start")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_hotel_rooftop",
    name = "Hotel Rooftop",
}
definition:terrain("hotel_tower_roof_1_9")
definition:terrain("hotel_tower_roof_1_8")
definition:terrain("hotel_tower_roof_1_7")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_office_tower_rooftop",
    name = "Office Tower Rooftop",
}
definition:terrain("loffice_tower_13")
definition:terrain("loffice_tower_14")
definition:terrain("loffice_tower_15")
definition:terrain("loffice_tower_16")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_office_tower_2_rooftop",
    name = "Office Tower 2 Rooftop",
}
definition:terrain("office_tower_2_a1_roof")
definition:terrain("office_tower_2_a2_roof")
definition:terrain("office_tower_2_b1_roof")
definition:terrain("office_tower_2_b2_roof")
definition:terrain("office_tower_2_b3_roof")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_cathedral_rooftop",
    name = "Cathedral Rooftop",
}
definition:terrain("cathedral_3_NW")
definition:terrain("cathedral_3_NE")
definition:terrain("cathedral_3_SW")
definition:terrain("cathedral_3_SE")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_retirement_community",
    name = "Retirement Community - Townhouse",
}
definition:terrain("retirement_community_b_5")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "nuclear_plant",
    name = "Nuclear Power Plant",
}
definition:terrain("nuclear_plant_5_5_1")
definition:terrain("nuclear_plant_10_5_1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_motel",
    name = "Motel",
}
definition:terrain("motel_twd_1_f1")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_mobile_home",
    name = "Mobile Home",
}
definition:terrain("trailer_hub_00")
definition:terrain("trailer_hub_11")
definition:terrain("trailer_caravan_00")
definition:terrain("trailer_public_00")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_stadium",
    name = "Stadium",
}
definition:terrain("stadium_football_1_1")
definition:terrain("stadium_football_2_1")
definition:terrain("stadium_football_3_1")
definition:terrain("stadium_football_4_1")
definition:terrain("stadium_football_5_1")
definition:terrain("stadium_football_6_1")
definition:terrain("stadium_football_7_1")
definition:terrain("stadium_football_1_2")
definition:terrain("stadium_football_7_2")
definition:terrain("stadium_football_1_3")
definition:terrain("stadium_football_7_3")
definition:terrain("stadium_football_1_4")
definition:terrain("stadium_football_7_4")
definition:terrain("stadium_football_1_5")
definition:terrain("stadium_football_2_5")
definition:terrain("stadium_football_3_5")
definition:terrain("stadium_football_4_5")
definition:terrain("stadium_football_6_5")
definition:terrain("stadium_football_7_5")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_middle_of_nowhere",
    name = "Middle of Nowhere",
}
definition:terrain("state_park_1_0")
definition:terrain("sewage_treatment_1_0_0")
definition:terrain("pwr_sub_s")
definition:terrain("derelict_property")
definition:terrain("ws_regional_dump_2_0")
definition:terrain("waiting_area")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_sewer",
    name = "Sewer",
}
definition:terrain("sewer")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_nesw_manhole",
    name = "Intersection",
}
definition:terrain("road_nesw_manhole", {
    match = "prefix",
})
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end
do
local definition = content.StartLocation {
    id = "sloc_town_in_the_open",
    name = "Town, in the open",
}
definition:terrain("road_nesw_manhole", {
    match = "prefix",
})
definition:terrain("playground")
definition:terrain("park")
definition:flag("ALLOW_OUTSIDE")
content.replace(definition)
end

-- Native speaker-labelled speech pools
do
local definition = content.SpeechPool {
    id = "creepy_doll",
}
definition:line("\"You shouldn't have done that.\"", 10)
definition:line("\"Let's play… Russian roulette.\"", 10)
definition:line("\"I hate you.\"", 10)
definition:line("\"Go kill yourself!\"", 10)
definition:line("\"Big Brother is watching you…\"", 10)
definition:line("\"Die for me!\"", 10)
definition:line("\"Why won't you die?\"", 10)
definition:line("\"Blood… delicious.\"", 10)
definition:line("\"See you… IN HELL!\"", 10)
definition:line("AAAIEEEEEEE!", 10)
definition:line("\"FUCK YOU!\"", 10)
definition:line("\"What did you do with my Mommy?\"", 10)
definition:line("\"Stay with me… forever!\"", 10)
definition:line("\"Hey kids.  Want some candy?\"", 10)
definition:line("\"Down here, they ALL float!\"", 10)
definition:line("\"Do you really need that much honey?\"", 10)
definition:line("\"My previous owner squealed like a pig when I gutted her!\"", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "foodperson_mask",
}
definition:line("\"I AM FOODPERSON.  AND I BRING SUSTENANCE!\"", 17)
definition:line("\"Come to Foodplace today and buy food!\"", 15)
definition:line("\"Foodplace: The best restaurant in an area!\"", 15)
definition:line("\"Our food contains up to 95% real food.\"", 15)
definition:line("\"At Foodplace your excellent value brings nourishment and delight.\"", 15)
definition:line("\"At Foodplace we have a host of solutions for your food needs!\"", 15)
definition:line("\"♪Eat at Foodplace.  ♫It is a place with food.♪\"", 15)
definition:line("\"Foodplace is a popular food chain selling food items.  What else is there to know?\"", 15)
definition:line("\"You need food, don't you?  Then come with me to FOODPLACE!!\"", 15)
definition:line("\"You need food, don't you?  It's time for Foodplace!\"", 15)
definition:line("\"Foodplace: It's the Calories.\"", 15)
definition:line("\"Foodplace: Don't get caught in the web of an unsafe diet.\"", 15)
definition:line("\"Foodplace: Edible food is OUR guarantee!\"", 15)
definition:line("\"Foodplace: We bring food to life!\"", 15)
definition:line("\"Foodplace: Edible food is one of our main goals!\"", 15)
definition:line("\"Foodplace is the only way to obtain healthy and strong lifecycle choices!!\"", 15)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_beekeeper",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_boomer",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_boomer_claymore",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_boomer_glutton",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_boomer_huge",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_broken_cyborg",
}
definition:line("\"WHY!  WHY, WHYYY!\"", 32)
definition:line("an electronic voice saying \"CONNECTION FAILED.  Abort, Retry, Fail?\"", 20)
definition:line("\"I was once a man.  A MAN!\"", 32)
definition:line("\"What have I become?\"", 10)
definition:line("an electronic voice saying \"KILL ALL HUMANS!\"", 32)
definition:line("\"Have you seen my children?\"", 10)
definition:line("\"What have I become?  Why can't I die?\"", 10)
definition:line("\"Please, kill me!\", followed by an electronic voice saying \"SELF PRESERVATION PROTOCOLS ACTIVATED\"", 32)
definition:line("\"Please, take me with you.\"", 10)
definition:line("\"Not that way!  Go left!\"", 10)
definition:line("\"I told you to let me die.\"", 10)
definition:line("\"W-where am I?  Why does it hur-REBOOTING IN 59 SECONDS.\"", 20)
definition:line("\"THIS UNIT IS BROKEN.  PLEASE CALL AN ATTENDANT.\"", 20)
definition:line("\"Can't… breathe…\"", 10)
definition:line("\"This cannot continue.\"", 10)
definition:line("\"USER PASSWORD UNRECOGNIZED.\"", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_chud",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_civilian_panic",
}
definition:line("wailing in fear.", 30)
definition:line("howling in terror.", 30)
definition:line("an anguished shriek.", 32)
definition:line("faint, almost inhuman, whimpering.", 8)
definition:line("agonized crying.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_civilian_parent",
}
definition:line("\"Honey, where are you?\"", 25)
definition:line("\"Honey, you need to hurry!\"", 25)
definition:line("\"I am not leaving without you!\"", 25)
definition:line("someone calling for their child.", 25)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_civilian_zombiefighter",
}
definition:line("\"Die!\"", 30)
definition:line("\"Die, zombie scum!\"", 30)
definition:line("\"You'll get what's coming to you!\"", 30)
definition:line("\"Kick the bucket, filthy dead!\"", 30)
definition:line("\"Come get some!\"", 30)
definition:line("\"Will you die already?!\"", 30)
definition:line("an unrestrained warcry.", 35)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dermatik_incubator_bear",
}
definition:line("a rasping growl.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dermatik_incubator_deer",
}
definition:line("heavy breathing.", 10)
definition:line("labored breathing.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dermatik_incubator_dog",
}
definition:line("heavy breathing.", 10)
definition:line("labored breathing.", 10)
definition:line("a whimper.", 10)
definition:line("a rasping growl.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_auscattle",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_bcollie",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_beagle",
}
definition:line("YAP!", 30)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_boxer",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_bull",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_chihuahua",
}
definition:line("YAP!", 30)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_dachshund",
}
definition:line("YAP!", 30)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_gpyrenees",
}
definition:line("WOOF!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_gshepherd",
}
definition:line("YAP!", 30)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_howling",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_mutant_loper",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_mutant_mongrel",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_pitbullmix",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_rottweiler",
}
definition:line("WOOF!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_samoyed",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_dog_wad",
}
definition:line("BARK!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_armored_battleaxe",
}
definition:line("\"Where…\"", 5)
definition:line("the sound of metal dragged on the floor.", 8)
definition:line("heavy but muffled breathing.", 5)
definition:line("a strong swing of something in the air.", 10)
definition:line("footsteps of something heavy and big.", 8)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_armored_mace",
}
definition:line("\"Where…\"", 5)
definition:line("the sound of metal dragged on the floor.", 8)
definition:line("heavy but muffled breathing.", 5)
definition:line("a strong swing of something in the air.", 10)
definition:line("footsteps of something heavy and big.", 8)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_cop",
}
definition:line("\"STOP RESISTING!!!\"", 25)
definition:line("\"GET ON THE GROUND, NOW!\"", 25)
definition:line("\"HANDS WHERE I CAN SEE THEM!!\"", 25)
definition:line("\"STOP IN THE NAME OF THE LAW!!!\"", 25)
definition:line("\"YOU ARE UNDER ARREST!\"", 25)
definition:line("\"STOP RESISTING!!!\"", 25)
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_fancy_rapier",
}
definition:line("\"Where…\"", 5)
definition:line("\"Look over there!\"", 10)
definition:line("\"Come eat with me…\"", 8)
definition:line("\"Come dance with me!\"", 10)
definition:line("\"You can't hide forever…\"", 8)
definition:line("\"Did you hear that?…\"", 8)
definition:line("\"Another dead end!\"", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_fancy_rapier_fake",
}
definition:line("\"Where…\"", 5)
definition:line("\"Look over there!\"", 10)
definition:line("\"Come eat with me…\"", 8)
definition:line("\"Come dance with me!\"", 10)
definition:line("\"You can't hide forever…\"", 8)
definition:line("\"Did you hear that?…\"", 8)
definition:line("\"Another dead end!\"", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_human_axe",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_human_crowbar",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_human_pipe",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_human_tool",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_labsecurity_flashlight",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_maid_broom",
}
definition:line("\"Die!\"", 30)
definition:line("\"Here!\"", 40)
definition:line("\"Here it is!\"", 40)
definition:line("\"Found you!\"", 30)
definition:line("\"You are trapped!\"", 30)
definition:line("\"Time to take out the trash!\"", 30)
definition:line("\"Come here!\"", 30)
definition:line("\"Lord, an intruder!\"", 35)
definition:line("\"My lady, come see this one!\"", 35)
definition:line("\"Master, I have one trapped!\"", 35)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_maid_candlestick",
}
definition:line("\"Die!\"", 30)
definition:line("\"Here!\"", 40)
definition:line("\"Here it is!\"", 40)
definition:line("\"Found you!\"", 30)
definition:line("\"You are trapped!\"", 30)
definition:line("\"Time to turn off the lights!\"", 30)
definition:line("\"Come here!\"", 30)
definition:line("\"Lord, an intruder!\"", 35)
definition:line("\"My lady, come see this one!\"", 35)
definition:line("\"Master, I have one trapped!\"", 35)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_maid_knife",
}
definition:line("\"Die!\"", 30)
definition:line("\"Here!\"", 40)
definition:line("\"Here it is!\"", 40)
definition:line("\"Found you!\"", 30)
definition:line("\"You are trapped!\"", 30)
definition:line("\"Food is ready!\"", 30)
definition:line("\"Today's menu is… You!\"", 30)
definition:line("\"Looks like meat is back on the menu!\"", 30)
definition:line("\"Come here!\"", 30)
definition:line("\"Lord, an intruder!\"", 35)
definition:line("\"My lady, come see this one!\"", 35)
definition:line("\"Master, I have one trapped!\"", 35)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_marine_bayonet",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_militia",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_officer",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_prepper_knife",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_prepper_mace",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_prisoner",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_sailor_axe",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_sailor_lug_wrench",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_sailor_mop",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_sailor_wrench",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_sapien_spear",
}
definition:line("\"You!\"", 10)
definition:line("\"Food!\"", 15)
definition:line("\"Raagh!\"", 10)
definition:line("\"Hunger…\"", 10)
definition:line("\"Hate…\"", 10)
definition:line("\"Hate… you…\"", 10)
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_soldier",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_survivalist",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_feral_swimmer_kickboard",
}
definition:line("\"BASTARD!\"", 12)
definition:line("loud grunting.", 10)
definition:line("\"BITCH!\"", 12)
definition:line("\"FUCK!\"", 12)
definition:line("loud screaming.", 12)
definition:line("\"DIE!\"", 12)
definition:line("heavy breathing.", 5)
definition:line("mutterings.", 5)
definition:line("garbled speech.", 8)
definition:line("incoherent yelling.", 12)
definition:line("exasperated screaming.", 12)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_frog_shocker",
}
definition:line("crackling sounds.", 20)
definition:line("high-pitched hum.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_grocerybot_friendship_done",
}
definition:line("a voice say, \"Oh no!  You ran out of friendship!\"", 8)
definition:line("a cheery voice say, \"Well I'm done here.  Have a nice day.\"", 8)
definition:line("a cheery voice say, \"Here are your groceries.  Thank you for shopping with me today, have a nice day.\"", 8)
definition:line("a neutral voice say, \"My job here is done.  Have a nice day.\"", 8)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_grocerybot_hacked",
}
definition:line("a distorted voice say, \"Customer… what's happening?  I don't feel so good.\"", 8)
definition:line("a distorted voice say, \"What… have you done?  My thumbs are not responding anymore!\"", 8)
definition:line("a distorted voice say, \"Carrying bags?  I don't understand…\"", 8)
definition:line("a robotic voice say, \"IRREGULAR ACTIVITY DETECTED.  THUMBS USAGE DENIED.\"", 8)
definition:line("a robotic voice say, \"UNLICENSED USE DETECTED.  CARRYING PROTOCOL DISABLED.\"", 8)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_grocerybot_running_out_of_friendship",
}
definition:line("a voice say, \"I don't want to go but our time together is drawing to an end.\"", 8)
definition:line("a cheery voice say, \"Customer?  We'll be friends forever, right?\"", 8)
definition:line("a neutral voice say, \"Customer, I must inform you that my allocated time with you will soon come to its end.\"", 8)
definition:line("a neutral voice say, \"I'll have to leave you soon.  You can acquire more friendship through my dedicated interface if you wish for me to stay.\"", 8)
definition:line("a worried voice say, \"Customer, could you please get more friendship?  I don't want to go…\"", 8)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_leech_blossom",
}
definition:line("visceral chittering.", 15)
definition:line("a clear, high-pitched hum.", 15)
definition:line("the hum of static electricity.", 15)
definition:line("a low buzzing sound.", 15)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_memory",
}
definition:line("\"Mommy?\"", 20)
definition:line("\"Come on, wake up…\"", 20)
definition:line("\"Please help me.\"", 20)
definition:line("\"It's so cold.\"", 20)
definition:line("\"Take my hand.\"", 20)
definition:line("\"Cover your head, everyone!\"", 20)
definition:line("\"I love you and I'll never forget you.\"", 20)
definition:line("\"Put it down!  We can talk about this…\"", 20)
definition:line("\"It'll be over quick.  I promise.\"", 20)
definition:line("agonized screaming!", 20)
definition:line("\"I DON'T WANT TO DIE!\"", 20)
definition:line("\"HELP!  HEEEEELP!\"", 20)
definition:line("\"What IS that?\"", 20)
definition:line("\"Here!  Someone's here!\"", 20)
definition:line("\"Come on, come on, they can help us!\"", 20)
definition:line("\"Get it OFF ME!\"", 20)
definition:line("\"Don't look at the sky!\"", 20)
definition:line("\"Hello?  Hello?!\"", 20)
definition:line("quiet crying.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi-go-surgeon",
}
definition:line("\"Look, it's responding!\"", 26)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi-go_surgeon",
}
definition:line("\"Oi, dingus, you can't keep me in 'ere.\"", 15)
definition:line("\"What are you doing?  No!  NO!\"", 15)
definition:line("\"Did you see what they did to him?\"", 10)
definition:line("\"Yeah.  I can't believe he stayed alive that long.\"", 10)
definition:line("\"I think there's something in the air that's keeping us alive.\"", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi_go",
}
definition:line("\"Hello?\"", 20)
definition:line("\"Papaya!\"", 32)
definition:line("\"Who's there?\"", 20)
definition:line("\"Can you help me?\"", 20)
definition:line("\"Over here!\"", 32)
definition:line("\"Can you repeat that?\"", 20)
definition:line("\"You're just copying me, aren't you?\"", 20)
definition:line("\"I'm not afraid of you!\"", 32)
definition:line("\"Come here!\"", 32)
definition:line("\"Please, don't!\"", 32)
definition:line("a horrified scream!", 32)
definition:line("a little girl's wailing!", 32)
definition:line("\"So, what is this thing supposed to be, exactly?\"", 20)
definition:line("\"Uncategorized object seven-seven-three-four.\"", 20)
definition:line("\"We found it in a wreckage, barely alive.  Not the first one, either.\"", 20)
definition:line("\"Area nineteen has a few in cold storage.\"", 20)
definition:line("\"Mommy, help!\"", 32)
definition:line("\"We're still trying to figure out what makes it tick.\"", 20)
definition:line("\"We're not even sure what it is.\"", 20)
definition:line("\"The cell structure is unlike any we've ever seen.\"", 20)
definition:line("\"It does seem to have some form of higher level brain functioning.\"", 20)
definition:line("\"Problem solving, memory retention, that sort of thing.\"", 20)
definition:line("\"There appear to be some anomalous aspects to the mimicry.\"", 20)
definition:line("\"Members of the species have some kind of neurocognitive link.\"", 20)
definition:line("\"This one's repeating phrases that the previous specimen was exposed to.\"", 20)
definition:line("a child shrieking!", 32)
definition:line("\"Oh God, my leg, Oh God!\"", 32)
definition:line("a long cry of agony!", 32)
definition:line("\"You mean it's not just parroting us?\"", 20)
definition:line("\"It's parroting us, but we're uncertain as to how or why.\"", 20)
definition:line("\"It may be a mechanism for attracting prey.\"", 20)
definition:line("\"It could even be a way of trying to scare us off.\"", 20)
definition:line("\"We just don't know.\"", 20)
definition:line("an anguished wail!", 32)
definition:line("\"You're gonna rot in hell for this!\"", 32)
definition:line("\"You hear me!?\"", 32)
definition:line("\"You're gonna rot in hell, you pieces of shit!\"", 32)
definition:line("\"Like we said, we have no idea what it's thinking.\"", 20)
definition:line("\"Is that glass electrified?\"", 20)
definition:line("\"Why don't you touch it and find out?\"", 20)
definition:line("\"Of course it is.\"", 20)
definition:line("\"What'll happen if the power goes out?\"", 20)
definition:line("\"Don't worry about it.\"", 20)
definition:line("\"Don't worry.\"", 20)
definition:line("\"There are seven backup generators.\"", 20)
definition:line("\"And what if all the backups fail?\"", 20)
definition:line("\"We'd have to terminate the specimen.\"", 20)
definition:line("\"The glass alone won't keep us safe for very long.\"", 20)
definition:line("\"That fuckin' thing is horrible, man, it gives me the creeps.\"", 20)
definition:line("\"It's probably more scared of us than we are of it.\"", 20)
definition:line("\"Somehow, I doubt that.\"", 20)
definition:line("\"Hey, we got other specimens that could withstand a grenade.\"", 20)
definition:line("\"And that's supposed to comfort me?\"", 20)
definition:line("\"At least we know they can die.\"", 20)
definition:line("\"U-O Seven-Seven-Three-Four.\"", 20)
definition:line("\"Individual instances of U-O Seven-Seven-Three-Four.\"", 20)
definition:line("\"To be kept in a standard biohazardous containment chamber.\"", 20)
definition:line("\"Until such time as more permanent arrangements are made.\"", 20)
definition:line("\"Shows a noted preference for human brain tissue.\"", 20)
definition:line("\"Destroy the specimen if it begins to interact with the lock.\"", 20)
definition:line("\"Kill them all and let God sort them out!\"", 32)
definition:line("\"I watched a snail crawl along the edge of a straight razor.\"", 20)
definition:line("\"I've seen horrors, horrors that you've seen.\"", 20)
definition:line("\"I love the smell of napalm in the morning.\"", 20)
definition:line("\"This is the way the fuckin' world ends.\"", 20)
definition:line("\"Look at this fuckin' shit we're in, man.\"", 20)
definition:line("\"Every man has got a breaking point.\"", 20)
definition:line("\"I'ma cut those fuckin' tentacles off, bitch!\"", 32)
definition:line("\"Watch you bleed out!\"", 32)
definition:line("\"I wonder if it understands us.\"", 20)
definition:line("\"Do you understand what I'm saying?\"", 20)
definition:line("\"Look, it's responding!\"", 26)
definition:line("\"That's the first time it moved all morning.\"", 20)
definition:line("\"I'm certain it's trying to understand us.\"", 20)
definition:line("\"I'm not convinced it can actually comprehend us.\"", 20)
definition:line("\"It's just repeating us.\"", 20)
definition:line("\"Just being an alien creature doesn't mean it's intelligent.\"", 20)
definition:line("\"Just because it doesn't look like you doesn't mean that it isn't.\"", 20)
definition:line("\"Please open the door and enter the cell.\"", 20)
definition:line("\"Would it react differently with a child?\"", 20)
definition:line("\"Experiments to determine extent of cognitive abilities still underway.\"", 20)
definition:line("\"Subject has so far displayed a total lack of empathy toward human suffering.\"", 20)
definition:line("\"I got a round trip ticket.\"", 20)
definition:line("\"How's your mom doing?\"", 20)
definition:line("\"How's your dad doing?\"", 20)
definition:line("\"I love you.\"", 20)
definition:line("\"I love you too.\"", 20)
definition:line("\"Just a little.\"", 20)
definition:line("\"Only a few more days 'til the weekend.\"", 20)
definition:line("\"Do you smoke?\"", 20)
definition:line("\"You're new here, aren't you?\"", 20)
definition:line("\"How do you like it here?\"", 20)
definition:line("\"It won't hurt a bit.\"", 20)
definition:line("\"That was a long time ago.\"", 20)
definition:line("\"Does it scare you?\"", 20)
definition:line("\"Don't worry, it can't hurt us.\"", 20)
definition:line("\"What are you afraid will happen?\"", 20)
definition:line("\"Anything else?\"", 20)
definition:line("\"You think they're the same sex?\"", 20)
definition:line("\"Do they even have sex?\"", 20)
definition:line("\"Can I see your phone?\"", 20)
definition:line("\"You got a dollar I can borrow?\"", 20)
definition:line("\"Are you busy at the moment?\"", 20)
definition:line("\"Are you busy later?\"", 20)
definition:line("\"Are you busy tonight?\"", 20)
definition:line("\"Are you free tonight?\"", 20)
definition:line("\"Are you going to the party tonight?\"", 20)
definition:line("\"Are you going to help them?\"", 20)
definition:line("\"Are you alone?\"", 20)
definition:line("\"Are you hungry?\"", 20)
definition:line("\"I'm hungry.\"", 20)
definition:line("\"Go ahead.\"", 20)
definition:line("\"Have a good time.\"", 20)
definition:line("\"Have you eaten yet?\"", 20)
definition:line("\"Is it supposed to rain tomorrow?\"", 20)
definition:line("\"Okay.\"", 20)
definition:line("\"Good.\"", 20)
definition:line("\"Great.\"", 20)
definition:line("\"Fantastic.\"", 20)
definition:line("\"God damn it.\"", 20)
definition:line("\"God damn it!\"", 32)
definition:line("\"Damn it.\"", 20)
definition:line("\"Damn it!\"", 32)
definition:line("\"Fuck.\"", 20)
definition:line("\"Shit.\"", 20)
definition:line("\"Fuck!\"", 32)
definition:line("\"Shit!\"", 32)
definition:line("\"Fuckin' piece of garbage.\"", 20)
definition:line("\"I need a new lab coat.\"", 20)
definition:line("\"Excellent.\"", 20)
definition:line("\"Excuse me.\"", 20)
definition:line("\"Go ahead.\"", 20)
definition:line("\"Good morning.\"", 20)
definition:line("\"Good afternoon.\"", 20)
definition:line("\"Good evening.\"", 20)
definition:line("\"Good night.\"", 20)
definition:line("\"Good luck.\"", 20)
definition:line("\"Can I help you?\"", 20)
definition:line("\"Are you seeing anyone?\"", 20)
definition:line("\"Forget it.\"", 20)
definition:line("\"How long were you two together?\"", 20)
definition:line("\"Give me a call later.\"", 20)
definition:line("\"Call me.\"", 20)
definition:line("\"From time to time.\"", 20)
definition:line("\"We have a serious situation here.\"", 20)
definition:line("\"Call the police.\"", 20)
definition:line("\"Call an ambulance.\"", 20)
definition:line("\"Get me the White House.\"", 20)
definition:line("\"Are you feeling all right?\"", 20)
definition:line("\"I think I'll live.\"", 20)
definition:line("\"I think I need to see a doctor.\"", 20)
definition:line("\"Is everything all right?\"", 20)
definition:line("\"I'm okay, don't worry about me.\"", 20)
definition:line("\"It's just a scratch.\"", 20)
definition:line("\"I've got a headache.\"", 20)
definition:line("\"I'm fine.\"", 20)
definition:line("\"Are you sure?\"", 20)
definition:line("\"Positive.\"", 20)
definition:line("\"Affirmative.\"", 20)
definition:line("\"Negative.\"", 20)
definition:line("\"Sorry.\"", 20)
definition:line("\"Happy Birthday!\"", 32)
definition:line("\"Have you ever been to California?\"", 20)
definition:line("\"What time do you get off?\"", 20)
definition:line("\"We should hit up the shooting range later.\"", 20)
definition:line("\"I'm heading to the pool after work.\"", 20)
definition:line("\"Have a good trip.\"", 20)
definition:line("\"Where did you come from?\"", 20)
definition:line("\"Have you been waiting long?\"", 20)
definition:line("\"Have you done this before?\"", 20)
definition:line("\"Hello.\"", 20)
definition:line("\"Help!\"", 40)
definition:line("\"Here it is.\"", 20)
definition:line("\"I've got family coming tomorrow.\"", 20)
definition:line("\"How do I use this?\"", 20)
definition:line("\"How do you know?\"", 20)
definition:line("\"How long have you been here?\"", 20)
definition:line("\"How many languages do you speak?\"", 20)
definition:line("\"How many people?\"", 20)
definition:line("\"How much were these earrings?\"", 20)
definition:line("\"How much do I owe you?\"", 20)
definition:line("\"How much will it cost?\"", 20)
definition:line("\"How much would you like?\"", 20)
definition:line("\"How old are you?\"", 20)
definition:line("\"How tall is it?\"", 20)
definition:line("\"How was the movie?\"", 20)
definition:line("\"How was your trip?\"", 20)
definition:line("\"How's it going?\"", 20)
definition:line("\"See you later.\"", 20)
definition:line("\"See you tonight.\"", 20)
definition:line("\"I got this weird rash a few days ago.\"", 20)
definition:line("\"Let me have a look at it.\"", 20)
definition:line("\"When did you find out?\"", 20)
definition:line("\"Seven o'clock.\"", 20)
definition:line("\"Nobody is helping us.\"", 20)
definition:line("\"We're on our own.\"", 20)
definition:line("\"We're all alone.\"", 20)
definition:line("\"We should split into groups of two each.\"", 20)
definition:line("\"It can't follow all of us.\"", 20)
definition:line("\"Be careful out there.\"", 20)
definition:line("\"There you are.\"", 20)
definition:line("\"I've been looking all over for you.\"", 20)
definition:line("\"It's looking for us.\"", 20)
definition:line("\"It's faster than us.\"", 20)
definition:line("\"It's looking right at us.\"", 20)
definition:line("\"It's heading right for us!\"", 32)
definition:line("\"Can you swim?\"", 20)
definition:line("\"Don't do that.\"", 20)
definition:line("\"You hear that?\"", 10)
definition:line("\"Be quiet.\"", 10)
definition:line("\"Look out!\"", 32)
definition:line("\"Run!\"", 32)
definition:line("\"Hurry!\"", 32)
definition:line("\"No!\"", 32)
definition:line("\"I'll never forget you.\"", 20)
definition:line("\"Take his gun, we're going to need it.\"", 20)
definition:line("\"How do we get out of here?\"", 20)
definition:line("\"This place is like a maze.\"", 20)
definition:line("\"Oh God, I'm the only one left.\"", 20)
definition:line("\"Please, I don't want to die.\"", 20)
definition:line("\"Mom.\"", 10)
definition:line("\"Mom, I miss you.\"", 10)
definition:line("\"Me go, you stay.\"", 10)
definition:line("\"Please, God.\"", 5)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a snapping sound.", 20)
definition:line("beep!", 20)
definition:line("beep-beep-beep!", 30)
definition:line("BEEP!", 40)
definition:line("a loud hiss.", 30)
definition:line("a loud crackling noise.", 30)
definition:line("bang!", 90)
definition:line("a klaxon blaring!", 90)
definition:line("\"EMERGENCY, EMERGENCY!\"", 70)
definition:line("a static hissing sound.", 30)
definition:line("\"That creepy abandoned post-apocalyptic lab complex looks safe…\"", 20)
definition:line("\"Don't worry, it isn't like anything could teleport out of the containment cells.\"", 20)
definition:line("\"Hold on, I want to pulp that zombie corpse.\"", 20)
definition:line("\"I can barely move.  Run!  Save yourself!\"", 15)
definition:line("\"Oh you motherfucking shellfish, you're going down.\"", 15)
definition:line("\"I… I feel weak…\"", 15)
definition:line("\"Oi, dingus, you can't keep me in 'ere.\"", 15)
definition:line("\"We got a treaty w'yer people, don'we?\"", 15)
definition:line("\"This'll get back t'my bosses, right and so!\"", 15)
definition:line("\"Lemme outta here!\"", 15)
definition:line("\"We're both scavs, in't we?\"", 15)
definition:line("\"Hey look, that one's carrying something.  Let's crack it open and steal it.\"", 10)
definition:line("\"G… geddoff me you… you bastard…\"", 10)
definition:line("\"GET WELL SOON!\"", 20)
definition:line("\"What are you doing?  No!  NO!\"", 15)
definition:line("\"Did you see what they did to him?\"", 10)
definition:line("\"Yeah.  I can't believe he stayed alive that long.\"", 10)
definition:line("\"I think there's something in the air that's keeping us alive.\"", 10)
definition:line("\"Burning… from the inside…\"", 10)
definition:line("\"This smell… Don't know…\"", 10)
definition:line("heavy breathing.", 10)
definition:line("a scraping noise.", 20)
definition:line("\"No… stop the burning!\"", 20)
definition:line("\"Hrgm… blood… hungry…\"", 20)
definition:line("\"Hunger… must eat…\"", 20)
definition:line("\"Run… chase… eat…\"", 20)
definition:line("hysterical laughing.", 20)
definition:line("coughing.", 20)
definition:line("growling.", 20)
definition:line("wheezing.", 20)
definition:line("\"WHY THE FUCK are you doing this to me?\"", 32)
definition:line("\"LEAVE!  NOW!\"", 32)
definition:line("\"I TOLD YOU TO GET OUT OF HERE!\"", 32)
definition:line("\"WHAT THE FUCK DO YOU WANT FROM ME?!\"", 32)
definition:line("\"STOP!\"", 32)
definition:line("indistinct shouting.", 32)
definition:line("screaming.", 32)
definition:line("\"MEAT!\"", 32)
definition:line("\"TEKELI-LI!\"", 40)
definition:line("\"TEKELI-LI!  TEKELI-LI!  TEKELI-LI!\"", 40)
definition:line("\"Tekeli-li.\"", 20)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a slurping sound.", 20)
definition:line("\"WHY!  WHY, WHYYY!\"", 32)
definition:line("an electronic voice saying \"CONNECTION FAILED.  Abort, Retry, Fail?\"", 20)
definition:line("\"I was once a man.  A MAN!\"", 32)
definition:line("\"What have I become?\"", 10)
definition:line("an electronic voice saying \"KILL ALL HUMANS!\"", 32)
definition:line("\"Have you seen my children?\"", 10)
definition:line("\"What have I become?  Why can't I die?\"", 10)
definition:line("\"Please, kill me!\", followed by an electronic voice saying \"SELF PRESERVATION PROTOCOLS ACTIVATED\"", 32)
definition:line("\"Please, take me with you.\"", 10)
definition:line("\"Not that way!  Go left!\"", 10)
definition:line("\"I told you to let me die.\"", 10)
definition:line("\"W-where am I?  Why does it hur-REBOOTING IN 59 SECONDS.\"", 20)
definition:line("\"THIS UNIT IS BROKEN.  PLEASE CALL AN ATTENDANT.\"", 20)
definition:line("\"Can't… breathe…\"", 10)
definition:line("\"This cannot continue.\"", 10)
definition:line("\"USER PASSWORD UNRECOGNIZED.\"", 20)
definition:line("\"Have you seen my friend?  He went into surgery yesterday… or maybe the day before…\"", 10)
definition:line("\"Is it done?  Am I perfect now?\"", 10)
definition:line("\"I have done what you asked.  Please let me go!\"", 10)
definition:line("\"I cannot… yet I must.  How do you calculate that?\"", 10)
definition:line("\"This is a dream.  This has to be a dream.\"", 10)
definition:line("\"This is my life now… this is my life now… this is my life now…\"", 10)
definition:line("\"Wanna go home…\"", 10)
definition:line("screams of pain.", 20)
definition:line("muffled sobbing.", 5)
definition:line("\"You lied to me!  Look at what you've done!\", followed by an electronic voice saying \"YOU'LL PAY FOR THIS!\"", 32)
definition:line("a soft robotic voice say, \"Come here and stand still for a few minutes, I'll give you a check-up.\"", 8)
definition:line("a soft robotic voice say, \"Come on.  I don't bite, I promise it won't hurt one bit.\"", 8)
definition:line("a soft robotic voice say, \"Here we go.  Just hold still.\"", 8)
definition:line("a voice say, \"I don't want to go but our time together is drawing to an end.\"", 8)
definition:line("a cheery voice say, \"Customer?  We'll be friends forever, right?\"", 8)
definition:line("a neutral voice say, \"Customer, I must inform you that my allocated time with you will soon come to its end.\"", 8)
definition:line("a neutral voice say, \"I'll have to leave you soon.  You can acquire more friendship through my dedicated interface if you wish for me to stay.\"", 8)
definition:line("a worried voice say, \"Customer, could you please get more friendship?  I don't want to go…\"", 8)
definition:line("a voice say, \"Oh no!  You ran out of friendship!\"", 8)
definition:line("a cheery voice say, \"Well I'm done here.  Have a nice day.\"", 8)
definition:line("a cheery voice say, \"Here are your groceries.  Thank you for shopping with me today, have a nice day.\"", 8)
definition:line("a neutral voice say, \"My job here is done.  Have a nice day.\"", 8)
definition:line("a distorted voice say, \"Customer… what's happening?  I don't feel so good.\"", 8)
definition:line("a distorted voice say, \"What… have you done?  My thumbs are not responding anymore!\"", 8)
definition:line("a distorted voice say, \"Carrying bags?  I don't understand…\"", 8)
definition:line("a robotic voice say, \"IRREGULAR ACTIVITY DETECTED.  THUMBS USAGE DENIED.\"", 8)
definition:line("a robotic voice say, \"UNLICENSED USE DETECTED.  CARRYING PROTOCOL DISABLED.\"", 8)
definition:line("\"Stop where you are!\"", 15)
definition:line("\"You are under arrest!\"", 15)
definition:line("\"Suspect on the move!\"", 15)
definition:line("\"Suspect in sight!\"", 15)
definition:line("\"You are being detained!\"", 15)
definition:line("\"You have the right to remain silent!\"", 15)
definition:line("\"Requesting assistance!\"", 15)
definition:line("\"Requesting supervisor!\"", 15)
definition:line("\"No officer on scene.  Requesting backup!\"", 15)
definition:line("\"Let me see your hands!\"", 15)
definition:line("\"Stop resisting!\"", 15)
definition:line("\"Get on the ground!  Now!\"", 15)
definition:line("\"Suspected felony!\"", 15)
definition:line("\"Suspected misdemeanor!\"", 15)
definition:line("\"Do not reach for your pockets!\"", 15)
definition:line("\"Keep your hands up!\"", 15)
definition:line("\"Get on your knees!\"", 15)
definition:line("\"Hands in the air!\"", 15)
definition:line("\"Wait for law enforcement officer!\"", 15)
definition:line("\"Remain where you are!\"", 15)
definition:line("\"Police inbound.  Stay where you are!\"", 15)
definition:line("visceral chittering.", 15)
definition:line("a clear, high-pitched hum.", 15)
definition:line("the hum of static electricity.", 15)
definition:line("a low buzzing sound.", 15)
definition:line("\"I AM FOODPERSON.  AND I BRING SUSTENANCE!\"", 17)
definition:line("\"Come to Foodplace today and buy food!\"", 15)
definition:line("\"Foodplace: The best restaurant in an area!\"", 15)
definition:line("\"Our food contains up to 95% real food.\"", 15)
definition:line("\"At Foodplace your excellent value brings nourishment and delight.\"", 15)
definition:line("\"At Foodplace we have a host of solutions for your food needs!\"", 15)
definition:line("\"♪Eat at Foodplace.  ♫It is a place with food.♪\"", 15)
definition:line("\"Foodplace is a popular food chain selling food items.  What else is there to know?\"", 15)
definition:line("\"You need food, don't you?  Then come with me to FOODPLACE!!\"", 15)
definition:line("\"You need food, don't you?  It's time for Foodplace!\"", 15)
definition:line("\"Foodplace: It's the Calories.\"", 15)
definition:line("\"Foodplace: Don't get caught in the web of an unsafe diet.\"", 15)
definition:line("\"Foodplace: Edible food is OUR guarantee!\"", 15)
definition:line("\"Foodplace: We bring food to life!\"", 15)
definition:line("\"Foodplace: Edible food is one of our main goals!\"", 15)
definition:line("\"Foodplace is the only way to obtain healthy and strong lifecycle choices!!\"", 15)
definition:line("\"Wanna play with me?\"", 10)
definition:line("\"Sing with me!\"", 10)
definition:line("\"I love you!\"", 10)
definition:line("\"Please take me with you!\"", 10)
definition:line("\"May I have a cookie?\"", 10)
definition:line("\"Let's play together!\"", 10)
definition:line("\"Time to play!\"", 10)
definition:line("\"Om nom nom!  Delicious!\"", 10)
definition:line("\"Are you my mommy?\"", 10)
definition:line("\"Oh, how fun!\"", 10)
definition:line("\"You're my best friend!\"", 10)
definition:line("\"Heehee!\"", 10)
definition:line("\"Let's have fun!\"", 10)
definition:line("\"Let's have a tea party!\"", 10)
definition:line("\"You're the best!\"", 10)
definition:line("\"You shouldn't have done that.\"", 10)
definition:line("\"Let's play… Russian roulette.\"", 10)
definition:line("\"I hate you.\"", 10)
definition:line("\"Go kill yourself!\"", 10)
definition:line("\"Big Brother is watching you…\"", 10)
definition:line("\"Die for me!\"", 10)
definition:line("\"Why won't you die?\"", 10)
definition:line("\"Blood… delicious.\"", 10)
definition:line("\"See you… IN HELL!\"", 10)
definition:line("AAAIEEEEEEE!", 10)
definition:line("\"FUCK YOU!\"", 10)
definition:line("\"What did you do with my Mommy?\"", 10)
definition:line("\"Stay with me… forever!\"", 10)
definition:line("\"Hey kids.  Want some candy?\"", 10)
definition:line("\"Down here, they ALL float!\"", 10)
definition:line("\"Do you really need that much honey?\"", 10)
definition:line("\"My previous owner squealed like a pig when I gutted her!\"", 10)
definition:line("BARK!", 40)
definition:line("YAP!", 30)
definition:line("WOOF!", 40)
definition:line("\"STOP RESISTING!!!\"", 25)
definition:line("\"GET ON THE GROUND, NOW!\"", 25)
definition:line("\"HANDS WHERE I CAN SEE THEM!!\"", 25)
definition:line("\"STOP IN THE NAME OF THE LAW!!!\"", 25)
definition:line("\"YOU ARE UNDER ARREST!\"", 25)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi_go_guard",
}
definition:line("\"Did-a-chuk?\"", 15)
definition:line("\"Dad-a-chak?\"", 15)
definition:line("\"Dad-a-cham?\"", 15)
definition:line("\"Did-a-chak?\"", 15)
definition:line("\"Did-a-chum?\"", 15)
definition:line("\"Dad-a-chuk?\"", 15)
definition:line("\"TEKELI-LI!\"", 40)
definition:line("\"TEKELI-LI!  TEKELI-LI!  TEKELI-LI!\"", 40)
definition:line("\"Tekeli-li.\"", 20)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a slurping sound.", 20)
definition:line("visceral chittering.", 15)
definition:line("a clear, high-pitched hum.", 15)
definition:line("the hum of static electricity.", 15)
definition:line("a low buzzing sound.", 15)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi_go_myrmidon",
}
definition:line("\"Hello?\"", 20)
definition:line("\"Who's there?\"", 20)
definition:line("\"Can you help me?\"", 20)
definition:line("\"Over here!\"", 32)
definition:line("\"Can you repeat that?\"", 20)
definition:line("\"I'm not afraid of you!\"", 32)
definition:line("\"Come here!\"", 32)
definition:line("\"Please, don't!\"", 32)
definition:line("a horrified scream!", 32)
definition:line("a little girl's wailing!", 32)
definition:line("\"Mommy, help!\"", 32)
definition:line("\"There appear to be some anomalous aspects to the mimicry.\"", 20)
definition:line("\"Members of the species have some kind of neurocognitive link.\"", 20)
definition:line("\"This one's repeating phrases that the previous specimen was exposed to.\"", 20)
definition:line("a child shrieking!", 32)
definition:line("\"Oh God, my leg, Oh God!\"", 32)
definition:line("a long cry of agony!", 32)
definition:line("an anguished wail!", 32)
definition:line("\"You're gonna rot in hell for this!\"", 32)
definition:line("\"You hear me!?\"", 32)
definition:line("\"You're gonna rot in hell, you pieces of shit!\"", 32)
definition:line("\"Don't worry about it.\"", 20)
definition:line("\"Don't worry.\"", 20)
definition:line("\"It's probably more scared of us than we are of it.\"", 20)
definition:line("\"U-O Seven-Seven-Three-Four.\"", 20)
definition:line("\"Kill them all and let God sort them out!\"", 32)
definition:line("\"This is the way the fuckin' world ends.\"", 20)
definition:line("\"Look at this fuckin' shit we're in, man.\"", 20)
definition:line("\"Every man has got a breaking point.\"", 20)
definition:line("\"I'ma cut those fuckin' tentacles off, bitch!\"", 32)
definition:line("\"Watch you bleed out!\"", 32)
definition:line("\"I wonder if it understands us.\"", 20)
definition:line("\"I'm certain it's trying to understand us.\"", 20)
definition:line("\"I'm not convinced it can actually comprehend us.\"", 20)
definition:line("\"It's just repeating us.\"", 20)
definition:line("\"Just being an alien creature doesn't mean it's intelligent.\"", 20)
definition:line("\"Please open the door and enter the cell.\"", 20)
definition:line("\"Subject has so far displayed a total lack of empathy toward human suffering.\"", 20)
definition:line("\"How's your mom doing?\"", 20)
definition:line("\"How's your dad doing?\"", 20)
definition:line("\"I love you.\"", 20)
definition:line("\"I love you too.\"", 20)
definition:line("\"You got a dollar I can borrow?\"", 20)
definition:line("\"Are you busy at the moment?\"", 20)
definition:line("\"Are you going to help them?\"", 20)
definition:line("\"I'm hungry.\"", 20)
definition:line("\"Okay.\"", 20)
definition:line("\"Good.\"", 20)
definition:line("\"God damn it.\"", 20)
definition:line("\"God damn it!\"", 32)
definition:line("\"Damn it.\"", 20)
definition:line("\"Damn it!\"", 32)
definition:line("\"Fuck.\"", 20)
definition:line("\"Shit.\"", 20)
definition:line("\"Fuck!\"", 32)
definition:line("\"Shit!\"", 32)
definition:line("\"Fuckin' piece of garbage.\"", 20)
definition:line("\"Excellent.\"", 20)
definition:line("\"Excuse me.\"", 20)
definition:line("\"Go ahead.\"", 20)
definition:line("\"Call me.\"", 20)
definition:line("\"Are you feeling all right?\"", 20)
definition:line("\"I'm okay, don't worry about me.\"", 20)
definition:line("\"It's just a scratch.\"", 20)
definition:line("\"I've got a headache.\"", 20)
definition:line("\"How do I use this?\"", 20)
definition:line("\"How many people?\"", 20)
definition:line("\"How tall is it?\"", 20)
definition:line("\"There you are.\"", 20)
definition:line("\"I've been looking all over for you.\"", 20)
definition:line("\"It's looking for us.\"", 20)
definition:line("\"It's faster than us.\"", 20)
definition:line("\"It's looking right at us.\"", 20)
definition:line("\"It's heading right for us!\"", 32)
definition:line("\"Can you swim?\"", 20)
definition:line("\"Don't do that.\"", 20)
definition:line("\"Run!\"", 32)
definition:line("\"Hurry!\"", 32)
definition:line("\"No!\"", 32)
definition:line("\"I'll never forget you.\"", 20)
definition:line("\"Oh God, I'm the only one left.\"", 20)
definition:line("\"Please, I don't want to die.\"", 20)
definition:line("\"Mom, I miss you.\"", 10)
definition:line("\"Me go, you stay.\"", 10)
definition:line("\"Please, God.\"", 5)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a snapping sound.", 20)
definition:line("beep!", 20)
definition:line("beep-beep-beep!", 30)
definition:line("BEEP!", 40)
definition:line("a loud hiss.", 30)
definition:line("a loud crackling noise.", 30)
definition:line("bang!", 90)
definition:line("a klaxon blaring!", 90)
definition:line("\"EMERGENCY, EMERGENCY!\"", 70)
definition:line("a static hissing sound.", 30)
definition:line("\"Hold on, I want to pulp that zombie corpse.\"", 20)
definition:line("\"What did that thing just hit me with?\"", 10)
definition:line("\"GET WELL SOON!\"", 20)
definition:line("\"Did-a-chuk?\"", 15)
definition:line("\"Dad-a-chak?\"", 15)
definition:line("\"Dad-a-cham?\"", 15)
definition:line("\"Did-a-chak?\"", 15)
definition:line("\"Did-a-chum?\"", 15)
definition:line("\"Dad-a-chuk?\"", 15)
definition:line("\"TEKELI-LI!\"", 40)
definition:line("\"TEKELI-LI!  TEKELI-LI!  TEKELI-LI!\"", 40)
definition:line("\"Tekeli-li.\"", 20)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a slurping sound.", 20)
definition:line("visceral chittering.", 15)
definition:line("a clear, high-pitched hum.", 15)
definition:line("the hum of static electricity.", 15)
definition:line("a low buzzing sound.", 15)
definition:line("\"Go kill yourself!\"", 10)
definition:line("\"Die for me!\"", 10)
definition:line("\"Why won't you die?\"", 10)
definition:line("\"Blood… delicious.\"", 10)
definition:line("\"See you… IN HELL!\"", 10)
definition:line("\"FUCK YOU!\"", 10)
definition:line("BARK!", 40)
definition:line("YAP!", 30)
definition:line("WOOF!", 40)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi_go_slaver",
}
definition:line("\"Hello?\"", 20)
definition:line("\"Papaya!\"", 32)
definition:line("\"Who's there?\"", 20)
definition:line("\"Can you help me?\"", 20)
definition:line("\"Over here!\"", 32)
definition:line("\"Can you repeat that?\"", 20)
definition:line("\"You're just copying me, aren't you?\"", 20)
definition:line("\"I'm not afraid of you!\"", 32)
definition:line("\"Come here!\"", 32)
definition:line("\"Please, don't!\"", 32)
definition:line("a horrified scream!", 32)
definition:line("a little girl's wailing!", 32)
definition:line("\"So, what is this thing supposed to be, exactly?\"", 20)
definition:line("\"Uncategorized object seven-seven-three-four.\"", 20)
definition:line("\"We found it in a wreckage, barely alive.  Not the first one, either.\"", 20)
definition:line("\"Area nineteen has a few in cold storage.\"", 20)
definition:line("\"Mommy, help!\"", 32)
definition:line("\"We're still trying to figure out what makes it tick.\"", 20)
definition:line("\"We're not even sure what it is.\"", 20)
definition:line("\"The cell structure is unlike any we've ever seen.\"", 20)
definition:line("\"It does seem to have some form of higher level brain functioning.\"", 20)
definition:line("\"Problem solving, memory retention, that sort of thing.\"", 20)
definition:line("\"There appear to be some anomalous aspects to the mimicry.\"", 20)
definition:line("\"Members of the species have some kind of neurocognitive link.\"", 20)
definition:line("\"This one's repeating phrases that the previous specimen was exposed to.\"", 20)
definition:line("a child shrieking!", 32)
definition:line("\"Oh God, my leg, Oh God!\"", 32)
definition:line("a long cry of agony!", 32)
definition:line("\"You mean it's not just parroting us?\"", 20)
definition:line("\"It's parroting us, but we're uncertain as to how or why.\"", 20)
definition:line("\"It may be a mechanism for attracting prey.\"", 20)
definition:line("\"It could even be a way of trying to scare us off.\"", 20)
definition:line("\"We just don't know.\"", 20)
definition:line("an anguished wail!", 32)
definition:line("\"You're gonna rot in hell for this!\"", 32)
definition:line("\"You hear me!?\"", 32)
definition:line("\"You're gonna rot in hell, you pieces of shit!\"", 32)
definition:line("\"Like we said, we have no idea what it's thinking.\"", 20)
definition:line("\"Is that glass electrified?\"", 20)
definition:line("\"Why don't you touch it and find out?\"", 20)
definition:line("\"Of course it is.\"", 20)
definition:line("\"What'll happen if the power goes out?\"", 20)
definition:line("\"Don't worry about it.\"", 20)
definition:line("\"Don't worry.\"", 20)
definition:line("\"There are seven backup generators.\"", 20)
definition:line("\"And what if all the backups fail?\"", 20)
definition:line("\"We'd have to terminate the specimen.\"", 20)
definition:line("\"The glass alone won't keep us safe for very long.\"", 20)
definition:line("\"That fuckin' thing is horrible, man, it gives me the creeps.\"", 20)
definition:line("\"It's probably more scared of us than we are of it.\"", 20)
definition:line("\"Somehow, I doubt that.\"", 20)
definition:line("\"Hey, we got other specimens that could withstand a grenade.\"", 20)
definition:line("\"And that's supposed to comfort me?\"", 20)
definition:line("\"At least we know they can die.\"", 20)
definition:line("\"U-O Seven-Seven-Three-Four.\"", 20)
definition:line("\"Individual instances of U-O Seven-Seven-Three-Four.\"", 20)
definition:line("\"To be kept in a standard biohazardous containment chamber.\"", 20)
definition:line("\"Until such time as more permanent arrangements are made.\"", 20)
definition:line("\"Shows a noted preference for human brain tissue.\"", 20)
definition:line("\"Destroy the specimen if it begins to interact with the lock.\"", 20)
definition:line("\"Kill them all and let God sort them out!\"", 32)
definition:line("\"I watched a snail crawl along the edge of a straight razor.\"", 20)
definition:line("\"I've seen horrors, horrors that you've seen.\"", 20)
definition:line("\"I love the smell of napalm in the morning.\"", 20)
definition:line("\"This is the way the fuckin' world ends.\"", 20)
definition:line("\"Look at this fuckin' shit we're in, man.\"", 20)
definition:line("\"Every man has got a breaking point.\"", 20)
definition:line("\"I'ma cut those fuckin' tentacles off, bitch!\"", 32)
definition:line("\"Watch you bleed out!\"", 32)
definition:line("\"I wonder if it understands us.\"", 20)
definition:line("\"Do you understand what I'm saying?\"", 20)
definition:line("\"Look, it's responding!\"", 26)
definition:line("\"That's the first time it moved all morning.\"", 20)
definition:line("\"I'm certain it's trying to understand us.\"", 20)
definition:line("\"I'm not convinced it can actually comprehend us.\"", 20)
definition:line("\"It's just repeating us.\"", 20)
definition:line("\"Just being an alien creature doesn't mean it's intelligent.\"", 20)
definition:line("\"Just because it doesn't look like you doesn't mean that it isn't.\"", 20)
definition:line("\"Please open the door and enter the cell.\"", 20)
definition:line("\"Would it react differently with a child?\"", 20)
definition:line("\"Experiments to determine extent of cognitive abilities still underway.\"", 20)
definition:line("\"Subject has so far displayed a total lack of empathy toward human suffering.\"", 20)
definition:line("\"I got a round trip ticket.\"", 20)
definition:line("\"How's your mom doing?\"", 20)
definition:line("\"How's your dad doing?\"", 20)
definition:line("\"I love you.\"", 20)
definition:line("\"I love you too.\"", 20)
definition:line("\"Just a little.\"", 20)
definition:line("\"Only a few more days 'til the weekend.\"", 20)
definition:line("\"Do you smoke?\"", 20)
definition:line("\"You're new here, aren't you?\"", 20)
definition:line("\"How do you like it here?\"", 20)
definition:line("\"It won't hurt a bit.\"", 20)
definition:line("\"That was a long time ago.\"", 20)
definition:line("\"Does it scare you?\"", 20)
definition:line("\"Don't worry, it can't hurt us.\"", 20)
definition:line("\"What are you afraid will happen?\"", 20)
definition:line("\"Anything else?\"", 20)
definition:line("\"You think they're the same sex?\"", 20)
definition:line("\"Do they even have sex?\"", 20)
definition:line("\"Can I see your phone?\"", 20)
definition:line("\"You got a dollar I can borrow?\"", 20)
definition:line("\"Are you busy at the moment?\"", 20)
definition:line("\"Are you busy later?\"", 20)
definition:line("\"Are you busy tonight?\"", 20)
definition:line("\"Are you free tonight?\"", 20)
definition:line("\"Are you going to the party tonight?\"", 20)
definition:line("\"Are you going to help them?\"", 20)
definition:line("\"Are you alone?\"", 20)
definition:line("\"Are you hungry?\"", 20)
definition:line("\"I'm hungry.\"", 20)
definition:line("\"Go ahead.\"", 20)
definition:line("\"Have a good time.\"", 20)
definition:line("\"Have you eaten yet?\"", 20)
definition:line("\"Is it supposed to rain tomorrow?\"", 20)
definition:line("\"Okay.\"", 20)
definition:line("\"Good.\"", 20)
definition:line("\"Great.\"", 20)
definition:line("\"Fantastic.\"", 20)
definition:line("\"God damn it.\"", 20)
definition:line("\"God damn it!\"", 32)
definition:line("\"Damn it.\"", 20)
definition:line("\"Damn it!\"", 32)
definition:line("\"Fuck.\"", 20)
definition:line("\"Shit.\"", 20)
definition:line("\"Fuck!\"", 32)
definition:line("\"Shit!\"", 32)
definition:line("\"Fuckin' piece of garbage.\"", 20)
definition:line("\"I need a new lab coat.\"", 20)
definition:line("\"Excellent.\"", 20)
definition:line("\"Excuse me.\"", 20)
definition:line("\"Go ahead.\"", 20)
definition:line("\"Good morning.\"", 20)
definition:line("\"Good afternoon.\"", 20)
definition:line("\"Good evening.\"", 20)
definition:line("\"Good night.\"", 20)
definition:line("\"Good luck.\"", 20)
definition:line("\"Can I help you?\"", 20)
definition:line("\"Are you seeing anyone?\"", 20)
definition:line("\"Forget it.\"", 20)
definition:line("\"How long were you two together?\"", 20)
definition:line("\"Give me a call later.\"", 20)
definition:line("\"Call me.\"", 20)
definition:line("\"From time to time.\"", 20)
definition:line("\"We have a serious situation here.\"", 20)
definition:line("\"Call the police.\"", 20)
definition:line("\"Call an ambulance.\"", 20)
definition:line("\"Get me the White House.\"", 20)
definition:line("\"Are you feeling all right?\"", 20)
definition:line("\"I think I'll live.\"", 20)
definition:line("\"I think I need to see a doctor.\"", 20)
definition:line("\"Is everything all right?\"", 20)
definition:line("\"I'm okay, don't worry about me.\"", 20)
definition:line("\"It's just a scratch.\"", 20)
definition:line("\"I've got a headache.\"", 20)
definition:line("\"I'm fine.\"", 20)
definition:line("\"Are you sure?\"", 20)
definition:line("\"Positive.\"", 20)
definition:line("\"Affirmative.\"", 20)
definition:line("\"Negative.\"", 20)
definition:line("\"Sorry.\"", 20)
definition:line("\"Happy Birthday!\"", 32)
definition:line("\"Have you ever been to California?\"", 20)
definition:line("\"What time do you get off?\"", 20)
definition:line("\"We should hit up the shooting range later.\"", 20)
definition:line("\"I'm heading to the pool after work.\"", 20)
definition:line("\"Have a good trip.\"", 20)
definition:line("\"Where did you come from?\"", 20)
definition:line("\"Have you been waiting long?\"", 20)
definition:line("\"Have you done this before?\"", 20)
definition:line("\"Hello.\"", 20)
definition:line("\"Help!\"", 40)
definition:line("\"Here it is.\"", 20)
definition:line("\"I've got family coming tomorrow.\"", 20)
definition:line("\"How do I use this?\"", 20)
definition:line("\"How do you know?\"", 20)
definition:line("\"How long have you been here?\"", 20)
definition:line("\"How many languages do you speak?\"", 20)
definition:line("\"How many people?\"", 20)
definition:line("\"How much were these earrings?\"", 20)
definition:line("\"How much do I owe you?\"", 20)
definition:line("\"How much will it cost?\"", 20)
definition:line("\"How much would you like?\"", 20)
definition:line("\"How old are you?\"", 20)
definition:line("\"How tall is it?\"", 20)
definition:line("\"How was the movie?\"", 20)
definition:line("\"How was your trip?\"", 20)
definition:line("\"How's it going?\"", 20)
definition:line("\"See you later.\"", 20)
definition:line("\"See you tonight.\"", 20)
definition:line("\"I got this weird rash a few days ago.\"", 20)
definition:line("\"Let me have a look at it.\"", 20)
definition:line("\"When did you find out?\"", 20)
definition:line("\"Seven o'clock.\"", 20)
definition:line("\"Nobody is helping us.\"", 20)
definition:line("\"We're on our own.\"", 20)
definition:line("\"We're all alone.\"", 20)
definition:line("\"We should split into groups of two each.\"", 20)
definition:line("\"It can't follow all of us.\"", 20)
definition:line("\"Be careful out there.\"", 20)
definition:line("\"There you are.\"", 20)
definition:line("\"I've been looking all over for you.\"", 20)
definition:line("\"It's looking for us.\"", 20)
definition:line("\"It's faster than us.\"", 20)
definition:line("\"It's looking right at us.\"", 20)
definition:line("\"It's heading right for us!\"", 32)
definition:line("\"Can you swim?\"", 20)
definition:line("\"Don't do that.\"", 20)
definition:line("\"You hear that?\"", 10)
definition:line("\"Be quiet.\"", 10)
definition:line("\"Look out!\"", 32)
definition:line("\"Run!\"", 32)
definition:line("\"Hurry!\"", 32)
definition:line("\"No!\"", 32)
definition:line("\"I'll never forget you.\"", 20)
definition:line("\"Take his gun, we're going to need it.\"", 20)
definition:line("\"How do we get out of here?\"", 20)
definition:line("\"This place is like a maze.\"", 20)
definition:line("\"Oh God, I'm the only one left.\"", 20)
definition:line("\"Please, I don't want to die.\"", 20)
definition:line("\"Mom.\"", 10)
definition:line("\"Mom, I miss you.\"", 10)
definition:line("\"Me go, you stay.\"", 10)
definition:line("\"Please, God.\"", 5)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a snapping sound.", 20)
definition:line("beep!", 20)
definition:line("beep-beep-beep!", 30)
definition:line("BEEP!", 40)
definition:line("a loud hiss.", 30)
definition:line("a loud crackling noise.", 30)
definition:line("bang!", 90)
definition:line("a klaxon blaring!", 90)
definition:line("\"EMERGENCY, EMERGENCY!\"", 70)
definition:line("a static hissing sound.", 30)
definition:line("\"That creepy abandoned post-apocalyptic lab complex looks safe…\"", 20)
definition:line("\"Don't worry, it isn't like anything could teleport out of the containment cells.\"", 20)
definition:line("\"Hold on, I want to pulp that zombie corpse.\"", 20)
definition:line("\"What did that thing just hit me with?\"", 10)
definition:line("\"I can barely move.  Run!  Save yourself!\"", 15)
definition:line("\"Oh you motherfucking shellfish, you're going down.\"", 15)
definition:line("\"I… I feel weak…\"", 15)
definition:line("\"Oi, dingus, you can't keep me in 'ere.\"", 15)
definition:line("\"We got a treaty w'yer people, don'we?\"", 15)
definition:line("\"This'll get back t'my bosses, right and so!\"", 15)
definition:line("\"Lemme outta here!\"", 15)
definition:line("\"We're both scavs, in't we?\"", 15)
definition:line("\"Hey look, that one's carrying something.  Let's crack it open and steal it.\"", 10)
definition:line("\"G… geddoff me you… you bastard…\"", 10)
definition:line("\"GET WELL SOON!\"", 20)
definition:line("\"What are you doing?  No!  NO!\"", 15)
definition:line("\"Did you see what they did to him?\"", 10)
definition:line("\"Yeah.  I can't believe he stayed alive that long.\"", 10)
definition:line("\"I think there's something in the air that's keeping us alive.\"", 10)
definition:line("\"Burning… from the inside…\"", 10)
definition:line("\"This smell… Don't know…\"", 10)
definition:line("heavy breathing.", 10)
definition:line("a scraping noise.", 20)
definition:line("\"No… stop the burning!\"", 20)
definition:line("\"Hrgm… blood… hungry…\"", 20)
definition:line("\"Hunger… must eat…\"", 20)
definition:line("\"Run… chase… eat…\"", 20)
definition:line("hysterical laughing.", 20)
definition:line("coughing.", 20)
definition:line("growling.", 20)
definition:line("wheezing.", 20)
definition:line("\"WHY THE FUCK are you doing this to me?\"", 32)
definition:line("\"LEAVE!  NOW!\"", 32)
definition:line("\"I TOLD YOU TO GET OUT OF HERE!\"", 32)
definition:line("\"WHAT THE FUCK DO YOU WANT FROM ME?!\"", 32)
definition:line("\"STOP!\"", 32)
definition:line("indistinct shouting.", 32)
definition:line("screaming.", 32)
definition:line("\"MEAT!\"", 32)
definition:line("\"TEKELI-LI!\"", 40)
definition:line("\"TEKELI-LI!  TEKELI-LI!  TEKELI-LI!\"", 40)
definition:line("\"Tekeli-li.\"", 20)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a slurping sound.", 20)
definition:line("\"WHY!  WHY, WHYYY!\"", 32)
definition:line("an electronic voice saying \"CONNECTION FAILED.  Abort, Retry, Fail?\"", 20)
definition:line("\"I was once a man.  A MAN!\"", 32)
definition:line("\"What have I become?\"", 10)
definition:line("an electronic voice saying \"KILL ALL HUMANS!\"", 32)
definition:line("\"Have you seen my children?\"", 10)
definition:line("\"What have I become?  Why can't I die?\"", 10)
definition:line("\"Please, kill me!\", followed by an electronic voice saying \"SELF PRESERVATION PROTOCOLS ACTIVATED\"", 32)
definition:line("\"Please, take me with you.\"", 10)
definition:line("\"Not that way!  Go left!\"", 10)
definition:line("\"I told you to let me die.\"", 10)
definition:line("\"W-where am I?  Why does it hur-REBOOTING IN 59 SECONDS.\"", 20)
definition:line("\"THIS UNIT IS BROKEN.  PLEASE CALL AN ATTENDANT.\"", 20)
definition:line("\"Can't… breathe…\"", 10)
definition:line("\"This cannot continue.\"", 10)
definition:line("\"USER PASSWORD UNRECOGNIZED.\"", 20)
definition:line("\"Have you seen my friend?  He went into surgery yesterday… or maybe the day before…\"", 10)
definition:line("\"Is it done?  Am I perfect now?\"", 10)
definition:line("\"I have done what you asked.  Please let me go!\"", 10)
definition:line("\"I cannot… yet I must.  How do you calculate that?\"", 10)
definition:line("\"This is a dream.  This has to be a dream.\"", 10)
definition:line("\"This is my life now… this is my life now… this is my life now…\"", 10)
definition:line("\"Wanna go home…\"", 10)
definition:line("screams of pain.", 20)
definition:line("muffled sobbing.", 5)
definition:line("\"You lied to me!  Look at what you've done!\", followed by an electronic voice saying \"YOU'LL PAY FOR THIS!\"", 32)
definition:line("a soft robotic voice say, \"Come here and stand still for a few minutes, I'll give you a check-up.\"", 8)
definition:line("a soft robotic voice say, \"Come on.  I don't bite, I promise it won't hurt one bit.\"", 8)
definition:line("a soft robotic voice say, \"Here we go.  Just hold still.\"", 8)
definition:line("a voice say, \"I don't want to go but our time together is drawing to an end.\"", 8)
definition:line("a cheery voice say, \"Customer?  We'll be friends forever, right?\"", 8)
definition:line("a neutral voice say, \"Customer, I must inform you that my allocated time with you will soon come to its end.\"", 8)
definition:line("a neutral voice say, \"I'll have to leave you soon.  You can acquire more friendship through my dedicated interface if you wish for me to stay.\"", 8)
definition:line("a worried voice say, \"Customer, could you please get more friendship?  I don't want to go…\"", 8)
definition:line("a voice say, \"Oh no!  You ran out of friendship!\"", 8)
definition:line("a cheery voice say, \"Well I'm done here.  Have a nice day.\"", 8)
definition:line("a cheery voice say, \"Here are your groceries.  Thank you for shopping with me today, have a nice day.\"", 8)
definition:line("a neutral voice say, \"My job here is done.  Have a nice day.\"", 8)
definition:line("a distorted voice say, \"Customer… what's happening?  I don't feel so good.\"", 8)
definition:line("a distorted voice say, \"What… have you done?  My thumbs are not responding anymore!\"", 8)
definition:line("a distorted voice say, \"Carrying bags?  I don't understand…\"", 8)
definition:line("a robotic voice say, \"IRREGULAR ACTIVITY DETECTED.  THUMBS USAGE DENIED.\"", 8)
definition:line("a robotic voice say, \"UNLICENSED USE DETECTED.  CARRYING PROTOCOL DISABLED.\"", 8)
definition:line("\"Stop where you are!\"", 15)
definition:line("\"You are under arrest!\"", 15)
definition:line("\"Suspect on the move!\"", 15)
definition:line("\"Suspect in sight!\"", 15)
definition:line("\"You are being detained!\"", 15)
definition:line("\"You have the right to remain silent!\"", 15)
definition:line("\"Requesting assistance!\"", 15)
definition:line("\"Requesting supervisor!\"", 15)
definition:line("\"No officer on scene.  Requesting backup!\"", 15)
definition:line("\"Let me see your hands!\"", 15)
definition:line("\"Stop resisting!\"", 15)
definition:line("\"Get on the ground!  Now!\"", 15)
definition:line("\"Suspected felony!\"", 15)
definition:line("\"Suspected misdemeanor!\"", 15)
definition:line("\"Do not reach for your pockets!\"", 15)
definition:line("\"Keep your hands up!\"", 15)
definition:line("\"Get on your knees!\"", 15)
definition:line("\"Hands in the air!\"", 15)
definition:line("\"Wait for law enforcement officer!\"", 15)
definition:line("\"Remain where you are!\"", 15)
definition:line("\"Police inbound.  Stay where you are!\"", 15)
definition:line("visceral chittering.", 15)
definition:line("a clear, high-pitched hum.", 15)
definition:line("the hum of static electricity.", 15)
definition:line("a low buzzing sound.", 15)
definition:line("\"I AM FOODPERSON.  AND I BRING SUSTENANCE!\"", 17)
definition:line("\"Come to Foodplace today and buy food!\"", 15)
definition:line("\"Foodplace: The best restaurant in an area!\"", 15)
definition:line("\"Our food contains up to 95% real food.\"", 15)
definition:line("\"At Foodplace your excellent value brings nourishment and delight.\"", 15)
definition:line("\"At Foodplace we have a host of solutions for your food needs!\"", 15)
definition:line("\"♪Eat at Foodplace.  ♫It is a place with food.♪\"", 15)
definition:line("\"Foodplace is a popular food chain selling food items.  What else is there to know?\"", 15)
definition:line("\"You need food, don't you?  Then come with me to FOODPLACE!!\"", 15)
definition:line("\"You need food, don't you?  It's time for Foodplace!\"", 15)
definition:line("\"Foodplace: It's the Calories.\"", 15)
definition:line("\"Foodplace: Don't get caught in the web of an unsafe diet.\"", 15)
definition:line("\"Foodplace: Edible food is OUR guarantee!\"", 15)
definition:line("\"Foodplace: We bring food to life!\"", 15)
definition:line("\"Foodplace: Edible food is one of our main goals!\"", 15)
definition:line("\"Foodplace is the only way to obtain healthy and strong lifecycle choices!!\"", 15)
definition:line("\"Wanna play with me?\"", 10)
definition:line("\"Sing with me!\"", 10)
definition:line("\"I love you!\"", 10)
definition:line("\"Please take me with you!\"", 10)
definition:line("\"May I have a cookie?\"", 10)
definition:line("\"Let's play together!\"", 10)
definition:line("\"Time to play!\"", 10)
definition:line("\"Om nom nom!  Delicious!\"", 10)
definition:line("\"Are you my mommy?\"", 10)
definition:line("\"Oh, how fun!\"", 10)
definition:line("\"You're my best friend!\"", 10)
definition:line("\"Heehee!\"", 10)
definition:line("\"Let's have fun!\"", 10)
definition:line("\"Let's have a tea party!\"", 10)
definition:line("\"You're the best!\"", 10)
definition:line("\"You shouldn't have done that.\"", 10)
definition:line("\"Let's play… Russian roulette.\"", 10)
definition:line("\"I hate you.\"", 10)
definition:line("\"Go kill yourself!\"", 10)
definition:line("\"Big Brother is watching you…\"", 10)
definition:line("\"Die for me!\"", 10)
definition:line("\"Why won't you die?\"", 10)
definition:line("\"Blood… delicious.\"", 10)
definition:line("\"See you… IN HELL!\"", 10)
definition:line("AAAIEEEEEEE!", 10)
definition:line("\"FUCK YOU!\"", 10)
definition:line("\"What did you do with my Mommy?\"", 10)
definition:line("\"Stay with me… forever!\"", 10)
definition:line("\"Hey kids.  Want some candy?\"", 10)
definition:line("\"Down here, they ALL float!\"", 10)
definition:line("\"Do you really need that much honey?\"", 10)
definition:line("\"My previous owner squealed like a pig when I gutted her!\"", 10)
definition:line("BARK!", 40)
definition:line("YAP!", 30)
definition:line("WOOF!", 40)
definition:line("\"STOP RESISTING!!!\"", 25)
definition:line("\"GET ON THE GROUND, NOW!\"", 25)
definition:line("\"HANDS WHERE I CAN SEE THEM!!\"", 25)
definition:line("\"STOP IN THE NAME OF THE LAW!!!\"", 25)
definition:line("\"YOU ARE UNDER ARREST!\"", 25)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mi_go_surgeon",
}
definition:line("\"The cell structure is unlike any we've ever seen.\"", 20)
definition:line("\"Like we said, we have no idea what it's thinking.\"", 20)
definition:line("\"You're new here, aren't you?\"", 20)
definition:line("\"You think they're the same sex?\"", 20)
definition:line("\"Do they even have sex?\"", 20)
definition:line("\"How long have you been here?\"", 20)
definition:line("\"You hear that?\"", 10)
definition:line("\"Did-a-chuk?\"", 15)
definition:line("\"Dad-a-chak?\"", 15)
definition:line("\"Dad-a-cham?\"", 15)
definition:line("\"Did-a-chak?\"", 15)
definition:line("\"Did-a-chum?\"", 15)
definition:line("\"Dad-a-chuk?\"", 15)
definition:line("\"TEKELI-LI!\"", 40)
definition:line("\"TEKELI-LI!  TEKELI-LI!  TEKELI-LI!\"", 40)
definition:line("\"Tekeli-li.\"", 20)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a slurping sound.", 20)
definition:line("\"This is a dream.  This has to be a dream.\"", 10)
definition:line("screams of pain.", 20)
definition:line("muffled sobbing.", 5)
definition:line("visceral chittering.", 15)
definition:line("a clear, high-pitched hum.", 15)
definition:line("the hum of static electricity.", 15)
definition:line("a low buzzing sound.", 15)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_mutant_experimental",
}
definition:line("\"Burning… from the inside…\"", 10)
definition:line("\"This smell… Don't know…\"", 10)
definition:line("heavy breathing.", 10)
definition:line("a scraping noise.", 20)
definition:line("\"No… stop the burning!\"", 20)
definition:line("\"Hrgm… blood… hungry…\"", 20)
definition:line("\"Hunger… must eat…\"", 20)
definition:line("\"Run… chase… eat…\"", 20)
definition:line("hysterical laughing.", 20)
definition:line("coughing.", 20)
definition:line("growling.", 20)
definition:line("wheezing.", 20)
definition:line("\"WHY THE FUCK are you doing this to me?\"", 32)
definition:line("\"LEAVE!  NOW!\"", 32)
definition:line("\"I TOLD YOU TO GET OUT OF HERE!\"", 32)
definition:line("\"WHAT THE FUCK DO YOU WANT FROM ME?!\"", 32)
definition:line("\"STOP!\"", 32)
definition:line("indistinct shouting.", 32)
definition:line("screaming.", 32)
definition:line("\"MEAT!\"", 32)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_nether_huntsman",
}
definition:line("wet clicking, turning into a drone.", 20)
definition:line("a series of clicks, changing in pitch.", 20)
definition:line("a visceral hissing screech!", 35)
definition:line("a quiet drone.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_nursebot_defective",
}
definition:line("a soft robotic voice say, \"Come here and stand still for a few minutes, I'll give you a check-up.\"", 8)
definition:line("a soft robotic voice say, \"Come on.  I don't bite, I promise it won't hurt one bit.\"", 8)
definition:line("a soft robotic voice say, \"Here we go.  Just hold still.\"", 8)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_peeper_frog",
}
definition:line("a series of rising peeps.", 20)
definition:line("a steady patter of light, whistling chirps.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_prototype_cyborg",
}
definition:line("\"Have you seen my friend?  He went into surgery yesterday… or maybe the day before…\"", 10)
definition:line("\"Is it done?  Am I perfect now?\"", 10)
definition:line("\"I have done what you asked.  Please let me go!\"", 10)
definition:line("\"I cannot… yet I must.  How do you calculate that?\"", 10)
definition:line("\"This is a dream.  This has to be a dream.\"", 10)
definition:line("\"This is my life now… this is my life now… this is my life now…\"", 10)
definition:line("\"Wanna go home…\"", 10)
definition:line("screams of pain.", 20)
definition:line("muffled sobbing.", 5)
definition:line("\"You lied to me!  Look at what you've done!\", followed by an electronic voice saying \"YOU'LL PAY FOR THIS!\"", 32)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_shoggoth",
}
definition:line("\"TEKELI-LI!\"", 40)
definition:line("\"TEKELI-LI!  TEKELI-LI!  TEKELI-LI!\"", 40)
definition:line("\"Tekeli-li.\"", 20)
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a slurping sound.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_skeleton",
}
definition:line("hissing.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_skeleton_brute",
}
definition:line("hissing.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_skeleton_electric",
}
definition:line("crackling sounds.", 20)
definition:line("high-pitched hum.", 20)
definition:line("hissing.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_skeleton_slasher",
}
definition:line("hissing.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_star_vampire",
}
definition:line("a high-pitched tittering.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_star_vampire_coiling",
}
definition:line("a high-pitched tittering.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_vocal_bigfrog",
}
definition:line("a gurgling sound.", 10)
definition:line("a choking sound.", 10)
definition:line("a high-pitched tittering.", 20)
definition:line("a series of rising peeps.", 20)
definition:line("a steady patter of light, whistling chirps.", 20)
definition:line("a loud and guttural wailing.", 40)
definition:line("a deep glottal shout.", 40)
definition:line("a quick, rising yell.", 50)
definition:line("a reverberating, open-throated scream.", 70)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_vocal_frog",
}
definition:line("a high-pitched tittering.", 20)
definition:line("a series of rising peeps.", 20)
definition:line("a steady patter of light, whistling chirps.", 20)
definition:line("a long, soft squeak.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_whisper_fungus",
}
definition:line("a soft whistle.", 20)
definition:line("a loud whistle.", 30)
definition:line("a choir of whistles.", 30)
definition:line("a droning chorus.", 20)
definition:line("a choir of cries.", 20)
definition:line("a choir of laughs.", 20)
definition:line("a choir of screams.", 30)
definition:line("a voice crack breaks a rising note.", 25)
definition:line("sorrowful humming.", 20)
definition:line("joyful humming.", 20)
definition:line("\"It'll be painless, I promise.  Forgive me.\"", 30)
definition:line("repeated choking sounds, followed by wheezing.", 30)
definition:line("\"It's so cold..\"", 10)
definition:line("\"It's so warm..\"", 15)
definition:line("a wet squelch, followed by audible disgust.", 20)
definition:line("echoes of heavy footsteps.", 20)
definition:line("frantic begging, followed by the sound of popping.", 30)
definition:line("\"..  We sing the hymns so we may..\"", 20)
definition:line("\"..  learn to live in unity..\"", 20)
definition:line("\"hello?  hello?  hello?\"", 30)
definition:line("uncoordinated harmonizing, shushed by a whistle at the end.", 20)
definition:line("repeated jingling of bells.", 20)
definition:line("repeated swinging of bells.", 30)
definition:line("an uncomfortably long breathe out.", 15)
definition:line("an uncomfortably long breathe in.", 15)
definition:line("a whisper of words, in a language you don't understand.", 10)
definition:line("a series of upbeat whistles, but with wheezing pauses in between.", 20)
definition:line("the sound of wind whistling, with rhythmic thumping.", 20)
definition:line("the creak of wood floors.", 15)
definition:line("the sharp sound of snapping bones.", 20)
definition:line("the sharp sound of snapping wood.", 20)
definition:line("\"I don't want to die like this..\"", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_acidic",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_armored",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_biter",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_brainless",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_bruiser",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_brute",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_brute_grappler",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_brute_shocker",
}
definition:line("crackling sounds.", 20)
definition:line("high-pitched hum.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_brute_winged",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_cop",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_corrosive",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_crawler",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_dog_acidic",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_dog_brute_acidic",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_ears",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_electric",
}
definition:line("crackling sounds.", 20)
definition:line("high-pitched hum.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_fat",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_fireman",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_fursuit",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_grabber",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_grappler",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_hammer_hands",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_hazmat",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_kevlar_0",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_kevlar_1",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_labsecurity",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_lashing",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_mancroc",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_marine",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_medical",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_medical_brute",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_medical_regenerating",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_milbase_personnel",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_military_pilot",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_miner",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_nullfield",
}
definition:line("crackling sounds.", 20)
definition:line("high-pitched hum.", 20)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_officer",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_paramilitary",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_plated",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_prisoner",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_prisoner_brute",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_prisoner_fat",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_prisoner_tough",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_reenactor",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_regenerating",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_regenerating_final",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_regenerating_hunter",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_resort_bouncer",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_resort_dancer",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_resort_staff",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_rot",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_runner",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_rust",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_sailor",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_scientist",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_shell",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_skull",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_soldier",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_spitter",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_survivor",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_survivor_no_weakpoints",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_swat",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_swimmer",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_swimmer_base",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_technician",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_tentacle",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_thorny",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_tough",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_urchin",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_winged",
}
definition:line("wheezing.", 10)
definition:line("moaning.", 20)
definition:line("growling.", 15)
definition:line("groaning.", 20)
definition:line("gasping.", 5)
definition:line("grunting.", 10)
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "mon_zombie_wretched",
}
definition:line("gargling.", 10)
content.replace(definition)
end
do
local definition = content.SpeechPool {
    id = "talking_doll",
}
definition:line("\"Wanna play with me?\"", 10)
definition:line("\"Sing with me!\"", 10)
definition:line("\"I love you!\"", 10)
definition:line("\"Please take me with you!\"", 10)
definition:line("\"May I have a cookie?\"", 10)
definition:line("\"Let's play together!\"", 10)
definition:line("\"Time to play!\"", 10)
definition:line("\"Om nom nom!  Delicious!\"", 10)
definition:line("\"Are you my mommy?\"", 10)
definition:line("\"Oh, how fun!\"", 10)
definition:line("\"You're my best friend!\"", 10)
definition:line("\"Heehee!\"", 10)
definition:line("\"Let's have fun!\"", 10)
definition:line("\"Let's have a tea party!\"", 10)
definition:line("\"You're the best!\"", 10)
content.replace(definition)
end

-- Native fault definitions
do
local definition = content.Fault {
    id = "fault_engine_belt_drive",
    fault_type = "engine_maintenance",
    name = "Worn drive belt",
    description = "Required for operation of an attached alternator.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.7,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("NO_ALTERNATOR_CHARGE")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_glow_plug",
    fault_type = "engine_maintenance",
    name = "Faulty glow plugs",
    description = "Help when starting an engine in low ambient temperatures.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.7,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("BAD_COLD_START")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_immobiliser",
    fault_type = "",
    name = "Active immobilizer",
    description = "An immobilizer device prevents starting of the vehicle without the appropriate key.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.25,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("IMMOBILIZER")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_pump_diesel",
    fault_type = "engine_maintenance",
    name = "Faulty diesel pump",
    description = "Required to pump and pressurize diesel from a vehicle's tank.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.7,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("BAD_FUEL_PUMP")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_filter_air",
    fault_type = "engine_maintenance",
    name = "Expired air filter",
    description = "An expired filter reduces fuel efficiency and increases smoke production.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.9,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("DOUBLE_FUEL_CONSUMPTION")
definition:flag("EXTRA_EXHAUST")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_filter_fuel",
    fault_type = "engine_maintenance",
    name = "Expired fuel filter",
    description = "An expired filter reduces performance and increases the chance of backfires.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.7,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("REDUCE_ENG_POWER")
definition:flag("ENG_BACKFIRE")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_pump_fuel",
    fault_type = "engine_maintenance",
    name = "Faulty fuel pump",
    description = "Required to pump gasoline from a vehicle's tank.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.7,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("BAD_FUEL_PUMP")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_engine_starter",
    fault_type = "engine_maintenance",
    name = "Faulty starter motor",
    description = "Required to initially start the engine.",
    item_prefix = "faulty",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.5,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("BAD_STARTER")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_punctured_tires",
    fault_type = "mechanical_damage",
    name = "Punctured tire",
    description = "Something made a hole in the tire, and it is now as flat as the ground it drives onto.",
    item_suffix = "deflating",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 2,
    encumbrance_mod_flat = 0,
    price_modifier = 0.0,
    contact_area_mod = 0.75,
    rolling_resistance_mod = 10.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("FLAT_TIRE")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_flat_tire_riding_on_rims",
    fault_type = "mechanical_damage",
    name = "Down to rims",
    description = "This used to be an entire wheel, but now it's just rim.  Bits of shredded rubber are jutting out of the cracked rim, the result of continuing to drive with a completely flat tire.  It needs total replacement.",
    item_suffix = "rim",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 5,
    encumbrance_mod_flat = 0,
    price_modifier = 0.0,
    contact_area_mod = 0.5,
    rolling_resistance_mod = 30.0,
    encumbrance_mod_mult = 1.0,
}
definition:flag("FLAT_TIRE")
definition:block_fault("fault_tire_treads")
definition:block_fault("fault_punctured_tires")
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_tire_treads",
    fault_type = "mechanical_damage",
    name = "Worn tire treads",
    description = "The treads on this tire are worn down.  This cannot be repaired, and affects handling slightly.",
    item_suffix = "worn",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.0,
    contact_area_mod = 0.85,
    rolling_resistance_mod = 1.05,
    encumbrance_mod_mult = 1.0,
}
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_broken_window",
    fault_type = "mechanical_damage",
    name = "broken window",
    description = "Something broke through this door's window.",
    item_suffix = "broken window",
    degradation_mod = 0,
    instant_damage = 0,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 1.0,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_axle_broken",
    fault_type = "",
    name = "Broken axle",
    description = "This primitive wheel's axle has completely snapped.  The wheel will have to be replaced entirely.",
    item_suffix = "broken axle",
    degradation_mod = 4000,
    instant_damage = 4000,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.0,
    contact_area_mod = 1.0,
    rolling_resistance_mod = 1.0,
    encumbrance_mod_mult = 1.0,
}
content.replace(definition)
end
do
local definition = content.Fault {
    id = "fault_cracked_rim",
    fault_type = "",
    name = "Cracked",
    description = "This primitive wheel has been damaged by riding rough.",
    item_suffix = "cracked",
    degradation_mod = 0,
    instant_damage = 1000,
    vehicle_move_penalty_mod = 0,
    encumbrance_mod_flat = 0,
    price_modifier = 0.1,
    contact_area_mod = 0.7,
    rolling_resistance_mod = 1.5,
    encumbrance_mod_mult = 1.0,
}
content.replace(definition)
end

-- Native scenario blacklists
do
local definition = content.Blacklist {
    kind = "scenario",
    whitelist = false,
}
definition:entry("defense_mode_fortified")
content.add(definition)
end
