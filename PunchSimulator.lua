-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService") 
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Player
local LocalPlayer = Players.LocalPlayer

local parts = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}

-- Reusable functions
local function autoClick(enabled, interval)
  while enabled do
    local x, y = 420, 420
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
    
    wait(interval)
  end
end

local function autoPunch(enabled)
  while enabled do
    ReplicatedStorage.Events.DamageIncreaseOnClickEvent:FireServer()
    wait() 
  end
end

local function fireEggs(count, delay, arg)
  local args = {
    [1] = tostring(arg) 
  }

  local remote = ReplicatedStorage.Events.PlayerPressedKeyOnEgg

  for i = 1, count do
    remote:FireServer(unpack(args))
    wait(delay) 
  end

end

-- Gui library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Main window
local Window = OrionLib:MakeWindow({
  Name = "Punch Simulator",
  HidePremium = false,
  SaveConfig = true,
  ConfigFolder = "PunchSimulator"
})

-- Tabs
local MainTab = Window:MakeTab({
  Name = "Main", 
  Icon = "rbxassetid://4483345998"
})

local EggTab = Window:MakeTab({
  Name = "Eggs",
  Icon = "rbxassetid://4483345998" 
})

local GeneralTab = Window:MakeTab({
  Name = "Misc",
  Icon = "rbxassetid://4483345998"
})

-- Elements
MainTab:AddParagraph("Made by", "Angeel")

-- Main
local autoPunchEnabled = false

MainTab:AddToggle({
    Name = "Skip Fight",
    Default = false,
    Callback = function(Value)
        _G.skipfight = Value
        while _G.skipfight and task.wait() do
			local args = {
				[1] = true
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
		end
    end
})


MainTab:AddToggle({
  Name = "Auto Punch",
  Default = false,
  Callback = function(value) 
    autoPunchEnabled = value
    autoPunch(autoPunchEnabled)
  end
})


MainTab:AddButton({
    Name = "Load Tora Script",
    Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/ToraIsMe/ToraIsMe/main/0PUNCH'))()
    end    
})

MainTab:AddButton({
    Name = "Remove ProximityPrompt timer",
    Callback = function()
		for _, v in next, workspace:GetDescendants() do
		if v:IsA("ProximityPrompt") then
		v.HoldDuration = 0
		end
		end
    end    
})

-- Egg 
EggTab:AddToggle({
  Name = "Auto Break Forest Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "1"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Auto Break Snow Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "6"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Auto Break Toy Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "7"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Auto Break Farm Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "8"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Auto Break Samurai Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "9"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Auto Break Space Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "10"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Auto Break Magic Egg",
  Default = false,
  Callback = function(Value)
    autoBreakEgg = Value
    while autoBreakEgg and task.wait() do
      local args = {
        [1] = "11"  
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))
    end
  end
})

EggTab:AddToggle({
  Name = "Hide Animation",
  Default = false,
  Callback = function(Value)
    autoHideAnimation = Value
    while autoHideAnimation and task.wait() do
      if workspace.Camera:FindFirstChild("EggOpenMap") then
        workspace.Camera:FindFirstChild("EggOpenMap"):Destroy()
      end
    end
  end  
})

EggTab:AddToggle({
  Name = "Claim UGC",
  Default = false,
  Callback = function(Value)
    autoClaimUGC = Value
    while autoClaimUGC and task.wait(0.5) do
	  game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ClickedEventClaimButton"):FireServer()
    end
  end  
})

-- General
GeneralTab:AddDropdown({
  Name = "Teleports",
  Options = parts,
  Callback = function(value)
    local part = workspace.LevelBarriers:FindFirstChild(value)
    if part then
      LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
    end
  end
})

local freq = GeneralTab:AddTextbox({
	Name = "Autoclick Interval",
	Default = "0.01", 
	TextDisappear = false, 
	Callback = function(text)
		delay = tonumber(text) or 0
	end
})


GeneralTab:AddToggle({
    Name = "Auto Click",
    Default = false,
    Callback = function(Value)
        _G.click = Value
	    local virtual_input_manager = game:GetService("VirtualInputManager")
        while _G.click and task.wait(freq) do
	    local x, y = 420, 420
	        virtual_input_manager:SendMouseButtonEvent(x, y, 0, false, game, 0) -- Press the button
	        virtual_input_manager:SendMouseButtonEvent(x, y, 0, true, game, 0) -- Release the button
	    end
    end
})

GeneralTab:AddButton({
    Name = "Rejoin",
    Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end    
})


local plrs = game:GetService("Players")

local UI = game:GetObjects("rbxassetid://7437010836")[1]

local cool = {
    {2448201786, "Owner", 1},
}

local function isCool(player)
    local isCool = false
    local tag
    local num

    for i, v in next, cool do
        if player.UserId == v[1] then
            isCool = true
            tag = v[2]
            num = v[3]
        end
    end

    return {isCool, tag, num}
end

local function ApplyTag(player, text, num)
    local tag = UI:Clone()
    tag.Nameplate.Text = text
    if num == 1 then
        coroutine.wrap(
            function()
                while tag ~= nil do
                    wait()
                    local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    tag.Nameplate.TextColor3 = color
                end
            end
        )()
    end

    tag.Parent = player.Character:WaitForChild("Head")
end

for _, v in next, game.Players:GetPlayers() do
    if isCool(v)[1] then
        ApplyTag(v, isCool(v)[2], isCool(v)[3])

        v.CharacterAdded:Connect(
            function()
                ApplyTag(v, isCool(v)[2], isCool(v)[3])
            end
        )
    end
end

game.Players.PlayerAdded:Connect(
    function(plr)
        if isCool(plr)[1] then
            plr.CharacterAdded:Connect(
                function()
                    ApplyTag(plr, isCool(plr)[2], isCool(plr)[3])
                end
            )
        end
    end
)
-- Init
OrionLib:Init()
