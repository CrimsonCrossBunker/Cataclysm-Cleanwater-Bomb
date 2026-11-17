local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "DEBUG_ONLY",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This is not intended to be visible during normal gameplay.  <bad>Please file a bug report</bad> unless you are seeing this in the debug menu."),
})

content.add(content.JsonFlag {
    id = "NO_PAINT",
    info = ccb.content.text("This vehicle part keeps its own sprite colors and is never tinted by a vehicle color palette."),
})

content.add(content.JsonFlag {
    id = "SWIM_UNDER",
    info = ccb.content.text("Terrain with this flag is treated as having water beneath a covering (e.g. ice); entities may be considered under water for swimming and related mechanics."),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_ARMS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You can use this armor <info>with chainmail</info> without encumbrance penalty."),
    restriction = ccb.content.text("Item must be a chainmail compatible armor piece"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_ELBOWS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You can use this armor <info>with chainmail</info> without encumbrance penalty."),
    restriction = ccb.content.text("Item must be a chainmail compatible armor piece"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_LEGS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You can use this armor <info>with chainmail</info> without encumbrance penalty."),
    restriction = ccb.content.text("Item must be a chainmail compatible armor piece"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_KNEES",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You can use this armor <info>with chainmail</info> without encumbrance penalty."),
    restriction = ccb.content.text("Item must be a chainmail compatible armor piece"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_CHAINMAIL_TORSO",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You can use this armor <info>with chainmail</info> without encumbrance penalty."),
    restriction = ccb.content.text("Item must be a chainmail compatible armor piece"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_LARGE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This plate will fit in <info>large</info> armor pockets."),
    restriction = ccb.content.text("Item must be a large ablative plate"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_MANTLE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This will hook to a <info>Hub 01 proprietary</info> mantle connector."),
    restriction = ccb.content.text("Item must be an armored mantle"),
})

content.add(content.JsonFlag {
    id = "STAR_PLATE",
    info = ccb.content.text("This can be supported by the ryūsei battle kit."),
    restriction = ccb.content.text("Item must be resonance plate"),
})

content.add(content.JsonFlag {
    id = "STAR_SHOULDER",
    info = ccb.content.text("This can be supported by the ryūsei battle kit."),
    restriction = ccb.content.text("Item must be resonance shoulder"),
})

content.add(content.JsonFlag {
    id = "STAR_SKIRT",
    info = ccb.content.text("This can be supported by the ryūsei battle kit."),
    restriction = ccb.content.text("Item must be resonance skirt"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_MEDIUM",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This plate will fit in <info>medium</info> armor pockets."),
    restriction = ccb.content.text("Item must be a medium ablative plate"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_SKIRT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This will hook to a <info>Hub 01 proprietary</info> skirt connector."),
    restriction = ccb.content.text("Item must be an armored skirt"),
})

content.add(content.JsonFlag {
    id = "ABLATIVE_HELMET",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This will hook to a <info>Hub 01 proprietary</info> helmet connector."),
    restriction = ccb.content.text("Item must be an armored helmet"),
})

content.add(content.JsonFlag {
    id = "ACTIVE_CLOAKING",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear has <info>cloaking tech</info> that will <good>make you invisible</good> when active, at the cost of <info>power from a UPS</info>."),
})

content.add(content.JsonFlag { id = "ALLOWS_TAIL" })
content.add(content.JsonFlag { id = "ALLOWS_GASTROPOD_FOOT" })
content.add(content.JsonFlag { id = "ALLOWS_LEG_TENTACLES" })
content.add(content.JsonFlag { id = "ALLOWS_WING_ARMS" })
content.add(content.JsonFlag { id = "ALLOWS_WINGS" })
content.add(content.JsonFlag { id = "ALLOWS_TALONS" })

content.add(content.JsonFlag {
    id = "ALARMCLOCK",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear has an <info>alarm clock</info> feature."),
})

content.add(content.JsonFlag {
    id = "ALLOWS_BODY_BLOCK",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <info>won't prevent you from blocking with your body, such as arms or legs</info> when wielded as a weapon."),
})

content.add(content.JsonFlag {
    id = "ALLOWS_NATURAL_ATTACKS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing won't hinder special attacks that involve <info>mutated or cybernetic anatomy</info>."),
})

content.add(content.JsonFlag {
    id = "ALLOWS_REMOTE_USE",
    info = ccb.content.text("This item can be activated or reloaded from an adjacent tile without picking it up."),
})

content.add(content.JsonFlag {
    id = "CAN_USE_IN_DARK",
    info = ccb.content.text("This item can use all of its features in darkness."),
})

content.add(content.JsonFlag {
    id = "ALWAYS_AIMED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gun is <good>always fully aimed</good>."),
})

-- This item goes in the outer aura layer, intended for metaphysical effects.
content.add(content.JsonFlag {
    id = "AURA",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This is in your <info>outer aura</info>."),
})

content.add(content.JsonFlag {
    id = "BAROMETER",
    info = ccb.content.text("This gear is equipped with an accurate barometer (which is used to measure atmospheric pressure)."),
})

content.add(content.JsonFlag {
    id = "BELT_CLIP",
    restriction = ccb.content.text("Item must clip onto a belt loop"),
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can be <info>clipped onto a belt loop</info> of the appropriate size."),
})

-- Layer for backpacks and things worn over outerwear.
content.add(content.JsonFlag {
    id = "BELTED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear is <info>strapped</info> onto you."),
})

content.add(content.JsonFlag {
    id = "BIONIC_INSTALLATION_DATA",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <info>provides</info> instructions and other required data for several bionics, allowing installation of them with <good>minimal failure chance</good>."),
})

content.add(content.JsonFlag {
    id = "BIONIC_NPC_USABLE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("A <good>follower</good> could <info>make use of this CBM</info> if installed properly."),
})

-- Blinds the wearer while worn, and provides nominal protection vs flashbang flashes.
content.add(content.JsonFlag {
    id = "BLIND",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <bad>prevents</bad> you from <info>seeing</info> anything."),
})

content.add(content.JsonFlag {
    id = "BLOCK_WHILE_WORN",
    info = ccb.content.text("This item can be used to block attacks when worn."),
})

content.add(content.JsonFlag {
    id = "CALORIES_INTAKE",
    info = ccb.content.text("This item enables you to keep track of calorie intake."),
})

content.add(content.JsonFlag {
    id = "CALORIE_BURN",
    info = ccb.content.text("This item enables you to keep track of calorie consumption.  Includes CALORIES_INTAKE."),
})

content.add(content.JsonFlag {
    id = "CRYOGENIC_ROT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <info>requires specialized cryogenic preservation</info> and will <bad>spoil rapidly</bad> even at subzero temperatures."),
})

content.add(content.JsonFlag {
    id = "CASELESS_ROUNDS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Being caseless rounds, these <bad>cannot be disassembled or reloaded</bad>."),
})

content.add(content.JsonFlag {
    id = "CBM",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is a Compact Bionic Module.  You'll need to <info>use specialized machinery</info> or <info>ask a surgeon</info> to install it into your body."),
})

content.add(content.JsonFlag {
    id = "COLLAR",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing has a <info>wide collar</info> that can keep your mouth warm if it is unencumbered."),
})

content.add(content.JsonFlag {
    id = "COLLAPSE_CONTENTS",
    info = ccb.content.text("Contents are hidden by default in inventory view."),
})

do
    local flag = content.JsonFlag {
        id = "DEAF",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This gear <bad>prevents</bad> you from <info>hearing any sounds</info>."),
    }
    flag:conflicts_with("PARTIAL_DEAF")
    content.add(flag)
end

content.add(content.JsonFlag { id = "DESTROY_ON_CHARGE_USE" })

content.add(content.JsonFlag {
    id = "OVERHEATS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Continuously firing this weapon will cause it to <bad>overheat</bad> and <info>can potentially damage it</info>."),
})

content.add(content.JsonFlag {
    id = "DIAMOND",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item has a <good>diamond coating</good> improving its <info>cutting or piercing damage</info>."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "GEMSTONE",
    info = ccb.content.text("This item is a precious gemstone, used for ornamentation.  This is mostly useless post-Cataclysm."),
})

content.add(content.JsonFlag {
    id = "DIG_TOOL",
    info = ccb.content.text("While wielded, this item allows you to mine through rocks and other hard obstacles by moving into tiles with them.  Note that automatic mining option should be set to true for this to work."),
})

content.add(content.JsonFlag { id = "DURABLE" })

do
    local flag = content.JsonFlag {
        id = "DURABLE_MELEE",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("As a weapon, this item is <good>well-made</good> and will <info>withstand the punishment of combat</info>."),
    }
    flag:conflicts_with("FRAGILE_MELEE")
    content.add(flag)
end

content.add(content.JsonFlag {
    id = "EASY_CLEAN",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gun is made of <info>relatively simple parts</info> which makes powder fouling <good>easier to clean</good>."),
})

content.add(content.JsonFlag { id = "FIELD_DRESS" })
content.add(content.JsonFlag { id = "FIELD_DRESS_FAILED" })

content.add(content.JsonFlag {
    id = "HIDDEN",
    info = ccb.content.text("You have marked this article to not display a sprite when worn."),
})

content.add(content.JsonFlag { id = "QUARTERED" })

content.add(content.JsonFlag {
    id = "SCIENCE_CARD",
    info = ccb.content.text("You could probably use this to get into a secure science facility."),
})

content.add(content.JsonFlag {
    id = "MILITARY_CARD",
    info = ccb.content.text("You could probably use this to get into a secure military facility."),
})

content.add(content.JsonFlag {
    id = "INDOOR_GROWTH",
    info = ccb.content.text("It allows planting indoors without sunlight."),
})

content.add(content.JsonFlag {
    id = "INDUSTRIAL_CARD",
    info = ccb.content.text("You could probably use this to get into a secure industrial facility."),
})

content.add(content.JsonFlag {
    id = "ANDURIL_AR_CARD",
    info = ccb.content.text("You could probably use this to get into a secure Anduril Industries facility."),
})

content.add(content.JsonFlag {
    id = "EXODII_STRING_DIMENSION_CARD",
    info = ccb.content.text("You could probably use this to open some lock."),
})

content.add(content.JsonFlag {
    id = "COOP_CARD",
    info = ccb.content.text("Gives you access to the artisans workshop."),
})

content.add(content.JsonFlag { id = "SKINNED" })
content.add(content.JsonFlag { id = "BLED" })

content.add(content.JsonFlag {
    id = "CANT_HEAL_EVERYONE",
    info = ccb.content.text("This med can't be used by everyone, it requires a special mutation."),
})

content.add(content.JsonFlag {
    id = "CANT_WEAR",
    info = ccb.content.text("This armor can't be worn directly."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "DECAY_EXPOSED_ATMOSPHERE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("If exposed to the atmosphere, it will <bad>start to go bad</bad>."),
})

content.add(content.JsonFlag { id = "DIRTY" })

content.add(content.JsonFlag {
    id = "EATEN_COLD",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This tastes <good>better</good> while <color_light_cyan>cold</color>."),
})

content.add(content.JsonFlag {
    id = "EATEN_HOT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This tastes <good>better</good> while <color_red>hot</color>."),
})

