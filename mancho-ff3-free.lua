--=============================
-- MANCHO (UPDATED CROSSHAIR HIDER)
--=============================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
--=============================
-- GUI SETUP
--=============================
local gui = Instance.new("ScreenGui")
gui.Name = "MANCHO"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 380)
main.Position = UDim2.new(0.5, -175, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui
local corner = Instance.new("UICorner", main)
--=============================
-- DRAG LOGIC
--=============================
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,50)
top.BackgroundColor3 = Color3.fromRGB(0,0,0)
top.BorderSizePixel = 0
top.Parent = main
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "MANCHO"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,35,0,35)
close.Position = UDim2.new(1,-40,0,7)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.BackgroundColor3 = Color3.fromRGB(140,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Parent = top
Instance.new("UICorner", close)
close.MouseButton1Click:Connect(function() gui:Destroy() end)
local minimized = false
local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0,35,0,35)
mini.Position = UDim2.new(1,-80,0,7)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.BackgroundColor3 = Color3.fromRGB(60,60,60)
mini.TextColor3 = Color3.new(1,1,1)
mini.Parent = top
Instance.new("UICorner", mini)
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1,0,1,-60)
content.Position = UDim2.new(0,0,0,60)
content.CanvasSize = UDim2.new(0,0,0,0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.BackgroundTransparency = 1
content.ScrollBarThickness = 4
content.Parent = main
mini.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    main:TweenSize(minimized and UDim2.new(0, 350, 0, 50) or UDim2.new(0, 350, 0, 380), "Out", "Quad", 0.2, true)
    mini.Text = minimized and "+" or "-"
end)
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = content
Instance.new("UIPadding", content).PaddingTop = UDim.new(0,10)
--=============================
-- THEME SYSTEM
--=============================
local themes = {
    {Name = "Dark", Main = Color3.fromRGB(20,20,20), Top = Color3.fromRGB(0,0,0)},
    {Name = "Midnight", Main = Color3.fromRGB(15,20,35), Top = Color3.fromRGB(10,15,25)},
    {Name = "Crimson", Main = Color3.fromRGB(35,15,15), Top = Color3.fromRGB(25,10,10)},
    {Name = "Forest", Main = Color3.fromRGB(15,30,15), Top = Color3.fromRGB(10,20,10)}
}
local currentTheme = 1
local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(0.9,0,0,40)
themeBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
themeBtn.TextColor3 = Color3.new(1,1,1)
themeBtn.Text = "Cycle Theme: Dark"
themeBtn.Font = Enum.Font.GothamBold
themeBtn.Parent = content
Instance.new("UICorner", themeBtn)
themeBtn.MouseButton1Click:Connect(function()
    currentTheme = currentTheme + 1
    if currentTheme > #themes then currentTheme = 1 end
    local t = themes[currentTheme]
    main.BackgroundColor3 = t.Main
    top.BackgroundColor3 = t.Top
    themeBtn.Text = "Cycle Theme: " .. t.Name
end)
--=============================
-- FEATURES
--=============================
local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.Text = name .. " [OFF]"
    btn.Parent = content
    Instance.new("UICorner", btn)
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = name .. (on and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = on and Color3.fromRGB(60, 110, 60) or Color3.fromRGB(35,35,35)
        callback(on)
    end)
end
-- FPS INPUT
local fpsBox = Instance.new("TextBox")
fpsBox.Size = UDim2.new(0.9,0,0,40)
fpsBox.Text = "Set FPS Limit"
fpsBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
fpsBox.TextColor3 = Color3.new(1,1,1)
fpsBox.Parent = content
Instance.new("UICorner", fpsBox)
fpsBox.FocusLost:Connect(function()
    local fps = tonumber(fpsBox.Text)
    if fps and setfpscap then setfpscap(fps) end
end)
-- ANTI ACE (NO UNI)
local antiAceEnabled = false
createToggle("Anti Ace (No Uni)", function(state)
    antiAceEnabled = state
end)
local function runAntiAce()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local lastState = humanoid:GetState()
    humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
        lastState = humanoid:GetState()
    end)
    while true do
        task.wait(0.01)
        if antiAceEnabled and player.Character == character then
            local state = humanoid:GetState()
            if state == Enum.HumanoidStateType.Jumping and
               (lastState == Enum.HumanoidStateType.Running or lastState == Enum.HumanoidStateType.Landed) then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                task.wait(0.01)
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            lastState = state
        elseif player.Character ~= character then
            break
        end
    end
