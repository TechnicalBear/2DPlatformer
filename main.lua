local sti = require "libs/sti"

function love.load()
	local mappath  = "maps/"
	map = sti.new(mappath .. "map")
	
end

function love.draw()
	map:draw()
end

function love.update(dt)
end