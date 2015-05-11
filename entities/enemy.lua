Class	= require "lib.hump.class"

Entity	= require "entities.entity"
--

Enemy = Class {
	__includes = Entity,
	init = function(self, world, x, y)
		Entity.init(self, world, x, y, 32, 32)
		self.type = "enemy"
		self.health = 2
	end,
	--
	addToWorld = function(self)
		self.world:add(self,
			self.position.x, self.position.y,
			self.size.w, self.size.h)
	end,
	removeHealth = function(self, strength)
		self.health = self.health - strength

		if self.health <= 0 then
			self:destroy(self)
		end
	end,
	--
	update = function(self) end,
	draw = function(self) 
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(255,0,0,127)
		love.graphics.rectangle('fill',
			self.position.x, self.position.y,
			self.size.w, self.size.h)
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle('line',
			self.position.x, self.position.y,
			self.size.w, self.size.h)
		love.graphics.setColor(r,g,b,a)
	end,
	--
}


--

return Enemy
