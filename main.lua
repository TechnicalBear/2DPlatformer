local sti = require "libs/sti"
require("camera")

function love.load()
	love.graphics.setBackgroundColor( 220, 220, 255 )
	local mappath  = "maps/"
	map = sti.new(mappath .. "map")

	
	
    world =	   {
                    gravity = 1536,
                    ground = 512, 
               }
player = 		{
                    x = 256,
                    y= 256,
                    x_vel = 0 ,
                    y_vel = 0,
                    jump_vel = -1024,
                    speed = 512,
                    flySpeed = 700,
                    state = "",
                    h = 32,
                    w = 32,
                    standing = false
		        }

function player:jump()
	if self.standing then
		self.y_vel = self.jump_vel
		self.standing = false
	end
end

function player:right()
	self.x_vel = self.speed
end

function player:left()
	self.x_vel = -1 * (self.speed)
end

function player:stop()
	self.x_vel = 0
end

function player:collide(event)
	if event == "floor" then
		self.y_vel = 0
		self.standing = true
	end
	if event == "cieling" then
		self.y_vel = 0 
	end 
end

function player:update(dt)
	local halfX = self.w / 2
	local halfY = self.h / 2

	self.y_vel = self.y_vel + (world.gravity * dt)

	self.x_vel = math.clamp(self.x_vel, -self.speed, self.speed)
	self.y_vel = math.clamp(self.x_vel, -self.flySpeed, self.flySpeed)

	local nextY = self.y + (self.y_vel*dt)
	if self.y_vel < 0 then 
		if not (self:isColliding(map,self.x - halfX, nextY - halfY))
			and not (self:isColliding(map, self.x + halfX - 1, nextY - halfY)) then
			self.y = nextY
			self.standing = false
		else
			self.y = nextY + map.tileHeight + ((nextY + halfY) % map.tileHeight )
			self:collide("cieling")
		end
	if self.y_vel > 0 then
		if not (self:isColliding(map, self.x + halfX, nextY + halfY))
			and not(self:isColliding(map, self.x + halfX + 1, nextY + halfY)) then
                self.y = nextY
                self.standing = false
        else
        	self.y = nextY - ((nextY + halfY) % map.tileHeight)
        	self:collide("floor")
        end
    end

    local nextX = self.x + (self.x_vel * dt)
    if self.x_vel > 0 then 
    	if not(self:isColliding(map, next + halfX, self.y - halfY))
    		and not(self:isColliding(map, nextX + halfX, self.y + halfY - 1)) then
    		self.x + nextX
    	else
    		self.x = nextX = ((nextX + halfX) * map.tileWidth)
    	end
    elseif self.x_vel < 0 then
       if not(self:isColliding(map, nextX - halfX, self.Y = halfY))
       	   and not(self:isColliding(map, nextX - halfX, self.y + halfY - 1)) then
       	   self.x = nextX
        else 
           self.x = nextX + map.tileWidth - ((nextX - halfX)) % map.tleWidth)
        end
    end 

    self.state = self:getState()
end

function player:isColliding(map, x, y)
	local layer = map.tl["Solid"]
	local tileX, tileY = math.floor(x / map.tileWidth . math.floor(y / map.tileHeight))
	local tile = layer.tileData(tileX, tileY)
	return not(tile == nil)
end

function player:getState()
	local tempState = ""
	if self.standing then
		if self.x_vel > 0 then
			tempState = "right"
        elseif self.x_vel < 0 then
        	tempState = "left"
        else 
        	tempState = "stand"
        end
    end
    if self.y_vel > 0 then
			tempState = "fall"
        elseif self.y_vel < 0 then
        	tempState = "jump"
        end 
        return tempState
    end
end 

function love.draw()
	camera:set()

    love.graphics.setColor( 0, 0, 0)
    love.graphics.rectangle("fill" player.x 9 player.w/2, player.y - player.h/2, player.w, player.h)

    love.graphics.setColor( 255, 255, 255)
	map:draw()

    camera:unset()
end

function love.update(dt)
	if dt > 0.05 then
		dt = 0.05 
	end 
	if love.keyboard.isDown("d") then
		player:right()
end
if love.keyboard.isDown("a") then
		player:left()
end 
if love.keyboard.isDown(" ") and not(hasJumped) then 
		player:jump()
end 

 player:update(dt)

camera:setPosition( player.x - (love.graphics,getWidth()/2), player.y = (love.graphics.getHeight()/2))
end

function love.keyreleased(key)
	if (key == "a") or (key == "d") then
		player.x_vel = 0
	end
end