content.add(content.JsonFlag {
    id = "HUNGER_DISRUPTION",
    info = ccb.content.text("You don't know how hungry you are when you are effected by this."),
})

content.add(content.JsonFlag {
    id = "CANNOT_CONSUME_DRUGS",
    info = ccb.content.text("You cannot use any item with the consume_drug use_action when you have this flag."),
})

content.add(content.JsonFlag {
    id = "ELECTRIC_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>electric discharges</info>."),
})

content.add(content.JsonFlag {
    id = "BIO_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>biological damage</info>."),
})

content.add(content.JsonFlag {
    id = "BASH_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>bash damage</info>."),
})

content.add(content.JsonFlag {
    id = "EMP_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>EMP blasts</info>."),
})

content.add(content.JsonFlag {
    id = "CUT_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>cut damage</info>."),
})

content.add(content.JsonFlag {
    id = "BULLET_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>bullet damage</info>."),
})

content.add(content.JsonFlag {
    id = "ACID_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>acid damage</info>."),
})

content.add(content.JsonFlag {
    id = "STAB_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>stab damage</info>."),
})

content.add(content.JsonFlag {
    id = "HEAT_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>high temperatures</info>."),
})

content.add(content.JsonFlag {
    id = "HELMET_FACE_SHIELD",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable in the front of <info>hard hats and helmets</info> to protect your eyes or face."),
    restriction = ccb.content.text("Item must be some kind of face shield"),
})

content.add(content.JsonFlag {
    id = "HELMET_FRONT_ATTACHMENT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable in the front of <info>military helmets</info>."),
    restriction = ccb.content.text("Item must be some kind of frontal helmet attachment"),
})

content.add(content.JsonFlag {
    id = "HELMET_EAR_ATTACHMENT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable in <info>hard hats and helmets</info> to cover the ears."),
    restriction = ccb.content.text("Item must be some kind of ear attachment"),
})

content.add(content.JsonFlag {
    id = "HELMET_NAPE_PROTECTOR",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable in <info>hard hats and helmets</info> as a nape protector."),
    restriction = ccb.content.text("Item must be some kind of nape protector"),
})

content.add(content.JsonFlag {
    id = "HELMET_MANDIBLE_GUARD",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable as a mandible guard in military <info>helmets</info> or headgear specifically adapted with rails for attachments."),
    restriction = ccb.content.text("Item must be some kind of rail-mounted mandible guard"),
})

content.add(content.JsonFlag {
    id = "HELMET_MANDIBLE_GUARD_STRAPPED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable as a mandible guard in <info>hard hats and helmets</info>."),
    restriction = ccb.content.text("Item must be some kind of strapped mandible guard"),
})

content.add(content.JsonFlag {
    id = "HELMET_BACK_POUCH",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable in the back of <info>hard hats and helmets</info> as a counterweight pouch."),
    restriction = ccb.content.text("Item must be some kind of back pouch"),
})

content.add(content.JsonFlag {
    id = "HELMET_HEAD_ATTACHMENT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is attachable in <info>tactical helmets</info> as a flashlight."),
    restriction = ccb.content.text("Item must be some kind of flashlight"),
})

content.add(content.JsonFlag {
    id = "HELMET_AVENTAIL",
    info = ccb.content.text("This item is attachable to metal cap helmets as a face and neck protective layer."),
    restriction = ccb.content.text("Item must be some kind of chainmail veil"),
})

content.add(content.JsonFlag {
    id = "BOOT_FINS",
    info = ccb.content.text("This item is attachable to commercial diving boots as fins."),
    restriction = ccb.content.text("Item must be some kind of fins"),
})

content.add(content.JsonFlag {
    id = "BOOT_FINS_CUSTOM",
    info = ccb.content.text("This item is attachable to custom diving boots as fins."),
    restriction = ccb.content.text("Item must be some kind of custom fins"),
})

content.add(content.JsonFlag {
    id = "HEAD_STRAP_MOUNT",
    info = ccb.content.text("This item is attachable to straps and mountings on some masks and hoods."),
    restriction = ccb.content.text("Item must be some kind of item that can be attached to straps on masks and hoods"),
})

content.add(content.JsonFlag {
    id = "WRIST_MOUNT_ATTACHMENT",
    info = ccb.content.text("This item is attachable to a proprietary wrist mount."),
    restriction = ccb.content.text("Item must be some kind of item that can be attached to a proprietary wrist mount"),
})

content.add(content.JsonFlag {
    id = "EXTRA_PLATING",
    info = ccb.content.text("This item is wearable over some armors as an extra layer of plating."),
    restriction = ccb.content.text("Item must be some kind of strapped additional plating"),
})

content.add(content.JsonFlag {
    id = "NO_WING_GLIDING",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <bad>prevents using wings to glide</bad>."),
})

content.add(content.JsonFlag {
    id = "COLD_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>low temperatures</info>."),
})

content.add(content.JsonFlag { id = "ACID" })
content.add(content.JsonFlag { id = "CORROSIVE" })

do
    local flag = content.JsonFlag {
        id = "COSPLAY_COSTUME",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This clothing is <info>cosplay costume</info>."),
    }
    flag:conflicts_with("COSPLAY_PROPS")
    content.add(flag)
end

do
    local flag = content.JsonFlag {
        id = "COSPLAY_PROPS",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This item is <info>cosplay prop</info>."),
    }
    flag:conflicts_with("COSPLAY_COSTUME")
    content.add(flag)
end

content.add(content.JsonFlag {
    id = "ONE_PER_LAYER",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("<info>Only one</info> item can be worn on this clothing layer."),
})

content.add(content.JsonFlag {
    id = "FIRE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item counts as <color_red>fire</color> for crafting purposes."),
})

content.add(content.JsonFlag {
    id = "FIRESTARTER",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can start <color_red>fire</color>."),
})

content.add(content.JsonFlag {
    id = "FIREWOOD",
    info = ccb.content.text("This item can serve as a firewood."),
})

content.add(content.JsonFlag {
    id = "FIX_FARSIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>corrects farsightedness</good>."),
})

content.add(content.JsonFlag {
    id = "FIX_NEARSIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>corrects nearsightedness</good>."),
})

-- Like MYOPIC, but can't be fixed by glasses.
content.add(content.JsonFlag { id = "MYOPIC_SUPERNATURAL" })

-- Like MYOPIC_IN_LIGHT, but can't be fixed by glasses.
content.add(content.JsonFlag { id = "MYOPIC_IN_LIGHT_SUPERNATURAL" })

-- Supernatural healing effects, like magical spells, do not work while you have this flag.  Does not block u_hp EoC effects
content.add(content.JsonFlag { id = "BLOCK_SUPERNATURAL_HEALING" })

-- Zombie-dropped clothing giving various penalties if Filthy mod is active.  Also CBMs harvested from zombies.
content.add(content.JsonFlag {
    id = "FILTHY",
    craft_inherit = true,
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is <bad>filthy</bad>."),
})

-- Used for eyes protection from flashbang.
content.add(content.JsonFlag { id = "FLASH_PROTECTION" })

content.add(content.JsonFlag {
    id = "FLOTATION",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing <info>prevents going underwater</info> including both <good>drowning</good> and <bad>diving</bad>."),
})

content.add(content.JsonFlag {
    id = "FIN",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing has fins that <good>improve swimming speed</good>, but <bad>reduce movement speed</bad> on land."),
})

do
    local flag = content.JsonFlag {
        id = "FRAGILE",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This gear is <bad>fragile</bad> and <info>won't protect you for long</info>."),
        inherit = false,
    }
    flag:conflicts_with("STURDY")
    content.add(flag)
end

do
    local flag = content.JsonFlag {
        id = "FRAGILE_MELEE",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("As a weapon, this item is <bad>flimsy</bad> and <info>won't last long in combat</info> before breaking apart."),
    }
    flag:conflicts_with("DURABLE_MELEE")
    content.add(flag)
end

content.add(content.JsonFlag {
    id = "GAS_PROOF",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>any gas</info>."),
})

content.add(content.JsonFlag {
    id = "HOOD",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing has a <info>hood</info> to keep your head warm if your head is unencumbered."),
})

content.add(content.JsonFlag {
    id = "HYGROMETER",
    info = ccb.content.text("This gear is equipped with an accurate hygrometer (which is used to measure humidity)."),
})

-- You can visually inspect how much it is burned out (candle, torch).
content.add(content.JsonFlag { id = "BURNOUT" })

content.add(content.JsonFlag {
    id = "BRASS_CATCHER",
    info = ccb.content.text("This gun mod catches ejected casings."),
})

content.add(content.JsonFlag {
    id = "IRREMOVABLE",
    info = ccb.content.text("This item is a component of the gun it is attached to.  It can't be removed without destroying it."),
    inherit = false,
})

-- Item is on the normal layer.
content.add(content.JsonFlag {
    id = "NORMAL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <info>fits like</info> normal clothing."),
})

-- Item can never be used with a CVD machine.
content.add(content.JsonFlag { id = "NO_CVD" })

-- Prevents repairing of this item even if otherwise suitable tools exist.
content.add(content.JsonFlag {
    id = "NO_REPAIR",
    inherit = false,
})

-- items that are impossible to clean no matter how hard you try
content.add(content.JsonFlag {
    id = "NO_CLEAN",
    info = ccb.content.text("This item is impossible to clean."),
})

-- forces calories and vitamins to be the ones defined in the json, instead of inheriting from ingredients
content.add(content.JsonFlag { id = "NUTRIENT_OVERRIDE" })

-- This thing has been removed from the game
content.add(content.JsonFlag {
    id = "OBSOLETE",
    info = ccb.content.text("This thing no longer spawns naturally and has been obsoleted."),
})

content.add(content.JsonFlag {
    id = "PLANTABLE_SEED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("You could probably <color_brown>plant</color> these."),
})

content.add(content.JsonFlag {
    id = "POST_UP",
    info = ccb.content.text("This item can be put up on a wall, like a poster."),
})

content.add(content.JsonFlag {
    id = "MELTS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This food <neutral>melts when not in a very cold climate</neutral>, and tastes much <good>better</good> when <color_light_cyan>frozen</color>."),
})

content.add(content.JsonFlag { id = "MAG_DESTROY" })
content.add(content.JsonFlag { id = "MOP" })

-- This clothing is a prosthetic limb for the arms, and can only be used as a replacement limb.
content.add(content.JsonFlag { id = "ARM_PROSTHETIC" })

-- This clothing is a prosthetic limb for the legs, and can only be used as a replacement limb.
content.add(content.JsonFlag { id = "LEG_PROSTHETIC" })

-- Outer garment layer.
content.add(content.JsonFlag {
    id = "OUTER",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear is generally <info>worn over</info> clothing."),
})

