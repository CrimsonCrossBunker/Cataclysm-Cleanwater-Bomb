-- Built-in gameplay HUD.  The script only reads immutable snapshots; layout
-- overrides belong to the renderer and survive Lua hot reloads.

local function percentage(value, maximum)
    if maximum == nil or maximum <= 0 then
        return 0
    end
    return math.max(0, math.min(100, math.floor(value * 100 / maximum + 0.5)))
end

local function append_alert(alerts, active, label, value)
    if active then
        table.insert(alerts, label .. " " .. value)
    end
end

local movement_mode_labels = {
    walk = "行走",
    run = "奔跑",
    crouch = "蹲伏",
    prone = "俯卧"
}

local movement_mode_order = {
    walk = 1,
    run = 2,
    prone = 3,
    crouch = 4
}

ui.hud("ccb_player_status", {
    title = "角色状态",
    default_anchor = "top_left",
    default_x = 16,
    default_y = 16,
    default_width = 0.27,
    default_height = 0.27,
    alpha = 0.84,
    interactive = false,
    background = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    local player = game.player_snapshot()
    local equipment = game.equipment_snapshot(1)
    local stamina_percent = percentage(player.stamina, player.stamina_max)

    ctx:text(player.name)
    ctx:progress_bar(stamina_percent / 100.0, "耐力 " .. stamina_percent .. "%")

    local core_status = "疼痛 " .. player.pain ..
                        "  专注 " .. player.focus ..
                        "  速度 " .. player.speed
    if player.pain > 0 then
        ctx:text_colored(core_status, 1.0, 0.45, 0.38, 1.0)
    else
        ctx:disabled_text(core_status)
    end

    local alerts = {}
    append_alert(alerts, player.hunger >= 100, "饥饿", player.hunger)
    append_alert(alerts, player.thirst >= 80, "口渴", player.thirst)
    append_alert(alerts, player.sleepiness >= 192, "疲劳", player.sleepiness)
    append_alert(alerts, player.radiation > 0, "辐射", player.radiation)
    if #alerts > 0 then
        ctx:text_colored(table.concat(alerts, "  "), 1.0, 0.72, 0.25, 1.0)
    end

    if equipment.has_weapon and equipment.weapon ~= nil then
        ctx:text("武器：" .. equipment.weapon.name)
    else
        ctx:disabled_text("武器：空手")
    end
end)

ui.hud("ccb_movement_mode", {
    title = "移动模式",
    default_anchor = "bottom_right",
    default_x = 148,
    default_y = 148,
    default_width = 0.10,
    default_height = 0.09,
    alpha = 0.92,
    interactive = true,
    background = false,
    title_bar = false,
    movable = true,
    scalable = false,
    user_toggleable = true
}, function(ctx)
    local player = game.player_snapshot()
    local modes = game.movement_modes_snapshot()
    local current_id = player.movement_mode_id
    local center_label = movement_mode_labels[current_id] or player.movement_mode_name or current_id
    local options = {}
    for _, mode in ipairs(modes.items) do
        local name = movement_mode_labels[mode.id] or mode.name or mode.id
        table.insert(options, {
            id = mode.id,
            label = name .. "\n" .. string.format("%.2f 秒", mode.switch_seconds),
            enabled = mode.available,
            selected = mode.desired
        })
    end
    table.sort(options, function(left, right)
        return (movement_mode_order[left.id] or 100) <
               (movement_mode_order[right.id] or 100)
    end)
    local selected = ctx:radial_select_id("movement_mode_selector", center_label, options)
    if selected ~= "" and selected ~= player.desired_movement_mode_id then
        game.actions.enqueue("set_move_mode", { id = selected })
    end
end)

ui.hud("ccb_world_status", {
    title = "环境信息",
    default_anchor = "top_right",
    default_x = 88,
    default_y = 16,
    default_width = 0.30,
    default_height = 0.18,
    alpha = 0.80,
    interactive = false,
    background = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    local clock = game.time_snapshot()
    local weather = game.weather_snapshot()
    local tile = game.current_tile_snapshot(8)

    ctx:text(clock.season_name .. " 第 " .. clock.day .. " 天  " ..
             string.format("%02d:%02d", clock.hour, clock.minute))

    local weather_text = weather.name .. "  " .. weather.temperature_display
    if weather.dangerous then
        ctx:text_colored(weather_text, 1.0, 0.48, 0.35, 1.0)
    else
        ctx:text(weather_text)
    end

    local location = tile.terrain_name
    if tile.furniture_name ~= "" then
        location = location .. " / " .. tile.furniture_name
    end
    ctx:text(location)

    if tile.dangerous_field or tile.trap_dangerous then
        ctx:text_colored("当前位置存在危险", 1.0, 0.35, 0.30, 1.0)
    elseif tile.item_count > 0 then
        ctx:disabled_text("地面物品 " .. tile.item_count)
    end
end)
