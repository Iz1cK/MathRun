--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local producer = require(script.Parent.RootProducer)
--#endregion

--#region Packages
local Reflex = require(ReplicatedStorage.Packages.Reflex)
--#endregion

--#region Modules
--#endregion

--#region Variables
local Players = game:GetService("Players")
--#endregion

--#region Functions
local function generateGoodEquation(): (producer.Operation, number)
	local operand1: number = math.random(10) -- Generates a random number between 1 and 10
	local operations = {}
	for _, op in pairs(producer.Operations) do
		table.insert(operations, op)
	end
	local operation = operations[math.random(4)]
	return operation, operand1
end

local function init()
	local player = Players.LocalPlayer
	for i = -160, -2048, -160 do
		local debounce = false
		for j = -25, 25, 50 do
			-- local gate = if j == -25 then "left" else "right"
			local gatePart = ReplicatedStorage.ReplicatedAssets.Gate:Clone()
			gatePart.Position = Vector3.new(j, 14, i)
			gatePart.Name = "Gate"

			local surfaceGUI = Instance.new("SurfaceGui")
			surfaceGUI.CanvasSize = Vector2.new(100, 100)
			surfaceGUI.Face = Enum.NormalId.Back

			local textLabel = Instance.new("TextLabel")
			local operation, operand1 = generateGoodEquation()
			textLabel.Text = `x {operation.sign} {operand1}`
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.Parent = surfaceGUI

			surfaceGUI.Parent = gatePart

			local touched
			touched = gatePart.Touched:Connect(function(hit)
				if debounce then
					touched:Disconnect()
					return
				end
				if hit.Parent:FindFirstChild("Humanoid") then
					print("touched gate")
					producer.rootProducer.updateScore(player.UserId, operand1, operation)
					debounce = true
				end
			end)

			gatePart.Parent = workspace
		end
	end
end
local function start() end
--#endregion

--#region Listeners
--#endregion
init()
start()
