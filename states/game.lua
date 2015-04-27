gamestate	= require "lib.hump.gamestate"
bump		= require "lib.bump.bump"

local state = {}

function state:enter(state)
	love.graphics.setBackgroundColor(16,16,16)
	self.uptime = 0
	
	self.world = bump.newWorld(50)
	self.ground = { name = "Ground", x = 0, y = SCREEN_BOTTOM-240, 
					w = SCREEN_WIDTH, h = 240 }
	self.player = { name = "Player", x = SCREEN_CENTER_X, y = SCREEN_CENTER_Y - 80,
					w = 48, h = 96 }
	self.player.checkIsGrounded = function(self, y)
		if y < 0 then 
			self.grounded = true
			self.velocity.y = 0  
		end
	end
	self.player.grounded = false
	self.player.velocity = { x = 0, y = 0 }
	
	self.world:add( self.ground, self.ground.x, self.ground.y, self.ground.w, self.ground.h )
	self.world:add( self.player, self.player.x, self.player.y, self.player.w, self.player.h )
end

function state:keyreleased(key, unicode)

end

function state:update(dt)
	self.uptime = self.uptime + dt
	self.dt = dt
			
	if self.player.grounded then
		if love.keyboard.isDown("up") then self.player.velocity.y = -500 self.player.grounded = false end
	end
	
	if love.keyboard.isDown("right") then
		self.player.velocity.x = 400
	elseif love.keyboard.isDown("left") then
		self.player.velocity.x = -400
	else
		self.player.velocity.x = 0 
	end		

	if self.player.grounded == false then
		self.player.velocity.y = self.player.velocity.y + GRAVITY
	end

	
	local aX, aY, cols, len = self.world:move(self.player, self.player.x + self.player.velocity.x * dt, self.player.y + self.player.velocity.y * dt )
	self.player.x = aX
	self.player.y = aY
	
	self.player.grounded = false
	for i=1,len do
		local col = cols[i]
		self.player:checkIsGrounded(col.normal.y)
	end

end

function state:draw()
	love.graphics.setColor(255,255,self.player.grounded and 0 or 255)
	love.graphics.rectangle( "fill", self.player.x, self.player.y, self.player.w, self.player.h ) 
	
	love.graphics.setColor(255,255,255) 
	love.graphics.rectangle( "fill", self.ground.x, self.ground.y, self.ground.w, self.ground.h )
	love.graphics.print(string.format("%02.2f",self.uptime), SCREEN_RIGHT - 128, SCREEN_TOP + 16)
	love.graphics.print(string.format("%02.2f %02.2f", self.player.velocity.x, self.player.velocity.y), SCREEN_RIGHT - 128, SCREEN_TOP + 32)
end

return state