-- Can always be worn no matter encumbrance/mutations/bionics/etc., but prevents any other clothing being worn over this.
content.add(content.JsonFlag {
    id = "OVERSIZE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing is large enough to accommodate <info>abnormally large mutated anatomy</info>."),
})

-- This clothing can be worn comfortably by mutants with Tiny or Unassuming.  Too small for anyone else.
content.add(content.JsonFlag { id = "UNDERSIZE" })

do
    local flag = content.JsonFlag {
        id = "PARTIAL_DEAF",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This gear <good>reduces</good> the volume of <info>sounds</info> to a safe level."),
    }
    flag:conflicts_with("DEAF")
    content.add(flag)
end

-- This item goes in the personal aura layer, intended for metaphysical effects.
content.add(content.JsonFlag {
    id = "PERSONAL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This is in your <info>personal aura</info>."),
})

-- Increases warmth for hands if the player's hands are cold and the player is wielding nothing.
content.add(content.JsonFlag {
    id = "POCKETS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing has <info>pockets</info> to warm your hands when you are wielding nothing."),
})

content.add(content.JsonFlag {
    id = "POLEARM",
    info = ccb.content.text("As a weapon, this item needs considerable space to use properly and does 70% of its normal damage to adjacent enemies."),
})

-- Designates a food that is usually undesirable but gives a morale bonus to characters with predator mutations.
content.add(content.JsonFlag { id = "PREDATOR_FUN" })

-- This item will store the tripoint_abs_ms it spawned in the 'spawn_location' var
content.add(content.JsonFlag { id = "PRESERVE_SPAWN_LOC" })

-- Shows a snippet of how far the character from the `spawn_location`: 1 OMT or less is `(from here)`, less than 6 OMT is `(from nearby)`, less than 30 OMT is `(from this area)`, anything more is (from far away)
content.add(content.JsonFlag { id = "HINT_THE_LOCATION" })

-- Shows a snippet with the name of the closest city to the `spawn_location`
content.add(content.JsonFlag { id = "LOCATION_PRECISE_CLOSEST_CITY" })

-- This item provides martial arts techniques in addition to the character's weapon
content.add(content.JsonFlag { id = "PROVIDES_TECHNIQUES" })

-- This item will spawn active. Not advised for items that drain power when active.
content.add(content.JsonFlag { id = "SPAWN_ACTIVE" })

content.add(content.JsonFlag { id = "STAB" })
content.add(content.JsonFlag { id = "SPEAR" })
content.add(content.JsonFlag { id = "PRIMITIVE_RANGED_WEAPON" })
content.add(content.JsonFlag { id = "SOLARPACK_ON" })
content.add(content.JsonFlag { id = "PSEUDO" })
content.add(content.JsonFlag { id = "RADIOSIGNAL_1" })
content.add(content.JsonFlag { id = "RADIOSIGNAL_2" })
content.add(content.JsonFlag { id = "RADIOSIGNAL_3" })
content.add(content.JsonFlag { id = "RADIO_ACTIVATION" })
content.add(content.JsonFlag { id = "RADIO_MOD" })
content.add(content.JsonFlag { id = "RADIOCARITEM" })
content.add(content.JsonFlag { id = "DISCOUNT_VALUE_1" })
content.add(content.JsonFlag { id = "DISCOUNT_VALUE_2" })
content.add(content.JsonFlag { id = "DISCOUNT_VALUE_3" })

content.add(content.JsonFlag {
    id = "MC_MOBILE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Can be used to <info>store data</info> for other devices."),
})

content.add(content.JsonFlag {
    id = "MC_HAS_DATA",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Some of your data is <info>stored</info> here."),
})

content.add(content.JsonFlag { id = "NO_PARASITES" })
content.add(content.JsonFlag { id = "MUSHY" })

content.add(content.JsonFlag {
    id = "IRRADIATED",
    info = ccb.content.text("This food item has been irradiated, and will spoil 4 times slower."),
})

content.add(content.JsonFlag { id = "FREEZERBURN" })

content.add(content.JsonFlag {
    id = "OLD_CURRENCY",
    info = ccb.content.text("This item used to be legal tender before the Cataclysm."),
})

content.add(content.JsonFlag { id = "NO_AUTO_CONSUME" })

content.add(content.JsonFlag {
    id = "NO_WEAR_EFFECT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can be worn, but it <neutral>won't provide any effects</neutral>."),
})

content.add(content.JsonFlag {
    id = "PADDED",
    info = ccb.content.text("This item has notable padding and will be comfortable worn without clothing under it."),
})

content.add(content.JsonFlag {
    id = "PALS_SMALL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item will <good>attach directly</good> to <info>load bearing vests</info>, taking a <good>small amount of space</good>."),
})

content.add(content.JsonFlag {
    id = "PALS_MEDIUM",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item will <good>attach directly</good> to <info>load bearing vests</info>, taking an average amount of space."),
})

content.add(content.JsonFlag {
    id = "PALS_LARGE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item will <good>attach directly</good> to <info>load bearing vests</info>, taking a <bad>large amount of space</bad>."),
})

-- 25% chance to protect against fear_paralyze monster attack.
content.add(content.JsonFlag {
    id = "PSYSHIELD_PARTIAL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>keeps out</good> the <info>mind control rays</info>."),
})

content.add(content.JsonFlag {
    id = "RAD_DETECT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can <good>detect</good> dangerous levels of <info>radiation</info>."),
})

do
    local flag = content.JsonFlag {
        id = "RAD_PROOF",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This clothing <good>completely protects</good> you from <info>radiation</info>."),
    }
    flag:conflicts_with("RAD_RESIST")
    content.add(flag)
end

do
    local flag = content.JsonFlag {
        id = "RAD_RESIST",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This clothing <good>partially protects</good> you from <info>radiation</info>."),
    }
    flag:conflicts_with("RAD_PROOF")
    content.add(flag)
end

content.add(content.JsonFlag {
    id = "RAD_STERILIZED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Sterilized using radiation, so it's <good>safe to eat</good>."),
})

content.add(content.JsonFlag {
    id = "REQUIRES_BALANCE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear requires careful balance to use.  Being hit while wearing it could make you <bad>fall down</bad>."),
})

content.add(content.JsonFlag { id = "ROLLER_ONE" })
content.add(content.JsonFlag { id = "ROLLER_INLINE" })
content.add(content.JsonFlag { id = "ROLLER_QUAD" })

content.add(content.JsonFlag {
    id = "TWO_WAY_RADIO",
    info = ccb.content.text("This item can be used to communicate with radio waves."),
})

content.add(content.JsonFlag {
    id = "PERFECT_LOCKPICK",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can be used to <info>pick locks</info> with <good>zero effort</good>."),
})

-- Prevents the covered body-part(s) from getting wet in the rain.
content.add(content.JsonFlag {
    id = "RAINPROOF",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing is designed to keep you <info>dry</info> in the rain."),
})

-- Prevents the player from wielding a weapon two-handed, forcing one-handed use if the weapon permits it.
content.add(content.JsonFlag { id = "RESTRICT_HANDS" })

-- Prevents the item from participating in the encumbrance system when worn.
content.add(content.JsonFlag {
    id = "SEMITANGIBLE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("It seems <info>partially intangible</info>, and can occupy the same space as other things when worn."),
})

content.add(content.JsonFlag {
    id = "SHEATH_AXE",
    restriction = ccb.content.text("Item must fit in an axe sheath"),
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can <info>fit in an axe sheath</info> of the appropriate size."),
})

content.add(content.JsonFlag {
    id = "SHEATH_KNIFE",
    restriction = ccb.content.text("Item must fit in a sheath"),
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can <info>fit in a sheath</info> of the appropriate size."),
})

content.add(content.JsonFlag {
    id = "SHEATH_SWORD",
    restriction = ccb.content.text("Item must fit in a scabbard"),
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can <info>fit in a scabbard</info> of the appropriate size."),
})

content.add(content.JsonFlag {
    id = "SHEATH_SPEAR",
    restriction = ccb.content.text("Item must attach to a spear strap"),
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can <info>attach to a spear strap</info> of the appropriate size."),
})

content.add(content.JsonFlag {
    id = "SHEATH_BOW",
    restriction = ccb.content.text("Item must fit in a bow sling"),
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can <info>fit in a bow sling</info> of the appropriate size."),
})

-- This item can be stored in a bag of the appropriate size.
content.add(content.JsonFlag { id = "SHEATH_GOLF" })

-- Undergarment layer.
content.add(content.JsonFlag {
    id = "SKINTIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing <info>lies close</info> to the skin."),
})

content.add(content.JsonFlag {
    id = "SLEEP_AID",
    info = ccb.content.text("This item provides comfort during sleep."),
})

content.add(content.JsonFlag { id = "SLEEP_AID_CONTAINER" })
content.add(content.JsonFlag { id = "REVIVE_SPECIAL" })

do
    local flag = content.JsonFlag {
        id = "STURDY",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This clothing will <good>protect</good> you from harm and withstand <info>a lot of abuse</info>."),
        inherit = false,
    }
    flag:conflicts_with("FRAGILE")
    content.add(flag)
end

-- Hardcoded application/removal.
content.add(content.JsonFlag { id = "FAULT_ON_COMPLETION" })

-- Prevents glaring when in sunlight.
content.add(content.JsonFlag {
    id = "SUN_GLASSES",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing keeps the <info>glare</info> out of your eyes."),
})

-- Allows you to see much further under water.
content.add(content.JsonFlag {
    id = "SWIM_GOGGLES",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing allows you to <good>see much further</good> <info>under water</info>."),
})

content.add(content.JsonFlag {
    id = "THERMOMETER",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear is equipped with an <info>accurate thermometer</info>."),
})

-- Can be made to fit via tailoring.
content.add(content.JsonFlag { id = "VARSIZE" })

-- Layer for belts and other things worn on the waist.
content.add(content.JsonFlag {
    id = "WAIST",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear is worn on or around your <info>waist</info>."),
})

-- Acts as a watch and allows the player to see actual time.
content.add(content.JsonFlag {
    id = "WATCH",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear allows to see <info>actual time</info>."),
})

-- Prevents the covered body-part(s) from getting wet in any circumstance.
content.add(content.JsonFlag {
    id = "WATERPROOF",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing <info>won't let water through</info>.  Even if you jump into a river."),
})

-- Prevents the item from making the body part count as unfriendly to water and thus causing negative morale from being wet.
content.add(content.JsonFlag {
    id = "WATER_FRIENDLY",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing <good>performs well</good> even when <info>soaking wet</info>.  This can feel good."),
})

-- Glare lasts twice as long.
content.add(content.JsonFlag { id = "HIGH_GLARE" })

content.add(content.JsonFlag {
    id = "ITEM_BROKEN",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item was broken and <bad>won't activate anymore</bad>."),
})

content.add(content.JsonFlag {
    id = "WATER_BREAK",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <bad>will get broken</bad> by water."),
})

