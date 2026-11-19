local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_READ_VAMPIRE_ANATHEMA_BOOK",
    line = ccb.content.text("[You skim through the book, searching for useful information.  Most pages are filled with trivial notes and long rants, but there's a few that attract your attention.]"),
    replies = {
        {
            text = ccb.content.text("[Read about their history]"),
            next_topic = "TALK_ANATHEMA_HISTORY",
        },
        {
            text = ccb.content.text("[Read about their recipe]"),
            next_topic = "TALK_ANATHEMA_RECIPE",
        },
        {
            text = ccb.content.text("[Read about the recipe's benefits]"),
            next_topic = "TALK_ANATHEMA_BENEFITS",
        },
        {
            text = ccb.content.text("[Read about the recipe's drawbacks]"),
            next_topic = "TALK_ANATHEMA_DRAWBACKS",
        },
        {
            text = ccb.content.text("[Read about other hunters]"),
            next_topic = "TALK_ANATHEMA_HUNTERS",
        },
        { text = ccb.content.text("[Close the book]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANATHEMA_HISTORY",
    line = ccb.content.text("I've been a vampire hunter since as far as I can remember.  I spent my entire life killing all the vampires I could find but I recently realized that doing so was futile with my current power.  I need more power.  No matter how many vampires I kill, there's always more.\nI became a vampire so I could kill them all, but even that wasn't enough.  I've followed the mentor's instructions until they had nothing more to tell me but that wasn't enough.\nI need to find a way to reach power undreamt of.  To protect everyone from the vampire threat, I must become the strongest vampire ever seen."),
    replies = {
        {
            text = ccb.content.text("[Read about their recipe]"),
            next_topic = "TALK_ANATHEMA_RECIPE",
        },
        {
            text = ccb.content.text("[Read about the recipe's benefits]"),
            next_topic = "TALK_ANATHEMA_BENEFITS",
        },
        {
            text = ccb.content.text("[Read about the recipe's drawbacks]"),
            next_topic = "TALK_ANATHEMA_DRAWBACKS",
        },
        {
            text = ccb.content.text("[Read about other hunters]"),
            next_topic = "TALK_ANATHEMA_HUNTERS",
        },
        { text = ccb.content.text("[Close the book]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANATHEMA_RECIPE",
    line = ccb.content.text("After so long spent experimenting on vampire blood, I found a way to push vampirism beyond its absolute limits.\nBy taking vampire blood, a drop of my own blood, some blood no human nor vampire could ever want to drink and an assortment of poisons and toxins, it is possible to apply the process of an ancient poison-making method to vampire blood, forcing it to devour itself to become stronger.\nWhen the process was over and I drank the remaining blood, I could now drink vampire blood to become more of a vampire than they are, with all the power this brings."),
    replies = {
        {
            text = ccb.content.text("[Read about their history]"),
            next_topic = "TALK_ANATHEMA_HISTORY",
        },
        {
            text = ccb.content.text("[Read about the recipe's benefits]"),
            next_topic = "TALK_ANATHEMA_BENEFITS",
        },
        {
            text = ccb.content.text("[Read about the recipe's drawbacks]"),
            next_topic = "TALK_ANATHEMA_DRAWBACKS",
        },
        {
            text = ccb.content.text("[Read about other hunters]"),
            next_topic = "TALK_ANATHEMA_HUNTERS",
        },
        { text = ccb.content.text("[Close the book]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANATHEMA_BENEFITS",
    line = ccb.content.text("After drinking enough vampire blood, I gained new abilities.  I could store more blood inside me, my vampiric abilities all became stronger, I could feed from vampire blood, my wounds closed at incredible speeds in the dark and more.  At the point I now am, every time I drink vampire blood my vampiric abilities grow stronger."),
    replies = {
        {
            text = ccb.content.text("[Read about their history]"),
            next_topic = "TALK_ANATHEMA_HISTORY",
        },
        {
            text = ccb.content.text("[Read about their recipe]"),
            next_topic = "TALK_ANATHEMA_RECIPE",
        },
        {
            text = ccb.content.text("[Read about the recipe's drawbacks]"),
            next_topic = "TALK_ANATHEMA_DRAWBACKS",
        },
        {
            text = ccb.content.text("[Read about other hunters]"),
            next_topic = "TALK_ANATHEMA_HUNTERS",
        },
        { text = ccb.content.text("[Close the book]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANATHEMA_DRAWBACKS",
    line = ccb.content.text("In addition to manifesting more of the vampires' classical weaknesses, some time after beginning to consume vampires for power the sun's rays started to ignite me, as I found the hard way when a fight lasted longer than planned.\nMy powers barely did anything to block them and I had to sink below the earth to survive that day.\nI did felt a passing impulse to drink more vampire blood and the first few doses made me think my mind would unravel, but that passed.  It might be that this path gives a single weakness not seen in other vampires to those far enough on it, but testing this would require creating vampires and I won't ever tolerate this."),
    replies = {
        {
            text = ccb.content.text("[Read about their history]"),
            next_topic = "TALK_ANATHEMA_HISTORY",
        },
        {
            text = ccb.content.text("[Read about their recipe]"),
            next_topic = "TALK_ANATHEMA_RECIPE",
        },
        {
            text = ccb.content.text("[Read about the recipe's benefits]"),
            next_topic = "TALK_ANATHEMA_BENEFITS",
        },
        {
            text = ccb.content.text("[Read about other hunters]"),
            next_topic = "TALK_ANATHEMA_HUNTERS",
        },
        { text = ccb.content.text("[Close the book]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANATHEMA_HUNTERS",
    line = ccb.content.text("There are other hunters, but they are traitors to the cause.  All of them.\nHow can they attack me?  How can some of them team up with vampires to attack me?\nIt is worse than I thought.  I am the last true hunter.  The duty of purging the world of vampires is mine and mine alone now.  I still let my past allies decide between running away or dying, but so many refuse to flee.\nThey force my hand over and over, I hope they will remember that."),
    replies = {
        {
            text = ccb.content.text("[Read about their history]"),
            next_topic = "TALK_ANATHEMA_HISTORY",
        },
        {
            text = ccb.content.text("[Read about their recipe]"),
            next_topic = "TALK_ANATHEMA_RECIPE",
        },
        {
            text = ccb.content.text("[Read about the recipe's benefits]"),
            next_topic = "TALK_ANATHEMA_BENEFITS",
        },
        {
            text = ccb.content.text("[Read about the recipe's drawbacks]"),
            next_topic = "TALK_ANATHEMA_DRAWBACKS",
        },
        { text = ccb.content.text("[Close the book]"), next_topic = "TALK_DONE" },
    },
}
