local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "<good_job>" }
    category:text(ccb.content.text("You deserve a pat on the back!"))
    category:text(ccb.content.text("Groovy!"))
    category:text(ccb.content.text("Bitchin'!"))
    category:text(ccb.content.text("Hip hip hurray!"))
    category:text(ccb.content.text("Gee that's swell!"))
    category:text(ccb.content.text("Good for you!"))
    category:text(ccb.content.text("I say, smashing job!"))
    category:text(ccb.content.text("Like, totally gnarly!"))
    category:text(ccb.content.text("Nice, <u_name>!"))
    category:text(ccb.content.text("Good job, <u_name>!"))
    category:text(ccb.content.text("Awesome!"))
    ccb.content.add(category)
end
