local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "MainVoidUI"

local function createNotify(text)
    local notifyFrame = Instance.new("Frame", screenGui)
    notifyFrame.Size = UDim2.new(0, 200, 0, 40)
    notifyFrame.Position = UDim2.new(1, 20, 0.1, 0)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", notifyFrame)
    local label = Instance.new("TextLabel", notifyFrame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = text:upper()
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    notifyFrame:TweenPosition(UDim2.new(1, -220, 0.1, 0), "Out", "Back", 0.5, true)
    task.delay(2, function() notifyFrame:Destroy() end)
end

local root = nil
local ACTIVE = false
local RANGE = 70000

local function getRoot()
    local char = player.Character or player.CharacterAdded:Wait()
    root = char:WaitForChild("HumanoidRootPart")
end
getRoot()

local function createBtn(pos, text, color)
    local btn = Instance.new("TextButton", screenGui)
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    return btn
end

local tBtn = createBtn(UDim2.new(0, 20, 0.2, 0), "START VOID", Color3.fromRGB(30, 30, 30))

tBtn.MouseButton1Click:Connect(function()
    ACTIVE = not ACTIVE
    if ACTIVE then
        tBtn.Text = "STOP VOID"
        tBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        createNotify("Void Activated")
    else
        tBtn.Text = "START VOID"
        tBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        createNotify("Void Stopped")
    end
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
