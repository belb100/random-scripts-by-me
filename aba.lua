--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local StarterGui = game:GetService("StarterGui")
local showNotification = true

function Notify(tl, t, d) 
if showNotification == true then
StarterGui:SetCore("SendNotification", {
	Title = tl;
	Text = t;
	Duration = d;
	Icon = "http://www.roblox.com/asset/?id=8388262491";
})
end
end

if game.CoreGui:FindFirstChild("destruct") then
game.CoreGui.destruct:Destroy()
end

local BlurFX = Instance.new("BlurEffect")
BlurFX.Size = 0
BlurFX.Name = "Blur"
BlurFX.Parent = workspace.CurrentCamera

local function blurefct(siz)
local TweenService = game:GetService("TweenService")
local goal = {}
goal.Size = siz

local tweenInfo = TweenInfo.new(2)
local tween = TweenService:Create(BlurFX, tweenInfo, goal)

tween:Play()
end

local remote = "nil"
local found = false
local enable = false
local sent = false
local LocalPlayer = game:GetService("Players").LocalPlayer
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local checkIn = {"Workspace", "ReplicatedStorage", "StarterGui", "CoreGui"}
local names = {"Delete", "Deletar", "Remove", "Destroy", "Clean", "Clear","Bullet", "Bala", "Shoot", "Shot", "Fire", "Segway", "Handless", "Sword", "Attack"}
if char then
blurefct(20)
Notify("Vulnerability Checker", "Looking up for remotes, may take a while.", 3)
for _, service in pairs(checkIn) do
for i,v in pairs(game:GetService(service):GetDescendants()) do
for _, str in pairs(names) do
if string.match(v.Name, str) and v:IsA("RemoteEvent") then
print("Checking " .. v.Name .. " from " .. service .. " service")
local success, error = pcall(function()
game:GetService("ReplicatedStorage")[v.Name]:FireServer(LocalPlayer.Character.Head)
found = true
end)
if success then
remote = game:GetService("ReplicatedStorage")[v.Name]
end 
wait(0.5)
if not LocalPlayer.Character:FindFirstChild("Head") then
enable = true
sent = true
end
end
end
end
end
end

if sent == false then
Notify("Vulnerability Checker", "This game is not vulnerable/supported.", 5)
blurefct(0)
end

function work(arg1)
remote:FireServer(arg1)
end

function GetPlayer(String)
   local Found = {}
   local strl = String:lower()
   if strl == "all" then
       for i,v in pairs(game.Players:GetPlayers()) do
           table.insert(Found,v.Name)
       end
   elseif strl == "others" then
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Name ~= game.Players.LocalPlayer.Name then
               table.insert(Found,v.Name)
           end
       end  