content.add(content.JsonFlag {
    id = "WATER_BREAK_ACTIVE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <bad>will get broken</bad> by water if it gets <info>submerged while active</info>."),
})

content.add(content.JsonFlag {
    id = "WATER_DISSOLVE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <bad>will get dissolved</bad> in water."),
})

content.add(content.JsonFlag { id = "WET" })

-- Allows power armor to be worn with compatible armors like ear plugs and mouthpieces.
content.add(content.JsonFlag {
    id = "POWERARMOR_COMPATIBLE",
    info = ccb.content.text("This item can be worn simultaneously with power armor."),
})

content.add(content.JsonFlag { id = "ZERO_WEIGHT" })

content.add(content.JsonFlag {
    id = "ZOOM",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item can be used to <good>better</good> see <info>things far away</info>."),
})

content.add(content.JsonFlag {
    id = "furred",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing has a fur lining sewn into it to <good>increase</good> its overall <info>warmth</info>."),
})

content.add(content.JsonFlag {
    id = "kevlar_padded",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear has Kevlar inserted into strategic locations to <good>increase protection</good> with some <bad>increase to encumbrance</bad>."),
})

content.add(content.JsonFlag {
    id = "leather_padded",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear has certain parts padded with leather to <good>increase protection</good> with moderate <bad>increase to encumbrance</bad>."),
})

content.add(content.JsonFlag {
    id = "steel_padded",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear has certain parts padded with steel to <good>increase protection</good> with moderate <bad>increase to encumbrance</bad>."),
})

content.add(content.JsonFlag {
    id = "wooled",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing has a wool lining sewn into it to <good>increase</good> its overall <info>warmth</info>."),
})

-- This gun wont train marksmanship when fired.  Used in Aftershock smart guns.
content.add(content.JsonFlag { id = "WONT_TRAIN_MARKSMANSHIP" })

-- Used in Aftershock gene editing.
content.add(content.JsonFlag { id = "GENE_TECH" })

content.add(content.JsonFlag {
    id = "NANOFAB_REPAIR",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item has a holographic patch that reflects the light oddly.  It was constructed in a nanofabricator and can be <info>repaired in one</info>."),
})

content.add(content.JsonFlag {
    id = "NANOFAB_TEMPLATE",
    info = ccb.content.text("This item contains a nanofabricator recipe."),
})

content.add(content.JsonFlag {
    id = "NANOFAB_TEMPLATE_SINGLE_USE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This template is copy protected and will be <bad>destroyed</bad> after a single use."),
})

content.add(content.JsonFlag {
    id = "BIONIC_FAULTY",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This bionic is <bad>faulty</bad>."),
})

content.add(content.JsonFlag {
    id = "BIONIC_POWER_SOURCE",
    info = ccb.content.text("This bionic provides power."),
})

-- This bionic only has a function when activated, else it causes its effect every turn.
content.add(content.JsonFlag { id = "BIONIC_TOGGLED" })

-- This bionic is a gun bionic and activating it will fire it.  Prevents all other activation effects.
content.add(content.JsonFlag { id = "BIONIC_GUN" })

-- This bionic is a weapon bionic and activating it will create (or destroy) bionic's fake_item in user's hands.  Prevents all other activation effects.
content.add(content.JsonFlag { id = "BIONIC_WEAPON" })

content.add(content.JsonFlag {
    id = "BIONIC_ARMOR_INTERFACE",
    info = ccb.content.text("This bionic can provide power to powered armor."),
})

-- This makes the spell's effects permanent.
content.add(content.JsonFlag { id = "PERMANENT" })

-- Spellcasting never fails for this spell
content.add(content.JsonFlag { id = "NO_FAIL" })

-- Spellcasting never shows any messages for this spell
content.add(content.JsonFlag { id = "HIDDEN_SPELL" })

-- This makes the spell's Area of Effect ignore walls.
content.add(content.JsonFlag { id = "IGNORE_WALLS" })

-- You can cast spells with this item in your hand.
content.add(content.JsonFlag { id = "MAGIC_FOCUS" })

-- This makes the spell's summoned monster always hostile.  Note that the spell needs to be a summon spell for this to do anything.
content.add(content.JsonFlag { id = "HOSTILE_SUMMON" })

-- This makes the spell's summoned monster hostile 50% of the time.  Note that the spell needs to be a summon spell for this to do anything.
content.add(content.JsonFlag { id = "HOSTILE_50" })

-- The spell makes no sound at its point of impact.
content.add(content.JsonFlag { id = "SILENT" })

-- This spell is much louder at its point of impact.
content.add(content.JsonFlag { id = "LOUD" })

-- The caster must speak in order to cast the spell.  More mouth encumbrance increases failure percent, and the caster speaks when casting.
content.add(content.JsonFlag { id = "VERBAL" })

-- The spell requires arm movement to cast.  Arm encumbrance affects failure percentage and casting time.
content.add(content.JsonFlag { id = "SOMATIC" })

-- The spell does not require hands in order to cast it.  Encumbrance penalties on hands are nullified.
content.add(content.JsonFlag { id = "NO_HANDS" })

-- This spell does not require leg movement in order to be cast.  All encumbrance penalties for legs are nullified.
content.add(content.JsonFlag { id = "NO_LEGS" })

-- This spell requires focus to cast.  The lower your focus, the higher failure rate to cast.
content.add(content.JsonFlag { id = "CONCENTRATE" })

-- Chooses a spell at random to cast from extra_effects.  See MAGIC.md for details
content.add(content.JsonFlag { id = "WONDER" })

-- A spell extra effects are cast before the main spell.  See MAGIC.md for details
content.add(content.JsonFlag { id = "EXTRA_EFFECTS_FIRST" })

-- pain altering spells can't be resisted (like with the deadened trait)
content.add(content.JsonFlag { id = "PAIN_NORESIST" })

-- Allows summoned monsters to drop their usual death drops.  Otherwise, summoned monsters drop nothing on death.
content.add(content.JsonFlag { id = "SPAWN_WITH_DEATH_DROPS" })

-- The character is in a form other than their natural one due to some preternatural effect.
content.add(content.JsonFlag { id = "TEMPORARY_SHAPESHIFT" })

-- Due to shapeshifting, the character is size Tiny.
content.add(content.JsonFlag { id = "SHAPESHIFT_SIZE_TINY" })

-- Due to shapeshifting, the character is size Small.
content.add(content.JsonFlag { id = "SHAPESHIFT_SIZE_SMALL" })

-- Due to shapeshifting, the character is size Large.
content.add(content.JsonFlag { id = "SHAPESHIFT_SIZE_LARGE" })

-- Due to shapeshifting, the character is size Huge.
content.add(content.JsonFlag { id = "SHAPESHIFT_SIZE_HUGE" })

-- Due to shapeshifting, the character lacks humanoid hands.
content.add(content.JsonFlag { id = "TEMPORARY_SHAPESHIFT_NO_HANDS" })

-- Used to tag armor that is part of the character's new form to apply other flags.
content.add(content.JsonFlag {
    id = "SHAPESHIFTED_ARMOR",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is currently <good>part of your form</good> and <bad>will not protect you</bad>."),
})

-- Prevents armor from protecting the character.
content.add(content.JsonFlag { id = "INTANGIBLE_ARMOR" })

-- Due to mutation, your hands (or paws etc) are not suitable to use firearms.
content.add(content.JsonFlag { id = "HANDS_CANNOT_USE_FIREARMS" })

-- This mutation does not count toward thresholds at all.
content.add(content.JsonFlag { id = "NON_THRESH" })

-- Applies robust genetic bonus - mutations give only 1 unit of instability for all traits instead of 1 unit for your current tree, and 2 for any outer tree.
content.add(content.JsonFlag { id = "ROBUST_GENETIC" })

-- For some reason you're unable to use a computer terminal.
content.add(content.JsonFlag { id = "CANNOT_USE_COMPUTERS" })

-- If food gives any health bonus or penalty, having this flag would prevent you from receiving such.
content.add(content.JsonFlag { id = "SKIP_HEALTH" })

-- Contains hallucinogenic compounds from foraged foods.
content.add(content.JsonFlag {
    id = "HIDDEN_HALLU",
    craft_inherit = true,
})

-- Contains poisonous compounds from foraged foods.
content.add(content.JsonFlag {
    id = "HIDDEN_POISON",
    craft_inherit = true,
})

-- Has a bad taste or texture that can't be covered up through cooking.
content.add(content.JsonFlag {
    id = "BAD_TASTE",
    craft_inherit = true,
    taste_modifier = -5,
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This food is <bad>unappetizing</bad> in a way that <bad>can't be covered up by most cooking</bad>."),
})

-- Decreases calories as they appear in JSON def by 25%.  This penalty is removed if the item is used in a recipe that requires heating.
content.add(content.JsonFlag {
    id = "RAW",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This food is <info>raw</info>, and will be <good>more nutritious</good> if cooked."),
})

-- Obsoleted!
content.add(content.JsonFlag { id = "CANNIBALISM" })

content.add(content.JsonFlag {
    id = "STRICT_HUMANITARIANISM",
    craft_inherit = true,
})

content.add(content.JsonFlag { id = "ALLERGEN_BREAD" })
content.add(content.JsonFlag { id = "ALLERGEN_CHEESE" })
content.add(content.JsonFlag { id = "ALLERGEN_DRIED_VEGETABLE" })
content.add(content.JsonFlag { id = "ALLERGEN_EGG" })
content.add(content.JsonFlag { id = "ALLERGEN_FRUIT" })
content.add(content.JsonFlag { id = "ALLERGEN_JUNK" })
content.add(content.JsonFlag { id = "ALLERGEN_MEAT" })
content.add(content.JsonFlag { id = "ALLERGEN_MILK" })
content.add(content.JsonFlag { id = "ALLERGEN_NUT" })
content.add(content.JsonFlag { id = "ALLERGEN_VEGGY" })
content.add(content.JsonFlag { id = "ALLERGEN_WHEAT" })
content.add(content.JsonFlag { id = "ALLERGEN_WOOL" })
content.add(content.JsonFlag { id = "ANIMAL_PRODUCT" })

content.add(content.JsonFlag {
    id = "ALWAYS_TWOHAND",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("<bad>You must</bad> have two free hands to wield this item."),
})

content.add(content.JsonFlag { id = "APPLIANCE" })
content.add(content.JsonFlag { id = "BIPOD" })
content.add(content.JsonFlag { id = "BIRD" })
content.add(content.JsonFlag { id = "BOMB" })
content.add(content.JsonFlag { id = "BYPRODUCT" })
content.add(content.JsonFlag { id = "CABLE_SPOOL" })
content.add(content.JsonFlag { id = "CAMERA_PRO" })
content.add(content.JsonFlag { id = "CANNIBAL" })
content.add(content.JsonFlag { id = "CARDIO_MIN_GUARANTE" })
content.add(content.JsonFlag { id = "CARNIVORE_OK" })
content.add(content.JsonFlag { id = "CASING" })
content.add(content.JsonFlag { id = "CATTLE" })
content.add(content.JsonFlag { id = "CHALLENGE" })
content.add(content.JsonFlag { id = "CHARGEDIM" })
content.add(content.JsonFlag { id = "CITY_START" })
content.add(content.JsonFlag { id = "COLD" })

