--!strict
--#region Services
local Players = game:GetService("Players")
--#endregion

--#region Packages
--#endregion

--#region Variables
--#endregion

--#region Functions
local function init()
	-- make the normal walking speed faster
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
