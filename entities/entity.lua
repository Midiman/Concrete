Class	= require "lib.hump.class"

--

Entity = Class {
	init = function(self, world, x, y, w, h)
		self.type = "entity"
		self.world = world
		self.position = { x = x, y = y }
		self.velocity = { x = 0, y = 0 }
		self.size = { w = w, h = h }
		-- Install to world
		self.addToWorld(self)
	end,
	addToWorld = function(self)
		return nil
	end,
	--
	getPosition = function(self)
		return self.position.x, self.position.y
	end,
	getBounds = function(self)
		return self.bounds.w, self.bounds.h
	end,
	getCenter = function(self)
		return self.position.x + self.size.w/2,
			   self.position.y + self.size.h/2
	end,
	--
	update = function(self) end,
	draw = function(self) end,
	--
	destroy = function(self)
		self.isDestroyed = true
		self.world:remove(self)
	end
}


--

return Entity
