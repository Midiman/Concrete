Class		= require "lib.hump.class"
bump		= require "lib.bump.bump"
--
Manager = Class {
	init = function(self, collider)
		self.entities = {}
		self.collider = nil,
		self.objects = 0
	end,
	update = function(self, dt)
	end,
	draw = function(self)
	end,
	forEach = function(self, func)
	end,
	clearAll = function(self)
	end,
	numItems = function(self)
		return self.objects
	end
}

return Map
