local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")


local checkpointsFolder = workspace:WaitForChild("Checkpoints")
local maxCheckpoints = 2000
local yOffset = Vector3.new(0, 0, 0)


local function notify(title, text, duration)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = duration or 5
		})
	end)
end


local function setCollision(state)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = state
		end
	end
end


local function removeKillBricks(parent)
	local removedCount = 0
	for _, obj in ipairs(parent:GetDescendants()) do
		if obj:IsA("BasePart") then
			local nameLower = string.lower(obj.Name)
			if nameLower:find("kill") or nameLower:find("death") then
				obj:Destroy()
				removedCount += 1
			end
		end
	end
	print("Removed " .. removedCount .. " kill bricks from workspace.")
end


if humanoid.Health <= 0 then
	notify("Error", "You are dead. Please respawn first.", 5)
	return
	end


local stage = 0
pcall(function()
	local stats = player:WaitForChild("leaderstats", 5)
	if stats then
		local stageVal = stats:FindFirstChild("Stage")
		if stageVal and stageVal:IsA("IntValue") then
			stage = stageVal.Value
		end
	end
end)

notify("Teleporting...", "Starting from Stage "..stage + 1, 5)


humanoid.PlatformStand = true
setCollision(false)


task.spawn(function()
	for i = stage + 1, maxCheckpoints do
		if humanoid.Health <= 0 then
			notify("Teleport Cancelled", "You died during teleporting.", 5)
			break
		end

		local checkpoint = checkpointsFolder:FindFirstChild(tostring(i))
		if checkpoint and checkpoint:IsA("BasePart") then
			local targetCFrame = checkpoint.CFrame + yOffset
			rootPart.CFrame = targetCFrame
			task.wait(0.25)
		end
	end


	humanoid.PlatformStand = false
	setCollision(true)
	notify("Done", "You've completed the checkpoint chain!", 5)


	removeKillBricks(workspace)
end)
