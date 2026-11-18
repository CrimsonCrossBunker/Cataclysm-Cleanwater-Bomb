local content = require("ccb").content

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_crystallize_mana",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Crystallize Mana", "Scrolls of Crystallize Mana"),
        description = content.text("A proper wizard is always prepared, crystallize your mana for the future!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "crystallize_mana" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_dark_sight",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Dark Sight", "Scrolls of Dark Sight"),
        description = content.text("The darkness holds no secrets for the arcane.  Adjust your sight to see in perfect darkness!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "dark_sight" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_sound_bomb",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Sound Bomb", "Scrolls of Sound Bomb"),
        description = content.text("Behind the cool name hides a common joke spell to spook your friends and restrain dogs.  It can be useful in some special cases."),
    }
    book:clear_use_actions()
    book:teach_spells({ "sound_bomb" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_invisibility",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Invisibility", "Scrolls of Invisibility"),
        description = content.text("The light can not interact with you unless you want it to.  Become invisible!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "invisibility" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_obfuscated_body",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Obfuscated Body", "Scrolls of Obfuscated Body"),
        description = content.text("A magical aura distorts light around your body, making it easier to dodge enemy attacks."),
    }
    book:clear_use_actions()
    book:teach_spells({ "obfuscated_body" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_thought_shield",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Thought Shield", "Scrolls of Thought Shield"),
        description = content.text("Harried by evil spirits or creatures from beyond?  This spell will keep your mind safe!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "thought_shield" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_holographic_transposition",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Holographic Transposition", "Scrolls of Holographic Transposition"),
        description = content.text("Allows you to swap places with a previously existing holographic image of yourself.  If the universe itself can't tell you apart, who could?"),
    }
    book:clear_use_actions()
    book:teach_spells({ "holographic_transposition" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_smite",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Smite", "Scrolls of Smite"),
        description = content.text("Evil has become pervasive throughout the world.  Let your power be the light that shines in the darkness!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "smite" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_recover_mana",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Life Conversion", "Scrolls of Life Conversion"),
        description = content.text("You channel your life force itself into your spiritual energy.  You spend HP to regain mana."),
    }
    book:clear_use_actions()
    book:teach_spells({ "recover_mana" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_recover_pain",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mind Over Pain", "Scrolls of Mind Over Pain"),
        description = content.text("With an intense ritual that resembles crossfit, you manage to put some of your pain at bay."),
    }
    book:clear_use_actions()
    book:teach_spells({ "recover_pain" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_baleful_polymorph",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Fleshwarping", "Scrolls of Fleshwarping"),
        description = content.text("Brutally warp the flesh of your enemies, turning them into a malformed pile of writhing limbs and mismatched parts."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_baleful_polymorph" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_summon_undead",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Undead", "Scrolls of Summon Undead"),
        description = content.text("An ethereal-looking zombie rises from the depths of the earth to fight for you.  You may be able to summon more with a higher level in this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_undead" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_rupture",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Rupture", "Scrolls of Rupture"),
        description = content.text("You pour mana into an unwilling and unprepared vessel, causing cellular break-down, internal hemorrhaging, leylines to become muddled, and electronics to overcharge.  Immensely gruesome, crude, and was once illegal world-wide, not that it matters now."),
    }
    book:clear_use_actions()
    book:teach_spells({ "rupture" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_devour",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Devour", "Scrolls of Devour"),
        description = content.text("Kill a summoned creature, consuming its life energy to regain some health."),
    }
    book:clear_use_actions()
    book:teach_spells({ "devour" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_summon_floating_disk",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Floating Disk", "Scrolls of Summon Floating Disk"),
        description = content.text("Summons a floating disk that is sworn to carry your burdens."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_floating_disk" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_summon_undead_swarm",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Undead Swarm", "Scrolls of Summon Undead Swarm"),
        description = content.text("A few decrepit looking animals rises from the depths of the earth to fight for you.  You may be able to summon better with a higher level in this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_undead_swarm" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_convert",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Convert", "Scrolls of Convert"),
        description = content.text("Kill an ally creature, converting its life energy into compact rune, that you can use afterwards."),
    }
    book:clear_use_actions()
    book:teach_spells({ "convert" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_dominate",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Domination", "Scrolls of Domination"),
        description = content.text("Force the undead creature you pick to obey your command, making it an ally for a short time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "dominate" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_life_detonation",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Life Detonation", "Scrolls of Life Detonation"),
        description = content.text("Explode a living energy inside your undead, to release a tremendous force around."),
    }
    book:clear_use_actions()
    book:teach_spells({ "life_detonation" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_light_healing",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Knit the Rent Flesh", "Scrolls of Knit the Rent Flesh"),
        description = content.text("Cause the target's wounds to pull themselves together."),
    }
    book:clear_use_actions()
    book:teach_spells({ "light_healing" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_pain_split",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Pain Split", "Scrolls of Pain Split"),
        description = content.text("Evens out damage among your limbs."),
    }
    book:clear_use_actions()
    book:teach_spells({ "pain_split" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_vicious_tentacle",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Vicious Tentacle", "Scrolls of Vicious Tentacle"),
        description = content.text("This spell extrudes a long nasty whiplike tentacle of sharp bones and oozing acid from your body, it has a long reach attack and vicious damage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "vicious_tentacle" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_bio_grotesque",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Grotesque Enhancement", "Scrolls of Grotesque Enhancement"),
        description = content.text("A spell that warps your body in alien ways to increase your physical abilities and strength."),
    }
    book:clear_use_actions()
    book:teach_spells({ "bio_grotesque" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_bio_acidicspray",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Acidic Spray", "Scrolls of Acidic Spray"),
        description = content.text("When cast, the mage opens his mouth and sprays acid in a wide cone to dissolve his foes into goo.  Just imagine what he'll do with the goo."),
    }
    book:clear_use_actions()
    book:teach_spells({ "bio_acidicspray" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_bio_fleshpouch",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Flesh Pouch", "Scrolls of Flesh Pouch"),
        description = content.text("This spell grows a large pouch out of your skin on your back, allowing you to store your gear in it."),
    }
    book:clear_use_actions()
    book:teach_spells({ "bio_fleshpouch" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_bio_bonespear",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Conjure Bonespear", "Scrolls of Conjure Bonespear"),
        description = content.text("This spell creates a long shaft of bone with a wicked point and blades along its length."),
    }
    book:clear_use_actions()
    book:teach_spells({ "bio_bonespear" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_megablast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Megablast", "Scrolls of Megablast"),
        description = content.text("You always wanted to fire energy beams like in the animes you watched as a kid.  Now you can!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "megablast" })
    content.add(book)
end

do
    -- Classless spell1
    local book = content.Item {
        id = "spell_scroll_create_atomic_light",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Magical Light", "Scrolls of Magical Light"),
        description = content.text("Creates a magical light."),
    }
    book:clear_use_actions()
    book:teach_spells({ "create_atomic_light" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_blinding_flash",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Blinding Flash", "Scrolls of Blinding Flash"),
        description = content.text("Blind enemies for a short time with a sudden, dazzling light.  Higher levels deal slightly higher damage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "blinding_flash" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_ethereal_grasp",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Ethereal Grasp", "Scrolls of Ethereal Grasp"),
        description = content.text("A mass of spectral hands emerge from the ground, slowing everything in range.  Higher levels allow a bigger AoE, and longer effect."),
    }
    book:clear_use_actions()
    book:teach_spells({ "ethereal_grasp" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_protection_aura",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Aura of Protection", "Scrolls of Aura of Protection"),
        description = content.text("Encases your whole body in a magical aura that protects you from the environment."),
    }
    book:clear_use_actions()
    book:teach_spells({ "protection_aura" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_veggrasp",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Vegetative Grasp", "Scrolls of Vegetative Grasp"),
        description = content.text("This spell causes roots and vines to burst forth from the ground and grab your foes, slowing them and doing a small amount of damage as they dig in."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_veggrasp" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_rootstrike",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Root Strike", "Scrolls of Root Strike"),
        description = content.text("This spell causes roots to spear out the ground and stab into your foes in an arc, impaling them."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_rootstrike" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_woodshaft",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Wooden Shaft", "Scrolls of Wooden Shaft"),
        description = content.text("This spell creates a projectile of hardwood that shoots forth from the caster's hand at high speed to stab into an enemy."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_woodshaft" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_naturebow1",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Nature's Bow", "Scrolls of Nature's Bow"),
        description = content.text("This spell conjures a magical wooden recurve bow that fires endless arrows for as long as it lasts."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_naturebow1" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_recover_sleepiness",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Nature's Trance", "Scrolls of Nature's Trance"),
        description = content.text("Your connection to living things allows you to go into a magical trance.  This allows you to recover from fatigue quickly in exchange for mana."),
    }
    book:clear_use_actions()
    book:teach_spells({ "recover_sleepiness" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_summon_cats",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Bag of Cats", "Scrolls of Bag of Cats"),
        description = content.text("Are you the crazy cat lady?"),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_cats" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_summon_wolf",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Wolf", "Scrolls of Summon Wolf"),
        description = content.text("Call to the wilds for aid from some wolves."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_wolf_druid" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_cause_rot",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Cause Rot", "Scrolls of Cause Rot"),
        description = content.text("A spell from a darker sect of druidry, created to forcibly begin the circle of life anew.  For without rot, you cannot have growth.  Affects a huge area, but is indiscriminate and slow both in casting and effect.  Once lost entirely to the passage of time, this spell was thought to be no more than a myth, the stuff of fairy tales, albeit grim ones."),
    }
    book:clear_use_actions()
    book:teach_spells({ "cause_rot" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_healing",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Restoration", "Scrolls of Restoration"),
        description = content.text("Directed magical energy that slowly heals your body from wounds."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_healing" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_healing_herb",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Floral Healing", "Scrolls of Floral Healing"),
        description = content.text("Uses magic energy from herbs to heal your wounds."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_healing_herb" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_bandage",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Vegetative Poultice", "Scrolls of Vegetative Poultice"),
        description = content.text("Turns a bunch of leaves and bark into an effective bandage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_bandage_heal" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_stonefist",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stonefist", "Scrolls of Stonefist"),
        description = content.text("Encases your arms and hands in a sheath of magical stone, you can punch and defend yourself with it in melee combat."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stonefist" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_seismic_stomp",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Seismic Stomp", "Scrolls of Seismic Stomp"),
        description = content.text("Focusing mana into your leg, you stomp your foot and send out a shockwave, knocking enemies around you onto the ground."),
    }
    book:clear_use_actions()
    book:teach_spells({ "seismic_stomp" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_recover_stamina",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stone's Endurance", "Scrolls of Stone's Endurance"),
        description = content.text("You focus on the stones beneath you and draw from their agelessness.  Your mana is converted to stamina."),
    }
    book:clear_use_actions()
    book:teach_spells({ "recover_stamina" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_shardspray",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shardspray", "Scrolls of Shardspray"),
        description = content.text("This spell projects a wide spray of sharp metal shards, cutting into your foes and friends alike."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_shardspray" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_piercing_bolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Piercing Bolt", "Scrolls of Piercing Bolt"),
        description = content.text("This spell projects a piercing rod of conjured iron at those that dare oppose you."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_piercing_bolt" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_shardstorm",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shardstorm", "Scrolls of Shardstorm"),
        description = content.text("Creates an omnidirectional spray of razor sharp metal shards all around you."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_shardstorm" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_rockbolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Rockbolt", "Scrolls of Rockbolt"),
        description = content.text("Fires a conjured stone projectile at high velocity."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_rockbolt" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_clairvoyance",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Clairvoyance", "Scrolls of Clairvoyance"),
        description = content.text("You close your eyes and the earth surrenders its secrets to you."),
    }
    book:clear_use_actions()
    book:teach_spells({ "clairvoyance" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_stoneskin",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stoneskin", "Scrolls of Stoneskin"),
        description = content.text("Envelops your entire body in armor formed from living rock, encumbering yet protective."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_stoneskin" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_pillar",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Pillar of Stone", "Scrolls of Pillar of Stone"),
        description = content.text("Drawing upon the surrounding earth, you form a pillar of solid rock.  Experience will make the task easier, and less disruptive to the surrounding area."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_pillar" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_pertifying_touch",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Petrifying Touch", "Scrolls of Petrifying Touch"),
        description = content.text("Your hands try to transform the body of your enemy into pure stone.  The effect is temporary, but it can deal significant damage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "pertifying_touch" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_reactive_armor",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Reactive Armor", "Scrolls of Reactive Armor"),
        description = content.text("Explode your stone skin to deal massive damage to all enemies around."),
    }
    book:clear_use_actions()
    book:teach_spells({ "reactive_armor" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_impalement",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Impalement", "Scrolls of Impalement"),
        description = content.text("Summon a stone spikes underground, that penetrate your enemies, and nail them for a while."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_impalement" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_spawn_tools",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Utility Molding", "Scrolls of Utility Molding"),
        description = content.text("Shape the basic working tools, using your own magic abilities and earth nearby.  Activate to change the shape of a tool."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_spawn_tools" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_melee_damage",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Weighting", "Scrolls of Weighting"),
        description = content.text("Fill yourself with the power of Earth, and make each your attacks as devastating as an earthquake."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_melee_damage" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_eshaper_crystal_wrap",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Crystal Wrapping", "Scrolls of Crystal Wrapping"),
        description = content.text("You cover your body with a layer of razor sharp crystals.  Monster that attack you will take some damage in return, and gives you some additional cut damage in melee."),
    }
    book:clear_use_actions()
    book:teach_spells({ "eshaper_crystal_wrap" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_shape_of_dust",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shape of Dust", "Scrolls of Shape of Dust"),
        description = content.text("Hide yourself between the sand gust.  It's harder to hit you, and monster's can't spot you."),
    }
    book:clear_use_actions()
    book:teach_spells({ "shape_of_dust" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_summon_eshaper_golem",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Earthshaper's Golem", "Scrolls of Earthshaper's Golem"),
        description = content.text("Shape a strong golem out of the stone.  It may help for a lot, but you have not enough energy to support it forever."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_eshaper_golem" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_boulder",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Boulder", "Scrolls of Summon Boulder"),
        description = content.text("Pull the smooth rock underground, using your forces of earth shaping.  You can use it as a table, or as a primitive anvil."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_boulder" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_reveal_world_map",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Reading the Earthbones", "Scrolls of Reading the Earthbones"),
        description = content.text("Use magic to reveal nearby terrain."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_reveal_world_map" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_point_flare",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Point Flare", "Scrolls of Point Flare"),
        description = content.text("Causes an intense heat at the location, damaging the target."),
    }
    book:clear_use_actions()
    book:teach_spells({ "point_flare" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_create_lighter",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Finger Firelighter", "Scrolls of Finger Firelighter"),
        description = content.text("Summons a small flame that does not burn you, but you can use it to light things on fire.  It seems to need you to have some intent to light things on fire, because you are able to put it in your pocket with no issue."),
    }
    book:clear_use_actions()
    book:teach_spells({ "create_lighter" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_ice_spike",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Ice Spike", "Scrolls of Ice Spike"),
        description = content.text("Causes jagged icicles to form in the air above the target, falling and damaging it."),
    }
    book:clear_use_actions()
    book:teach_spells({ "ice_spike" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_fireball",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Fireball", "Scrolls of Fireball"),
        description = content.text("You hurl a pea-sized glowing orb that when reaches its target or an obstacle produces a pressure-less blast of searing heat."),
    }
    book:clear_use_actions()
    book:teach_spells({ "fireball" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_cone_cold",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Cone of Cold", "Scrolls of Cone of Cold"),
        description = content.text("You blast a cone of frigid air toward the target."),
    }
    book:clear_use_actions()
    book:teach_spells({ "cone_cold" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_burning_hands",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Burning Hands", "Scrolls of Burning Hands"),
        description = content.text("You're pretty sure you saw this in a game somewhere.  You fire a short-range cone of fire."),
    }
    book:clear_use_actions()
    book:teach_spells({ "burning_hands" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_frost_spray",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Frost Spray", "Scrolls of Frost Spray"),
        description = content.text("You're pretty sure you saw this in a game somewhere.  You fire a short-range cone of ice and cold."),
    }
    book:clear_use_actions()
    book:teach_spells({ "frost_spray" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_chilling_touch",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Chilling Touch", "Scrolls of Chilling Touch"),
        description = content.text("Freezes the touched target with intense cold."),
    }
    book:clear_use_actions()
    book:teach_spells({ "chilling_touch" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_glide_ice",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Glide on Ice", "Scrolls of Glide on Ice"),
        description = content.text("Encases your feet in a magical coating of ice, allowing you to glide along smooth surfaces faster."),
    }
    book:clear_use_actions()
    book:teach_spells({ "glide_ice" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_hoary_blast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Hoary Blast", "Scrolls of Hoary Blast"),
        description = content.text("You project a glowing white crystal of ice and it explodes on impact into a blossom of shattering cold."),
    }
    book:clear_use_actions()
    book:teach_spells({ "hoary_blast" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_ice_shield",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Ice Shield", "Scrolls of Ice Shield"),
        description = content.text("Creates a magical shield of ice on your arm, you can defend yourself with it in melee combat and use it to bash."),
    }
    book:clear_use_actions()
    book:teach_spells({ "ice_shield" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_frost_armor",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Frost Armor", "Scrolls of Frost Armor"),
        description = content.text("Covers you in a thin layer of magical ice to protect you from harm."),
    }
    book:clear_use_actions()
    book:teach_spells({ "frost_armor" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_shadow_field",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shadow Field", "Scrolls of Shadow Field"),
        description = content.text("Cast a field of shadows."),
    }
    book:clear_use_actions()
    book:teach_spells({ "shadow_field" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magic_missile",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Magic Missile", "Scrolls of Magic Missile"),
        description = content.text("I cast Magic Missile at the darkness!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "magic_missile" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_phase_door",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Phase Door", "Scrolls of Phase Door"),
        description = content.text("Teleports you in a random direction a short distance."),
    }
    book:clear_use_actions()
    book:teach_spells({ "phase_door" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_gravity_well",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Gravity Well", "Scrolls of Gravity Well"),
        description = content.text("Summons a well of gravity with the epicenter at the location.  Deals bashing damage to all creatures in the affected area."),
    }
    book:clear_use_actions()
    book:teach_spells({ "gravity_well" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_mana_blast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mana Blast", "Scrolls of Mana Blast"),
        description = content.text("A blast of concentrated magical power that obliterates a large area."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_mana_blast" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_mana_bolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mana Bolt", "Scrolls of Mana Bolt"),
        description = content.text("A bolt of magical power that only damages your foes."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_mana_bolt" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_haste",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Haste", "Scrolls of Haste"),
        description = content.text("This spell gives you an enormous boost of speed lasting a short period of time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_haste" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_slow",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Slow", "Scrolls of Slow"),
        description = content.text("This spell slows a single target greatly for its duration."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_slow" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_mana_beam",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mana Beam", "Scrolls of Mana Beam"),
        description = content.text("A beam of focused magical power that damages any foes in its path."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_mana_beam" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_escape",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Escape", "Scrolls of Escape"),
        description = content.text("Teleports you in a random direction a medium distance, to help escape your foes in dangerous situations."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_escape" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_dexterity_buff_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Steadiness of Hand", "Scrolls of Steadiness of Hand"),
        description = content.text("You become more graceful, agile, and coordinated."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_dexterity_buff_spell" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_perception_buff_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Keenness of Sight", "Scrolls of Keenness of Sight"),
        description = content.text("Your senses all sharpen."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_perception_buff_spell" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_strength_buff_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Strength of Arm", "Scrolls of Strength of Arm"),
        description = content.text("You gain greatly-increased strength."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_strength_buff_spell" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_intelligence_buff_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Clarity of Thought", "Scrolls of Clarity of Thought"),
        description = content.text("Your mind clears and your thoughts race."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_intelligence_buff_spell" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_focused_bolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Focused Bolt", "Scrolls of Focused Bolt"),
        description = content.text("You focus your mana into a microscopically thin pulsed beam of pure energy, capable of extreme range and precision; as well as unparalleled penetration, provided proper skill.  Once the invention of a notorious assassin, this spell has slayed many a king and noble.  Passed on only through direct descendants over the ages, though occasionally shared by them to others."),
    }
    book:clear_use_actions()
    book:teach_spells({ "focused_bolt" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_shocking_lash",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shocking Lash", "Scrolls of Shocking Lash"),
        description = content.text("A quick burst of electricity strikes a target and possibly one other nearby."),
    }
    book:clear_use_actions()
    book:teach_spells({ "shocking_lash" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_jolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Jolt", "Scrolls of Jolt"),
        description = content.text("A short-ranged fan of electricity shoots from your fingers."),
    }
    book:clear_use_actions()
    book:teach_spells({ "jolt" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_lightning_bolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Lightning Bolt", "Scrolls of Lightning Bolt"),
        description = content.text("The go-to spell for many Stormshapers, this iconic spell does just what you expect: you shoot lightning from your fingertips.  However, this lightning is more directed than most lightning, and travels in a line through most non-solid targets."),
    }
    book:clear_use_actions()
    book:teach_spells({ "lightning_bolt" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_air_blast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Air Blast", "Scrolls of Air Blast"),
        description = content.text("A concentrated puff of air that knocks down a single foe."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_air_blast" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_windstrike",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Windstrike", "Scrolls of Windstrike"),
        description = content.text("A powerful blast of wind slams into anything in front of your outstretched hand."),
    }
    book:clear_use_actions()
    book:teach_spells({ "windstrike" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_storm_shipwrecker",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shipwrecker", "Scrolls of Shipwrecker"),
        description = content.text("The spell moves out of your mouth, creating a giant shockwave that shatters everything in its path."),
    }
    book:clear_use_actions()
    book:teach_spells({ "storm_shipwrecker" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_explosive_decompression",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Explosive Decompression", "Scrolls of Explosive Decompression"),
        description = content.text("Create a high-pressure zone originating from the selected point.  Shortly after, a massive pressure wave will crush everything inside, inflicting barotraumatic injuries on everyone affected."),
    }
    book:clear_use_actions()
    book:teach_spells({ "explosive_decompression" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_vacuum_decompression",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Vacuum Decompression", "Scrolls of Vacuum Decompression"),
        description = content.text("Create a high-pressure zone originating from the selected point.  Shortly after, a massive pressure wave will crush everything inside, inflicting barotraumatic injuries on everyone affected.  The pressure differential will also pull unprepared creatures inside the zone before collapsing."),
    }
    book:clear_use_actions()
    book:teach_spells({ "vacuum_decompression" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_air_bubble",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Air Bubble", "Scrolls of Air Bubble"),
        description = content.text("Cover your head with an air bubble, allowing you to breathe underwater or prevent breathing of toxic gases."),
    }
    book:clear_use_actions()
    book:teach_spells({ "air_bubble" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_storm_superconductor",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Superconductor", "Scrolls of Superconductor"),
        description = content.text("Create arcs of devastating electric charge in an area around you, roasting everything within."),
    }
    book:clear_use_actions()
    book:teach_spells({ "storm_superconductor" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_shocking_dash",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shocking Dash", "Scrolls of Shocking Dash"),
        description = content.text("Fill your legs with energy and quickly dash to a target destination."),
    }
    book:clear_use_actions()
    book:teach_spells({ "shocking_dash" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_toxtricity",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Toxtricity", "Scrolls of Toxtricity"),
        description = content.text("Inject a corrosive electric energy into targets within the affected area, weakening them and dealing huge damage over time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "toxtricity" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_electric_eye",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Electric Eye", "Scrolls of Electric Eye"),
        description = content.text("Enhance your sight with your powers.  It allows you to see creatures of the same energy around you, and block or dodge an additional attack your enhanced perception speed could anticipate."),
    }
    book:clear_use_actions()
    book:teach_spells({ "electric_eye" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_electric_waves",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Electric Waves", "Scrolls of Electric Waves"),
        description = content.text("Your hands start to emit a huge amount of energy, that you release with each attack."),
    }
    book:clear_use_actions()
    book:teach_spells({ "electric_waves" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_electric_arts",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Electric Arts", "Scrolls of Electric Arts"),
        description = content.text("Insulate the skin against electrical damage.  Particularly useful for the apprentice Stormshaper, whose magical control is weak and whose efforts could easily end in self-electrocution."),
    }
    book:clear_use_actions()
    book:teach_spells({ "electric_arts" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_summon_teravolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Teravolt", "Scrolls of Teravolt"),
        description = content.text("Summon a Teravolt, a small, semi-intelligent spirit that homes onto hostile creatures and explodes into a huge spark cloud."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_teravolt" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_windrun",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Windrunning", "Scrolls of Windrunning"),
        description = content.text("A magical wind pushes you forward as you move, easing your movements and increasing speed."),
    }
    book:clear_use_actions()
    book:teach_spells({ "windrun" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_storm_hammer",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Call Stormhammer", "Scrolls of Call Stormhammer"),
        description = content.text("Creates a crackling magical warhammer full of lightning to smite your foes with, and of course, smash things to bits!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "storm_hammer" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormfist",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stormfist", "Scrolls of Stormfist"),
        description = content.text("Encases your arm and hand in a sheath of crackling magical lightning, you can punch and defend yourself with it in melee combat."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormfist" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_bless",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Paragon", "Scrolls of Paragon"),
        description = content.text("A spell that improves your abilities across a broad spectrum."),
    }
    book:clear_use_actions()
    book:teach_spells({ "bless" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_mage_conjured_blade",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Force Blade", "Scrolls of Force Blade"),
        description = content.text("Conjure up a sword made of force, sharper than any physical blade."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_mage_conjured_blade" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_mage_conjured_armor",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Force Armor", "Scrolls of Force Armor"),
        description = content.text("Conjure a suit of magical armor made of pure force, when you need armor in a hurry."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_mage_conjured_armor" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_create_atomic_lamp",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Enchanted Lamp", "Scrolls of Enchanted Lamp"),
        description = content.text("Enchant a bit of stone or metal to give it an unwavering glow."),
    }
    book:clear_use_actions()
    book:teach_spells({ "create_atomic_lamp" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_recover_bionic_power",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Manatricity", "Scrolls of Manatricity"),
        description = content.text("You have found a way to convert your spiritual energy into power you can use for your bionics."),
    }
    book:clear_use_actions()
    book:teach_spells({ "recover_bionic_power" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_taze",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Taze", "Scrolls of Taze"),
        description = content.text("This spell creates a very short range bolt of electricity to shock your foes."),
    }
    book:clear_use_actions()
    book:teach_spells({ "taze" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_quantum_tunnel_lesser",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Lesser Quantum Tunnel", "Scrolls of Lesser Quantum Tunnel"),
        description = content.text("This spell manipulates some quantum something or other to tunnel you through a short distance of space, and even matter, unfortunately there's that whole uncertainty thing as to where you come out.  It leaves you a little dazed on the other side as you reorient yourself."),
    }
    book:clear_use_actions()
    book:teach_spells({ "quantum_tunnel_lesser" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_synaptic_stimulation",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Synaptic Stimulation", "Scrolls of Synaptic Stimulation"),
        description = content.text("This spell stimulates the synapses in your brain beyond normal processing speeds, giving you a large boost in mental processing capability, including enhancing your reflexes, speed, and raw intellectual power.  Use responsibly!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "synaptic_stimulation" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_laze",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Laze", "Scrolls of Laze"),
        description = content.text("You concentrate and release a focused beam of photons at a target, also known as a laser."),
    }
    book:clear_use_actions()
    book:teach_spells({ "laze" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_animated_blade",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Animated Blade", "Scrolls of Animated Blade"),
        description = content.text("This spell conjures flying animated blades that will cut your enemies down to size.  Into small pieces that is."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animated_blade" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_mirror_image",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mirror Image", "Scrolls of Mirror Image"),
        description = content.text("This spell manipulates light into barely tangible duplicates of a living being, a magical hologram in short."),
    }
    book:clear_use_actions()
    book:teach_spells({ "mirror_image" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_lightning_blast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Lightning Blast", "Scrolls of Lightning Blast"),
        description = content.text("You fire a small concentrated ball of lightning at the target.  The electricity diffuses quickly, so it doesn't do much damage, but you're able to fire off several quick ones in a row."),
    }
    book:clear_use_actions()
    book:teach_spells({ "lightning_blast" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_necrotic_gaze",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Necrotic Gaze", "Scrolls of Necrotic Gaze"),
        description = content.text("You use the power of your own blood to imbue necrotic energy into your gaze, damaging the target you look at."),
    }
    book:clear_use_actions()
    book:teach_spells({ "necrotic_gaze" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_purification_seed",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Purification Seed", "Scrolls of Purification Seed"),
        description = content.text("You summon a gift of the earth which will purify water.  Greater levels yield greater numbers of seeds."),
    }
    book:clear_use_actions()
    book:teach_spells({ "purify_seed" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_x-ray",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of X-ray Vision", "Scrolls of X-ray Vision"),
        description = content.text("You fire a cone of X-rays that magically allow you to see that area for a short time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "x-ray" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_overcharge_eyes",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Optical Sneeze Beam", "Scrolls of Optical Sneeze Beam"),
        description = content.text("You overcharge your internal batteries to send a semi-directed beam from your face."),
    }
    book:clear_use_actions()
    book:teach_spells({ "overcharge_eyes" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_bleed",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Bleed", "Scrolls of Bleed"),
        description = content.text("With a shout and a gesture, the target starts bleeding from old wounds."),
    }
    book:clear_use_actions()
    book:teach_spells({ "bleed" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_banishment_lesser",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Lesser Banishment", "Scrolls of Lesser Banishment"),
        description = content.text("Banish a monster to the lesser-known nether dimension.  If a monster is more powerful than you can handle, the spell drains your life force to make up the difference."),
    }
    book:clear_use_actions()
    book:teach_spells({ "banishment_lesser" })
    content.add(book)
end

do
    -- Classless spell, black dragon books
    local book = content.Item {
        id = "spell_scroll_acid_resistance",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Acid Resistance", "Scrolls of Acid Resistance"),
        description = content.text("This spell creates an invisible aura to protect you from acid."),
    }
    book:clear_use_actions()
    book:teach_spells({ "acid_resistance" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "lightning_storm_scroll",
        name = content.plural_text("Scroll of Lightning Storm", "Scrolls of Lightning Storm"),
        description = content.text("This scroll details how a spell called 'Lightning Blast' which is commonly used among Stormshapers can be altered to become much more powerful, at a much higher mana cost."),
        mass_milligrams = 129000,
        volume_ml = 500,
        price_cents = 25000,
        symbol = "?",
        color = "light_blue",
    }
    book:clear_use_actions()
    book:teach_spells({ "lightning_storm" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druidic_regrowth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Sacrificial Regrowth", "Scrolls of Sacrificial Regrowth"),
        description = content.text("Through giving of one's own life force, you restore withered and barren plant life nearby.  What remains will need time to regrow its full strength."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druidic_regrowth" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druidic_healing",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Sacrificial Healing", "Scrolls of Sacrificial Healing"),
        description = content.text("Channels some of the user's own life force into healing energy, for the sake of one's allies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druidic_healing" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_move_earth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Move Earth", "Scrolls of Move Earth"),
        description = content.text("Make the terrain answer to your call."),
    }
    book:clear_use_actions()
    book:teach_spells({ "move_earth" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_paralytic_dart",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Paralytic Dart", "Scrolls of Paralytic Dart"),
        description = content.text("Spits a warped needle of sinew and bone, carrying with it a sting that slows your victim."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_paralytic_dart" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_visceral_projection",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Visceral Projection", "Scrolls of Visceral Projection"),
        description = content.text("Projects a spray of acrid blood and gore all around you, growing to ensnare your prey in a field of twitching poisonous tendrils."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_visceral_projection" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_coagulant_weave",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Coagulant Weave", "Scrolls of Coagulant Weave"),
        description = content.text("Turns your biological mastery inwards, medically enhancing your flesh.  Rather than strength of healing, it staves off blood loss and purges wounds before they can turn septic, at the cost of increased hunger and thirst."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_coagulant_weave" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_ionization",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Ionization", "Scrolls of Ionization"),
        description = content.text("By manipulating the charge in the air, you can conjure a sharp snap of lightning over a wide area.  While its destructive potential is a far cry from natural lightning, the light and thunderclap produced will leave your foes reeling."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_ionization" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_summon_wisps",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Ignus Fatuus", "Scrolls of Ignus Fatuus"),
        description = content.text("Summons ghostly foxfire worked from living marsh vapor to lead your enemies astray.  With more experience, this spell can conjure multiple ghost lights."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_wisps" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_wall_of_fog",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Wall of Fog", "Scrolls of Wall of Fog"),
        description = content.text("Draws forth a broad wall of thick fog.  While the sudden force of air pressure will floor any enemies caught in it, the conjuration is otherwise harmless."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_wall_of_fog" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_knock",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Knock", "Scrolls of Knock"),
        description = content.text("You can channel magical energy to open locked wooden doors from a short range away."),
    }
    book:clear_use_actions()
    book:teach_spells({ "knock" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_improved_knock",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Improved Knock", "Scrolls of Improved Knock"),
        description = content.text("You can channel magical energy to open any locked door from a short range away."),
    }
    book:clear_use_actions()
    book:teach_spells({ "improved_knock" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_create_electric_lighter",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Fire Spark", "Scrolls of Fire Spark"),
        description = content.text("Summons a small electric spark, that do not harm anything.  You can use it to ignite something flammable."),
    }
    book:clear_use_actions()
    book:teach_spells({ "create_electric_lighter" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_repelling_arc",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Repelling Arc", "Scrolls of Repelling Arc"),
        description = content.text("You manifest an aura of crackling electricity around you to strike attackers with baleful lightning."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_repelling_arc" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_tornskin",
        copy_from = "spell_scroll",
        name = content.plural_text("Sappy Scroll", "Sappy Scrolls"),
        description = content.text("This scroll is covered in sap and rose thorns.  You can still make out some of the writings, but it probably won't work the same."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_tornskin" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_feralform",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Feral Form", "Scrolls of Feral Form"),
        description = content.text("Unleash your inner beast by snapping a fur-covered bone, becoming beastly."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_feralform" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_flamesword",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Flamesword", "Scrolls of Flamesword"),
        description = content.text("Ignite a wooden sword to create a flaming saber."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_summon_flamesword" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_flamebreath",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Flamebreath", "Scrolls of Flamebreath"),
        description = content.text("A pocketful of combustible powder is ignited, creating a cone of flame with ashes that stick to those in its path."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_flamebreath" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_caustic_aura",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Caustic Aura", "Scrolls of Caustic Aura"),
        description = content.text("Animate a layer of acid around you, burning attackers and increasing your melee damage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_caustic_aura" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_boneclub",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Decaying Boneclub", "Scrolls of Decaying Boneclub"),
        description = content.text("Link your live blood to dead blood and bones, creating a club eager to harvest the living."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_summon_decaying_boneclub" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_disruption_bolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Disruption Bolt", "Scrolls of Disruption Bolt"),
        description = content.text("Release a resonant bolt of spiritual energy at a nearby target.  It will disrupt the natural link between matter and animus, causing heavy but never lethal damage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "disruption_bolt" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_impactsling",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Impact Sling", "Scrolls of Impact Sling"),
        description = content.text("Infuse a sling with excess energy, delivering devastating throws before it tears itself apart."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_summon_impact_sling" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_knifeshot",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Knifeshot", "Scrolls of Knifeshot"),
        description = content.text("Emulate a railgun, launching a knife at high speed."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_knifeshot" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_summon_magic_motorcycle",
        copy_from = "spell_scroll",
        name = content.plural_text("MICE(R) blueprint", "MICE(R) blueprints"),
        description = content.text("Manafied Infernal Combustion Engine (Rideable)\nDetailed schematics for a motorcycle, that are somehow simultaneously obviously impossible and yet intriguingly intuitive.\nIn one margin, the word 'Mojocycle' has been scrawled in a flowing hand."),
    }
    book:clear_use_actions()
    book:teach_spells({ "summon_magic_motorcycle" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_nova_flare",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Nova Flare", "Scrolls of Nova Flare"),
        description = content.text("Causes an intense heat at the location, greatly damaging the target."),
    }
    book:clear_use_actions()
    book:teach_spells({ "nova_flare" })
    content.add(book)
end

do
    local book = content.Item {
        id = "spell_scroll_force_jar",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Jar of Force", "Scrolls of Jar of Force"),
        description = content.text("Summon a jar of force you can use to store liquids in."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_force_jar" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_freezing_touch",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Freezing Touch", "Scrolls of Freezing Touch"),
        description = content.text("Your hands freeze anything they touch at temperatures so cold it slows down your foes."),
    }
    book:clear_use_actions()
    book:teach_spells({ "freezing_touch" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_natures_commune",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Nature's Commune", "Scrolls of Nature's Commune"),
        description = content.text("Your connection with nature allows you to become one with it; you revitalize your body while in communion with the flora and fauna around you."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_natures_commune" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_seed_of_growth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Seed of Growth", "Scrolls of Seed of Growth"),
        description = content.text("Offer some of your life in a ritual to increase the fertility of nearby crops."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_growth" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_whisper_leaves",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Whisper of the Leaves", "Scrolls of Whisper of the Leaves"),
        description = content.text("Deepen your bond with the forest and understand the whispers of the trees."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_whisper_leaves" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_danger_sense",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Tremorsense", "Scrolls of Tremorsense"),
        description = content.text("Sink your senses into the earth and learn of the approach of anything walking upon it."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_danger_sense" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_fortitude_of_stone",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stones' Fortitude", "Scrolls of Stones' Fortitude"),
        description = content.text("Like the unyielding stone, lessen your need for food or water."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_fortitude_of_stone" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_turning_of_earth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of the Turning of the Earth", "Scrolls of the Turning of the Earth"),
        description = content.text("Ask the earth spirits to prepare the earth for planting and sowing."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_turning_of_earth" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_harvest_hunter",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Harvest of the Hunter", "Scrolls of Harvest of the Hunter"),
        description = content.text("Create usable arrows out of forest detritus."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_harvest_hunter" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_sense_outsiders",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Sense Outsiders", "Scrolls of Sense Outsiders"),
        description = content.text("Open your mystic senses and locate the things that should not be."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_sense_outsiders" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_anti_cold",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Cloak of Warmth", "Scrolls of Cloak of Warmth"),
        description = content.text("Winter-be-gone through the power of modern magic."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_anti_cold" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_anti_heat",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Cloak of Chill", "Scrolls of Cloak of Chill"),
        description = content.text("Summer-be-gone through the power of modern magic."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_anti_heat" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_slowfall",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Slowfall", "Scrolls of Slowfall"),
        description = content.text("Who's afraid of heights?  Not you, after you read this scroll."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_slowfall" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_spiderclimb",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Spider Climb", "Scrolls of Spider Climb"),
        description = content.text("Free climb better than the best."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_spiderclimb" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_swim_frog",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Limbs of the Frog", "Scrolls of Limbs of the Frog"),
        description = content.text("Swim with the fish, with your froggy hands and legs."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_swim_frog" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_giant_growth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Giant Growth", "Scrolls of Giant Growth"),
        description = content.text("Grow to enormous size and crush your enemies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_giant_growth" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_remove_instability",
        copy_from = "spell_scroll",
        name = content.plural_text("Formula of Preserve Genetic Stability", "Formulae of Preserve Genetic Stability"),
        description = content.text("This research paper has an extremely complicated series of formulae with various genetic code diagrams interspersed.  It claims that the spell will reduce the negative effects of XE037 exposure."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_remove_instability" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_carrion_feast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Carrion Feast", "Scrolls of Carrion Feast"),
        description = content.text("Eat rotten food with no ill effects.  It doesn't make it taste any better, though."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_carrion_feast" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_classless_watch_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Knowing the Day and the Hour", "Scrolls of Knowing the Day and the Hour"),
        description = content.text("Cast this spell to know exactly what time it is.  You're amazed anyone is still making these scrolls; this spell might as well be a museum piece."),
    }
    book:clear_use_actions()
    book:teach_spells({ "classless_watch_spell" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_teleport_mark",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Magus's Mark", "Scrolls of Magus's Mark"),
        description = content.text("Mark an area to be aetherically resonant so that you can easily find it later; for example, by using the Word of Recall spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_teleport_mark" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_word_of_recall",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Word of Recall", "Scrolls of Word of Recall"),
        description = content.text("The counterpart to Magus's Mark, reciting this simple spell will instantly return you to wherever it was that you cast that spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_word_of_recall" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_summon_watcher",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Watcher Spirit", "Scrolls of Summon Watcher Spirit"),
        description = content.text("Summon a spirit through whose eyes you can see.  This spell was frowned upon pre-Cataclysm due to the potential for misuse, but its many legitimate uses kept it on the curriculum at major universities' thaumaturgical studies departments."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_summon_watcher" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_beguile_savage_beast",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Beguiling the Savage Beast", "Scrolls of Beguiling the Savage Beast"),
        description = content.text("Charm an animal into your service for a time.  They don't even technically have to be savage!"),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_beguile_savage_beast" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_robot_shutdown",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shutdown", "Scrolls of Shutdown"),
        description = content.text("Stop a robot, golem, or cyborg in their tracks.  Be perfectly prepared for a different kind of apocalypse."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_robot_shutdown" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_conjure_radio",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Speak through the Aether", "Scrolls of Speak through the Aether"),
        description = content.text("Summon up a magical device that allows you to communicate through radio waves.  Well, maybe there's someone still out there."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_conjure_radio" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_conjure_ups",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Power Supply", "Scrolls of Power Supply"),
        description = content.text("Power all of your devices using mana instead of electricity."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_conjure_ups" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_welder",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Voltaic Touch", "Scrolls of Voltaic Touch"),
        description = content.text("Weld metal using touch alone.  It'll do a number on a zombie too."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_welder" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_granite_aegis",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Granite Aegis", "Scrolls of Granite Aegis"),
        description = content.text("When the going gets tough, the tough summon yards-thick walls of solid rock around themselves."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_granite_aegis" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_bramble_spear",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Spear of Brambles", "Scrolls of Spear of Brambles"),
        description = content.text("Transform a long stick into a spear that drips with sticky sap."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_bramble_spear" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_summon_tanglevine",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Summon Tanglevine", "Scrolls of Summon Tanglevine"),
        description = content.text("Conjure a lashing bunch of animated vines that will grab and hold your enemies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_summon_tanglevine" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_thornskin",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Thornskin", "Scrolls of Thornskin"),
        description = content.text("Transform your skin into bark covered in sharp thorns."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_thorn_skin" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_summon_brambles",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stranglethorns", "Scrolls of Stranglethorns"),
        description = content.text("Conjure a bunch of thick brambles out of the ground to either form a wall or slow your enemies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_summon_brambles" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_cloak_of_fog",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Cloak of Fog", "Scrolls of Cloak of Fog"),
        description = content.text("Summon up a large cloud of mist that will conceal your movements from your enemies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_cloak_of_fog" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_heart_of_hurricane",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Heart of the Hurricane", "Scrolls of Heart of the Hurricane"),
        description = content.text("Compress raging storm winds into a shell around you to protect you."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_heart_of_hurricane" })
    content.add(book)
end

do
    -- Stormshaper spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_cloak_of_frog",
        copy_from = "spell_scroll",
        name = content.plural_text("Scribbled Scroll", "Scribbled Scrolls"),
        description = content.text("Someone has scribbled on this scroll in…colored pencil?  You're pretty sure whatever it does now isn't the spell's original function."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_cloak_of_frog" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_lashing_tentacles",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Lashing Tentacles", "Scrolls of Lashing Tentacles"),
        description = content.text("Grow a pair of barbed tentacles from your shoulders that will attack enemies in melee range."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_lashing_tentacles" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_cure_disease_minor",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Purgation of Maladies", "Scrolls of Purgation of Maladies"),
        description = content.text("Snap your fingers and get rid of that nasty cold or flu, with the slight disadvantage that you'll have to vomit it out."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_cure_disease_minor" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_classless_dispel_magic",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Dispel Magic", "Scrolls of Dispel Magic"),
        description = content.text("Enemy wizards got you down?  Just remove all their magic and punch them in the face."),
    }
    book:clear_use_actions()
    book:teach_spells({ "classless_dispel_magic" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_classless_disjunction",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Disjunction", "Scrolls of Disjunction"),
        description = content.text("Remove all magic from your target, even rare or powerful spells.  Who's the archmage now?"),
    }
    book:clear_use_actions()
    book:teach_spells({ "classless_disjunction" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_hyper_regeneration",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Corporeal Reconstitution", "Scrolls of Corporeal Reconstitution"),
        description = content.text("Cuts?  Lacerations?  Torn organs?  Fix all that with this handy spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_hyper_regeneration" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_slow_bleeding",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Halt Bleeding", "Scrolls of Halt Bleeding"),
        description = content.text("Keep all that blood in your body."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_slow_bleeding" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_scalpel_fingers",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Flensing Fingers", "Scrolls of Flensing Fingers"),
        description = content.text("Turn your fingers into myriad bone knives."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_scalpel_fingers" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_caustic_blood",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Caustic Blood", "Scrolls of Caustic Blood"),
        description = content.text("Turn your blood into acid, just like that movie you used to watch all that time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_caustic_blood" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_renew_forest_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Renew the Forest", "Scrolls of Renew the Forest"),
        description = content.text("Grow an entire forest from nothing, given enough time and mana.  There were druids who made good money doing this for industrial logging, the ethics of which were always good to start an argument at a party."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_renew_forest_spell" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_wood_living_tree_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Shape Wood", "Scrolls of Shape Wood"),
        description = content.text("Grow a log from a living tree and prune it without violence."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_wood_living_tree_spell" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_anti_heat",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Water's Cooling Touch", "Scrolls of Water's Cooling Touch"),
        description = content.text("Using a bit of water, transfer water's refreshing chill to yourself."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_anti_heat" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_breathing_underwater",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Aquatic Mantle", "Scrolls of Aquatic Mantle"),
        description = content.text("Grow magical seaweed to form a protective coating, allowing you to travel the depths."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_breathing_underwater" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_disinfectant",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Wash the Wounds Clean", "Scrolls of Wash the Wounds Clean"),
        description = content.text("Disinfect your wounds with just a bit of water and magic."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_disinfectant" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_water_walking",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Water Strider's Walk", "Scrolls of Water Strider's Walk"),
        description = content.text("Walk on water using the power of your magic."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_water_walking" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_recharge_vehicle",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Imbue with Lightning", "Scrolls of Imbue with Lightning"),
        description = content.text("Charge a battery using only your mana!  Once of niche use, now a vital skill."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_recharge_vehicle" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_persuasion_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Flames of Passion", "Scrolls of Flames of Passion"),
        description = content.text("Fire yourself up to give a persuasive speech with this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_persuasion_spell" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_extinguish_fire_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Extinguish", "Scrolls of Extinguish"),
        description = content.text("Turn a fire directly into cold, putting it out.  Once one of the most commonly-known spells in the world, the lack of open flames in daily life has lead to a steep decline in its use."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_extinguish_fire_spell" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_summon_freezer_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Freezer Field", "Scrolls of Freezer Field"),
        description = content.text("Summon a sphere of ice to preserve your food inside.  Once a vital spell to keep food from rotting, then a party trick to keep drinks cold at the beach, and now back to vital once again."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_summon_freezer_spell" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_harden_earth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Harden Earth", "Scrolls of Harden Earth"),
        description = content.text("Turn dirt into solid rock.  Useful for making a fortress or a castle in a fraction of the time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_harden_earth" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_sleep_in_earth",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Stone Slumber", "Scrolls of Stone Slumber"),
        description = content.text("Sink into the depths of the earth to heal more quickly and make sleep more restful.  You don't need to eat or drink either…  Say, how many earthshapers are still asleep down there?"),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_sleep_in_earth" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_classless_clean_clothing_and_self",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Freshen Up", "Scrolls of Freshen Up"),
        description = content.text("The single most well-known spell in the entire world before the Cataclysm.  Why take a shower and do your laundry if you can get magic to do it for you?"),
    }
    book:clear_use_actions()
    book:teach_spells({ "classless_clean_clothing_and_self" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_spirit_walking",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Body of Spirit", "Scrolls of Body of Spirit"),
        description = content.text("Highly restricted before the Cataclysm, this spell allows you to turn into pure spirit and pass through the physical world unseen and insubstantial."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_spirit_walking" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_stop_attack_shield",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mageshield", "Scrolls of Mageshield"),
        description = content.text("A common protective spell even before the Cataclysm, Mageshield will render you completely invincible…against a single attack."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_stop_attack_shield" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_traverse_the_wilds",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Traverse the Wilds", "Scrolls of Traverse the Wilds"),
        description = content.text("A favored spell of those hiking the Appalachian Trail, this spell increases your speed in the wilderness."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_traverse_the_wilds" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_no_emotion_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of The Rime-Covered Heart", "Scrolls of The Rime-Covered Heart"),
        description = content.text("Highly-restricted before the Cataclysm, this spell prevents you from feeling any emotion for the duration."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_no_emotion_spell" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_far_hand_pull",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Sorcerer's Hand", "Scrolls of Sorcerer's Hand"),
        description = content.text("Pull a distant creature or item toward you.  The ultimate spell for the couch potato mage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_far_hand_pull" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_mass_hiding_aoe",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of A Shadow in the Crowd", "Scrolls of A Shadow in the Crowd"),
        description = content.text("Cut yourself off from your fellows, and also make yourself invisible to them."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_mass_hiding_aoe" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_luck_bone",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Osseous Luck", "Scrolls of Osseous Luck"),
        description = content.text("Summon benevolent spirits into a bone, granting minor benefits."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_luck_bone" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_bearmantle",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Bearmantle", "Scrolls of Bearmantle"),
        description = content.text("Take on some of the characteristics of the bear, making it much easier to survive the winter."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_bearmantle" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_eat_tons_of_food",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Gluttonous Consumption", "Scrolls of Gluttonous Consumption"),
        description = content.text("For when you don't know where your next meal is coming from and you want to make sure absolutely nothing goes to waste."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_eat_tons_of_food" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_classless_easy_sleep_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Peaceful Rest", "Scrolls of Peaceful Rest"),
        description = content.text("Never spend any time tossing and turning again with one of the most popular pre-Cataclysm spells."),
    }
    book:clear_use_actions()
    book:teach_spells({ "classless_easy_sleep_spell" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_firebolt",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Firebolt", "Scrolls of Firebolt"),
        description = content.text("Hurls a bolt of fire at the target, just like the name implies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_firebolt" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_stormshaper_loud_voice_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Thundering Voice", "Scrolls of Thundering Voice"),
        description = content.text("Greatly increases the volume of the caster's voice while also making them immune to any hearing damage the resulting noise would cause.  Very popular at pre-Cataclysm metal concerts, both on and off the stage."),
    }
    book:clear_use_actions()
    book:teach_spells({ "stormshaper_loud_voice_spell" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_ranged_increase",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Arrowflight", "Scrolls of Arrowflight"),
        description = content.text("Manipulate gravity, atmospheric drag, and friction to increase the effective ranged of ranged weapons, both bows and firearms."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_ranged_increase" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_animist_add_evasion_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Guardian Spirit", "Scrolls of Guardian Spirit"),
        description = content.text("Summon a benevolent spirit to watch over the caster and warn them of imminent attack."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_add_evasion_spell" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_technomancer_gain_electronics_computer_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Machine Mind", "Scrolls of Machine Mind"),
        description = content.text("Gain an intuitive understanding of computers and electronics, allowing an easier time repairing or using them."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_gain_electronics_computer_spell" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_heat_food",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Baking Hands", "Scrolls of Baking Hands"),
        description = content.text("Warm up your food using pure mana."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_heat_food" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_diamond_imbuement",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Diamond Imbuement", "Scrolls of Diamond Imbuement"),
        description = content.text("Enchant a weapon with the metaphysical essence of diamonds, greatly increasing its power."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_diamond_imbuement" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_slow_food_rotting_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Abjure Spirits of Rot", "Scrolls of Abjure Spirits of Rot"),
        description = content.text("Banish the decay spirits from the food you're carrying, making it last much longer before going bad."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_slow_food_rotting_spell" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_repair_metal_stone",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Fault-Mending Chant", "Scrolls of Fault-Mending Chant"),
        description = content.text("With some earth and stone and a song, repair an item made of natural stone or metal."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_repair_metal_stone" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_create_ups_connection",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Power Linkage", "Scrolls of Power Linkage"),
        description = content.text("Enchant a tool to accept power wirelessly from a compatible source."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_create_ups_connection" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_far_sight",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Zoom Lens", "Scrolls of Zoom Lens"),
        description = content.text("Enchant a lens with the ability to see beyond the horizon."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_far_sight" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_pain_ignore",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of The Body Mechanical", "Scrolls of The Body Mechanical"),
        description = content.text("Grant yourself brief reprieves from the effects of pain."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_pain_ignore" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_magic_fissile",
        copy_from = "spell_scroll",
        name = content.plural_text("Rewritten Scroll", "Rewritten Scrolls"),
        description = content.text("This scroll has been scribbled over again and again in the handwriting of more than one person.  The notes in the margins imply some sort of departmental competition, but no matter the results you can still make out a functional spell in the mess."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_magic_fissile" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_vocalize",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of The Inner Voice", "Scrolls of The Inner Voice"),
        description = content.text("Speak with your soul instead of your voice, allowing casting spells in silence."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_cast_spells_when_silent" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_silence",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Silence", "Scrolls of Silence"),
        description = content.text("Shut that pesky enemy wizard right up with this spell."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_silence" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_light_target",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Faerie Fire", "Scrolls of Faerie Fire"),
        description = content.text("Limn the target in a soft green or blue light.  Great at parties."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_light_target" })
    content.add(book)
end

do
    -- Classless spell
    local book = content.Item {
        id = "spell_scroll_classless_restore_crystal_mana",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mana Extraction", "Scrolls of Mana Extraction"),
        description = content.text("Turn crystallized mana back into mana you can use.  Doing that repeatedly is a great way to make huge quantities of mana vanish into the Aethereum."),
    }
    book:clear_use_actions()
    book:teach_spells({ "classless_restore_crystal_mana" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_goodberry",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Goodberry", "Scrolls of Goodberry"),
        description = content.text("Transform a set of berries into a set of even better berries that keep you full and heal your wounds.  Delicious and nutritious."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_goodberry" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_do_psionic_damage_to_head",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Mind Crush", "Scrolls of Mind Crush"),
        description = content.text("Use your own spirit to attack the target's spirit."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_do_psionic_damage_to_head" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_permanent_light",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Imperishable Light", "Scrolls of Imperishable Light"),
        description = content.text("Create a permanent glowing orb of light in the air.  Well, it will take a few years to see if it's really permanent; hopefully you'll live to know the answer."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_permanent_light" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_get_more_blood",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Carmine Infusion", "Scrolls of Carmine Infusion"),
        description = content.text("Using water as a medium, restore some of your lost blood.  Be more careful where you put that blood next time."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_get_more_blood" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_create_temporary_spring",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Fountain of the Depths", "Scrolls of Fountain of the Depths"),
        description = content.text("Call up the hidden waters from the depths of the earth to the surface.  Less convenient than a faucet, but the plumbing has been off for a while."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_create_temporary_spring" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_cannot_move_attack_or_damage_target",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Adamantine Gaol", "Scrolls of Adamantine Gaol"),
        description = content.text("Imprison the target in an impenetrable shell of force."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_cannot_move_attack_or_damage_target" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_diggable_teleport",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Earth Gate", "Scrolls of Earth Gate"),
        description = content.text("Sink into the ground and re-emerge somewhere nearby.  More likely to keep you in shape than the ability to teleport to the kitchen from your bedroom."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_diggable_teleport" })
    content.add(book)
end

do
    -- Druid spell
    local book = content.Item {
        id = "spell_scroll_druid_turn_tree_into_treant",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Awakening of the Forest Guardian", "Scrolls of Awakening of the Forest Guardian"),
        description = content.text("Give motion and awareness to a tree, allowing it to shake free of the soil and crush your enemies."),
    }
    book:clear_use_actions()
    book:teach_spells({ "druid_turn_tree_into_treant" })
    content.add(book)
end

do
    -- Kelvinist spell
    local book = content.Item {
        id = "spell_scroll_kelvinist_set_everyone_on_fire",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Flames of the Apocalypse", "Scrolls of Flames of the Apocalypse"),
        description = content.text("Call forth an inner fire from every enemy in the spell's radius, causing multiple explosions."),
    }
    book:clear_use_actions()
    book:teach_spells({ "kelvinist_set_everyone_on_fire" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_detect_wizards",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Witchsight", "Scrolls of Witchsight"),
        description = content.text("Open up your senses to detect the brighter ley lines of those who habitually use their magic."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_detect_wizards" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_control_mutations",
        copy_from = "spell_scroll",
        name = content.plural_text("Formula of Morphogenic Mastery", "Formulae of Morphogenic Mastery"),
        description = content.text("This research paper has an extremely complicated series of formulae with various genetic code diagrams interspersed.  It claims that the spell will allow conscious control over any \"morphogenic alterations\"."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_control_mutations" })
    content.add(book)
end

do
    -- Magus spell
    local book = content.Item {
        id = "spell_scroll_magus_push_nearby_enemies_back",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Repulsion Wave", "Scrolls of Repulsion Wave"),
        description = content.text("Unleash a wave of force to hurl anyone nearby backwards.  Great for the commute."),
    }
    book:clear_use_actions()
    book:teach_spells({ "magus_push_nearby_enemies_back" })
    content.add(book)
end

do
    -- Animist spell
    local book = content.Item {
        id = "spell_scroll_animist_see_invisibility",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Seeing the Unseen", "Scrolls of Seeing the Unseen"),
        description = content.text("Detect nearby beings with your soul rather than your eyes, allowing you to see invisible creatures."),
    }
    book:clear_use_actions()
    book:teach_spells({ "animist_see_invisibility" })
    content.add(book)
end

do
    -- Earthshaper spell
    local book = content.Item {
        id = "spell_scroll_earthshaper_remove_corpses",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of The Last Embrace", "Scrolls of The Last Embrace"),
        description = content.text("Target a corpse and cause it to sink beneath the living earth.  A staple of prehistoric funeral rites."),
    }
    book:clear_use_actions()
    book:teach_spells({ "earthshaper_remove_corpses" })
    content.add(book)
end

do
    -- Biomancer spell
    local book = content.Item {
        id = "spell_scroll_biomancer_pull_items_from_distance",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Monstrous Grasp", "Scrolls of Monstrous Grasp"),
        description = content.text("Extend a tentacle to grab an item and drag it back to you.  Disgusting but practical."),
    }
    book:clear_use_actions()
    book:teach_spells({ "biomancer_pull_items_from_distance" })
    content.add(book)
end

do
    -- Technomancer spell
    local book = content.Item {
        id = "spell_scroll_technomancer_arete_buff_spell",
        copy_from = "spell_scroll",
        name = content.plural_text("Scroll of Arete", "Scrolls of Arete"),
        description = content.text("Become the best you that it's possible to be."),
    }
    book:clear_use_actions()
    book:teach_spells({ "technomancer_arete_buff_spell" })
    content.add(book)
end
