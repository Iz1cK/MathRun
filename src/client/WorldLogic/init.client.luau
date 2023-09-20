--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Score = require(script.Parent.score)
--#endregion

--#region Packages
--#endregion

--#region Modules
--#endregion

--#region Variables
--#endregion

--#region Functions
local function generateGoodEquation()
	local operand1 = math.random(1, 10) -- Generates a random number between 1 and 10
	local operations = { "+", "*", "-", "/" }
	local operation = operations[math.random(1, #operations)] -- Randomly selects an operation

	-- local equation = `x {operation} {operand1}`

	return operation, operand1
end

local function evaluateEquation(score: number, operation, operand1: number)
	if operation == "+" then
		return score + operand1
	elseif operation == "-" then
		return score - operand1
	elseif operation == "*" then
		return score * operand1
	elseif operation == "/" then
		-- Ensure that we don't divide by zero
		return score / operand1
	else
		error("Unknown operation: " .. operation)
	end
end

local function init()
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
			textLabel.Text = `x {operation} {operand1}`
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
					local correctAnswer = evaluateEquation(Score:getScore(), operation, operand1)
					Score:setScore(correctAnswer)
					print("score: " .. Score:getScore())
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
