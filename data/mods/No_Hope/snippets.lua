local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "necropolis_intro" }
    category:entry {
        id = "necropolis_intro_1",
        text = ccb.content.text("WELCOME HOME!  Your decision to join our family will lead you to become part of the next generation of job creators.  With us you will already have a foot in the door when it is time to rebuild the nation!"),
    }
    category:entry {
        id = "necropolis_intro_2",
        text = ccb.content.text("NEED A NEW JOB?  Now that you have secured a comfortable home, try looking into one of the many promising career opportunities that have positions open.  Openings such as GEOLOGICAL ENGINEERING ASSISTANT or FACILITY TECHNICIAN offer limitless growth potential!  Please contact your employment adviser if you have any questions."),
    }
    category:entry {
        id = "necropolis_intro_3",
        text = ccb.content.text("GOOD WITH YOUR HANDS?  Engineering always needs another hand keeping our home in good working order!  As an incentive, everyone working on level 3 will receive additional hazardous pay and time off.  Please go to the engineering office on level 3 if you are interested."),
    }
    category:entry {
        id = "necropolis_intro_4",
        text = ccb.content.text("WANT TO CONTINUE YOUR EDUCATION?  Our educational facilities are top notch and offer courses for individuals at all age groups.  Many new careers are opening up to those who are willing to learn a new craft.  Our library and research labs will keep even the hungriest minds fed!"),
    }
    ccb.content.add(category)
end
