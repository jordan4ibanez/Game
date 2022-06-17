math.randomseed(os.time())

local player_position = { x = 2, y = 3}
local scaler = 11.5

local function collide_player(axis, modifier)
    -- apply the position in dry run
    local new_player_position = {x = player_position.x, y = player_position.y}
    new_player_position[axis] = new_player_position[axis] + modifier

    -- no going out of the cell
    if new_player_position.x < 0 or new_player_position.x > cell_size
        or new_player_position.y < 0 or new_player_position.y > cell_size then
            return false
    end

    -- there's something blocking it
    if test_cell[new_player_position.y][new_player_position.x] ~= 0 then
        return false
    end

    -- good to go
    return true
end

function move_player(axis, modifier)
    if collide_player(axis, modifier) then
        player_position[axis] = player_position[axis] + modifier

        play_sound("step")
    end
end



dofile("sound_api/sound_api.lua")
dofile("controls/controls.lua")
dofile("map/cell_main.lua")
dofile("user_interface/user_interface.lua")

batch_load_ogg({
    name = "step",
    assets = 5,
    random_pitch = false
})


function love.load()

    love.graphics.setDefaultFilter( "nearest", "nearest", 1 )

    ibm = love.graphics.newFont("font/NFPixels.ttf", 16)
    ibm:setFilter("nearest", "nearest", 1)
    love.graphics.setFont(ibm)
    
    complete_ogg_load()
end

function love.update(delta)
    update_user_interface(delta)
end

function love.draw()

    love.graphics.setColor(1,1,1,1)

    for y = 1,50 do
        for x = 1,50 do
            if test_cell[x][y] == 1 then
                love.graphics.print("X", y * scaler, x * scaler)
            end
        end
    end

    love.graphics.setColor(1,0,0,1)

    love.graphics.print("O", player_position.x * scaler, player_position.y * scaler)

    render_user_interface()

end