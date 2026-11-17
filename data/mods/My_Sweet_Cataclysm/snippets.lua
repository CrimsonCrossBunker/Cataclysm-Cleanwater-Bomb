local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "flier" }
    category:entry {
        id = "flier_my_sweet_cataclysm_1",
        text = ccb.content.text("A flyer for some kind of candy.  It shows a picture of a gleaming human made of smooth candy looking at you in terror.  \"SugarKin the first life-size human candy!  Are you a real monster?  Will you be able to devour it all?\""),
    }
    ccb.content.add(category)
end
