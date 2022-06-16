math.randomseed(os.time())

local player_position = { x = 2, y = 3}
local scaler = 10

function collide_player()
    
end

function move_player(axis, modifier)
    player_position[axis] = player_position[axis] + modifier
end


dofile("controls/controls.lua")
dofile("map/cell_main.lua")



function love.load()

end

function love.update(delta)
    
end

function love.draw()

    love.graphics.setColor(1,1,1,1)

    for y = 1,50 do
        for x = 1,50 do
            if map[x][y] == 1 then
                love.graphics.print("x", y * scaler, x * scaler)
            end
        end
    end

    love.graphics.setColor(1,0,0,1)

    love.graphics.print("O", player_position.x * scaler, player_position.y * scaler)


end