local playerMemory = require("module/playerMemory")
local callbacks = nil

--- Interface module
-- @module interface
modules.interface = {
	--- the name of the provided interface
	interfaceName = "Kux-Zooming",

	onInit = function()
		--print("onInit")
		callbacks = {}
		modules.interface.register()
	end,

	onLoad = function()
		--print("onLoad")
		-- REMEMBER Do not change game state! not availabe are
		callbacks = global.callbacks or {}
		modules.interface.register()
	end,

	onConfigurationChanged=function ()
		--[[
		callbacks = global.callbacks or {}
		-- migrate from old format
		for e,callbackRegistrations in pairs(callbacks) do
			for k, v in pairs(callbackRegistrations) do -- ERROR invalid key to 'next' ???
				if type(v) == "table" then --  {functionName = "ffff", interfaceName = "iiii"}
					callbackRegistrations[k] = nil
					callbackRegistrations[v.interfaceName] = v.functionName
				end
			end
		end
		]]
		callbacks = {} -- clear all registrations
	end,

	--- registers this interface
	register = function()
		remote.add_interface(modules.interface.interfaceName, modules.interface.functions)
	end,

	--- provided interface functions
	functions = {

		--- Gets the current zoom factor
		--@param   playerIndex The player index [integer]
		--@return  The zoom factor [double]
		getZoomFactor = function(playerIndex)
			return playerMemory.getCurrentZoomLevel(game.players[playerIndex])
		end,

		--- Sets the zoom factor
		--@param playerIndex  The player index [integer]
		--@param zoomFactor   The new zoom factor [double]
		--@param renderMode   The new render mode [defines.render_mode, optional]
		--@param position     The new render mode [position, optional]
		setZoomFactor = function(playerIndex, zoomFactor, renderMode, position)
			--TODO
		end,

		--- add callback
		--@param interfaceName  The name of the interface to be called [string]
		--@param functionName   The name of the function to be called [string]
		onZoomFactorChanged_add = function(interfaceName, functionName)
			callbacks.onZoomFactorChanged = callbacks.onZoomFactorChanged or {}
			callbacks.onZoomFactorChanged[interfaceName] = functionName
			local count = 0
			for _ in pairs(callbacks.onZoomFactorChanged) do count = count + 1 end
			global.callbacks = callbacks
		end,

		--- remove callback
		--@param interfaceName  The name of the interface to be removed [string]
		onZoomFactorChanged_remove = function(interfaceName)
			callbacks.onZoomFactorChanged = callbacks.onZoomFactorChanged or {}
			callbacks.onZoomFactorChanged[interfaceName] = nil
			global.callbacks = callbacks
		end,
	},

	--- raise event (calls the registered remote interfaces)
	--@param player      The player [LuaPlayer]
	--@param zoomFactor  The zoom factor [double]
	--@param renderMode  The render mode [defines.render_mode]
	onZoomFactorChanged_raise = function (player, zoomFactor, renderMode)
		callbacks.onZoomFactorChanged = callbacks.onZoomFactorChanged or {}

		local eventArgs = {
			playerIndex = player.index,
			zoomFactor  = zoomFactor,
			renderMode  = renderMode
		}

		for interfaceName,functionName in pairs(callbacks.onZoomFactorChanged) do
			if functionName == nil then goto next end
			local f = function() remote.call(interfaceName, functionName, eventArgs) end
			local status, ex = pcall(f)
			if not status then
				callbacks.onZoomFactorChanged[interfaceName] = nil
				print("Kux-Zooming: ERROR callback failed. Registration removed. interface: '"..interfaceName.."', function: '"..functionName.."'\nException: "..ex )
				game.print("The mod caused a error.\nPlease report this error to the mod author (not Kux-Zooming).\n\n"..ex ,{1,0.5,0.5})
			end
			::next::
		end
	end,
}

return modules.interface