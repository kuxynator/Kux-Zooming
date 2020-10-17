
local function isEnabled()
	return game.get_player(1).mod_settings["ZoomingReinvented_debug"].value
end

--- debug module
-- @module debug
local module = {

	onSettingsChanged = function ()
		--
	end,

	trace = function(...)
		if not isEnabled() then return end

		local msg = ""
		local args = {...}
		for i,v in ipairs(args) do
			if v == nil then v = "{nil}" end
		   msg = msg .. v
		end
		game.get_player(1).print(msg, {r = 0.7, g = 0.7, b = 0.7, a = 1})
	end,

	warning = function(...)
		if not isEnabled() then return end

		local msg = ""
		local args = {...}
		for i,v in ipairs(args) do
			if v == nil then v = "{nil}" end
		   msg = msg .. v
		end
		game.get_player(1).print(msg, {r = 1, g = 1, b = 0, a = 1})
	end,

	error = function(...)
		if not isEnabled() then return end

		local msg = ""
		local args = {...}
		for i,v in ipairs(args) do
			if v == nil then v = "{nil}" end
		   msg = msg .. v
		end
		game.get_player(1).print(msg, {r = 1, g = 0, b = 0, a = 1})
	end
}

return module