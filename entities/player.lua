Class	= require "lib.hump.class"

Entity	= require "entities.entity"
--

Player = Class {
	__includes = Entity, 
	init = function(self, world, x, y)
		Entity.init(self, world, x, y, 32, 64)
		self.type = "player"
		--self:addToWorld()
		self.accel = 18
		self.decel = 11
		self.brakePower = 1.5
		self.maxSpeed = 300
		self.grounded = false
		--
		self.health = 5
	end,
	--
	addToWorld = function(self)
		self.world:add(self,
			self.position.x, self.position.y,
			self.size.w, self.size.h)
	end,
	addGravity = function(self, dt)
		self.velocity.y = self.velocity.y + GRAVITY
	end,
	respondToInput = function(self, dt)
		-- Jump
		if self.grounded and love.keyboard.isDown( 'up' ) then
			self.velocity.y = -400
			self.grounded = false
		end

		-- Accel
		if love.keyboard.isDown( 'right' ) then
			self.velocity.x = math.min(self.velocity.x + self.accel, self.maxSpeed)
		end
		if love.keyboard.isDown( 'left' ) then
			self.velocity.x = math.max(self.velocity.x - self.accel, -self.maxSpeed)
		end

		-- Decel
		if not love.keyboard.isDown( 'right' ) and self.velocity.x > 0.0 then
			if self.velocity.x > 0.0 and self.velocity.x < self.decel then
				self.velocity.x = 0
			else
				self.velocity.x = self.velocity.x - self.decel
			end
		end
		
		if not love.keyboard.isDown( 'left' ) and self.velocity.x < 0.0 then
			if self.velocity.x < 0.0 and self.velocity.x > -self.decel then
				self.velocity.x = 0
			else
				self.velocity.x = self.velocity.x + self.decel
			end
		end	
	end,
	moveWithCollision = function(self, dt)
		self.grounded = false
		local world = self.world

		local futureX = self.position.x + self.velocity.x * dt
		local futureY = self.position.y + self.velocity.y * dt

		local nextX, nextY, cols, len = world:move(self,
			futureX, futureY)

		for i=1,len do
			local col = cols[i]

			if col.other.type == "enemy" then
				self.velocity.x = self.velocity.x * -1 
				self.velocity.x = -160 
				col.other:removeHealth(1)
			else
				self:checkOnGround(col.normal.y)
				self:checkSides(col.normal.x)
			end
		end

		self.position.x = nextX
		self.position.y = nextY
	end,
	checkSides = function(self, normalX)
		if normalX ~= 0 then self.velocity.x = 0 end
	end,
	checkOnGround = function(self, normalY)
		if normalY < 0 then
			self.grounded = true
			self.velocity.y = 0
		end
	end,
	--
	update = function(self, dt)
		self:addGravity(dt)
		self:respondToInput(dt)
		self:moveWithCollision(dt)
	end,
	draw = function(self)
		local r,b,g,a = love.graphics.getColor()
		love.graphics.setColor(128,128,128)
		love.graphics.rectangle('fill',
			self.position.x, self.position.y,
			self.size.w, self.size.h)

		if self.grounded then
			love.graphics.setColor(255,0,128)
			love.graphics.rectangle('fill',
				self.position.x, self.position.y + self.size.h -4,
				self.size.w, 4)
		end

		love.graphics.setColor(r,b,g,a)
	end,
	--
	destroy = function(self)
		return nil
	end
}


--

return Player
