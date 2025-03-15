local function getValue1()
	return math.random(-10,10)
end

local function getValue2()
	return math.random(-10,10)
end

local part = game.Workspace["Button"]
local distance = 5
script.Parent.Anchored = true
local partIsTouch = false
local count = 0
local kickThreshold = 42

local sound = game.Workspace["Button Click"]

local function press()
	if not sound.IsPlaying then
		sound:Play()
	end
end

local function changeColor()
	local r = math.random(0, 255) / 255 -- Convert to 0-1 range
	local g = math.random(0, 255) / 255
	local b = math.random(0, 255) / 255

	part.Color = Color3.new(r, g, b) -- Apply the new color
end

local function getPlayerFromTouch(touch)
	local character = touch.Parent
	if character then
		return game.Players:GetPlayerFromCharacter(character)
	end
	return nil
end

local function getClosestMessage(count, messages)
	local closestKey = nil
	for key, _ in pairs(messages) do
		if key <= count then
			if closestKey == nil or key > closestKey then
				closestKey = key
			end
		end
	end
	return closestKey and messages[closestKey] or nil
end

-- Function to ensure GUI is inside PlayerGui
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		local playerGui = player:FindFirstChild("PlayerGui")
		if playerGui then
			-- Check if GUI already exists
			if not playerGui:FindFirstChild("MessageGui") then
				local screenGui = game.StarterGui:FindFirstChild("MessageGui")
				if screenGui then
					local clonedGui = screenGui:Clone()
					clonedGui.Parent = playerGui
				end
			end
		end
	end)
end)

-- Function to display message on screen
local function showMessage(player, text)
	if player then
		local playerGui = player:FindFirstChild("PlayerGui")
		if playerGui then
			local screenGui = playerGui:FindFirstChild("MessageGui")
			if screenGui then
				local messageLabel = screenGui:FindFirstChild("MessageLabel")
				if messageLabel then
					messageLabel.Text = text
					messageLabel.Visible = true
					task.wait(3) -- Display message for 3 seconds
					messageLabel.Visible = false
				else
					warn("MessageLabel not found in MessageGui")
				end
			else
				warn("MessageGui not found in PlayerGui")
			end
		else
			warn("PlayerGui not found in player")
		end
	end
end

part.Touched:Connect(function(move)
	if partIsTouch == false then
		partIsTouch = true
		press()

		local player = getPlayerFromTouch(move)

		local x = 27
		if count < x then
			for i = 0, distance do
				part.CFrame = part.CFrame + Vector3.new(0, -0.5, 0)
				task.wait(0.2)
				part.CFrame = part.CFrame + Vector3.new(0, 0.5, 0)
			end
		elseif count > x then
			for i = 0, distance do
				part.CFrame = part.CFrame + Vector3.new(0, 0, getValue1())
				task.wait(0.2)
				part.CFrame = part.CFrame + Vector3.new(getValue2(), 0, 0)
				changeColor()
			end
		end

		if player and count >= kickThreshold then
			player:Kick("You have pressed the button too many times!")
		end

		count = count + 1

		local messages = {
			[2] = "What are you doing here?",
			[7] = "Can you stop pressing that useless button?",
			[11] = "Well, if you want something to entertain you, I can make something.",
			[16] = "Here. Hope you like it.",
			[20] = "Why are you still here?",
			[25] = "How about I change things up a bit?",
			[32] = "Isn't this fun? Running around doing absolutely nothing but pressing that useless button.",
			[37] = "Alright, playtime is over. Can you actually go away now?",
			[41] = "Fine then, how about this?",
			[45] = "I dare you to press the button now.",
		}

		if messages[count] and player then
			showMessage(player, messages[count]) -- Show message on screen
		end

		task.wait(0.5)
		partIsTouch = false
	end
end)
