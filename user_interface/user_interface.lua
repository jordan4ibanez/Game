ui_table = {}

local function add_element(element_table)
    assert(element_table.id, "you forgot to add in an id to your ui element")
    ui_table[element_table.id] = {
        text = element_table.text,
        position = element_table.position,
        effect = element_table.effect,
        size = element_table.size,
        color = element_table.color,
        speed = element_table.speed
    }

    -- don't feel like typing this out over and over
    local element_pointer = ui_table[element_table.id]

    -- typing effect
    if element_table.effect == "type" then
        element_pointer.current_char = 0
        element_pointer.timer = 0
        element_pointer.current_string = ""
    end
end

-- this mainly processes effects on text
function update_user_interface(delta)
    -- print(string.sub(ui_table.debug.text, 1, 3))

    for id,data in pairs(ui_table) do
        if data.effect and data.effect == "type" then
            data.timer = data.timer + delta
            if data.timer >= data.speed then
                data.timer = 0
                data.current_char = data.current_char + 1

                if data.current_char > string.len(data.text) then
                    data.current_char = 0
                end
                data.current_string = string.sub(data.text, 0, data.current_char)
            end
        end
    end
end

function render_user_interface()
    for id,data in pairs(ui_table) do
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

add_element({
    id = "debug",
    text = "this is my debug",
    position = {x = 100, y = 100},
    effect = "type",
    speed = 1,
    size = 1,
    color = {1.0, 1.0, 0.0}
})