end
task.spawn(runAntiAce)
player.CharacterAdded:Connect(function()
    task.spawn(runAntiAce)
end)
-- PINK SKY
createToggle("Pink Sky", function(state)
    if state then
        for _,v in ipairs(Lighting:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
        local sky = Instance.new("Sky")
        sky.SkyboxUp = "rbxassetid://271042516"
        sky.SkyboxDn = "rbxassetid://271042516"
        sky.SkyboxLf = "rbxassetid://271042516"
        sky.SkyboxRt = "rbxassetid://271042516"
        sky.SkyboxFt = "rbxassetid://271042516"
        sky.SkyboxBk = "rbxassetid://271042516"
        sky.Parent = Lighting
    end
end)
-- GREY BALL
local greyBallEnabled = false
createToggle("Grey Ball", function(state)
    greyBallEnabled = state
end)
local function trySet(fn) pcall(fn) end
local function clearTextures(inst)
    trySet(function() inst.Texture = "" end)
    trySet(function() inst.TextureId = "" end)
    trySet(function() inst.TextureID = "" end)
    trySet(function() inst.ColorMap = "" end)
    trySet(function() inst.RoughnessMap = "" end)
    trySet(function() inst.MetalnessMap = "" end)
end
local function whitenPart(part)
    if not part or not part:IsA("BasePart") or not greyBallEnabled then return end
    trySet(function()
        part.Color = Color3.fromRGB(60,60,60)
        part.BrickColor = BrickColor.new("dark stone grey")
        part.Material = Enum.Material.SmoothPlastic
        part.Reflectance = 0
        part.Transparency = 0
    end)
    for _, obj in ipairs(part:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SpecialMesh") or obj:IsA("MeshPart") or obj:IsA("SurfaceAppearance") then
            clearTextures(obj)
        end
    end
end
local function processObject(obj)
    if obj:IsA("BasePart") then
        whitenPart(obj)
        task.spawn(function()
            while obj.Parent and greyBallEnabled do
                task.wait(0.45)
                whitenPart(obj)
            end
        end)
    else
        for _, d in ipairs(obj:GetDescendants()) do
            if d:IsA("BasePart") and (string.find(d.Name:lower(), "ball") or string.find(d.Name:lower(), "football")) then
                whitenPart(d)
                task.spawn(function()
                    while d.Parent and greyBallEnabled do
                        task.wait(0.45)
                        whitenPart(d)
                    end
                end)
            end
        end
    end
end
workspace.DescendantAdded:Connect(function(obj)
    if not greyBallEnabled then return end
    task.wait(0.05)
    local lname = obj.Name:lower()
    if obj:IsA("BasePart") and (string.find(lname, "ball") or string.find(lname, "football")) then
        processObject(obj)
    else
        local ancestor = obj:FindFirstAncestorWhichIsA("Model")
        if ancestor and (string.find(ancestor.Name:lower(), "ball") or string.find(ancestor.Name:lower(), "football")) then
            processObject(ancestor)
        end
    end
end)
-- NO CURSOR
local noCursor = false
local cursorConn
createToggle("No Cursor", function(state)
    noCursor = state
    if state then
        cursorConn = RunService.RenderStepped:Connect(function()
            if noCursor then
                UIS.MouseIconEnabled = false
                local mouse = player:GetMouse()
                if mouse then mouse.Icon = "rbxassetid://0" end
            end
        end)
    else
        if cursorConn then cursorConn:Disconnect() end
        UIS.MouseIconEnabled = true
        local mouse = player:GetMouse()
        if mouse then mouse.Icon = "" end
    end
end)
-- UNI SCRIPT
local uniConn
createToggle("Uni Script", function(state)
    if not state then if uniConn then uniConn:Disconnect() end return end
    local event = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CharacterSoundEvent")
    local function apply()
        local char = player.Character or player.CharacterAdded:Wait()
        task.wait(0.5)
        if char:FindFirstChild("Uniform") then
            event:FireServer("Game","Customization","Toggle","LeftGlove")
            event:FireServer("Game","Customization","Toggle","RightGlove")
            event:FireServer("Game","Customization","Number","0")
            event:FireServer("Game","Customization","Name"," ")
        end
    end
    apply()
    uniConn = player.CharacterAdded:Connect(apply)
end)
-- FPS DISPLAY
local fpsL, fpsC
createToggle("FPS Display", function(state)
    if state then
        fpsL = Instance.new("TextLabel", gui)
        fpsL.Size = UDim2.new(0, 100, 0, 30)
        fpsL.Position = UDim2.new(1, -110, 0, 10)
        fpsL.BackgroundColor3 = Color3.new(0,0,0)
        fpsL.BackgroundTransparency = 0.5
        fpsL.TextColor3 = Color3.new(0,1,0)
        fpsL.Font = Enum.Font.Code
        fpsL.TextSize = 14
        Instance.new("UICorner", fpsL)
        fpsC = RunService.RenderStepped:Connect(function(dt) fpsL.Text = "FPS: "..math.floor(1/dt) end)
    else
        if fpsL then fpsL:Destroy() end
        if fpsC then fpsC:Disconnect() end
    end
end)
--=============================
-- JERSEY CUSTOMIZER
--=============================
local jerseyTitle = Instance.new("TextLabel")
jerseyTitle.Size = UDim2.new(0.9,0,0,30)
jerseyTitle.BackgroundTransparency = 1
jerseyTitle.Text = "--- JERSEY CUSTOMIZER ---"
jerseyTitle.TextColor3 = Color3.fromRGB(150,150,150)
jerseyTitle.Font = Enum.Font.GothamBold
jerseyTitle.TextSize = 14
jerseyTitle.Parent = content
local jerseyNameBox = Instance.new("TextBox")
jerseyNameBox.Size = UDim2.new(0.9,0,0,40)
jerseyNameBox.Text = "lazy is back!"
jerseyNameBox.PlaceholderText = "Jersey Name (Back of Jersey)"
jerseyNameBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
jerseyNameBox.TextColor3 = Color3.new(1,1,1)
jerseyNameBox.Font = Enum.Font.Gotham
jerseyNameBox.Parent = content
Instance.new("UICorner", jerseyNameBox)
local jerseyNumberBox = Instance.new("TextBox")
jerseyNumberBox.Size = UDim2.new(0.9,0,0,40)
jerseyNumberBox.Text = "0"
jerseyNumberBox.PlaceholderText = "Jersey Number"
jerseyNumberBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
jerseyNumberBox.TextColor3 = Color3.new(1,1,1)
jerseyNumberBox.Font = Enum.Font.Gotham
jerseyNumberBox.Parent = content
Instance.new("UICorner", jerseyNumberBox)
local applyJerseyBtn = Instance.new("TextButton")
applyJerseyBtn.Size = UDim2.new(0.9,0,0,40)
applyJerseyBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
applyJerseyBtn.TextColor3 = Color3.new(1,1,1)
applyJerseyBtn.Text = "Apply Jersey Customization"
applyJerseyBtn.Font = Enum.Font.GothamBold
applyJerseyBtn.Parent = content
Instance.new("UICorner", applyJerseyBtn)
local soundEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CharacterSoundEvent")
local function applyJerseyCustomization()
    local character = player.Character or player.CharacterAdded:Wait()
    if character:WaitForChild("Uniform", 5) then
        soundEvent:FireServer("Game", "Customization", "Toggle", "LeftGlove")
        soundEvent:FireServer("Game", "Customization", "Toggle", "RightGlove")
        soundEvent:FireServer("Game", "Customization", "Number", jerseyNumberBox.Text)
        soundEvent:FireServer("Game", "Customization", "Name", jerseyNameBox.Text)
    end
end
applyJerseyBtn.MouseButton1Click:Connect(applyJerseyCustomization)
