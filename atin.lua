local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Daftar posisi teleport - URUT DARI POS 1 SAMPAI ATAS GUNUNG
local positions = {
    -- POS 1-10
    {"POS 1", 16.71, 55.17, -1082.89},
    {"POS 2", -184.51, 128.12, 410.02},
    {"POS 3", -165.30, 229.49, 652.66},
    {"POS 4", -38.05, 406.52, 615.72},
    {"POS 5", 130.50, 651.73, 613.73},
    {"POS 6", -246.89, 665.75, 734.28},
    {"POS 7", -684.70, 640.81, 867.17},
    {"POS 8", -657.72, 688.47, 1458.55},
    {"POS 9", -507.93, 902.91, 1867.53},
    {"POS 10", 61.12, 950.03, 2089.24},
    
    -- POS 11-20
    {"POS 11", 52.36, 981.52, 2450.20},
    {"POS 12", 72.50, 1096.91, 2457.48},
    {"POS 13", 262.49, 1270.10, 2037.55},
    {"POS 14", -418.36, 1302.17, 2393.75},
    {"POS 15", -773.39, 1313.91, 2664.38},
    {"POS 16", -837.46, 1475.24, 2626.15},
    {"POS 17", -468.23, 1465.68, 2769.87},
    {"POS 18", -467.19, 1537.45, 2836.36},
    {"POS 19", -385.24, 1640.28, 2794.49},
    {"POS 20", -207.53, 1665.71, 2749.04},
    
    -- POS 21-26
    {"POS 21", -232.78, 1742.05, 2791.72},
    {"POS 22", -424.79, 1740.43, 2798.86},
    {"POS 23", -424.14, 1712.74, 3420.33},
    {"POS 24", 70.43, 1718.68, 3427.15},
    {"POS 25", 435.99, 1720.55, 3430.46},
    {"POS 26", 625.42, 1799.45, 3433.81},
    
    -- POSISI KHUSUS (TERAKHIR)
    {"⬆️ ATAS POS 26", 552.07, 1899.41, 3467.05},
    {"🏔️ ATAS GUNUNG", 111.78, 2474.83, 3472.24}
}

-- Fungsi teleport
local function teleportTo(name, x, y, z)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        print("✅ Teleported to " .. name .. " (" .. x .. ", " .. y .. ", " .. z .. ")")
    else
        warn("❌ Character atau HumanoidRootPart tidak ditemukan!")
    end
end

-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0, 50, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Corner radius untuk frame utama
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "CURSED HUB"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Minimize button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- ScrollingFrame untuk daftar posisi
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 1, -55)
scrollFrame.Position = UDim2.new(0, 10, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)
scrollFrame.Parent = mainFrame

-- UIListLayout untuk mengatur tombol secara vertikal
local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.SortOrder = Enum.SortOrder.LayoutOrder -- PENTING: Sortir berdasarkan LayoutOrder
listLayout.Padding = UDim.new(0, 3)
listLayout.Parent = scrollFrame

-- Buat tombol untuk setiap posisi (URUT SESUAI ARRAY)
local buttons = {}
for i = 1, #positions do
    local pos = positions[i]
    local name = pos[1]
    local x, y, z = pos[2], pos[3], pos[4]
    
    local button = Instance.new("TextButton")
    button.Name = "Button_" .. i
    button.Size = UDim2.new(1, -10, 0, 32)
    
    -- Warna khusus berdasarkan nama
    if string.find(name, "ATAS GUNUNG") then
        button.BackgroundColor3 = Color3.fromRGB(255, 69, 0) -- Orange untuk ATAS GUNUNG
    elseif string.find(name, "ATAS POS 26") then
        button.BackgroundColor3 = Color3.fromRGB(138, 43, 226) -- Purple untuk ATAS POS 26
    else
        button.BackgroundColor3 = Color3.fromRGB(0, 122, 255) -- Biru untuk POS biasa
    end
    
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- Event handler untuk tombol teleport
    button.MouseButton1Click:Connect(function()
        teleportTo(name, x, y, z)
        
        -- Visual feedback
        local originalText = button.Text
        local originalColor = button.BackgroundColor3
        
        button.Text = "✅ " .. name
        button.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        
        wait(1.5)
        
        button.Text = originalText
        button.BackgroundColor3 = originalColor
    end)
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        local hoverColor
        if string.find(name, "ATAS GUNUNG") then
            hoverColor = Color3.fromRGB(220, 60, 0)
        elseif string.find(name, "ATAS POS 26") then
            hoverColor = Color3.fromRGB(120, 35, 200)
        else
            hoverColor = Color3.fromRGB(0, 100, 220)
        end
        
        local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor})
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local normalColor
        if string.find(name, "ATAS GUNUNG") then
            normalColor = Color3.fromRGB(255, 69, 0)
        elseif string.find(name, "ATAS POS 26") then
            normalColor = Color3.fromRGB(138, 43, 226)
        else
            normalColor = Color3.fromRGB(0, 122, 255)
        end
        
        local normalTween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor})
        normalTween:Play()
    end)
    
    table.insert(buttons, button)
