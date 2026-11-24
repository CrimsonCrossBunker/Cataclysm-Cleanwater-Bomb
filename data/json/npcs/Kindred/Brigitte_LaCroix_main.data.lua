local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_BONE_SEER", "TALK_FRIEND_BONE_SEER_Abilities" },
    line = { when = predicates.conversation_state("radio"), yes = {
            when = predicates.actor_state("speaker", "female"),
            yes = ccb.content.text(" *psssht* Do you read me, sister?  The song cannot transmit over these waves."),
            no = ccb.content.text(" *psssht* Do you read me, brother?  The song cannot transmit over these waves."),
        }, no = { when = predicates.conversation_state("has_reason"), yes = { special = "consume_reason" }, no = {
                when = predicates.actor_state("speaker", "female"),
                yes = ccb.content.text("Greetings, sister."),
                no = ccb.content.text("Greetings, brother."),
            } } },
    replies = {
        {
            text = ccb.content.text("[rules] Let's talk about how we'll work together."),
            next_topic = "TALK_DONE",
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("I'd like to know a bit more about your abilities."),
            next_topic = "TALK_FRIEND_BONE_SEER_Abilities",
            actions = { "reveal_stats" },
        },
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("There's something I want you to do."),
            next_topic = "TALK_BONE_SEER_ORDERS",
        },
        {
            text = ccb.content.text("I just wanted to talk for a bit."),
            next_topic = "TALK_BONE_SEER_SOCIAL",
            when = predicates.handler("dlg_p_dda_5d493fb3087d"),
        },
        {
            text = ccb.content.text("Can you help me understand something?  (HELP/TUTORIAL)"),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("[DEBUG MIND CONTROL] Now listen closely… (DEBUG FUNCTIONS)"),
            next_topic = "TALK_ALLY_DEBUG",
            when = predicates.has_trait("speaker", "DEBUG_MIND_CONTROL"),
        },
        {
            text = ccb.content.text("I'm going to go my own way for a while."),
            next_topic = "TALK_LEAVE",
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_BONE_SEER",
    line = ccb.content.text("Listen…  Can't you hear the song here?"),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND_BONE_SEER",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND_BONE_SEER" },
        { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_BONE_SEER_Abilities",
    line = ccb.content.text("I hear the song of the bones.  You can hear it too.  We listen to them, and learn from their stories.  I can also break them just the same."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_BONE_SEER_ORDERS" },
    line = {
        choices = {
            ccb.content.text("I know you understand my motives, but the way you phrase things is awfully distant.  No matter.  What do you need?"),
            ccb.content.text("I lent you my services, and I listen."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you teach me anything?"),
            when = predicates.negate(predicates.conversation_state("radio")),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_24352433e095") },
            success = { next_topic = "TALK_DENY_TRAIN" },
            failure = { next_topic = "TALK_TRAIN_PERSUADE_BONE_SEER" },
        },
        {
            text = ccb.content.text("Can you host a training seminar?"),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_6df687e81cfd") },
            success = { next_topic = "TALK_DENY_TRAIN_SEMINAR" },
            failure = { next_topic = "TALK_TRAIN_SEMINAR_PERSUADE_BONE_SEER" },
        },
        {
            text = ccb.content.text("I have something to teach you."),
            next_topic = "TALK_TRAIN_NPC",
            when = predicates.handler("dlg_p_dda_6347d53c499b"),
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_FRIEND_BONE_SEER",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")), predicates.negate(predicates.conversation_state("radio")) }),
            actions = { "start_trade" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_FRIEND_BONE_SEER",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("Hold on to this item."),
            next_topic = "TALK_FRIEND_BONE_SEER",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item" },
        },
        {
            text = ccb.content.text("Guard this position."),
            next_topic = "TALK_FRIEND_GUARD_BONE_SEER",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "assign_guard" },
        },
        {
            text = ccb.content.text("Find a horse and mount up!"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e15f2a008540"),
            actions = { "find_mount" },
        },
        {
            text = ccb.content.text("Drop off any items you're not using."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "drop_items_in_place" },
        },
        {
            text = ccb.content.text("Get off your mount, please."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_dc5e444f6fd5"),
            actions = { "dismount" },
        },
        {
            text = ccb.content.text("Let's talk about your current activity."),
            next_topic = "TALK_ACTIVITIES",
        },
        {
            text = ccb.content.text("Let's talk about the camp."),
            next_topic = "TALK_CAMP",
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE_BONE_SEER",
    line = ccb.content.text("I have taught you much.  A little more won't hurt."),
    replies = {
        {
            text = ccb.content.text("And I listen, as you have taught me to."),
            next_topic = "TALK_TRAIN",
            actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_PERSUADE_BONE_SEER",
    line = ccb.content.text("I haven't taught so many people before, I'll try my best."),
    replies = {
        {
            text = ccb.content.text("I know you'll do well."),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_TRAIN_SEMINAR" },
            failure = {
                next_topic = "TALK_DENY_PERSONAL",
                actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_BONE_SEER_SOCIAL" },
    line = ccb.content.text("What do you need?"),
    replies = {
        {
            text = ccb.content.text("Tell me about the songs again."),
            next_topic = "TALK_BONE_SEER_SONG_FRIEND",
        },
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_BONE_SEER_ABOUT_FRIEND",
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_ABOUT_FRIEND",
    line = ccb.content.text("I grew up in Louisiana with my grandmother.  Great cook.  Made the best boudin I've ever had.  Each night, she would tell me stories; mostly folklore and myths, like about the rougarou, or the Honey Island Swamp monster but… she sometimes told me about me about the Song, and the bones.  The way she talked about it was… different, serious.  Didn't give it much thought back then; I was just a child, after all.  I moved here a few years back for work, before the Cataclysm, before everything changed.  I do miss home sometimes, but at least the rats here are smaller.  Never could stand the things.  Anyway… thank you for asking.  Been a while since I could simply talk to someone."),
    replies = {
        {
            text = ccb.content.text("Why didn't your parents raise you?"),
            next_topic = "TALK_BONE_SEER_PARENTS_FRIEND",
        },
        { text = ccb.content.text("What's boudin?"), next_topic = "TALK_BONE_SEER_BOUDIN_FRIEND" },
        {
            text = ccb.content.text("What do you mean she talked about the Song 'differently'?"),
            next_topic = "TALK_BONE_SEER_GRANDMA_FRIEND",
        },
        {
            text = ccb.content.text("What's wrong with rats?"),
            next_topic = "TALK_BONE_SEER_RATS_FRIEND",
        },
        {
            text = ccb.content.text("Thank you for sharing.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_PARENTS_FRIEND",
    line = ccb.content.text("They died when I was very young.  Car accident.  I… don't have any memories of them, but my grandmother raised me as her own."),
    replies = { { text = ccb.content.text("She sounds nice."), next_topic = "TALK_BONE_SEER_ABOUT_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BOUDIN_FRIEND",
    line = ccb.content.text("Spicy sausage, green onions, rice.  She'd batter and deep fry them, make boudin balls.  A dish to die for."),
    replies = {
        { text = ccb.content.text("Sounds delicious."), next_topic = "TALK_BONE_SEER_ABOUT_FRIEND" },
        {
            text = ccb.content.text("Not my kind of thing."),
            next_topic = "TALK_BONE_SEER_ABOUT_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_GRANDMA_FRIEND",
    line = ccb.content.text("Unlike the other stories, she spoke with determination, reverence even.  I didn't realize it back then but it wasn't just a story; she knew that this wasn't just another tale."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_BONE_SEER_ABOUT_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_RATS_FRIEND",
    line = ccb.content.text("Ever since a young age, I hated rats.  Can't quite say why; they always struck me as something… foul.  I even have nightmares about them sometimes.  Not too long ago, I had one about a man-sized rat, shambling on it's hind legs.  It chased me up a tall building and then pushed me off, snickering.  Maybe the Song was trying to tell me something, but then again, maybe it was just a bad dream."),
    replies = {
        {
            text = ccb.content.text("Strange dream, but we all have fears, sometimes irrational."),
            next_topic = "TALK_BONE_SEER_ABOUT_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG_FRIEND",
    line = ccb.content.text("Listen carefully.  The bones… they hum.  Can you hear it?  The song they weave?  The stories they hold?"),
    replies = {
        { text = ccb.content.text("Tell me more."), next_topic = "TALK_BONE_SEER_SONG2_FRIEND" },
        {
            text = ccb.content.text("Uh… yeah, sure.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG2_FRIEND",
    line = ccb.content.text("When it all happened, the Cataclysm, something… changed.  You can see it in all creatures, most of all in their bones.  They break, morph, rise again, over and over - a never-ending cycle.  The dead walk again, horrors rip and tear each other apart.  And within each one… the quiet hum of raw strength.  Only by taking the bones does the cycle end - their story, their song, their strength; they become yours to use."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_song_asked_about_song", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do we actually do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("I'm still not remembering fully."),
            next_topic = "TALK_BONE_SEER_SONG3_FRIEND",
        },
        {
            text = ccb.content.text("Does anyone else, uh, believe this?"),
            next_topic = "TALK_BONE_SEER_OTHERS_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG3_FRIEND",
    line = ccb.content.text("Only when you crush the bones of a body does it cease to rise.  Only if you examine the bones can you see what was, the story of the bones.  Whatever causes this change is alive, writhing within us all; an inevitable part of this new world.  It holds the power of change.  When we hold the bones, we hold the power.  Thus the strength.  Together… they form a beautiful song."),
    replies = {
        {
            text = ccb.content.text("What do we actually do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("Does anyone else share this belief?"),
            next_topic = "TALK_BONE_SEER_OTHERS_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_OTHERS_FRIEND",
    line = ccb.content.text("There are others who know the power the bones hold, but not all of them are my kin.  Not anymore, at least."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_knows_kindred", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you mean 'not anymore'?"),
            next_topic = "TALK_BONE_SEER_COOPER_FRIEND",
        },
        {
            text = ccb.content.text("Why do we gather these bones again?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("Thank you for the recap, but I have to go now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER_FRIEND",
    line = ccb.content.text("Some time ago, a man named Cooper joined me and my kin.  He showed great promise and devotion to our cause, but in his effort to weave songs, he justified increasingly grim actions.  We tried to stop him when we learned of this, but he managed to get away.  If you ever come across him, be sure to thread carefully, and if you can, stop him."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What exactly did he do again?"),
            next_topic = "TALK_BONE_SEER_COOPER2_FRIEND",
        },
        {
            text = ccb.content.text("What do we do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("I see.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER2_FRIEND",
    line = ccb.content.text("He began killing others to get their bones as fresh as possible.  Later, he… he started carving the bones of the living.  Thought the anguish alone would empower the song.  The goal of the Kindred is to banish the shadow of the Cataclysm, not to cast it.  Such heinous acts will likely twist the song of the world, but I don't think Cooper realizes it.  To him, the end justifies any means."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper_kill", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Well… shit.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
        {
            text = ccb.content.text("What if he is right?  Maybe what you do isn't enough and he's the only one to do what it takes."),
            next_topic = "TALK_BONE_SEER_COOPER3_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER3_FRIEND",
    line = ccb.content.text("You do not realize the gravity of your claim.  When you understand the Song better, you will understand the danger of his actions."),
    replies = { { text = ccb.content.text("I see, I'm sorry."), next_topic = "TALK_FRIEND_BONE_SEER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BONES_FRIEND",
    line = ccb.content.text("The song can be woven in many forms.  Carved bone charms, weapons and armor all hold immense power, and when the time comes, me and my Kindred shall amass enough Song to restore this world as it was before.  Restore it, or end it.  Makes no difference."),
    replies = {
        {
            text = ccb.content.text("End the world?  What?"),
            next_topic = "TALK_BONE_SEER_END_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_END_FRIEND",
    line = ccb.content.text("The Song holds immeasurable power.  A grand symphony could revert the Cataclysm - or accelerate it to a time beyond all.  But with the world looking as is, both options are preferable."),
    replies = {
        {
            text = ccb.content.text("Yes, that's right.  Thank you for reminding me."),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
    },
}
