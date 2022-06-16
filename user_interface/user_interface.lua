ui_table = {}

batch_load_ogg({
    name = "type",
    assets = 5,
    random_pitch = false
})

local function add_element(element_table)
    assert(element_table.id, "you forgot to add in an id to your ui element")
    ui_table[element_table.id] = {
        text = element_table.text,
        position = element_table.position,
        effect = element_table.effect,
        size = element_table.size,
        color = element_table.color,
        speed = element_table.speed,
        render = (element_table.render == nil) or element_table.render
    }

    -- don't feel like typing this out over and over
    local element_pointer = ui_table[element_table.id]

    -- typing effect
    if element_table.effect == "type" then
        element_pointer.current_char = 0
        element_pointer.timer = element_table.initial_timer or 0
        element_pointer.current_string = ""
        element_pointer.loop = element_table.loop or false
        element_pointer.finished = false
    end
end

-- this mainly processes effects on text
function update_user_interface(delta)
    -- print(string.sub(ui_table.debug.text, 1, 3))

    for id,data in pairs(ui_table) do
        if data.render and data.effect and data.effect == "type" and not data.finished then
            data.timer = data.timer + delta
            if data.timer >= data.speed then

                play_sound("type")

                data.timer = 0
                data.current_char = data.current_char + 1

                if data.current_char > string.len(data.text) then
                    if data.loop then
                        data.current_char = 0
                    else
                        data.current_char = data.current_char - 1
                        data.finished = true
                    end
                end
                data.current_string = string.sub(data.text, 0, data.current_char)
            end
        end
    end
end

function render_user_interface()
    for id,data in pairs(ui_table) do
        if data.render then
            love.graphics.setColor(data.color[1], data.color[2], data.color[3], 1)
            if not data.effect then
                love.graphics.print(data.text, data.position.x, data.position.y, 0, data.size, data.size)
            else
                if data.effect == "type" then
                    love.graphics.print(data.current_string, data.position.x, data.position.y, 0, data.size, data.size)
                end
            end
        end
    end
end

add_element({
    id = "debug",
    text = "this is my debug",
    position = {x = 525, y = 20},
    effect = "type",
    speed = 0.1,
    initial_timer = 0,
    loop = false,
    size = 1,
    color = {1.0, 1.0, 0.0},
    render = true,
})

add_element({
    id = "debug2",
    text = "more debug here",
    position = {x = 525, y = 40},
    effect = "type",
    speed = 0.1,
    initial_timer = -2,
    loop = false,
    size = 1,
    color = {0.0, 1.0, 0.0}
})

add_element({
    id = "debug3",
    text = "look, more debug",
    position = {x = 525, y = 60},
    effect = "type",
    speed = 0.1,
    initial_timer = -4,
    loop = false,
    size = 1,
    color = {0.0, 0.0, 1.0}
})