end

-- Update scroll canvas size
local totalHeight = #positions * 35 + 20
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

-- Mini frame (untuk mode minimize)
local miniFrame = Instance.new("Frame")
miniFrame.Name = "MiniFrame"
miniFrame.Size = UDim2.new(0, 160, 0, 35)
miniFrame.Position = UDim2.new(0, 50, 0.5, -17)
miniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
miniFrame.BorderSizePixel = 0
miniFrame.Parent = screenGui
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 8)
miniCorner.Parent = miniFrame

-- Mini title text
local miniTitle = Instance.new("TextLabel")
miniTitle.Size = UDim2.new(1, -40, 1, 0)
miniTitle.Position = UDim2.new(0, 10, 0, 0)
miniTitle.BackgroundTransparency = 1
miniTitle.Text = "🚀 Teleport (28)"
miniTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
miniTitle.TextScaled = true
miniTitle.Font = Enum.Font.GothamBold
miniTitle.TextXAlignment = Enum.TextXAlignment.Left
miniTitle.Parent = miniFrame

-- Restore button
local restoreBtn = Instance.new("TextButton")
restoreBtn.Size = UDim2.new(0, 30, 0, 25)
restoreBtn.Position = UDim2.new(1, -35, 0, 5)
restoreBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
restoreBtn.BorderSizePixel = 0
restoreBtn.Text = "▲"
restoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreBtn.TextScaled = true
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.Parent = miniFrame

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 5)
restoreCorner.Parent = restoreBtn

-- Variables untuk minimize/restore
local isMinimized = false

-- Functions untuk minimize dan restore
local function minimizeGUI()
    isMinimized = true
    mainFrame.Visible = false
    miniFrame.Visible = true
    print("📱 GUI minimized")
end

local function restoreGUI()
    isMinimized = false
    miniFrame.Visible = false
    mainFrame.Visible = true
    print("📱 GUI restored")
end

-- Event handlers untuk control buttons
minimizeBtn.MouseButton1Click:Connect(minimizeGUI)
restoreBtn.MouseButton1Click:Connect(restoreGUI)
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("❌ Teleport GUI closed")
end)

-- Hover effects untuk control buttons
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = normalColor})
        tween:Play()
    end)
end

addHoverEffect(minimizeBtn, Color3.fromRGB(220, 170, 0), Color3.fromRGB(255, 193, 7))
addHoverEffect(closeBtn, Color3.fromRGB(220, 50, 40), Color3.fromRGB(255, 59, 48))
addHoverEffect(restoreBtn, Color3.fromRGB(30, 140, 50), Color3.fromRGB(40, 167, 69))

-- Keyboard toggle (T key)
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

-- Smooth entrance animation
mainFrame.BackgroundTransparency = 1
titleBar.BackgroundTransparency = 1

local fadeIn = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
local titleFade = TweenService:Create(titleBar, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})

fadeIn:Play()
titleFade:Play()

-- Fade in buttons dengan delay
for i, button in ipairs(buttons) do
    button.BackgroundTransparency = 1
    wait(0.02) -- Small delay untuk efek cascade
    local buttonFade = TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
    buttonFade:Play()
end

-- Success messages
print("=" .. string.rep("=", 50))
print("🎯 TELEPORT GUI BERHASIL DIMUAT!")
print("📍 Total Posisi: 28 Teleport Points")
print("🔢 Urutan: POS 1 → POS 26 → ATAS POS 26 → ATAS GUNUNG")
print("⌨️  Tekan 'T' untuk toggle/minimize GUI")
print("🖱️  Drag title bar untuk memindahkan GUI")
print("🎨 Warna: Biru (POS 1-26) | Purple (ATAS POS 26) | Orange (ATAS GUNUNG)")
print("=" .. string.rep("=", 50))