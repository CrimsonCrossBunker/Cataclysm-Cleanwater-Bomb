local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "clickbait" }
    category:text(ccb.content.text("MAYA SACRIFICING GAMEPLAY FOR REALISM?  THE SHOCKING TRUTH REVEALED"))
    category:text(ccb.content.text("TEN FACTS ABOUT THE NEW BIONIC SYSTEM THAT WILL SHOCK YOU"))
    category:text(ccb.content.text("YOU WON'T BELIEVE WHO JUST ADDED A NEW PROFESSION"))
    category:text(ccb.content.text("TRIVIALIZE THE EARLY GAME WITH THIS ONE SIMPLE SPEAR WEAPON!  CONTRIBUTORS HATE HIM"))
    category:text(ccb.content.text("A MEDICAL MUTANT SET THEMSELVES ON FIRE - YOU WON'T BELIEVE WHAT HAPPENED NEXT"))
    category:text(ccb.content.text("THE TRUTH ABOUT CATACLYSM'S DEVELOPMENT - AND ITS DISGUSTING SECRET"))
    category:text(ccb.content.text("IT'S TRUE - MUTAGEN IS 40% BLEACH, AND HERE'S WHY"))
    category:text(ccb.content.text("20 EASY WAYS TO ESCAPE A LAB - #4 WILL BLOW YOUR MIND"))
    ccb.content.add(category)
end
