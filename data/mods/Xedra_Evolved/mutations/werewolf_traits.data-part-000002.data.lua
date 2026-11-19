local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE",
    name = ccb.content.text_without_extraction("Sense the Outsider Active"),
    points = 2,
    description = ccb.content.text_without_extraction("The active trait for Sense the Outsider.  This should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_STUN_MACHINE",
    name = ccb.content.text("Gremlinize"),
    points = 2,
    description = ccb.content.text("You can cause just enough change in a machine to confuse the rigid requirements of its programming, stunning it."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_stun_machine_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_EXTRA_WEAKPOINT_HITS",
    name = ccb.content.text("Go for the Throat"),
    points = 3,
    description = ccb.content.text("A successful hunter targets the vulnerable belly, or throat, or ears, they do not simply bite the first thing that comes into their reach.  When unarmed or in war or wolf form, you have a higher chance to hit your enemies' weakpoints."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    enchantments = { "INLINE_ENCH_WEREWOLF_EXTRA_WEAKPOINT_HITS_0" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_FAR_JUMP",
    name = ccb.content.text("Grasshopper's Leap"),
    points = 2,
    description = ccb.content.text("You can make mighty leaps from a standing start that would normally be impossible.  While in wolf form, you can jump <color_green>even further</color>."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_far_jump_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_CAMOUFLAGE_COAT",
    name = ccb.content.text("Shimmerpelt"),
    points = 4,
    description = ccb.content.text("Blend your coat in with the surrounding environment, making it harder for enemies to spot you.  This gift is most effective in wolf form, but still has minor effects in human or war form."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 10,
    activation_message = "",
    enchantments = { "INLINE_ENCH_WEREWOLF_CAMOUFLAGE_COAT_0" },
}

-- Tier 3 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_PARTIAL_SHIFT",
    name = ccb.content.text("Partial Shift"),
    points = 2,
    description = ccb.content.text("Transforming fully is very useful but the real mark of mastery is changing only a part of your body.  This is most useful in human form, but can be used in other forms as well, such as transforming your hands back into human ones for easier manipulation."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
}
