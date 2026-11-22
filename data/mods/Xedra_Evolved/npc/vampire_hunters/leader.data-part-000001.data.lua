local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER",
    line = {
        choices = {
            {
            when = predicates.has_trait("speaker", "VAMPIRE"),
            yes = ccb.content.text("I'm not talking with you until you're fully cured.  It's not up to discussion."),
            no = {
                choices = {
                    ccb.content.text("Welcome."),
                    ccb.content.text("Hello."),
                    ccb.content.text("What are you here for?"),
                },
            },
        },
        },
    },
    on_enter = {
        { when = predicates.any_equal({ "yes", { scope = "speaker", key = "gave_hunter_doctor_elder_ginseng" } }), actions = { actions.replace_mutation("interlocutor", "EXTEND_LIFE") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_INTRO",
            when = predicates.negate(predicates.has_trait("speaker", "VAMPIRE")),
        },
        {
            text = ccb.content.text("Got any work for me?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
            when = predicates.handler("dlg_p_xedra_evolved_709ef5935fa8"),
        },
        {
            text = ccb.content.text("Got any work for me?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSION_CURE_OR_KILL",
            when = predicates.handler("dlg_p_xedra_evolved_fb994b54cfd1"),
        },
        {
            text = ccb.content.text("Got any work for me?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_ALL_DONE",
            when = predicates.handler("dlg_p_xedra_evolved_529068208d5f"),
        },
        {
            text = ccb.content.text("Any advice for the strigoi?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_STRIGOI_ADVICE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_LURKING_STRIGOI"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_lurking_strigoi" } })) }),
        },
        {
            text = ccb.content.text("Any advice for the renfields?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_GANG_ADVICE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_GANG"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_renfield_gang" } })) }),
        },
        {
            text = ccb.content.text("Any advice for the big renfield?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_MONSTER_ADVICE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_MONSTER"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_renfield_monster" } })) }),
        },
        {
            text = ccb.content.text("Any advice for the vampire I must try to cure?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_KILL_OR_CURE_ADVICE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_CURE_OR_KILL_TARGET"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_or_cure_target" } })) }),
        },
        {
            text = ccb.content.text("I'm back and I killed the strigoi."),
            next_topic = "TALK_KILL_LURKING_STRIGOI_COMPLETED",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.any_equal({ "yes", { scope = "speaker", key = "killed_strigoi_for_hunters" } }) }),
            actions = { actions.handler("dlg_a_xedra_evolved_7496547b9515"), actions.clear_actor_value("speaker", "killed_strigoi_for_hunters"), actions.set_actor_value("speaker", "completed_hunters_kill_lurking_strigoi", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the renfields."),
            next_topic = "TALK_KILL_RENFIELD_GANG_COMPLETED",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.any_equal({ "yes", { scope = "speaker", key = "killed_renfields_for_hunters" } }) }),
            actions = { actions.handler("dlg_a_xedra_evolved_89e264286fdb"), actions.clear_actor_value("speaker", "killed_renfields_for_hunters"), actions.set_actor_value("speaker", "completed_hunters_kill_renfield_gang", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the big renfield."),
            next_topic = "TALK_KILL_RENFIELD_MONSTER_COMPLETED",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.any_equal({ "yes", { scope = "speaker", key = "killed_renfield_monster_for_hunters" } }) }),
            actions = { actions.handler("dlg_a_xedra_evolved_7496547b9515"), actions.clear_actor_value("speaker", "killed_renfield_monster_for_hunters"), actions.set_actor_value("speaker", "completed_hunters_kill_renfield_monster", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the target."),
            next_topic = "TALK_KILL_OR_CURE_COMPLETED_KILL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunter_kill_target" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunter_cure_target" } })) }),
            actions = { actions.handler("dlg_a_xedra_evolved_c41a938df19b"), actions.clear_actor_value("speaker", "completed_hunter_kill_target"), actions.clear_actor_value("speaker", "completed_hunter_cure_target"), actions.finish_mission("MISSION_VAMPIRE_HUNTER_LEADER_CURE_OR_KILL_TARGET", { success = true }), actions.set_actor_value("speaker", "completed_hunters_kill_or_cure_target", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I cured the target."),
            next_topic = "TALK_KILL_OR_CURE_COMPLETED_CURE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "VAMPIRE")), predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunter_cure_target" } }) }),
            actions = { actions.handler("dlg_a_xedra_evolved_b061925b133f"), actions.clear_actor_value("speaker", "completed_hunter_kill_target"), actions.clear_actor_value("speaker", "completed_hunter_cure_target"), actions.finish_mission("MISSION_VAMPIRE_HUNTER_LEADER_CURE_OR_KILL_TARGET", { success = true }), actions.set_actor_value("speaker", "completed_hunters_kill_or_cure_target", "yes") },
        },
        {
            text = ccb.content.text("But why?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_WHY_NO_VAMPIRES",
            when = predicates.has_trait("speaker", "VAMPIRE"),
        },
        {
            text = ccb.content.text("Alright, I'll do that."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "VAMPIRE"),
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "VAMPIRE")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_INTRO",
    line = {
        choices = {
            ccb.content.text("We're what's left of a larger group of vampire hunters, sworn to protect humanity from these monsters that wish to subjugate it.  We would seek more vampires to destroy but <hunter_reason_a>, <hunter_reason_b> and <hunter_reason_c> changed our focus towards staying alive.  We can't fight the blood drinkers if we are all dead."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Anything I can do to help?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
            when = predicates.handler("dlg_p_xedra_evolved_709ef5935fa8"),
        },
        {
            text = ccb.content.text("Anything I can do to help?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSION_CURE_OR_KILL",
            when = predicates.handler("dlg_p_xedra_evolved_fb994b54cfd1"),
        },
        {
            text = ccb.content.text("Anything I can do to help?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_ALL_DONE",
            when = predicates.handler("dlg_p_xedra_evolved_529068208d5f"),
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_a14958bd5c9c"),
            yes = ccb.content.text("I have a few tasks to give you.  Which one do you want to do?."),
            no = ccb.content.text("I have no task to give you right now."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Killing the lurking strigoi."),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_LURKING_STRIGOI")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "killed_strigoi_for_hunters" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_lurking_strigoi" } })) }),
            actions = { actions.assign_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_LURKING_STRIGOI"), actions.handler("dlg_a_xedra_evolved_e534fc391cd7") },
        },
        {
            text = ccb.content.text("Killing the renfield gang."),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_GANG")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "killed_renfields_for_hunters" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_renfield_gang" } })) }),
            actions = { actions.assign_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_GANG"), actions.handler("dlg_a_xedra_evolved_e534fc391cd7") },
        },
        {
            text = ccb.content.text("Killing the monstrous renfield."),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_MONSTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "killed_renfield_monster_for_hunters" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_hunters_kill_renfield_monster" } })) }),
            actions = { actions.assign_mission("MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_MONSTER"), actions.handler("dlg_a_xedra_evolved_e534fc391cd7") },
        },
        {
            text = ccb.content.text("What do I get in exchange?"),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_REWARDS",
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSION_CURE_OR_KILL",
    line = ccb.content.text("We saw a nearby vampire walk under the sun recently.  Don't worry, they did not burn under the sun thanks to their umbrella.  It means they can be cured, should they accept to.  I will give you a dose of cure and you will go talk to them.  I'd prefer if you cured them from vampirism, but kill them if they refuse to take it."),
    replies = {
        {
            text = ccb.content.text("I will see if they want to be cured."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_VAMPIRE_HUNTER_LEADER_CURE_OR_KILL_TARGET"), actions.handler("dlg_a_xedra_evolved_1006266a91d6") },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_ALL_DONE",
    line = {
        choices = {
            ccb.content.text("I don't have any more missions for you.  Thank you for all your help."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_REWARDS",
    line = {
        choices = {
            ccb.content.text("I don't have much to offer except for a few services.  Elsa can give you leather and crossbow lessons while Blaine can spare some medical supplies and offer medical care in exchange for your help."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll help you."),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_LURKING_STRIGOI_COMPLETED",
    line = {
        choices = {
            ccb.content.text("This vampire was a lesser one, as seen by their resistance to the sun and lack of proper lair.  One day you will attack the lairs of true vampires alongside some of our hunters, but first we must find where they truly hide.  For now, we can enjoy some peace of mind and you can ask Elsa and Blaine for spare things to help you like you helped us."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_RENFIELD_GANG_COMPLETED",
    line = {
        choices = {
            ccb.content.text("They were close to our base, yet they did not attack it.  They were either on another mission or awaiting reinforcements before their attack.  I hope it's the former, for this base is why we did not had to risk our lives in the cities for food.  If they force us to choose between facing a raid or becoming nomads, we might never recover from it.  For now, we're alive and well thanks in no small part to you."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_RENFIELD_MONSTER_COMPLETED",
    line = {
        choices = {
            ccb.content.text("Renfields like that are rare and usually stay close to their masters to protect them.  If they're being sent to attack enemies, their masters are desperate or have many of them at their service.  It doesn't bode well, but at least you're able to kill them."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_OR_CURE_COMPLETED_KILL",
    line = {
        choices = {
            ccb.content.text("Unfortunate, but necessary.  Some don't want to be cured.  Even if we could forcefully administer it, they would go and get infected again.  Thank you for killing a future monster."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_OR_CURE_COMPLETED_CURE",
    line = {
        choices = {
            ccb.content.text("How fortunate that some of them are only regular people with an illness they want cured.  This is why we first try to cure: as long as they do not cross the point of no return with the horrible actions it requires, they are innocent until proven otherwise.  Thank you for saving an innocent from this plague."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_STRIGOI_ADVICE",
    line = {
        choices = {
            ccb.content.text("Like all vampires, the best time to attack it is during the day.  This one won't burn under the sun like true vampires, but it will stop its regeneration.  The zombies will ignore it and attacking without cutting or stabbing weapons is a bad idea.  Lastly, don't get bitten or you're in risk of catching vampirism."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_GANG_ADVICE",
    line = {
        choices = {
            ccb.content.text("They are all armed with firearms but they have very little ammo left, cannot aim well and have no consideration for friendly fire.  The best tactic would be to lure something hostile in range so they waste their ammo on it, like one of these pink crab-like creatures or a few walking plants.  If you can't, attacking them at night and making the most of their low night vision can give you an edge on them.  Just like their masters and the feral humans, they're too far gone to be targeted by zombies so don't bother luring zombies near them."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_MONSTER_ADVICE",
    line = {
        choices = {
            ccb.content.text("This kind of renfield is massive, tough, quick, precise and can tear you apart like wet paper so never get close to it.  If I were you, I would find a decent gun with enough ammo and I would shoot it from a distance until it's dead.  Yes, this one is also far too gone to be attacked by zombies.  Only true vampires are attacked by the walking corpses."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_MISSIONS_KILL_OR_CURE_ADVICE",
    line = {
        choices = {
            ccb.content.text("We know little about them, but we noticed they lack super-speed and hypnotic eyes.  If they had, I wouldn't send you on your own against them.  Approach during the day, so combat will result in them slowly burning under the sun or attacking you with an umbrella.  Unlike the previous missions, this one can be completed by luring the undead hordes at the target so they kill each other.  However, try to speak with them first to see if they want to be cured."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks for the advice."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
