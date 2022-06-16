-- simple helper function
local function bind(func, variable_1, variable_2)
    return function()
        return func(variable_1, variable_2)
    end
end

-- simple automated jump table for lua
local jump_table = {

    escape = bind(love.event.quit),
    f1 = bind(love.event.quit, "restart"),

    down = bind(move_player, "y", 1),
    up = bind(move_player, "y", -1),
    right = bind(move_player, "x", 1),
    left = bind(move_player, "x", -1)
}
-- basic controls
function love.keypressed( key )
    if jump_table[key] then jump_table[key]() end
end