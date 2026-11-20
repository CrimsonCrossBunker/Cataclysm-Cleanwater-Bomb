local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Uyen_1",
    name = ccb.content.text("Find 50 doses of antiseptic"),
    description = ccb.content.text("Find 50 doses of antiseptic for Uyen Tran in the refugee center, in exchange for <reward_count:FMCNote> merch."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "disinfectant",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Uyen_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There's the doc out front helping anyone that can pay… but for us up here, money mostly goes to food.  I could do a lot for basic cuts, bruises, and common stuff if I had some supplies to help out.  Could you bring me some antiseptic?  Six bottles would probably be enough to last us a while."),
        accepted = ccb.content.text("Thanks so much.  It's a small thing but it'd be really helpful."),
        rejected = ccb.content.text("That's okay.  I'm sure we'll make do somehow."),
        advice = ccb.content.text("Lots of people used to have first aid kits in their bathrooms.  I'm sure they can't all have been looted."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks so much.  Listen, I told some of the others what you were up to for us and we pooled our cash to thank you.  It's not much but I hope it helps… these are merch, the local money, you can trade them for goods from the shop.  A lot of us will take them in trade too."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 8 } },
        handler = {
            "mark_mission_flag_Uyen_Mission1",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Uyen_2",
    name = ccb.content.text("Find 30 bandages"),
    description = ccb.content.text("Find 30 bandages for Uyen Tran in the refugee center, in exchange for <reward_count:FMCNote> merch."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "bandages",
    item_count = 30,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Uyen_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There's the doc out front helping anyone that can pay… but for us up here, money mostly goes to food.  I could do a lot for basic cuts, bruises, and common stuff if I had some supplies to help out.  Could you bring me a few extra bandages?  Thirty would probably be enough to last us a while."),
        accepted = ccb.content.text("Thanks so much.  It's a small thing but it'd be really helpful."),
        rejected = ccb.content.text("That's okay.  I'm sure we'll make do somehow."),
        advice = ccb.content.text("Lots of people used to have first aid kits in their bathrooms.  I'm sure they can't all have been looted."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks so much.  Listen, I told some of the others what you were up to for us and we pooled our cash to thank you.  It's not much but I hope it helps… these are merch, the local money, you can trade them for goods from the shop."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 7 } },
        handler = {
            "mark_mission_flag_Uyen_Mission2",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Uyen_3",
    name = ccb.content.text("Find 60 doses of antidepressant"),
    description = ccb.content.text("Find 60 doses of antidepressant for Uyen Tran in the refugee center, in exchange for <reward_count:FMCNote> merch."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "prozac",
    item_count = 60,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We could still use your help…"),
        offer = ccb.content.text("I probably shouldn't be prescribing things, but there's a ton of people needing help with sleep in here.  If you could get us some antidepressants, Rhyzaea and I can probably make sure they're doled out appropriately without people having to starve to pay for them.  Three month's worth - about 6 bottles - would last us a little while."),
        accepted = ccb.content.text("Thanks so much.  It's a small thing but it'd be really helpful."),
        rejected = ccb.content.text("That's okay.  I'm sure we'll make do somehow."),
        advice = ccb.content.text("Antidepressant was really common.  You can probably find it in most medicine cabinets and pharmacies."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks so much.  Listen, I told some of the others what you were up to for us and we pooled our cash to thank you.  You've done a lot to help us out."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_flag_Uyen_Mission3",
            "advance_counter_refugee_center_refugee_happiness_by_3",
        },
    },
}
