local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A bloodthorne druid helping the hunters, mainly by proposing a cure to vampirism that's not dependent on current supplies.
-- Main goal is to make new Bloodthorne druids.
ccb.content.define_npc {
    id = "vampire_hunter_bloodthorne",
    suffix = ccb.content.text("Bloodthorne druid"),
    class = "NC_vampire_hunter_bloodthorne",
    unique_name = ccb.content.text("Phyliss Thomason"),
    gender = "female",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_HUNTER_BLOODTHORNE",
    personality = { aggression = 5, bravery = 10, collector = -3, altruism = 3 },
    faction = "vampire_hunters",
}

-- Hunts with her heartvines, so she's better at melee but poor at crossbows.
-- She has been a Bloodthorne for a very long time, thus getting all what a Bloodthorne can get.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_bloodthorne",
    name = ccb.content.text("Bloodthorne druid"),
    job_description = ccb.content.text("I hunt vampires with my inner plant."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Mixed" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "FALSE_ARVORE_HATRED" },
        { trait = "BLOODTHORNE_SORCERY" },
        { trait = "BLOODTHORNE_DRUID" },
        { trait = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" },
        { trait = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP" },
        { trait = "JAUNDICE_ARVORE_ALCHEMY" },
        { trait = "GREENSTRIDE" },
        { trait = "ARVORE_NURTURING_THE_GREEN" },
        { trait = "ARVORE_SUMMON_WOOD_WALL" },
        { trait = "ARVORE_COMMUNE_WITH_NATURE" },
        { trait = "ARVORE_SUMMON_BRIARS" },
        { trait = "ARVORE_FOREST_TELEPORT" },
        { trait = "ARVORE_TERRAIN_BASH_SPELL" },
        { trait = "ARVORE_VERDANT_INFUSION" },
        { trait = "ARVORE_SUMMON_GRASS_FIELD" },
        { trait = "ARVORE_CLIMBING_VINE_SPELL" },
        { trait = "ARVORE_ANTI_PLANT_SPELL" },
        { trait = "ARVORE_FOREST_MAPPING" },
        { trait = "ARVORE_WOOD_WEAPON_DAMAGE" },
        { trait = "ARVORE_TOXIC_FLESH" },
        { trait = "ARVORE_SUN_NUTRIENTS_AND_MANA" },
        { trait = "ARVORE_PAIN_RESISTANCE" },
        { trait = "ARVORE_VINE_DRAG" },
        { trait = "ARVORE_WOOD_CLAWS" },
        { trait = "ARVORE_RESIST_CHILL" },
        { trait = "ARVORE_KNOW_TIME" },
        { trait = "ARVORE_SURVIVAL_BONUS" },
        { trait = "ARVORE_EYES" },
        { trait = "ARVORE_BLOOD" },
        { trait = "ARVORE_THORN_SKIN" },
        { trait = "BLOODTHORNE_DRUID_REGAIN_BLOOD" },
        { trait = "BLOODTHORNE_DRUID_BONUS_MANA_REGEN" },
        { trait = "BLOODTHORNE_DRUID_STOP_BLEEDING" },
        { trait = "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM" },
        { trait = "BLOODTHORNE_DRUID_GAIN_STRENGTH_DEXTERITY_BUFF" },
        { trait = "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE" },
        { trait = "BLOODTHORNE_DRUID_AURA_OF_VINES" },
        { trait = "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD" },
        { trait = "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES" },
        { trait = "BLOODTHORNE_DRUID_SUMMON_THORNHOUND" },
        { trait = "BLOODTHORNE_DRUID_SLOWER_BLEEDING" },
        { trait = "BLOODTHORNE_DRUID_CREATE_THORN_PRISON" },
    },
    worn = "VAMPIRE_HUNTER_BLOODTHORNE_worn",
    weapon = "EMPTY_GROUP",
    common = false,
    skills = {
        { skill = "melee", bonus = { rng = { 5, 7 } } },
        { skill = "cutting", bonus = { rng = { 5, 7 } } },
        { skill = "survival", bonus = { rng = { 2, 3 } } },
        { skill = "dodge", bonus = { rng = { 4, 5 } } },
        { skill = "deduction", bonus = { rng = { 5, 6 } } },
    },
}

-- Due to her heartvines, she notices vampirism before it has visible symptoms.
ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_BLOODTHORNE",
    line = {
        choices = {
            {
                when = predicates.has_effect("speaker", "vampire_virus"),
                yes = ccb.content.text("You seem unwell.  Are you looking for a cure to your condition?"),
                no = {
                    choices = {
                        {
                            when = predicates.has_item("speaker", "arvore_sample"),
                            yes = ccb.content.text("I see you brought some arvore samples.  Can I have them?  I'll tell Elsa and Blaine to reward you if you do."),
                            no = ccb.content.text("You do not need my help right now, so I'll return to my work."),
                        },
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I am.  Free me from this curse."),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_OFFER_CURE",
            when = predicates.has_effect("speaker", "vampire_virus"),
        },
        {
            text = ccb.content.text("How can you help me?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INTRO",
            when = predicates.negate(predicates.has_effect("speaker", "vampire_virus")),
        },
        {
            text = ccb.content.text("Sure!  How many do you want?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_item("speaker", "arvore_sample"),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_OFFER_CURE",
    line = {
        choices = {
            {
            when = predicates.handler("w16b_p_xedra_evolved_a36fde5af7fe"),
            yes = ccb.content.text("Before that, you must starve yourself of blood so I know you genuinely want to be freed.  Return to me when you will show symptoms of blood starvation and I will cure you."),
            no = ccb.content.text("You starved yourself of blood.  Good.  Now lie there on the dirt and stay perfectly still while the heartvines do their work.  It'll take half an hour, it'll hurt and you'll probably need a few days to recover, but you won't become another victim of this curse."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Go ahead."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_f917d87baf9c"),
            actions = { actions.handler("w16b_a_xedra_evolved_e185a1582968") },
        },
        {
            text = ccb.content.text("Go ahead."),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_CURE_WARNING",
            when = predicates.handler("w16b_p_xedra_evolved_8a7c92bf3c2d"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_CURE_WARNING",
    line = {
        choices = {
            ccb.content.text("I must warn you before we start.  Your weakened body and your potent vampirism mean that the heartvines will cause severe damage to your body.  You could die from the procedure.  Are you sure you want to do this?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I will find another way."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Do it.  <color_red>This might literally kill you.</color>"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_xedra_evolved_e185a1582968") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_PERFORM_CURE",
    line = {
        choices = {
            ccb.content.text("\"And done\" Phyliss says.  \"You're now free from vampirism for the time being.  Take some time to recover, and ask Blaine if you ever want to buy a less painful cure from him.\""),
        },
    },
    replies = { { text = ccb.content.text("thanks.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INTRO",
    line = {
        choices = {
            ccb.content.text("I can use my heartvines to cure people from vampirism.  I let the heartvines enter their veins where the curse will be destroyed by the heartvines and their intense desire to kill all vampires.  It's painful for them, but it's better than staying a vampire."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What's a heartvine?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INNER_PLANT",
        },
        { text = ccb.content.text("Cool.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

-- Maybe she'll offer the player to become a Bloodthorne druid someday, but not for now.
ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INNER_PLANT",
    line = {
        choices = {
            ccb.content.text("That's how Bloodthorne druids call the plant inside them.  It empowers us through the essence of nature spirits so we may kill the blood-drinkers.  Before you ask, I can't help you become one.  I wasn't taught how to do this before I lost contact with other Bloodthorne druids."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you mean by \"essence\"?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_NEED_SAMPLES",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_NEED_SAMPLES",
    line = {
        choices = {
            ccb.content.text("Their very essence, torn from their corpses and transferred into our bodies.  They can sense that, and it is why they try to kill all Bloodthorne druids on sight.  As long as you don't ingest their essence they won't hate you for killing their brethren, so you're perfect to gather these samples for our mutual gain."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I have some.  Do you want them?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_item("speaker", "arvore_sample"),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_79ce6c0fc7d3"),
            yes = ccb.content.text("I'll take as many as you offer."),
            no = {
                choices = {
                    {
                    when = predicates.handler("dlg_p_xedra_evolved_3f092d269806"),
                    yes = ccb.content.text("You started hunting nature spirits?  Good!  Don't feel bad about them.  If they won't use their powers against the bloodsuckers, we will take these powers for ourselves to fight this war."),
                    no = {
                        choices = {
                            {
                            when = predicates.handler("dlg_p_xedra_evolved_e5045d407662"),
                            yes = ccb.content.text("I'll have to offer less help per sample, as I can't keep giving favors away for so little."),
                            no = ccb.content.text("The more samples, the better.  I'll need as many as possible so I may make more Bloodthorne druids someday."),
                        },
                        },
                    },
                },
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[Sell her 1 arvore sample]"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_item("speaker", "arvore_sample"),
            actions = { actions.transfer_items("arvore_sample"), actions.handler("dlg_a_xedra_evolved_222ea183fbd2") },
        },
        {
            text = ccb.content.text("[Sell her 5 arvore samples]"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_inventory("speaker", "arvore_sample", 5),
            actions = { actions.transfer_items("arvore_sample", 5), actions.handler("dlg_a_xedra_evolved_c270fbcc5a33") },
        },
        {
            text = ccb.content.text("[Sell her 10 arvore samples]"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_inventory("speaker", "arvore_sample", 10),
            actions = { actions.transfer_items("arvore_sample", 10), actions.handler("dlg_a_xedra_evolved_1dee5cbf43dc") },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
