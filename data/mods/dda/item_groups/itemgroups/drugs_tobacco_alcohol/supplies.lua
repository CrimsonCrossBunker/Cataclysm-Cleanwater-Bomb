local content = require("ccb").content

do
    -- contain either used or pristine boxes with any contact lenses
    local group = content.ItemGroup { id = "box_of_contact_lens_any", kind = "distribution" }
    group:group("box_of_contact_lens_weekly_pristine", 25)
    group:group("box_of_contact_lens_weekly_used")
    group:group("box_of_contact_lens_daily_pristine", 35)
    group:group("box_of_contact_lens_daily_used")
    group:group("box_of_contact_lens_daily_big_pristine", 8)
    group:group("box_of_contact_lens_daily_big_used", 30)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "box_of_contact_lens_weekly_pristine",
        kind = "distribution",
        container = "box_paper_small",
    }
    group:entry { item = "myopia_contacts_weekly", count = { 6, 6 } }
    group:entry { item = "myopia_transition_contacts_weekly", count = { 6, 6 }, probability = 25 }
    group:entry { item = "hyperopia_contacts_weekly", count = { 6, 6 } }
    group:entry { item = "hyperopia_transition_contacts_weekly", count = { 6, 6 }, probability = 25 }
    group:entry { item = "bifocal_contacts_weekly", count = { 6, 6 } }
    group:entry { item = "bifocal_transition_contacts_weekly", count = { 6, 6 }, probability = 25 }
    group:entry { item = "plano_transition_contacts_weekly", count = { 6, 6 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "box_of_contact_lens_weekly_used",
        kind = "distribution",
        container = "box_paper_small",
    }
    group:entry { item = "myopia_contacts_weekly", count = { 0, 6 } }
    group:entry { item = "myopia_transition_contacts_weekly", count = { 0, 6 }, probability = 25 }
    group:entry { item = "hyperopia_contacts_weekly", count = { 0, 6 } }
    group:entry { item = "hyperopia_transition_contacts_weekly", count = { 0, 6 }, probability = 25 }
    group:entry { item = "bifocal_contacts_weekly", count = { 0, 6 } }
    group:entry { item = "bifocal_transition_contacts_weekly", count = { 0, 6 }, probability = 25 }
    group:entry { item = "plano_transition_contacts_weekly", count = { 0, 6 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_of_contact_lens_daily_pristine", kind = "distribution", container = "box_small" }
    group:entry { item = "myopia_contacts_daily", count = { 30, 30 } }
    group:entry { item = "myopia_transition_contacts_daily", count = { 30, 30 }, probability = 25 }
    group:entry { item = "hyperopia_contacts_daily", count = { 30, 30 } }
    group:entry { item = "hyperopia_transition_contacts_daily", count = { 30, 30 }, probability = 25 }
    group:entry { item = "bifocal_contacts_daily", count = { 30, 30 } }
    group:entry { item = "bifocal_transition_contacts_daily", count = { 30, 30 }, probability = 25 }
    group:entry { item = "plano_transition_contacts_daily", count = { 30, 30 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_of_contact_lens_daily_used", kind = "distribution", container = "box_small" }
    group:entry { item = "myopia_contacts_daily", count = { 0, 30 } }
    group:entry { item = "myopia_transition_contacts_daily", count = { 0, 30 }, probability = 25 }
    group:entry { item = "hyperopia_contacts_daily", count = { 0, 30 } }
    group:entry { item = "hyperopia_transition_contacts_daily", count = { 0, 30 }, probability = 25 }
    group:entry { item = "bifocal_contacts_daily", count = { 0, 30 } }
    group:entry { item = "bifocal_transition_contacts_daily", count = { 0, 30 }, probability = 25 }
    group:entry { item = "plano_transition_contacts_daily", count = { 0, 30 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "box_of_contact_lens_daily_big_pristine",
        kind = "distribution",
        container = "box_small",
    }
    group:entry { item = "myopia_contacts_daily", count = { 90, 90 } }
    group:entry { item = "myopia_transition_contacts_daily", count = { 90, 90 }, probability = 25 }
    group:entry { item = "hyperopia_contacts_daily", count = { 90, 90 } }
    group:entry { item = "hyperopia_transition_contacts_daily", count = { 90, 90 }, probability = 25 }
    group:entry { item = "bifocal_contacts_daily", count = { 90, 90 } }
    group:entry { item = "bifocal_transition_contacts_daily", count = { 90, 90 }, probability = 25 }
    group:entry { item = "plano_transition_contacts_daily", count = { 90, 90 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_of_contact_lens_daily_big_used", kind = "distribution", container = "box_small" }
    group:entry { item = "myopia_contacts_daily", count = { 0, 90 } }
    group:entry { item = "myopia_transition_contacts_daily", count = { 0, 90 }, probability = 25 }
    group:entry { item = "hyperopia_contacts_daily", count = { 0, 90 } }
    group:entry { item = "hyperopia_transition_contacts_daily", count = { 0, 90 }, probability = 25 }
    group:entry { item = "bifocal_contacts_daily", count = { 0, 90 } }
    group:entry { item = "bifocal_transition_contacts_daily", count = { 0, 90 }, probability = 25 }
    group:entry { item = "plano_transition_contacts_daily", count = { 0, 90 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quikclot_bag_plastic_6", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "quikclot", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quikclot_bag_plastic_1_6", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "quikclot", count = { 1, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quikclot_bag_plastic_0_5", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "quikclot", count = { 0, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "adhesive_bandages_box_full", kind = "collection", container = "box_paper_small" }
    group:entry { item = "adhesive_bandages", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "adhesive_bandages_box_used", kind = "collection", container = "box_paper_small" }
    group:entry { item = "adhesive_bandages", count = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alcohol_wipes_box_full", kind = "collection", container = "box_paper_small" }
    group:entry { item = "alcohol_wipes", count = { 40, 40 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alcohol_wipes_box_used", kind = "collection", container = "box_paper_small" }
    group:entry { item = "alcohol_wipes", count = { 1, 40 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cotton_ball_bag_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cotton_ball", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tampon_box_full", kind = "collection", container = "box_small" }
    group:entry { item = "tampon", count = { 24, 24 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tampon_box_used", kind = "collection", container = "box_small" }
    group:entry { item = "tampon", count = { 1, 24 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "menstrual_pad_box_full", kind = "collection", container = "box_small" }
    group:entry { item = "menstrual_pad", count = { 24, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "menstrual_pad_box_used", kind = "collection", container = "box_small" }
    group:entry { item = "menstrual_pad", count = { 1, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cotton_ball_bag_used", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cotton_ball", count = { 1, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quikclot_bag_plastic_5", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "quikclot", count = { 5, 5 }, container = "null" }
    content.add(group)
end
