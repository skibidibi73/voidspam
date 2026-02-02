local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "MainVoidUI"

local root = nil
local ACTIVE = false
local RANGE = 70000

local function getRoot()
    local char = player.Character or player.CharacterAdded:Wait()
    root = char:WaitForChild("HumanoidRootPart")
end
getRoot()

local function createBtn(pos, text)
    local btn = Instance.new("TextButton", screenGui)
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 12
    Instance.new("UICorner", btn)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(60, 60, 60)
    return btn
end

-- ボタン作成
local tBtn = createBtn(UDim2.new(0, 20, 0.2, 0), "TOGGLE")
local uBtn = createBtn(UDim2.new(0, 20, 0.2, 40), "UNTOGGLE")

-- TOGGLEボタン（有効化）
tBtn.MouseButton1Click:Connect(function()
    ACTIVE = true
    tBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    tBtn.TextColor3 = Color3.new(0, 0, 0)
    uBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    uBtn.TextColor3 = Color3.new(1, 1, 1)
end)

-- UNTOGGLEボタン（無効化）
uBtn.MouseButton1Click:Connect(function()
    ACTIVE = false
    uBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    uBtn.TextColor3 = Color3.new(0, 0, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    tBtn.TextColor3 = Color3.new(1, 1, 1)
end)

task.spawn(function()
    while true do
        if ACTIVE and root and root.Parent then
            root.Velocity = Vector3.zero
            root.CFrame = CFrame.new(Vector3.new(math.random(-RANGE, RANGE), math.random(8000, 18000), math.random(-RANGE, RANGE)))
            RunService.Heartbeat:Wait()
        else task.wait(0.1) end
    end
end)