elseif strl == "me" then
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Name == game.Players.LocalPlayer.Name then
               table.insert(Found,v.Name)
           end
       end  
   else
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Name:lower():sub(1, #String) == String:lower() then
               table.insert(Found,v.Name)
           end
       end    
   end
   return Found    
end

if enable == true then
blurefct(0)
Notify("Destructed Hex", "Loaded", 10)

-- Новое меню
local destruct = Instance.new("ScreenGui")
destruct.Name = "Destructed_Hex_GUI"
destruct.Parent = game.CoreGui
destruct.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основной контейнер
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = destruct
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Active = true

-- Smooth dragging implementation
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Parent = mainFrame
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.BorderSizePixel = 0
titleBar.Size = UDim2.new(1, 0, 0, 30)

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Parent = titleBar
titleText.BackgroundTransparency = 1
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Font = Enum.Font.GothamBold
titleText.Text = "Destructed Hex GUI"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Parent = titleBar
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(0.93, 0, 0, 0)
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.TextSize = 14

closeButton.MouseButton1Click:Connect(function()
	destruct:Destroy()
end)

-- Поле ввода игрока
local playerInputFrame = Instance.new("Frame")
playerInputFrame.Name = "PlayerInputFrame"
playerInputFrame.Parent = mainFrame
playerInputFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
playerInputFrame.BorderSizePixel = 0
playerInputFrame.Position = UDim2.new(0.03, 0, 0.08, 0)
playerInputFrame.Size = UDim2.new(0.94, 0, 0, 35)

local playerInput = Instance.new("TextBox")
playerInput.Name = "PlayerInput"
playerInput.Parent = playerInputFrame
playerInput.BackgroundTransparency = 1
playerInput.Position = UDim2.new(0.05, 0, 0, 0)
playerInput.Size = UDim2.new(0.9, 0, 1, 0)
playerInput.Font = Enum.Font.Gotham
playerInput.PlaceholderText = "Enter player name"
playerInput.Text = ""
playerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
playerInput.TextSize = 14
playerInput.TextXAlignment = Enum.TextXAlignment.Left

-- Вкладки (только Player и Server)
local tabsContainer = Instance.new("Frame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Parent = mainFrame
tabsContainer.BackgroundTransparency = 1
tabsContainer.Position = UDim2.new(0, 0, 0.18, 0)
tabsContainer.Size = UDim2.new(1, 0, 0, 30)

local function createTabButton(name, position)
	local tab = Instance.new("TextButton")
	tab.Name = name .. "Tab"
	tab.Parent = tabsContainer
	tab.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	tab.BorderSizePixel = 0
	tab.Position = position
	tab.Size = UDim2.new(0.5, 0, 1, 0)
	tab.Font = Enum.Font.Gotham
	tab.Text = name
	tab.TextColor3 = Color3.fromRGB(200, 200, 200)
	tab.TextSize = 12
	return tab
end

local playerTab = createTabButton("Player", UDim2.new(0, 0, 0, 0))
local serverTab = createTabButton("Server", UDim2.new(0.5, 0, 0, 0))

-- Контейнер для контента вкладок
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Parent = mainFrame
contentFrame.BackgroundTransparency = 1
contentFrame.Position = UDim2.new(0, 0, 0.26, 0)
contentFrame.Size = UDim2.new(1, 0, 0.72, 0)
contentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
contentFrame.ScrollBarThickness = 5

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.Name = "ButtonLayout"
buttonLayout.Parent = contentFrame
buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonLayout.Padding = UDim.new(0, 5)

-- Функция создания кнопки
local function createActionButton(name)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Parent = contentFrame
	button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	button.BorderSizePixel = 0
	button.Size = UDim2.new(0.95, 0, 0, 35)
	button.Font = Enum.Font.Gotham
	button.Text = name
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 14
	button.AutoButtonColor = false
	
	-- Анимация наведения
	button.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(
			button,
			TweenInfo.new(0.2),
			{BackgroundColor3 = Color3.fromRGB(75, 75, 75)}
		):Play()
	end)
	
	button.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(
			button,
			TweenInfo.new(0.2),
			{BackgroundColor3 = Color3.fromRGB(65, 65, 65)}
		):Play()
	end)
	
	return button
end

-- Кнопки для вкладки Player
local playerButtons = {
	"Kill", "Kick", "Ban", "Unban", "Goto", "View", "Unview",
	"Naked", "Faceless", "NoLimbs", "Hatless", "Ragdoll", "Ranim",
	"BTools", "RTools", "STools", "Punish"
}

-- Кнопки для вкладки Server
local serverButtons = {
	"Nuke", "Fix Server", "Server Lock", "Shutdown", "Rchassis"
}

