local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "<ddotd_calculator_watch_use>" }
    category:text(ccb.content.text("You do some math using your watch.  Fancy!"))
    category:text(ccb.content.text("You press some buttons on your watch.  Digital watches are a pretty neat idea."))
    category:text(ccb.content.text("You have nothing to calculate, so you type 95*843.  Classy."))
    category:text(ccb.content.text("The world may have ended, but you have a calculator watch.  You admire it."))
    category:text(ccb.content.text("You start calculating your odds of long term survival, then get sad and stop."))
    category:text(ccb.content.text("You do some very important math, right on your wrist."))
    category:text(ccb.content.text("After doing some math on your wrist, you realize humans will never again reach such a pinnacle of microcomputing."))
    category:text(ccb.content.text("At the end of the world, nothing is as relaxing as doing a little math on your watch."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<talk_snippet_modded_liam_meeting1>" }
    category:text(ccb.content.text("*, your old friend, looks up at you in shock.  At his feet lies a corpse, its head almost completely blown off by the shotgun that drops limply from Liam's fingers as you approach.  \"I swear, dude, this is not what it looks like.\""))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<talk_snippet_modded_liam_Friends4ever>" }
    category:text(ccb.content.text("Aww, of course.  No matter what happens, you're always you and I'm always me, right?  We've been through worse than this.\"  He pauses, his brow furrowed.  \"Well, okay, maybe we haven't.  But we've stuck through it all for so many years, what's a little undead apocalypse gonna change?  Hell, I think we're in for one of those classic buddy-buddy zombie movie experiences, like, uh, Dawn of the Dead.\"  He pauses.  \"Maybe not that one.  Night of the Living Dead?\"  He pauses again.  \"Zombieland, maybe.  Who cares.  You're my family, more than my birth family ever was."))
    ccb.content.add(category)
end