-- this is deprecated for the COLLAPSED_STOCK and FOLDED_STOCK, kept around for mod support
content.add(content.JsonFlag { id = "COLLAPSIBLE_STOCK" })

-- for weapons whose stock has been cut off.
content.add(content.JsonFlag {
    id = "REMOVED_STOCK",
    info = ccb.content.text("This item has had its stock removed, it will be hard to shoot with."),
})

-- for weapons that stock folds to one side, no change in volume.
content.add(content.JsonFlag {
    id = "FOLDED_STOCK",
    info = ccb.content.text("This items stock is folded it will be hard to shoot with."),
})

-- for weapons that stock collapses into the body reducing volume as well.
content.add(content.JsonFlag {
    id = "COLLAPSED_STOCK",
    info = ccb.content.text("This items stock is collapsed it will be hard to shoot with."),
})

content.add(content.JsonFlag { id = "CONDUCTIVE" })
content.add(content.JsonFlag { id = "CONSUMABLE" })
content.add(content.JsonFlag { id = "COOKED" })
content.add(content.JsonFlag { id = "CORPSE" })
content.add(content.JsonFlag { id = "CRUTCHES" })
content.add(content.JsonFlag { id = "CUSTOM_EXPLOSION" })
content.add(content.JsonFlag { id = "DANGEROUS" })
content.add(content.JsonFlag { id = "DIMENSIONAL_ANCHOR" })
content.add(content.JsonFlag { id = "PORTAL_PROOF" })
content.add(content.JsonFlag { id = "TELEPORT_LOCK" })
content.add(content.JsonFlag { id = "DISABLE_SIGHTS" })
content.add(content.JsonFlag { id = "DROP_ACTION_ONLY_IF_LIQUID" })
content.add(content.JsonFlag { id = "EDIBLE_FROZEN" })
content.add(content.JsonFlag { id = "EFFECT_IMPEDING" })

-- Allows an effect type to trigger the bounded Lua hook when it is first added.
content.add(content.JsonFlag { id = "EFFECT_LUA_ON_ADDED" })

-- Allows an effect type to trigger the bounded Lua hook while it is processed.
content.add(content.JsonFlag { id = "EFFECT_LUA_ON_TICK" })

-- Allows an effect type to trigger the bounded Lua hook after it is removed.
content.add(content.JsonFlag { id = "EFFECT_LUA_ON_REMOVED" })

content.add(content.JsonFlag { id = "ENCUMBRANCE_UPDATE" })
content.add(content.JsonFlag { id = "ETHEREAL_ITEM" })
content.add(content.JsonFlag { id = "E_COMBUSTION" })
content.add(content.JsonFlag { id = "FAKE_MILL" })
content.add(content.JsonFlag { id = "FAKE_SMOKE" })
content.add(content.JsonFlag { id = "FLAT_TIRE" })
content.add(content.JsonFlag { id = "FELINE" })
content.add(content.JsonFlag { id = "FERTILIZER" })
content.add(content.JsonFlag { id = "FIT" })
content.add(content.JsonFlag { id = "FLAMING" })
content.add(content.JsonFlag { id = "FORAGE_HALLU" })
content.add(content.JsonFlag { id = "FORAGE_POISON" })
content.add(content.JsonFlag { id = "FROZEN" })
content.add(content.JsonFlag { id = "FUNGAL_VECTOR" })
content.add(content.JsonFlag { id = "GAS_DISCOUNT" })
content.add(content.JsonFlag { id = "GIBBED" })
content.add(content.JsonFlag { id = "GNV_EFFECT" })
content.add(content.JsonFlag { id = "HIDDEN_ITEM" })
content.add(content.JsonFlag { id = "HOT" })
content.add(content.JsonFlag { id = "HURT_WHEN_WIELDED" })
content.add(content.JsonFlag { id = "IMPERIAL_ROAD_KEY" })
content.add(content.JsonFlag { id = "IMPERIAL_ROAD_TRAVELER" })
content.add(content.JsonFlag { id = "INEDIBLE" })
content.add(content.JsonFlag { id = "INITIAL_PART" })
content.add(content.JsonFlag { id = "INSPIRATIONAL" })
content.add(content.JsonFlag { id = "INSTALL_DIFFICULT" })

content.add(content.JsonFlag {
    id = "INTEGRATED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This is <info>integrated into the body</info>."),
})

content.add(content.JsonFlag {
    id = "MUTATED_ANATOMY_ONLY",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This can only be worn by those with <info>particular mutated anatomy</info> "),
})

content.add(content.JsonFlag {
    id = "MORPHIC",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This is <info>naturally sized to the body</info>."),
})

content.add(content.JsonFlag { id = "IS_ARMOR" })
content.add(content.JsonFlag { id = "IS_PET_ARMOR" })

content.add(content.JsonFlag {
    id = "IS_UPS",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item provides power to <info>UPS compatible items</info>."),
    inherit = false,
})

content.add(content.JsonFlag { id = "LEAK_DAM" })
content.add(content.JsonFlag { id = "LITCIG" })
content.add(content.JsonFlag { id = "LUPINE" })
content.add(content.JsonFlag { id = "MAG_BELT" })

content.add(content.JsonFlag {
    id = "MAG_BULKY",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item is <bad>bulky</bad> and may not fit in all magazine pockets."),
    restriction = ccb.content.text("Item must be a bulky magazine"),
})

content.add(content.JsonFlag { id = "MAG_EJECT" })
content.add(content.JsonFlag { id = "MANUAL_CBM_INSTALLATION" })
content.add(content.JsonFlag { id = "MECH_BAT" })
content.add(content.JsonFlag { id = "MESSY" })
content.add(content.JsonFlag { id = "MISSION_ITEM" })

-- Allows enchantment check to get modules in pockets of this item (modules are items which have an enchantment effect and the HAS:WORN flag.
content.add(content.JsonFlag { id = "MODULE_HOLDER" })

content.add(content.JsonFlag {
    id = "MOUNTED_GUN",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This weapon is <bad>too unwieldy</bad> to fire on its own and <info>must be mounted</info> on a vehicle or furniture (window, table, mound of dirt, etc.) before use."),
})

-- A jackhammer that can mine and destroy walls
content.add(content.JsonFlag { id = "MULTI_DRILL" })

-- For items that have relic data but aren't actually magic
content.add(content.JsonFlag {
    id = "MUNDANE",
    info = ccb.content.text("This item is designed to have special effects"),
})

-- For items that do not have relic data, but intended to be magical; changes the color of item to pink
content.add(content.JsonFlag { id = "RELIC_PINK" })

content.add(content.JsonFlag {
    id = "MUTAGEN_SAMPLE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Used in the <neutral>creation of mutagenic drugs</neutral>."),
})

content.add(content.JsonFlag {
    id = "MUTAGEN_CATALYST",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Injecting it will <neutral>jumpstart mutation</neutral>."),
})

content.add(content.JsonFlag {
    id = "MUTAGEN_PRIMER",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Injecting it will <neutral>prime your body for mutation</neutral>."),
})

content.add(content.JsonFlag { id = "MYCUS_OK" })
content.add(content.JsonFlag { id = "NEEDS_NO_LUBE" })

content.add(content.JsonFlag {
    id = "NEEDS_SUNLIGHT",
    info = ccb.content.text("This tool only functions in strong direct sunlight.  It will not work indoors, underground, at night, or in overcast weather."),
})

-- Does not specifically cause magical effects, but used to know if an item can be considered magical by the code
content.add(content.JsonFlag { id = "MAGICAL" })

-- should not be used for folding mods, use a transforming mod instead
content.add(content.JsonFlag { id = "NEEDS_UNFOLD" })

content.add(content.JsonFlag { id = "NEGATIVE_MONOTONY_OK" })
content.add(content.JsonFlag { id = "NEVER_JAMS" })
content.add(content.JsonFlag { id = "NONCONDUCTIVE" })
content.add(content.JsonFlag { id = "NON_FOULING" })
content.add(content.JsonFlag { id = "NO_DROP" })
content.add(content.JsonFlag { id = "NO_INGEST" })
content.add(content.JsonFlag { id = "NO_PACKED" })
content.add(content.JsonFlag { id = "NO_RELOAD" })
content.add(content.JsonFlag { id = "NO_SALVAGE" })
content.add(content.JsonFlag { id = "NO_STERILE" })
content.add(content.JsonFlag { id = "NO_TAKEOFF" })
content.add(content.JsonFlag { id = "NO_TEMP" })

-- This flag should only be applied to GUN definitions, it will prevent generation of a turret vehicle part for the gun.  This blocks fake guns, or player unobtainable ones from appearing in turret list.
content.add(content.JsonFlag { id = "NO_TURRET" })

content.add(content.JsonFlag {
    id = "NO_UNLOAD",
    inherit = false,
})

content.add(content.JsonFlag { id = "NO_UNWIELD" })
content.add(content.JsonFlag { id = "NPC_ACTIVATE" })
content.add(content.JsonFlag { id = "NPC_ALT_ATTACK" })
content.add(content.JsonFlag { id = "NPC_SAFE" })
content.add(content.JsonFlag { id = "NPC_THROWN" })
content.add(content.JsonFlag { id = "NPC_THROW_NOW" })
content.add(content.JsonFlag { id = "NVG_GREEN" })
content.add(content.JsonFlag { id = "ORGANIC" })
content.add(content.JsonFlag { id = "PERPETUAL" })
content.add(content.JsonFlag { id = "PLACE_RANDOMLY" })
content.add(content.JsonFlag { id = "POWERED" })
content.add(content.JsonFlag { id = "PROCESSING" })
content.add(content.JsonFlag { id = "PROCESSING_RESULT" })
content.add(content.JsonFlag { id = "PULPED" })
content.add(content.JsonFlag { id = "PUMP_RAIL" })

content.add(content.JsonFlag {
    id = "LEVER_ACTION",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This weapon uses a manual lever to load each round into the chamber, forcing you to cock the lever after each shot, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are."),
})

content.add(content.JsonFlag {
    id = "SINGLE_ACTION",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This weapon requires you to cock the hammer of a firearm manually, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are."),
})

content.add(content.JsonFlag {
    id = "PUMP_ACTION",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This weapon requires you to manually pull and insert cartridge into the chamber by sliding a handguard, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are."),
})

content.add(content.JsonFlag {
    id = "BOLT_ACTION",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This weapon requires you to manually pull and insert cartridge into the chamber using a turn-bolt, which <bad>takes additional time</bad> and <bad>messes your aim</bad>.  The penalty is decreased the more experienced with guns you are."),
})

