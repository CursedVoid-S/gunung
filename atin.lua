-- Roblox Teleport GUI Script - Updated Coordinates
-- Pastikan script ini dijalankan di dalam executor yang mendukung GUI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Daftar posisi teleport (UPDATED - POS 1 sampai PUNCAK)
local teleportPositions = {
    {name = "POS 1", x = 16.71, y = 55.17, z = -1082.89},
    {name = "POS 2", x = -184.51, y = 128.12, z = 410.02},
    {name = "POS 3", x = -165.30, y = 229.49, z = 652.66},
    {name = "POS 4", x = -38.05, y = 406.52, z = 615.72},
    {name = "POS 5", x = 130.50, y = 651.73, z = 613.73},
    {name = "POS 6", x = -246.89, y = 665.75, z = 734.28},
    {name = "POS 7", x = -684.70, y = 640.81, z = 867.17},
    {name = "POS 8", x = -657.72, y = 688.47, z = 1458.55},
    {name = "POS 9", x = -507.93, y = 902.91, z = 1867.53},
    {name = "POS 10", x = 61.12, y = 950.03, z = 2089.24},
    {name = "POS 11", x = 52.36, y = 981.52, z = 2450.20},
    {name = "POS 12", x = 72.50, y = 1096.91, z = 2457.48},
    {name = "POS 13", x = 262.49, y = 1270.10, z = 2037.55},
    {name = "POS 14", x = -418.36, y = 1302.17, z = 2393.75},
    {name = "POS 15", x = -773.39, y = 1313.91, z = 2664.38},
    {name = "POS 16", x = -837.46, y = 1475.24, z = 2626.15},
    {name = "POS 17", x = -468.23, y = 1465.68, z = 2769.87},
    {name = "POS 18", x = -467.19, y = 1537.45, z = 2836.36},
    {name = "POS 19", x = -385.24, y = 1640.28, z = 2794.49},
    {name = "POS 20", x = -207.53, y = 1665.71, z = 2749.04},
    {name = "POS 21", x = -232.78, y = 1742.05, z = 2791.72},
    {name = "POS 22", x = -424.79, y = 1740.43, z = 2798.86},
    {name = "POS 23", x = -424.14, y = 1712.74, z = 3420.33},
    {name = "POS 24", x = 70.43, y = 1718.68, z = 3427.15},
    {name = "POS 25", x = 435.99, y = 1720.55, z = 3430.46},
    {name = "POS 26", x = 625.42, y = 1799.45, z = 3433.81},
    {name = "🏔️ PUNCAK", x = 111.78, y = 2474.83, z = 3472.24}
}

-- Fungsi teleport
local function teleportTo(x, y, z, posName)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        print("Teleported to " .. posName .. ": " .. x .. ", " .. y .. ", " .. z)
    else
        warn("Character atau HumanoidRootPart tidak ditemukan!")
    end
end

-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Frame utama (diperbesar untuk menampung 27 tombol)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 450)
mainFrame.Position = UDim2.new(0, 20, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

-- Title text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 8, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🚀 Teleport Hub"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -52, 0, 3)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 4)
minimizeCorner.Parent = minimizeButton

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -27, 0, 3)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

-- ScrollingFrame untuk daftar posisi
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -12, 1, -42)
scrollFrame.Position = UDim2.new(0, 6, 0, 36)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.Parent = mainFrame

-- UIListLayout untuk mengatur tombol dengan sorting otomatis
local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.SortOrder = Enum.SortOrder.LayoutOrder  -- Penting: Urutkan berdasarkan LayoutOrder
listLayout.Padding = UDim.new(0, 2)
listLayout.Parent = scrollFrame

