--!strict
--#region Services
local Players = game:GetService("Players")
--#endregion

--#region Packages
--#endregion

--#region Modules
local producer = require(script.RootProducer)
--#endregion

--#region Variables
local localPlayer = Players.LocalPlayer
--#endregion

--#region Functions

local function init()
	local rootProducer = producer.rootProducer
	rootProducer.initializeScore(localPlayer.UserId)
end

local function start() end
--#endregion

--#region Listeners
--#endregion

init()
start()
