local _0x56656c6f = "gg/XwBS4w9ggJ"
local _0x4c6f6164 = function()
    local s = game:GetService("StarterGui")
    task.spawn(function()
        pcall(function() s:SetCore("DevConsoleVisible", true) end)
        print("--- INITIALIZING VELO HUB ---")
        for i = 1, 50 do
            print("[" .. i .. "] Discord: " .. _0x56656c6f)
            task.wait(0.01)
        end
        print("------------------------------------------")
        print("   VELO HUB LOADED SUCCESSFULLY          ")
        print("------------------------------------------")
        task.wait(0.1)
        pcall(function() s:SetCore("DevConsoleVisible", false) end)
    end)
end

local function _0x52756e()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer
    local CoreGui = game:GetService("CoreGui")

    local screenGui = Instance.new("ScreenGui", CoreGui)
    screenGui.Name = "V_H_" .. math.random(1000, 9999)

    local ACTIVE = false
    local LOCKED = false
    local lastPos = nil
    local RANGE = 80000

    local function _0x5374796c65(obj, radius, strokeColor)
        local corner = Instance.new("UICorner", obj)
        corner.CornerRadius = UDim.new(0, radius)
        local stroke = Instance.new("UIStroke", obj)
        stroke.Color = strokeColor
        stroke.Thickness = 2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        return stroke
    end

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 230, 0, 180)
    mainFrame.Position = UDim2.new(0, 50, 0.25, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    mainFrame.BorderSizePixel = 0
    local mainStroke = _0x5374796c65(mainFrame, 5, Color3.fromRGB(45, 45, 45))

    local miniBtn = Instance.new("TextButton", mainFrame)
    miniBtn.Size = UDim2.new(0, 20, 0, 20)
    miniBtn.Position = UDim2.new(0, 8, 0, 8)
    miniBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    miniBtn.Text = "-"
    miniBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    miniBtn.Font = Enum.Font.GothamBold
    _0x5374796c65(miniBtn, 4, Color3.fromRGB(60, 60, 60))

    local vBtn = Instance.new("TextButton", screenGui)
    vBtn.Size = UDim2.new(0, 45, 0, 45)
    vBtn.Position = UDim2.new(0, 15, 0.1, 0)
    vBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    vBtn.Text = "V"
    vBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    vBtn.Font = Enum.Font.GothamBlack
    vBtn.TextSize = 24
    vBtn.Visible = false
    _0x5374796c65(vBtn, 8, Color3.fromRGB(200, 200, 200)) 
    local vGrad = Instance.new("UIGradient", vBtn)
    vGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))})
    vGrad.Rotation = 45

    miniBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        vBtn.Visible = true
    end)

    vBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        vBtn.Visible = false
    end)

    local title = Instance.new("TextLabel", mainFrame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "VELO HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.BackgroundTransparency = 1

    local statusLabel = Instance.new("TextLabel", mainFrame)
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Position = UDim2.new(0, 0, 0, 40)
    statusLabel.Text = "● STATUS: IDLE"
    statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    statusLabel.Font = Enum.Font.Code
    statusLabel.TextSize = 10
    statusLabel.BackgroundTransparency = 1

    local function makeDraggable(obj)
        local dragging, dragInput, dragStart, startPos
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not LOCKED then
                dragging = true
                dragStart = input.Position
                startPos = obj.Position
            end
        end)
        obj.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    end
    makeDraggable(mainFrame)
    makeDraggable(vBtn)

    local function createBtn(name, pos)
        local btn = Instance.new("TextButton", mainFrame)
        btn.Size = UDim2.new(0, 190, 0, 35)
        btn.Position = pos
        btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(160, 160, 160)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 13
        btn.AutoButtonColor = false
        _0x5374796c65(btn, 4, Color3.fromRGB(40, 40, 40))
        return btn
    end

    local tBtn = createBtn("START VOID SPAM", UDim2.new(0.5, -95, 0, 80))
    local lBtn = createBtn("LOCK POSITION", UDim2.new(0.5, -95, 0, 125))

    tBtn.MouseButton1Click:Connect(function()
        ACTIVE = not ACTIVE
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if ACTIVE then
            if root then lastPos = root.CFrame end
            tBtn.Text = "STOP VOID SPAM"
            tBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            tBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
            statusLabel.Text = "● STATUS: ACTIVE"
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        else
            tBtn.Text = "START VOID SPAM"
            tBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            tBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
            statusLabel.Text = "● STATUS: IDLE"
            statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            if root and lastPos then root.CFrame = lastPos end
        end
    end)

    lBtn.MouseButton1Click:Connect(function()
        LOCKED = not LOCKED
        if LOCKED then
            lBtn.Text = "POSITION LOCKED"
            lBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            lBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            mainStroke.Color = Color3.fromRGB(100, 100, 100)
        else
            lBtn.Text = "LOCK POSITION"
            lBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            lBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
            mainStroke.Color = Color3.fromRGB(45, 45, 45)
        end
    end)

    task.spawn(function()
        while true do
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if ACTIVE and root and root.Parent then
                root.Velocity = Vector3.zero
                root.CFrame = CFrame.new(Vector3.new(math.random(-RANGE, RANGE), math.random(8000, 18000), math.random(-RANGE, RANGE)))
                RunService.Heartbeat:Wait()
            else task.wait(0.1) end
        end
    end)
end

_0x4c6f6164()
_0x52756e()
