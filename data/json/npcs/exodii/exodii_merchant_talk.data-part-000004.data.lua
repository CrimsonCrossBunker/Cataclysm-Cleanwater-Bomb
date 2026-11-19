local ccb = require("ccb")

-- Ah, you've got a discerning eye.  They're the result of many years of work.  We've been fighting the Enemy for a long time, and over the years we've worked out some armor for the job.  Keeps you going a bit longer in the field, if you ask me.  I keep some of the parts in stock, but you'll have to put it together yourself.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad",
    line = ccb.content.text("Ah, a real monger's eye, ye be.  Them's the mettle o' many a year of trials.  Us'n've been clashin wi' the Enemy for a long an' then, an' o'er the turns us've worked out some vestments for the job.  Keep's a walker walkin' longer, an I'm ken.  This'n keeps some o' the parst in an' around, but ye'd be tassed to make the vestment with the grease o' your own brow."),
    replies = {
        {
            text = ccb.content.text("What makes your specific armor so great?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad2",
        },
        {
            text = ccb.content.text("Why do I have to make it myself?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad3",
        },
        {
            text = ccb.content.text("Why are your lockers full of medieval gear?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- This and that, you know.  It's made for a traveling scavenger, you see.  What I mean is, it's well suited to carry around whatever you pick up in the wastelands, without making it too hard to get around nor giving any easy handholds for scrambling arms.  That, and I'd say it's as tough as nails.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad2",
    line = ccb.content.text("This 'n that, an I'm ken.  It be made for a fine wander, beladen with the goods o' the hunt, y'see.  By which I'm to say, 'tis well suited to carry all ye can wrest from the cold arms o' the deadlands, without troublin' your gait nor makin' it easy for the cold clutch o' the scrabblin' arm.  Be an' it is tough as a tarket's nut, I'd razz."),
    replies = {
        {
            text = ccb.content.text("Why do I have to make it myself?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad3",
        },
        {
            text = ccb.content.text("Why are your lockers full of medieval gear?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- It's a simple matter of how we teleport.  Our clothes are often made from cloth and hides from wherever we visit, and our teleporter tears living stuff apart here and there when we travel.  Some can be saved if we take care, but there's no room to store nearly enough extra.  That, and our fabricators are always busy, no time to waste on stuff we don't need for ourselves.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad3",
    line = ccb.content.text("'Tis as simple as comes to a wobble.  Our vestment be oft made from the fine clothes and hides of the land, and our jibber tears the stuff o' life apart here and there when us'n travel.  For as some can be saved if care be taken, there be no case to store nigh enough o' this.  That, an' our manuc-makers run as hot as a sunstone, no spit'n taste for that which we don't use usselves."),
    replies = {
        {
            text = ccb.content.text("What makes your specific armor so great?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad2",
        },
        {
            text = ccb.content.text("Why are your lockers full of medieval gear?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- HEH, you can't get enough of old Rubik's merchandise, eh?  Sure as hell, come back after <restock_time_point>.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_AskedRestock",
    line = ccb.content.text("HEH, ye c'nnae get enough o' ol' Rubik's merchandise, eh?  Sure as 'ell, come back after <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