content.add(content.JsonFlag { id = "RADIOACTIVE" })
content.add(content.JsonFlag { id = "RADIOCAR" })
content.add(content.JsonFlag { id = "RADIO_CONTAINER" })
content.add(content.JsonFlag { id = "RADIO_INVOKE_PROC" })
content.add(content.JsonFlag { id = "RAIN_PROTECT" })
content.add(content.JsonFlag { id = "REACH3" })
content.add(content.JsonFlag { id = "REACH_ATTACK" })
content.add(content.JsonFlag { id = "REBREATHER" })
content.add(content.JsonFlag { id = "REBREATHER_INTERNAL" })
content.add(content.JsonFlag { id = "RECHARGE" })
content.add(content.JsonFlag { id = "REDUCED_BASHING" })
content.add(content.JsonFlag { id = "REDUCED_WEIGHT" })
content.add(content.JsonFlag { id = "RELOAD_AND_SHOOT" })
content.add(content.JsonFlag { id = "RELOAD_EJECT" })
content.add(content.JsonFlag { id = "RELOAD_ONE" })
content.add(content.JsonFlag { id = "REQUIRES_TINDER" })
content.add(content.JsonFlag { id = "SADDLE_BAG" })
content.add(content.JsonFlag { id = "SAFECRACK" })

content.add(content.JsonFlag {
    id = "SCBA",
    info = ccb.content.text("If paired with an air source and activated, this item can be used to breathe from a self-contained breathing apparatus."),
})

content.add(content.JsonFlag {
    id = "SCBA_ON",
    info = ccb.content.text("This item is active and can be used to breathe from self-contained breathing apparatus."),
})

content.add(content.JsonFlag {
    id = "SCBA_TANK",
    info = ccb.content.text("When activated, this item can fuel a self-contained breathing apparatus."),
})

content.add(content.JsonFlag {
    id = "SCBA_TANK_ON",
    info = ccb.content.text("This item is active and can be used to fuel a self-contained breathing apparatus."),
})

content.add(content.JsonFlag { id = "SLEEP_IGNORE" })
content.add(content.JsonFlag { id = "SLOW_WIELD" })
content.add(content.JsonFlag { id = "SMOKED" })
content.add(content.JsonFlag { id = "SOLARPACK" })

do
    local flag = content.JsonFlag {
        id = "SPEEDLOADER",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This item can quickly reload rounds into gun or magazine that <info>have enough space</info>."),
    }
    flag:conflicts_with("SPEEDLOADER_CLIP")
    content.add(flag)
end

do
    local flag = content.JsonFlag {
        id = "SPEEDLOADER_CLIP",
        -- TRANSLATORS: Leave the tags in angle brackets unchanged.
        info = ccb.content.text("This item can quickly reload rounds into gun or magazine that <info>don't have enough space</info>."),
    }
    flag:conflicts_with("SPEEDLOADER")
    content.add(flag)
end

content.add(content.JsonFlag { id = "SPLINT" })
content.add(content.JsonFlag { id = "STIRRUP" })
content.add(content.JsonFlag { id = "STR_RELOAD" })
content.add(content.JsonFlag { id = "TACK" })
content.add(content.JsonFlag { id = "TANGLE" })
content.add(content.JsonFlag { id = "TARDIS" })

content.add(content.JsonFlag {
    id = "SLING_LAUNCHER",
    info = ccb.content.text("Can launch sling-ready explosives directly from your inventory."),
})

content.add(content.JsonFlag {
    id = "SLING_AMMO",
    info = ccb.content.text("Can be automatically activated and launched with a staff sling."),
})

content.add(content.JsonFlag {
    id = "SLING_PROJECTILE",
    info = ccb.content.text("Can be thrown via a compatible sling."),
})

content.add(content.JsonFlag {
    id = "THROW_KEEP_WIELDED",
    info = ccb.content.text("Can be kept wielded while throwing another item, boosting the throw."),
})

content.add(content.JsonFlag { id = "TIE_UP" })
content.add(content.JsonFlag { id = "TINDER" })
content.add(content.JsonFlag { id = "TOBACCO" })
content.add(content.JsonFlag { id = "TOUGH_FEET" })
content.add(content.JsonFlag { id = "PAIN_IMMUNE" })
content.add(content.JsonFlag { id = "TOURNIQUET" })
content.add(content.JsonFlag { id = "TOW_CABLE" })
content.add(content.JsonFlag { id = "TRADER_AVOID" })
content.add(content.JsonFlag { id = "TRADER_KEEP" })
content.add(content.JsonFlag { id = "TRADER_KEEP_EQUIPPED" })
content.add(content.JsonFlag { id = "UNDERWATER_GUN" })
content.add(content.JsonFlag { id = "UNRECOVERABLE" })
content.add(content.JsonFlag { id = "URSINE_HONEY" })
content.add(content.JsonFlag { id = "USES_BIONIC_POWER" })
content.add(content.JsonFlag { id = "FIRING_EXT_POWER" })
content.add(content.JsonFlag { id = "USES_NEARBY_AMMO" })
content.add(content.JsonFlag { id = "USE_EAT_VERB" })
content.add(content.JsonFlag { id = "USE_PLAYER_ENERGY" })
content.add(content.JsonFlag { id = "USE_UPS" })
content.add(content.JsonFlag { id = "VEHICLE" })
content.add(content.JsonFlag { id = "WATER_EXTINGUISH" })
content.add(content.JsonFlag { id = "WHIP" })
content.add(content.JsonFlag { id = "WIND_EXTINGUISH" })
content.add(content.JsonFlag { id = "WRITE_MESSAGE" })

content.add(content.JsonFlag {
    id = "MUTE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <bad>prevents</bad> you from <info>speaking</info>."),
})

content.add(content.JsonFlag { id = "IRREPLACEABLE_CONSUMABLE" })

content.add(content.JsonFlag {
    id = "ACTIVATE_ON_PLACE",
    info = ccb.content.text("This item will be activated when it is placed in mapgen."),
})

content.add(content.JsonFlag { id = "ACT_IN_FIRE" })
content.add(content.JsonFlag { id = "ACT_ON_RANGED_HIT" })

-- This item cannot be activated by player or NPC, only by some internal game means like by throwing
content.add(content.JsonFlag { id = "NO_MANUAL_ACTIVATION" })

content.add(content.JsonFlag { id = "BACKBLAST" })
content.add(content.JsonFlag { id = "CAN_HAVE_CHARGES" })
content.add(content.JsonFlag { id = "DETERGENT" })

content.add(content.JsonFlag {
    id = "FIRE_TWOHAND",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("<bad>You must</bad> have two free hands to fire this item."),
})

content.add(content.JsonFlag {
    id = "GRENADE",
    restriction = ccb.content.text("Item must be a grenade"),
})

content.add(content.JsonFlag { id = "JAVELIN" })
content.add(content.JsonFlag { id = "LEAK_ALWAYS" })

content.add(content.JsonFlag {
    id = "MAG_COMPACT",
    info = ccb.content.text("This item has a small profile consistent with a compact magazine."),
    restriction = ccb.content.text("Item must be a compact magazine"),
})

content.add(content.JsonFlag { id = "NOGIB" })
content.add(content.JsonFlag { id = "PUMP_RAIL_COMPATIBLE" })
content.add(content.JsonFlag { id = "RADIO_MODABLE" })
content.add(content.JsonFlag { id = "STR_DRAW" })
content.add(content.JsonFlag { id = "UNBREAKABLE" })
content.add(content.JsonFlag { id = "UNBREAKABLE_MELEE" })
content.add(content.JsonFlag { id = "WATERPROOF_GUN" })
content.add(content.JsonFlag { id = "no_auto_equip" })
content.add(content.JsonFlag { id = "auto_wield" })
content.add(content.JsonFlag { id = "SOFT" })
content.add(content.JsonFlag { id = "HARD" })

