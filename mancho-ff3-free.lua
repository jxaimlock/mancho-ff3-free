-- === FOOTBALL FUSION 3 AUTO-BAN BAIT SCRIPT ===
-- Run this AFTER joining a match. Very obvious on purpose.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

-- Super speed + jump (very detectable)
Humanoid.WalkSpeed = 100
Humanoid.JumpPower = 200

-- Make character huge (visual red flag)
Character.HumanoidRootPart.Size = Vector3.new(10, 10, 10)

-- Ball magnet on steroids
spawn(function()
    while true do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Football" or obj:FindFirstChild("Ball") then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Velocity = (Root.Position - obj.Position) * 50
                bv.Parent = obj
                game:GetService("Debris"):AddItem(bv, 0.1)
            end
        end
        wait(0.05)
    end
end)

-- Auto score spam / position teleport (extremely ban-worthy)
spawn(function()
    while true do
        if Root then
            Root.CFrame = Root.CFrame + Vector3.new(0, 50, 0)  -- Fly up
            wait(0.1)
            Root.CFrame = Root.CFrame * CFrame.new(0, -50, 0) -- Slam down
        end
        wait(0.3)
    end
end)

-- Chat spam (extra reports incoming)
spawn(function()
    while true do
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("I AM USING CHEATS HAHA BAN ME", "All")
        wait(2)
    end
end)

print("Ban bait activated. Enjoy your short career 😂")
