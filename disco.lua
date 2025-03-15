script.Parent.Anchored = true
local partIsTouch = false

local count = 0  -- Use 'local' for better scope handling

local part = workspace.Button
local discoPart = workspace:FindFirstChild("Disco")
discoPart.Transparency = 1
part.Touched:Connect(function(hit)
	if not partIsTouch then
		partIsTouch = true
		task.wait(1.5)
		partIsTouch = false

		count = count + 1  -- Increment global count

		if count == 20 then
			script.Parent.Anchored = false  -- Unanchor when touched 5 times
			discoPart.Transparency = 0

			-- Start flashing colors in a separate thread
			if discoPart then
				task.spawn(function()
					while true do
						discoPart.BrickColor = BrickColor.new("Maroon")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Crimson")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Bright violet")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Eggplant")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Mulberry")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Eggplant")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Bright violet")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Crimson")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Maroon")
						wait(0.1)
						discoPart.BrickColor = BrickColor.new("Cocoa")
						wait(0.1)
					end
				end)
			else
				warn("Disco part not found in workspace!")
			end
		end
	end
end)