-- Buat tombol untuk setiap posisi
local buttons = {}
for i, pos in ipairs(teleportPositions) do
    local button = Instance.new("TextButton")
    button.Name = pos.name .. "Button"
    button.Size = UDim2.new(1, -8, 0, 26)
    
    -- Warna khusus untuk PUNCAK
    if pos.name == "🏔️ PUNCAK" then
        button.BackgroundColor3 = Color3.fromRGB(255, 69, 0)  -- Orange untuk puncak
    else
        button.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
    end
    
    button.BorderSizePixel = 0
    button.Text = pos.name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    -- Event handler untuk tombol
    button.MouseButton1Click:Connect(function()
        teleportTo(pos.x, pos.y, pos.z, pos.name)
        local originalText = pos.name
        local originalColor = button.BackgroundColor3
        
        button.Text = "✅ " .. pos.name
        button.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        
        wait(1)
        
        button.Text = originalText
        button.BackgroundColor3 = originalColor
    end)
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        local hoverColor
        if pos.name == "🏔️ PUNCAK" then
            hoverColor = Color3.fromRGB(220, 60, 0)
        else
            hoverColor = Color3.fromRGB(0, 100, 220)
        end
        
        local hoverTween = TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor})
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local normalColor
        if pos.name == "🏔️ PUNCAK" then
            normalColor = Color3.fromRGB(255, 69, 0)
        else
            normalColor = Color3.fromRGB(0, 122, 255)
        end
        
        local normalTween = TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = normalColor})
        normalTween:Play()
    end)
    
    table.insert(buttons, button)
end

-- Update scroll canvas size
local contentHeight = #teleportPositions * 28 + 10
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)

-- Minimode frame (saat diminimize)
local miniFrame = Instance.new("Frame")
miniFrame.Name = "MiniFrame"
miniFrame.Size = UDim2.new(0, 140, 0, 30)
miniFrame.Position = UDim2.new(0, 20, 0.5, -15)
miniFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
miniFrame.BorderSizePixel = 0
miniFrame.Parent = screenGui
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 8)
miniCorner.Parent = miniFrame

-- Mini title
local miniTitle = Instance.new("TextLabel")
miniTitle.Size = UDim2.new(1, -35, 1, 0)
miniTitle.Position = UDim2.new(0, 8, 0, 0)
miniTitle.BackgroundTransparency = 1
miniTitle.Text = "🚀 Teleport (27)"
miniTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
miniTitle.TextScaled = true
miniTitle.Font = Enum.Font.GothamBold
miniTitle.Parent = miniFrame

-- Restore button
local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 24, 0, 24)
restoreButton.Position = UDim2.new(1, -27, 0, 3)
restoreButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
restoreButton.BorderSizePixel = 0
restoreButton.Text = "▲"
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.TextScaled = true
restoreButton.Font = Enum.Font.GothamBold
restoreButton.Parent = miniFrame

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 4)
restoreCorner.Parent = restoreButton

-- Variables untuk minimize/restore
local isMinimized = false

-- Minimize/Restore functions
local function minimizeGUI()
    isMinimized = true
    mainFrame.Visible = false
    miniFrame.Visible = true
end

local function restoreGUI()
    isMinimized = false
    miniFrame.Visible = false
    mainFrame.Visible = true
end

-- Event handlers
minimizeButton.MouseButton1Click:Connect(minimizeGUI)
restoreButton.MouseButton1Click:Connect(restoreGUI)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Hover effects untuk control buttons
local function createHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor})
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local normalTween = TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = normalColor})
        normalTween:Play()
    end)
end

createHoverEffect(minimizeButton, Color3.fromRGB(220, 170, 0), Color3.fromRGB(255, 193, 7))
createHoverEffect(closeButton, Color3.fromRGB(220, 50, 40), Color3.fromRGB(255, 59, 48))
createHoverEffect(restoreButton, Color3.fromRGB(30, 140, 50), Color3.fromRGB(40, 167, 69))

-- Toggle GUI dengan keyboard
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.T then
        if isMinimized then
            restoreGUI()
        else
            if mainFrame.Visible then
                minimizeGUI()
            else
                restoreGUI()
            end
        end
    end
end)

-- Fade in animation
mainFrame.BackgroundTransparency = 1
titleBar.BackgroundTransparency = 1

local fadeInTween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0})
local titleFadeTween = TweenService:Create(titleBar, TweenInfo.new(0.3), {BackgroundTransparency = 0})

fadeInTween:Play()
titleFadeTween:Play()

for _, button in ipairs(buttons) do
    button.BackgroundTransparency = 1
    local buttonFadeTween = TweenService:Create(button, TweenInfo.new(0.3), {BackgroundTransparency = 0})
    buttonFadeTween:Play()
end

print("✅ Teleport GUI loaded!")
print("📍 Available positions: POS 1-26 + BAWAH PUNCAK + PUNCAK")
print("🎯 Total locations: 28")
print("⌨️ Press 'T' to toggle/minimize")
print("🖱️ Drag to move GUI")
print("⬇️ BAWAH PUNCAK is highlighted in dark orange!")
print("🏔️ PUNCAK is highlighted in orange!")