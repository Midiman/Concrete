Class	= require "lib.hump.class"

Entity	= require "entities.entity"
--

Block = Class {
	__includes = Entity,
	init = function(self, world, x, y, w, h)
		Entity.init(self, world, x, y, w, h)
		self.type = "solid"
	end,
	--
	addToWorld = function(self)
		self.world:add(self,
			self.position.x, self.position.y,
			self.size.w, self.size.h)
	end,
	--
	update = function(self, dt)
		return dt
	end,
	draw = function(self)
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(255,255,0,127)
		love.graphics.rectangle('fill',
			self.position.x, self.position.y,
			self.size.w, self.size.h)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle('line',
			self.position.x, self.position.y,
			self.size.w, self.size.h)
		love.graphics.setColor(r,g,b,a)
	end,
	--
	destroy = function(self)
		return nil
	end
}
--

return Block
