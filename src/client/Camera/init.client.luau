--!strict
--#region Services
local RunService = game:GetService("RunService")
--#endregion

--#region Packages
--#endregion

--#region Modules
--#endregion

--#region Variables
local Players = game:GetService("Players")
local camera: Camera = workspace.CurrentCamera
local CAMERA_DEPTH = 16
local CAMERA_HEIGHT = 10
local HEIGHT_OFFSET = 2
camera.FieldOfView = 64
--#endregion

--#region Functions

local function updateCamera()
	local player = Players.LocalPlayer
	local character = player.Character
	if character then
		local root = character:FindFirstChild("HumanoidRootPart")
		if root then
			local rootPosition = root.Position + Vector3.new(0, HEIGHT_OFFSET, 0)
			local cameraPosition = root.Position + Vector3.new(0, CAMERA_HEIGHT, CAMERA_DEPTH)
			camera.CFrame = CFrame.lookAt(cameraPosition, rootPosition)
		end
	end
end

RunService:BindToRenderStep("IsometricCamera", Enum.RenderPriority.Camera.Value + 1, updateCamera)
--#endregion

--#region Listeners

--#endregion