-- Функция переключения вкладок
local function showTab(tabName)
	-- Скрыть все кнопки
	for _, child in ipairs(contentFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child.Visible = false
		end
	end
	
	-- Показать кнопки выбранной вкладки
	local buttons = {}
	if tabName == "Player" then
		buttons = playerButtons
	elseif tabName == "Server" then
		buttons = serverButtons
	end
	
	-- Создать кнопки, если их нет
	for _, buttonName in ipairs(buttons) do
		local button = contentFrame:FindFirstChild(buttonName)
		if not button then
			button = createActionButton(buttonName)
			button.Visible = true
		else
			button.Visible = true
		end
	end
	
	-- Обновить выделение вкладок
	playerTab.BackgroundColor3 = tabName == "Player" and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(65, 65, 65)
	serverTab.BackgroundColor3 = tabName == "Server" and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(65, 65, 65)
end

-- Обработчики вкладок
playerTab.MouseButton1Click:Connect(function() showTab("Player") end)
serverTab.MouseButton1Click:Connect(function() showTab("Server") end)

-- Показать первую вкладку по умолчанию
showTab("Player")

-- Обработчики для кнопок (основной функционал)
local function setupButtonHandler(button, handler)
	button.MouseButton1Click:Connect(handler)
end

-- Player Tab Handlers
setupButtonHandler(contentFrame:WaitForChild("Kill"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			if game:GetService("Players")[v].Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
				work(game:GetService("Players")[v].Character.Torso.Neck)
			else
				work(game:GetService("Players")[v].Character.Head.Neck)
			end
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Kick"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			work(game:GetService("Players")[v])
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Ban"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			if not table.find(bannedPlayers, v.Name) then
				plr = game:GetService("Players")[v]
				table.insert(bannedPlayers, plr.Name)
				Notify("Banned", plr.Name .. " Will not be able to join the server", 5)
				work(plr)
			end
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Unban"), function()
	for i,v in pairs(GetBannedPlayer(playerInput.Text)) do
		spawn(function()
			table.remove(bannedPlayers, table.find(bannedPlayers, v))
			Notify("UnBanned", v .." Is now able to join the server", 5)
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Goto"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[v].Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("View"), function()
	for i, v in pairs(GetPlayer(playerInput.Text)) do
		if game:GetService("Players")[v].Character:FindFirstChild("Humanoid") then
			cam.CameraSubject = game:GetService("Players")[v].Character.Humanoid
		end
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Unview"), function()
	if LocalPlayer.Character:FindFirstChild("Humanoid") then
		cam.CameraSubject = LocalPlayer.Character.Humanoid
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Naked"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		if game:GetService("Players")[v].Character:FindFirstChildOfClass("Shirt") then
			spawn(function()
				work(game:GetService("Players")[v].Character:FindFirstChildOfClass("Shirt"))
			end)
		end
		if game:GetService("Players")[v].Character:FindFirstChildOfClass("Pants") then
			spawn(function()
				work(game:GetService("Players")[v].Character:FindFirstChildOfClass("Pants"))
			end)
		end
		if game:GetService("Players")[v].Character:FindFirstChild("Shirt Graphic") then
			spawn(function()
				work(game:GetService("Players")[v].Character:FindFirstChild("Shirt Graphic"))
			end)
		end
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Faceless"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function())
			destructwashere = game:GetService("Players")[v].Character.Head.face
			work(destructwashere)
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("NoLimbs"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			if game:GetService("Players")[v].Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
				names = {"Left Arm", "Right Arm", "Left Leg", "Right Leg"}
				for _, str in pairs(names) do
					work(game:GetService("Players")[v].Character[str])
				end
			else
				names = {"LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg"}
				for _, str in pairs(names) do
					work(game:GetService("Players")[v].Character[str])
				end
			end
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Hatless"), function()
	for i, v in pairs(GetPlayer(playerInput.Text)) do
		for i, h in pairs(game:GetService("Players")[v].Character:GetChildren()) do
			if h:IsA("Accessory") then
				work(h)
			end
		end
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Ragdoll"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			e = game:GetService("Players")[v].Character:FindFirstChild("Humanoid")
			work(e)
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Ranim"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		if game:GetService("Players")[v].Character:FindFirstChild("Humanoid") then
			work(game:GetService("Players")[v].Character.Humanoid:FindFirstChild("Animator"))
		end
	end
end)

setupButtonHandler(contentFrame:WaitForChild("BTools"), function()
	local Tool = Instance.new("Tool",game.Players.LocalPlayer.Backpack)
	local Equipped = false

	Tool.RequiresHandle = false
	Tool.Name = "Destroy Tool"
	local Field = Instance.new("SelectionBox",game.Workspace)
	local Mouse = game.Players.LocalPlayer:GetMouse()
	Field.LineThickness = 0.1
	Tool.TextureId = "http://www.roblox.com/asset/?id=12223874"
	Tool.Equipped:Connect(function()
		Equipped = true

		while Equipped == true do
			if Mouse.Target ~= nil then
				Field.Adornee = Mouse.Target
				Mouse.Icon = "rbxasset://textures/HammerCursor.png"
			else
				Field.Adornee = nil
				Mouse.Icon = ""
			end
			wait()
		end
	end)

	Tool.Unequipped:Connect(function()
		Equipped = false
		Field.Adornee = nil
		Mouse.Icon = ""
	end)

	Tool.Activated:Connect(function()
		if Mouse.Target ~= nil then
			print(Mouse.Target)
			remote:FireServer(Mouse.Target, {Value = Mouse.Target})
			local ex = Instance.new'Explosion'
			ex.BlastRadius = 0
			ex.Position = Mouse.Target.Position
			ex.Parent = workspace

			local AttemptTarget = Mouse.Target
			while AttemptTarget ~= nil do
				AttemptTarget.Velocity = Vector3.new(0,-1000000000000000,0)
				AttemptTarget.CanCollide = false
				wait()
			end
		end
	end)
end)

setupButtonHandler(contentFrame:WaitForChild("RTools"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			backpack = game:GetService("Players")[v]["Backpack"] or game:GetService("Players")[v]:WaitForChild("Backpack")
			for i,t in pairs(backpack:GetChildren()) do
				if t:IsA("BackpackItem") and t:FindFirstChild("Handle") then
					work(t)
				end
			end
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("STools"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			work(game:GetService("Players")[v].Character:FindFirstChildOfClass("Humanoid"))
			repeat wait() until game:GetService("Players")[v].Character:FindFirstChildOfClass("Humanoid").Parent == nil
			for i,v in pairs(game:GetService("Players")[v].Character:GetChildren()) do
				if v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
					LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
				end
			end
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Punish"), function()
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			work(game:GetService("Players")[v].Character)
		end)
	end
end)

-- Server Tab Handlers
setupButtonHandler(contentFrame:WaitForChild("Nuke"), function()
	for i,c in pairs(game.Workspace:GetChildren()) do
		all = c
		work(all)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Fix Server"), function()
	for i,c in pairs(game.StarterGui:GetChildren()) do
		all = c
		work(all)
	end
	for i,c in pairs(game.StarterPack:GetChildren()) do
		all = c
		work(all)
	end
	for i,c in pairs(game.Workspace:GetChildren()) do
		all = c
		work(all)
	end
	for i,c in pairs(game.Teams:GetChildren()) do
		all = c
		work(all)
	end
	for i,c in pairs(game.Chat:GetChildren()) do
		all = c
		work(all)
	end
	for i,c in pairs(game.CoreGui:GetChildren()) do
		all = c
		work(all)
	end
	for i,v in pairs(GetPlayer(playerInput.Text)) do
		spawn(function()
			work(game:GetService("Players")[v])
		end)
	end
end)

local serverLockToggle = false
setupButtonHandler(contentFrame:WaitForChild("Server Lock"), function()
	serverLockToggle = not serverLockToggle
	if serverLockToggle then
		Notify("Server Locked", "Nobody can join the server", 5)
		serverlock = true
	else
		Notify("Server Unlocked", "Anyone can join the server", 5)
		serverlock = false
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Shutdown"), function()
	sdown = true
	Notify("Shutdown", "Shutdowning server..", 5)
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		spawn(function()
			if v.Name ~= LocalPlayer.Name then
				work(v)
				repeat wait() until not game:GetService("Players"):FindFirstChild(v)
				work(LocalPlayer)
			end
		end)
	end
end)

setupButtonHandler(contentFrame:WaitForChild("Rchassis"), function()
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if string.match(v.Name, "Chassis") then
			work(v)
		end
	end
end)

-- Добавляем переменные, которые использовались в оригинальном скрипте
local bannedPlayers = {}
local serverlock = false
local sdown = false
local cam = workspace.CurrentCamera

function GetBannedPlayer(target)
	local Found = {}
	for _, str in pairs(bannedPlayers) do
		if str:find(target) then
			table.insert(Found, str)
			break
		end
	end
	return Found    
end

game:GetService("Players").PlayerAdded:Connect(function(plr)
	for i,v in pairs(bannedPlayers) do
		if plr.Name == v then
			Notify("Banned User", plr.Name .. " Tried to join the game", 5)
			work(plr)
		end
	end
	if serverlock == true then
		Notify("Join Attempt", plr.Name .. " Tried to join the game but the server is locked", 5)
		work(plr)
	end
	if sdown == true then
		work(plr)
	end
end)

end