-- Sharp or pointy item, capable to make a hole in your tire
content.add(content.JsonFlag { id = "PUNCTURE_VEHICLE_WHEELS" })

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_VISITOR",
    info = ccb.content.text("You could probably use this to get into a science facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MAINTENANCE_GREEN",
    info = ccb.content.text("You could probably use this to get into a science facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MAINTENANCE_YELLOW",
    info = ccb.content.text("You could probably use this to get into a secured maintenance area."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MAINTENANCE_BLUE",
    info = ccb.content.text("You could probably use this to get into a secured maintenance area."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_TRANSPORT_1",
    info = ccb.content.text("You could probably use this to get into a science facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_SECURITY_YELLOW",
    info = ccb.content.text("You could probably use this to get into a secured law enforcement area."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_SECURITY_MAGENTA",
    info = ccb.content.text("You could probably use this to get into a secured law enforcement area."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_SECURITY_BLACK",
    info = ccb.content.text("You could probably use this to get into a secured law enforcement area."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MUTAGEN_GREEN",
    info = ccb.content.text("You could probably use this to access a secure zone of a facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MUTAGEN_PINK",
    info = ccb.content.text("You could probably use this to access a secure zone of a facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MUTAGEN_CYAN",
    info = ccb.content.text("You could probably use this to access a secure zone of a facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MEDICAL_RED",
    info = ccb.content.text("You could probably use this to access a secure zone of a facility."),
})

content.add(content.JsonFlag {
    id = "SCIENCE_CARD_MU_UNIVERSAL",
    info = ccb.content.text("You could probably use this to access a secure zone of a facility."),
})

content.add(content.JsonFlag {
    id = "BATTERY_ULTRA_LIGHT",
    info = ccb.content.text("This item fits in items that use ultra-light batteries."),
    name = ccb.content.text("ultra-light battery"),
})

content.add(content.JsonFlag {
    id = "BATTERY_LIGHT",
    info = ccb.content.text("This item fits in items that use light batteries."),
    name = ccb.content.text("light battery"),
})

content.add(content.JsonFlag {
    id = "BATTERY_MEDIUM",
    info = ccb.content.text("This item fits in items that use medium batteries."),
    name = ccb.content.text("medium battery"),
})

content.add(content.JsonFlag {
    id = "BATTERY_HEAVY",
    info = ccb.content.text("This item fits in items that use tool batteries."),
    name = ccb.content.text("tool battery"),
})

content.add(content.JsonFlag {
    id = "METHANOL_TANK",
    info = ccb.content.text("This item fits in items that use methanol fuel cells."),
    name = ccb.content.text("methanol fuel cell"),
})

content.add(content.JsonFlag {
    id = "COMBAT_TOGGLEABLE",
    info = ccb.content.text("This item is meant to be toggled during combat."),
})

content.add(content.JsonFlag { id = "CHOKE" })

content.add(content.JsonFlag {
    id = "GAS_TANK",
    info = ccb.content.text("Airtight tanks for propane, natural gas, etc."),
    name = ccb.content.text("gas tank"),
})

content.add(content.JsonFlag {
    id = "LASER_SIGHT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Laser sights are invalid when the target position is <bad>too far</bad> or <bad>too bright</bad>."),
    name = ccb.content.text("laser sight"),
})

content.add(content.JsonFlag {
    id = "JETPACK",
    info = ccb.content.text("This item is a jetpack."),
})

content.add(content.JsonFlag {
    id = "LEVITATION",
    info = ccb.content.text("Allows movement in open air."),
})

content.add(content.JsonFlag {
    id = "SNOWWALKING",
    info = ccb.content.text("Your movement is not slowed regardless of snow depth."),
})

content.add(content.JsonFlag {
    id = "NO_BODY_HEAT",
    info = ccb.content.text("The character produces no body heat and is not visible on infrared (for characters only, for monsters use the WARM flag to enable infrared visibility)."),
})

content.add(content.JsonFlag {
    id = "ALL_TERRAIN_NAVIGATION",
    info = ccb.content.text("Allows movement over rough and sharp terrain without penalty."),
})

content.add(content.JsonFlag {
    id = "EXO_SMALL",
    info = ccb.content.text("This is meant for a small exosuit hardpoint."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_LARGE",
    info = ccb.content.text("This is meant for a large exosuit hardpoint."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_PSU",
    info = ccb.content.text("This is meant for an exosuit PSU hardpoint."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_SMALL_GADGET",
    info = ccb.content.text("This is meant for small exosuit gadgets, 1 L or less."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_HELMET_GADGET",
    info = ccb.content.text("This is meant for helmet-specific gadgets."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_MEDIUM_GADGET",
    info = ccb.content.text("This is meant for medium exosuit gadgets, between 1 L and 5 L."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_LARGE_GADGET",
    info = ccb.content.text("This is meant for large exosuit gadgets, larger than 5 L."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_UNDERLAYER",
    info = ccb.content.text("This is meant for exosuit underlayers."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_HELMET_PLATE",
    info = ccb.content.text("This is meant for exoskeleton helmet plating."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_TORSO_PLATE",
    info = ccb.content.text("This is meant for exoskeleton torso plating."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_ARM_PLATE",
    info = ccb.content.text("This is meant for exoskeleton arm plating."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_GLOVE_PLATE",
    info = ccb.content.text("This is meant for exoskeleton arm plating."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_LEG_PLATE",
    info = ccb.content.text("This is meant for exoskeleton leg plating."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "EXO_BOOT_PLATE",
    info = ccb.content.text("This is meant for exoskeleton foot plating."),
    inherit = false,
})

content.add(content.JsonFlag {
    id = "ENERGY_SHIELD",
    info = ccb.content.text("This piece of armor is an energy barrier and will break after absorbing a certain amount of damage."),
})

content.add(content.JsonFlag {
    id = "ROBOFAC_ROBOT_MEDIUM",
    info = ccb.content.text("A medium drone sold by Hub 01."),
})

content.add(content.JsonFlag {
    id = "ROBOFAC_ROBOT_SMALL",
    info = ccb.content.text("A small drone sold by Hub 01."),
})

content.add(content.JsonFlag {
    id = "VOLTMETER",
    info = ccb.content.text("This tool can test for voltage."),
})

content.add(content.JsonFlag {
    id = "SUNBURN_SUPERNATURAL",
    info = ccb.content.text("You burn in the sunlight like a vampire.  Probably because you're a vampire."),
})

content.add(content.JsonFlag {
    id = "SUNBURN_SUPERNATURAL_REDUCTION",
    info = ccb.content.text("You burn in the sunlight like a vampire, but not quite as badly."),
})

content.add(content.JsonFlag {
    id = "DISTRIBUTED_DAMAGE",
    info = ccb.content.text("Damage you take is split evenly between your limbs"),
})

content.add(content.JsonFlag {
    id = "SHREDDED",
    info = ccb.content.text("This is a small fragment."),
})

content.add(content.JsonFlag { id = "FROM_FROZEN_LIQUID" })

content.add(content.JsonFlag {
    id = "SINGLE_USE",
    info = ccb.content.text("This item is removed after use."),
})

content.add(content.JsonFlag {
    id = "BIONIC_FUEL_SOURCE",
    info = ccb.content.text("Contents of this item are used for fueling bionics."),
})

-- This bionic weapon is meant to be used in melee.
content.add(content.JsonFlag { id = "BIONIC_WEAPON_MELEE" })

content.add(content.JsonFlag { id = "ELECTRONIC" })

-- Any item that can handle electronic files
content.add(content.JsonFlag { id = "E_FILE_DEVICE" })

-- Any item that can be an electronic file
content.add(content.JsonFlag { id = "E_STORABLE" })

-- Any item that can ONLY be an electronic file
content.add(content.JsonFlag { id = "E_STORABLE_EXCLUSIVE" })

-- Any item that can be electronically copied and scanned
content.add(content.JsonFlag { id = "E_COPIABLE" })

-- Any item that represents a collection of electronic files; this is to avoid making a file system for electronic devices
content.add(content.JsonFlag { id = "E_FILE_COLLECTION" })

-- Any item that can handle electronic files but hasn't been read yet
content.add(content.JsonFlag { id = "E_FILE_DEVICE_UNREAD" })

-- Any item that can display a list of contained recipes
content.add(content.JsonFlag { id = "VIEW_RECIPES" })

-- Any item that can display a list of contained photos
content.add(content.JsonFlag { id = "VIEW_PHOTOS" })

content.add(content.JsonFlag {
    id = "AFS_CS_LOCKER_CARD",
    info = ccb.content.text("ID card granting access to the crashing ship's locker room."),
})

content.add(content.JsonFlag {
    id = "AFS_CS_ARMORY_CARD",
    info = ccb.content.text("ID card granting access to the crashing ship's armory."),
})

content.add(content.JsonFlag {
    id = "AFS_CS_EXOBAY_CARD",
    info = ccb.content.text("ID card granting access to the crashing ship's exobay."),
})

content.add(content.JsonFlag {
    id = "PAPER_SHAPED",
    restriction = ccb.content.text("Item must be shaped like paper"),
})

content.add(content.JsonFlag {
    id = "CREDIT_CARD_SHAPED",
    restriction = ccb.content.text("Item must be shaped like a credit card"),
})

content.add(content.JsonFlag {
    id = "BANK_NOTE_SHAPED",
    restriction = ccb.content.text("Item must be shaped like a bank note"),
})

content.add(content.JsonFlag {
    id = "COIN_SHAPED",
    restriction = ccb.content.text("Item must be shaped like a coin"),
})

content.add(content.JsonFlag {
    id = "BANK_NOTE_STRAP_SHAPED",
    restriction = ccb.content.text("Item must be shaped like a bank note strap"),
})

-- This item is fresh-cut grain, and can be dried in a stook.
content.add(content.JsonFlag { id = "FRESH_GRAIN" })

-- This seed will grow into a plant which needs a grass-cutting tool such as a sickle to harvest.
content.add(content.JsonFlag { id = "CUT_HARVEST" })

content.add(content.JsonFlag {
    id = "GASFILTER_SM",
    info = ccb.content.text("A small-sized gas mask filter."),
    name = ccb.content.text("filter mask cartridge"),
})

content.add(content.JsonFlag {
    id = "GASFILTER_MED",
    info = ccb.content.text("A medium-sized gas mask filter."),
    name = ccb.content.text("CBRN filter canister"),
})

content.add(content.JsonFlag {
    id = "PANORAMIC_OUTSERT",
    info = ccb.content.text("This item is meant to be externally attached to the eyepiece of a single-lens gas mask."),
    restriction = ccb.content.text("Item must be designed to clip onto the external Lenz brackets of a panoramic-view gas mask."),
})

content.add(content.JsonFlag {
    id = "PANORAMIC_INSERT",
    info = ccb.content.text("This item is intended to be inserted behind the visor of a single-lens gas mask."),
    restriction = ccb.content.text("Item must be able to clip into place within a gas mask that has a single, panoramic eyepiece."),
})

content.add(content.JsonFlag {
    id = "PAPR_MASK",
    info = ccb.content.text("This item functions as a powered air purifying respirator."),
})

content.add(content.JsonFlag {
    id = "PAPR_BLOWER",
    info = ccb.content.text("This item functions as a powered air purifying respirator blower."),
})

content.add(content.JsonFlag {
    id = "REBREATHER_CART",
    info = ccb.content.text("A filter for a rebreather."),
    name = ccb.content.text("rebreather cartridge"),
})

content.add(content.JsonFlag {
    id = "OLD_GUN",
    info = ccb.content.text("An old gun, WWII or earlier."),
})

content.add(content.JsonFlag {
    id = "USE_POWER_WHEN_HIT",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This armor <info>expends energy when hit</info>."),
})

content.add(content.JsonFlag { id = "RAT" })
content.add(content.JsonFlag { id = "MOUSE" })
content.add(content.JsonFlag { id = "RABBIT" })

content.add(content.JsonFlag {
    id = "ETHEREAL",
    info = ccb.content.text("You feel like you would keep all your items if you somehow became incorporeal."),
})

content.add(content.JsonFlag {
    id = "CLIMB_FLYING",
    info = ccb.content.text("You can ascend straight up even with no physical surface to climb on."),
})

content.add(content.JsonFlag {
    id = "HERITAGE",
    info = ccb.content.text("You have nonhuman ancestry or are not human"),
})

content.add(content.JsonFlag {
    id = "BLOCK_HUGE_ATTACKS",
    info = ccb.content.text("You are capable of blocking attacks from targets of any size"),
})

content.add(content.JsonFlag {
    id = "SUFFOCATION_IMMUNE",
    info = ccb.content.text("You are immune to being crowd-crushed"),
})

content.add(content.JsonFlag {
    id = "INHALED_TOXIN_IMMUNE",
    info = ccb.content.text("You are immune to gaseous toxins"),
})

content.add(content.JsonFlag {
    id = "INFECTION_RECOVERY",
    info = ccb.content.text("You have greater odds to recover from infections (equivalent to taking antibiotics)"),
})

content.add(content.JsonFlag {
    id = "TREE_COMMUNION_PLUS",
    info = ccb.content.text("You gain greatly enhanced effects from the Mycorrhizal Communion mutation"),
})

content.add(content.JsonFlag {
    id = "ROOTS2",
    info = ccb.content.text("The character has roots, which helps with the TREE_COMMUNION mutation."),
})

content.add(content.JsonFlag {
    id = "ROOTS3",
    info = ccb.content.text("The character has extensive roots, which helps with the TREE_COMMUNION mutation."),
})

content.add(content.JsonFlag {
    id = "VINE_RAPPEL",
    info = ccb.content.text("The character can use vines to safely rappel down sheer drops."),
})

content.add(content.JsonFlag {
    id = "ANIMALDISCORD",
    info = ccb.content.text("The character is disliked by natural animals."),
})

content.add(content.JsonFlag {
    id = "ANIMALDISCORD2",
    info = ccb.content.text("The character is intensely disliked by natural animals."),
})

content.add(content.JsonFlag {
    id = "ANIMALEMPATH",
    info = ccb.content.text("The character is liked by natural animals."),
})

content.add(content.JsonFlag {
    id = "TRUE_SEEING",
    info = ccb.content.text("The character can see through CAMOUFLAGE, NIGHT_INVISIBILITY, or the invisibility effect."),
})

content.add(content.JsonFlag {
    id = "SUPPRESS_INVISIBILITY",
    info = ccb.content.text("If you're invisible, now you're not"),
})

content.add(content.JsonFlag {
    id = "PAUSE_INFECTIONS",
    info = ccb.content.text("Infections cannot progress to a fatal stage while you have this flag."),
})

content.add(content.JsonFlag {
    id = "PAUSE_BODYPART_INFECTION",
    info = ccb.content.text("Prevents infection on a bodypart with this flag from progressing to death, though does not relieve symptoms"),
})

content.add(content.JsonFlag {
    id = "ANIMALEMPATH2",
    info = ccb.content.text("The character is intensely liked by natural animals."),
})

-- This corpse is from a monster with the CRITTER_UNDERFED flag.
content.add(content.JsonFlag { id = "UNDERFED" })

-- Ignores 'restricts' in mutation jsons.  Only for baggy, draped, adjustable, strapped etc items.
content.add(content.JsonFlag {
    id = "UNRESTRICTED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This clothing is able to <info>accommodate even mutated anatomy</info>."),
})

-- Removes some penalties for melee attacks made while prone or crouching.
content.add(content.JsonFlag { id = "PSEUDOPOD_GRASP" })

-- You eat blood to survive.
content.add(content.JsonFlag { id = "HEMOVORE" })

-- You really like blood, and get less enjoyment out of other foods.
content.add(content.JsonFlag { id = "BLOODFEEDER" })

-- This item contains blood and satisfies a hemovore's requirements.
content.add(content.JsonFlag { id = "HEMOVORE_FUN" })

-- This character goes down on all fours when they crouch, if their hands are free.  Used for paw mutations.
content.add(content.JsonFlag { id = "QUADRUPED_CROUCH" })

-- Wether your threshold mutation enables quadrupedal movement.
content.add(content.JsonFlag { id = "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT" })

-- This character can run or crouch on all fours if they have QUADRUPED_CROUCH, and gains the natural_stance effect.  Used for paw mutations.
content.add(content.JsonFlag { id = "QUADRUPED_RUN" })

-- This character treats received sounds as half as loud for the purposes of determing hearing damage.
content.add(content.JsonFlag { id = "HEARING_PROTECTION" })

content.add(content.JsonFlag {
    id = "LIXA_SCIENCE_CARD",
    info = ccb.content.text("This grants access to the LIXA facility."),
})

content.add(content.JsonFlag {
    id = "LIXA_SCIENCE_CARD_2",
    info = ccb.content.text("This grants access to the experiment chamber of the LIXA facility."),
})

content.add(content.JsonFlag {
    id = "LIXA_SCIENCE_CARD_3",
    info = ccb.content.text("This grants access to the experiment chamber and PPE lockup for the LIXA facility."),
})

content.add(content.JsonFlag {
    id = "LIXA_MILITARY_CARD",
    info = ccb.content.text("This grants access to locked-down areas of the LIXA facility."),
})

content.add(content.JsonFlag { id = "DRACULIN_VENOM" })

content.add(content.JsonFlag {
    id = "PREFIX_XL",
    item_suffix = ccb.content.text(" XL"),
})

content.add(content.JsonFlag {
    id = "PREFIX_XS",
    item_suffix = ccb.content.text(" XS"),
})

content.add(content.JsonFlag {
    id = "DECAYS_IN_AIR",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This will eventually <bad>go bad</bad> if left in the open air too long."),
})

content.add(content.JsonFlag {
    id = "IRRITANT_IMMUNE",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>skin irritants</info>."),
})

content.add(content.JsonFlag {
    id = "ITEM_WATERPROOFING",
    info = ccb.content.text("Something is preventing your worn and carried items from being effected by water."),
})

content.add(content.JsonFlag {
    id = "WATERWALKING",
    info = ccb.content.text("You can walk across the surface of water."),
})

content.add(content.JsonFlag {
    id = "CRAFT_IN_DARKNESS",
    info = ccb.content.text("You can craft at 100% speed in any level of light."),
})

-- Creatures and players with this flag cannot attack (includes any spellcasting).
content.add(content.JsonFlag { id = "CANNOT_ATTACK" })

-- Creatures and players with this flag cannot naturally move.
content.add(content.JsonFlag { id = "CANNOT_MOVE" })

content.add(content.JsonFlag { id = "CANNOT_TAKE_DAMAGE" })
content.add(content.JsonFlag { id = "CANNOT_CHANGE_TEMPERATURE" })

-- Creatures with this flag will not have their effects change in duration except for the effects that contain this flag.
content.add(content.JsonFlag { id = "FREEZE_EFFECTS" })

-- Creatures with this flag will not gain any new effects or gain extra time on their current ones.
content.add(content.JsonFlag { id = "CANNOT_GAIN_EFFECTS" })

content.add(content.JsonFlag { id = "NUMB" })
content.add(content.JsonFlag { id = "PSYCHOPATH" })
content.add(content.JsonFlag { id = "INSENSITIVITY" })

-- Vending machines with this flag will allow purchasing items with your bank balance.
content.add(content.JsonFlag { id = "BANK_NETWORKED" })

-- Wall tiles with this flag occur naturally underground and are not manmade.
content.add(content.JsonFlag { id = "NATURAL_UNDERGROUND" })

-- Having this flag makes the player bleed corpses in 1 second each.  Used for a XE vampire power.
content.add(content.JsonFlag { id = "INSTANT_BLEED" })

-- When the character falls, the height is reduced by 1 Z level before calculating damage.
content.add(content.JsonFlag { id = "ONE_STORY_FALL" })

-- A flag for the large grenade bandolier to limit the type of grenades it will accept.
content.add(content.JsonFlag { id = "CYLINDER_GRENADE" })

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "BARRICADABLE_DOOR_DAMAGED",
    name = ccb.content.text("Damaged Barricadable Door"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "BARRICADABLE_DOOR_REINFORCED_DAMAGED",
    name = ccb.content.text("Damaged Barricadable Reinforced Door"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "BARRICADABLE_DOOR_REINFORCED",
    name = ccb.content.text("Barricadable Reinforced Door"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "BARRICADABLE_DOOR",
    name = ccb.content.text("Barricadable Door"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "BARRICADABLE_WINDOW_CURTAINS",
    name = ccb.content.text("Barricadable Window with Curtains"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "BARRICADABLE_WINDOW",
    name = ccb.content.text("Barricadable Window"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "CHIP",
    name = ccb.content.text("Chip"),
    info = ccb.content.text("A paint chipper can be used to remove paint from this."),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "DIGGABLE",
    name = ccb.content.text("Diggable"),
    info = ccb.content.text("A hole can be dug here."),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "EASY_DECONSTRUCT",
    name = ccb.content.text("Simple"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "FLAT",
    name = ccb.content.text("Flat"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "PIT_FILLABLE",
    name = ccb.content.text("Fillable pit"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "PLOWABLE",
    name = ccb.content.text("Plowable"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "RUBBLE",
    name = ccb.content.text("Rubble"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "SUPPORTS_ROOF",
    name = ccb.content.text("Supports roof"),
    info = ccb.content.text("A roof can be built above this without other support."),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "TREE",
    name = ccb.content.text("Tree"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "WALL",
    name = ccb.content.text("Wall"),
})

-- Terrain / Furniture flag used in Construction pre_flags field
content.add(content.JsonFlag {
    id = "WIRED_WALL",
    name = ccb.content.text("Wired Wall"),
})

content.add(content.JsonFlag {
    id = "MWS_PORTAL_STORM_DATA",
    name = ccb.content.text("Odd recordings"),
    info = ccb.content.text("This ongoing report has a series of odd recordings, as if the instruments malfunctioned."),
})

-- Terrain / Furniture flag
-- This terrain will phase back to its original terrain when no longer modified.
content.add(content.JsonFlag { id = "PHASE_BACK" })

content.add(content.JsonFlag {
    id = "ROBOFAC_ARM",
    info = ccb.content.text("This item is a Hub 01 ARM exoskeleton.  It requires an implanted XM-ARM interface to function."),
})

content.add(content.JsonFlag {
    id = "ROBOFAC_LEG",
    info = ccb.content.text("This item is a Hub 01 LEG exoskeleton.  It requires an implanted XM-LEG interface to function."),
})

content.add(content.JsonFlag {
    id = "ROBOFAC_BACK",
    info = ccb.content.text("This item is a Hub 01 BACK exoskeleton.  It requires an implanted XM-LEG interface and it must be worn with ARM and LEG exoskeletons to function."),
})

content.add(content.JsonFlag {
    id = "ROBOFAC_LENS_ACCESSORY",
    info = ccb.content.text("This item is an accessory for a Hub 01 LENS helmet, and can only be worn with that helmet."),
})

content.add(content.JsonFlag {
    id = "ROBOFAC_LENS_HELMET",
    info = ccb.content.text("This item allows you to wear Hub 01 LENS accessories."),
})

content.add(content.JsonFlag {
    id = "CANNOT_GAIN_WEARINESS",
    info = ccb.content.text("You have a seemingly inexhaustible supply of energy."),
})

-- Allows characters to change their gender by bypassing the PLAYER_ARBITRARY_CHANGE_GENDER option.
content.add(content.JsonFlag { id = "GENDER_FLUIDITY" })

-- Preventing a character from changing their gender will override GENDER_FLUIDITY.
content.add(content.JsonFlag { id = "GENDER_INVARIANCE" })

-- Furniture with this flag prevents plants growing on it from becoming overgrown.
content.add(content.JsonFlag {
    id = "NO_CROP_OVERGROWTH",
    info = ccb.content.text("This planting facility can prevent crops from over-ripening and wilting."),
})

content.add(content.JsonFlag { id = "MARLOSS" })
content.add(content.JsonFlag { id = "SONAR_DETECTABLE" })
content.add(content.JsonFlag { id = "CONVECTS_TEMPERATURE" })
content.add(content.JsonFlag { id = "UNDODGEABLE" })

-- Omit the widget's label from being rendered in the sidebar
content.add(content.JsonFlag { id = "W_LABEL_NONE" })

-- Prevents the widget from being rendered in the sidebar if the widget's text is empty
content.add(content.JsonFlag { id = "W_DISABLED_WHEN_EMPTY" })

-- Makes the panel disabled in the panel manager if there's no panel_options.json
content.add(content.JsonFlag { id = "W_DISABLED_BY_DEFAULT" })

-- Allow multi-line widgets to dynamically adjust their height
content.add(content.JsonFlag { id = "W_DYNAMIC_HEIGHT" })

-- Removes alignment padding from widgets and sub-widgets
content.add(content.JsonFlag { id = "W_NO_PADDING" })
