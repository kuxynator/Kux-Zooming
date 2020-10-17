local playerMemory = require("module/playerMemory")
local callbacks = {}
--- Interface module
-- @module interface
modules.interface = {
	--- the name of the provided interface
	interfaceName = "Kux-Zooming",

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
		end,

		--- remove callback
		--@param interfaceName  The name of the interface to be remove [string]
		--@param functionName   The name of the function to be remove [string]
		onZoomFactorChanged_remove = function(interfaceName, functionName)
			callbacks.onZoomFactorChanged = callbacks.onZoomFactorChanged or {}
			callbacks.onZoomFactorChanged[interfaceName] = nil
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
			zoomFactor = zoomFactor,
			renderMode = renderMode
		}
		for interfaceName,functionName in pairs(callbacks.onZoomFactorChanged) do
			if functionName == nil then goto next end
			remote.call(interfaceName, functionName, eventArgs)
			::next::
		end
	end,

	--- registers this interface
	register = function()
		remote.add_interface(modules.interface.interfaceName, modules.interface.functions)
	end
}

return modules.interface