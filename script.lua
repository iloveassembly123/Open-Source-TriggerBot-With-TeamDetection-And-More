-- Settings
local HoldClick = true
local Hotkey = 't' -- Leave blank for always on
local HotkeyToggle = true -- True if you want it to toggle on and off with a click
local teamDetection = true
local fireIfToolEquipped = true 

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Toggle = (Hotkey ~= '')
local CurrentlyPressed = false

Mouse.KeyDown:Connect(function(key)
	if HotkeyToggle == true and key == Hotkey then
		Toggle = not Toggle
	elseif 
		key == Hotkey then
		Toggle = true
	end
end)

Mouse.KeyUp:Connect(function(key)
	if HotkeyToggle ~= true and key == Hotkey then
		Toggle = false
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggle then
		if Mouse.Target then
			if Mouse.Target.Parent:FindFirstChild('Humanoid') then
				local player = game.Players:GetPlayerFromCharacter(Mouse.Target.Parent)	
			
				if fireIfToolEquipped and not LocalPlayer.Character:FindFirstChildOfClass("Tool") or teamDetection and player.team == LocalPlayer.Team then return end --CONDITIONS CHECKER
					
				if HoldClick then
					if not CurrentlyPressed then
						CurrentlyPressed = true
						mouse1press()
					end
				else
					mouse1click()
				end
			else
				if HoldClick then
					CurrentlyPressed = false
					mouse1release()
				end
			end
		end
	end
end)
