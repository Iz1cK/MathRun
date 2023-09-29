--!strict
--#region Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
local Reflex = require(ReplicatedStorage.Packages.Reflex)
--#endregion

--#region Variables
local localPlayer = Players.LocalPlayer
local producer = require(script.Parent.RootProducer)
local soldiers = {}
--#endregion

--#region Functions
local function selectScoreById(id: string)
	return function(state: producer.RootState)
		return state.score[id]
	end
end

local function adjustUnits(newScore: number, oldScore: number)
	local difference = newScore - (oldScore or 0)
	local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
	if difference > 0 then
		for _ = 1, difference do
			local soldier = ReplicatedStorage.ReplicatedAssets.Soldier:Clone()
			soldier:PivotTo(character:GetPivot() + Vector3.new(math.random(-5, 5), 0, math.random(5, 10)))
			soldier.Parent = workspace
			table.insert(soldiers, soldier)
		end
	elseif difference < 0 then
		for _ = 1, -difference do
			local soldier = soldiers[#soldiers]
			soldier:Destroy()
			table.remove(soldiers, #soldiers)
		end
	end
end

local function init()
	-- make the normal walking speed faster
	local rootProducer = producer.rootProducer
	local selectScore = selectScoreById(localPlayer.UserId)
	rootProducer:subscribe(selectScore, function(newScore, oldScore)
		print("old score", oldScore)
		print("new score", newScore)
		adjustUnits(newScore, oldScore)
	end)
	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid: Humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = 30
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	humanoid.AutoRotate = false

	local angular = Instance.new("AngularVelocity")
	angular.AngularVelocity = Vector3.new(0, 0, 0)
	angular.Attachment0 = character.HumanoidRootPart.RootAttachment
	angular.Parent = humanoid
	angular.MaxTorque = math.huge

	local linearVelocity: LinearVelocity = Instance.new("LinearVelocity")
	linearVelocity.Attachment0 = character.HumanoidRootPart.RootAttachment
	linearVelocity.MaxForce = math.huge
	linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Line
	linearVelocity.LineVelocity = 40
	linearVelocity.LineDirection = Vector3.new(0, 0, -1)

	linearVelocity.Parent = character.HumanoidRootPart
end

local function start() end
--#endregion

--#region Listeners
--#endregion

init()
start()
