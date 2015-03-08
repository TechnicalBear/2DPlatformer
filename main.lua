local AdvTiledLoader = require ("AdvTiledLoader")

function love.load()
	AdvTiledLoader.path = "maps/"
	map = AdvTiledLoader/load("map.tmx")
	map:setDrawRange(0, 0, map.width * map.tileWidth, map.height * map.tileHeight)

end

function love.draw()
	map:draw()
end

function love.update(dt)
end