--========================================================
-- SEAMUSJUKES MOD CHECKER
--========================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--========================================================
-- ADMIN ID
--========================================================

local ADMIN_USER_ID = 11593044992

if LocalPlayer.UserId ~= ADMIN_USER_ID then
	return
end

--========================================================
-- GUI
--========================================================

local gui = Instance.new("ScreenGui")
gui.Name = "SeamusJukesModChecker"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- DRAGGING
--========================================================

local function makeDraggable(frame)

	local dragging = false
	local dragStart
	local startPosition

	frame.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = frame.Position

			input.Changed:Connect(function()

				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end

			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			frame.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)

		end
	end)
end

--========================================================
-- OPEN BUTTON
--========================================================

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 180, 0, 50)
openButton.Position = UDim2.new(0, 20, 0.5, -25)
openButton.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
openButton.Text = "MOD CHECKER"
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.TextSize = 16
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Active = true
openButton.Parent = gui

Instance.new("UICorner", openButton).CornerRadius =
	UDim.new(0, 10)

makeDraggable(openButton)

--========================================================
-- MAIN WINDOW
--========================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 760, 0, 520)
main.Position = UDim2.new(0.5, -380, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
	UDim.new(0, 12)

makeDraggable(main)

--========================================================
-- TITLE
--========================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 0, 60)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SeamusJukes Mod Checker"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

--========================================================
-- CLOSE
--========================================================

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 42, 0, 42)
close.Position = UDim2.new(1, -52, 0, 9)
close.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.Parent = main

Instance.new("UICorner", close).CornerRadius =
	UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
	main.Visible = false
	openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
	main.Visible = true
	openButton.Visible = false
end)

--========================================================
-- PLAYER LIST
--========================================================

local listBackground = Instance.new("Frame")
listBackground.Name = "PlayerListBackground"
listBackground.Position = UDim2.new(0, 15, 0, 75)
listBackground.Size = UDim2.new(0, 350, 1, -90)
listBackground.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
listBackground.BorderSizePixel = 0
listBackground.Parent = main

Instance.new("UICorner", listBackground).CornerRadius =
	UDim.new(0, 8)

-- Player list title

local listTitle = Instance.new("TextLabel")
listTitle.Size = UDim2.new(1, -20, 0, 40)
listTitle.Position = UDim2.new(0, 10, 0, 5)
listTitle.BackgroundTransparency = 1
listTitle.Text = "PLAYERS"
listTitle.TextColor3 = Color3.fromRGB(200, 200, 210)
listTitle.TextSize = 16
listTitle.Font = Enum.Font.GothamBold
listTitle.TextXAlignment = Enum.TextXAlignment.Left
listTitle.Parent = listBackground

-- Scrolling frame

local playerList = Instance.new("ScrollingFrame")
playerList.Name = "PlayerList"
playerList.Position = UDim2.new(0, 10, 0, 45)
playerList.Size = UDim2.new(1, -20, 1, -55)
playerList.BackgroundTransparency = 1
playerList.BorderSizePixel = 0
playerList.ScrollBarThickness = 6
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerList.Parent = listBackground

local playerLayout = Instance.new("UIListLayout")
playerLayout.Padding = UDim.new(0, 6)
playerLayout.SortOrder = Enum.SortOrder.Name
playerLayout.Parent = playerList

--========================================================
-- PLAYER INFO
--========================================================

local info = Instance.new("Frame")
info.Name = "PlayerInfo"
info.Position = UDim2.new(0, 380, 0, 75)
info.Size = UDim2.new(0, 365, 1, -90)
info.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
info.BorderSizePixel = 0
info.Parent = main

Instance.new("UICorner", info).CornerRadius =
	UDim.new(0, 8)

local selectedName = Instance.new("TextLabel")
selectedName.Position = UDim2.new(0, 20, 0, 20)
selectedName.Size = UDim2.new(1, -40, 0, 45)
selectedName.BackgroundTransparency = 1
selectedName.Text = "Select a player"
selectedName.TextColor3 = Color3.new(1, 1, 1)
selectedName.TextSize = 22
selectedName.Font = Enum.Font.GothamBold
selectedName.TextXAlignment = Enum.TextXAlignment.Left
selectedName.Parent = info

local status = Instance.new("TextLabel")
status.Position = UDim2.new(0, 20, 0, 75)
status.Size = UDim2.new(1, -40, 0, 35)
status.BackgroundTransparency = 1
status.Text = "Status: Normal"
status.TextColor3 = Color3.fromRGB(90, 255, 120)
status.TextSize = 17
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = info

local violationText = Instance.new("TextLabel")
violationText.Position = UDim2.new(0, 20, 0, 120)
violationText.Size = UDim2.new(1, -40, 0, 35)
violationText.BackgroundTransparency = 1
violationText.Text = "Violations: 0"
violationText.TextColor3 = Color3.fromRGB(220, 220, 220)
violationText.TextSize = 17
violationText.Font = Enum.Font.Gotham
violationText.TextXAlignment = Enum.TextXAlignment.Left
violationText.Parent = info

local reasonText = Instance.new("TextLabel")
reasonText.Position = UDim2.new(0, 20, 0, 170)
reasonText.Size = UDim2.new(1, -40, 0, 100)
reasonText.BackgroundTransparency = 1
reasonText.Text = "Detected violation: None"
reasonText.TextColor3 = Color3.fromRGB(255, 190, 70)
reasonText.TextSize = 17
reasonText.Font = Enum.Font.Gotham
reasonText.TextWrapped = true
reasonText.TextXAlignment = Enum.TextXAlignment.Left
reasonText.TextYAlignment = Enum.TextYAlignment.Top
reasonText.Parent = info

--========================================================
-- REPORT BUTTON
--========================================================

local report = Instance.new("TextButton")
report.Position = UDim2.new(0, 20, 1, -65)
report.Size = UDim2.new(1, -40, 0, 45)
report.BackgroundColor3 = Color3.fromRGB(190, 65, 65)
report.Text = "REPORT PLAYER"
report.TextColor3 = Color3.new(1, 1, 1)
report.TextSize = 16
report.Font = Enum.Font.GothamBold
report.Parent = info

Instance.new("UICorner", report).CornerRadius =
	UDim.new(0, 8)

--========================================================
-- PLAYER DATA
--========================================================

local playerData = {}
local selectedPlayer = nil
local playerButtons = {}

local function selectPlayer(plr)

	selectedPlayer = plr

	local data = playerData[plr]

	if not data then
		return
	end

	selectedName.Text = plr.DisplayName

	violationText.Text =
		"Violations: " .. data.violations

	reasonText.Text =
		"Detected violation: " .. data.reason

	if data.violations > 0 then

		status.Text = "Status: FLAGGED"
		status.TextColor3 =
			Color3.fromRGB(255, 75, 75)

	else

		status.Text = "Status: Normal"
		status.TextColor3 =
			Color3.fromRGB(90, 255, 120)

	end
end

--========================================================
-- ADD PLAYER TO LIST
--========================================================

local function addPlayer(plr)

	if playerButtons[plr] then
		return
	end

	playerData[plr] = {
		violations = 0,
		reason = "None"
	}

	local button = Instance.new("TextButton")

	button.Name = plr.Name
	button.Size = UDim2.new(1, 0, 0, 48)
	button.BackgroundColor3 =
		Color3.fromRGB(42, 42, 53)

	button.BorderSizePixel = 0
	button.Text = plr.DisplayName
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextSize = 15
	button.Font = Enum.Font.Gotham
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.AutoButtonColor = true
	button.Parent = playerList

	local buttonPadding = Instance.new("UIPadding")
	buttonPadding.PaddingLeft = UDim.new(0, 12)
	buttonPadding.Parent = button

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	playerButtons[plr] = button

	button.MouseButton1Click:Connect(function()
		selectPlayer(plr)
	end)
end

--========================================================
-- REMOVE PLAYER
--========================================================

local function removePlayer(plr)

	if playerButtons[plr] then
		playerButtons[plr]:Destroy()
		playerButtons[plr] = nil
	end

	playerData[plr] = nil

	if selectedPlayer == plr then

		selectedPlayer = nil

		selectedName.Text = "Select a player"
		status.Text = "Status: Normal"
		violationText.Text = "Violations: 0"
		reasonText.Text = "Detected violation: None"

	end
end

--========================================================
-- LOAD EXISTING PLAYERS
--========================================================

for _, plr in ipairs(Players:GetPlayers()) do

	if plr ~= LocalPlayer then
		addPlayer(plr)
	end

end

--========================================================
-- NEW PLAYERS
--========================================================

Players.PlayerAdded:Connect(function(plr)

	if plr ~= LocalPlayer then
		addPlayer(plr)
	end

end)

--========================================================
-- PLAYER LEAVES
--========================================================

Players.PlayerRemoving:Connect(function(plr)
	removePlayer(plr)
end)

--========================================================
-- TEST DETECTION FUNCTION
--========================================================

local function flagPlayer(plr, violation)

	if not playerData[plr] then
		return
	end

	playerData[plr].violations += 1
	playerData[plr].reason = violation

	local button = playerButtons[plr]

	if button then
		button.BackgroundColor3 =
			Color3.fromRGB(80, 35, 40)
	end

	if selectedPlayer == plr then
		selectPlayer(plr)
	end

	warn(
		"[MOD CHECKER] "
			.. plr.Name
			.. " - "
			.. violation
	)
end

--========================================================
-- BASIC MONITOR
--========================================================

local function monitor(plr, character)

	local humanoid =
		character:WaitForChild("Humanoid", 5)

	local root =
		character:WaitForChild("HumanoidRootPart", 5)

	if not humanoid or not root then
		return
	end

	local lastPosition = root.Position

	while character.Parent and plr.Parent do

		task.wait(0.5)

		if humanoid.Health <= 0 then
			lastPosition = root.Position
			continue
		end

		if humanoid.WalkSpeed > 24 then
			flagPlayer(
				plr,
				"Abnormally high WalkSpeed"
			)
		end

		if humanoid.UseJumpPower
			and humanoid.JumpPower > 65 then

			flagPlayer(
				plr,
				"Abnormally high JumpPower"
			)

		end

		local currentPosition = root.Position

		local difference =
			currentPosition - lastPosition

		local horizontal =
			Vector3.new(
				difference.X,
				0,
				difference.Z
			).Magnitude

		local speed = horizontal / 0.5

		if horizontal > 100 then

			flagPlayer(
				plr,
				"Possible teleport"
			)

		elseif speed > 45 then

			flagPlayer(
				plr,
				"Abnormally fast movement"
			)

		end

		lastPosition = currentPosition

	end
end

--========================================================
-- SETUP MONITOR
--========================================================

local function setupPlayer(plr)

	if plr.Character then

		task.spawn(function()
			monitor(plr, plr.Character)
		end)

	end

	plr.CharacterAdded:Connect(function(character)

		task.spawn(function()
			monitor(plr, character)
		end)

	end)
end

for _, plr in ipairs(Players:GetPlayers()) do

	if plr ~= LocalPlayer then
		setupPlayer(plr)
	end

end

Players.PlayerAdded:Connect(function(plr)

	if plr ~= LocalPlayer then
		setupPlayer(plr)
	end

end)

--========================================================
-- REPORT BUTTON
--========================================================

report.MouseButton1Click:Connect(function()

	if not selectedPlayer then

		report.Text = "SELECT A PLAYER FIRST"

		task.delay(2, function()

			if report then
				report.Text = "REPORT PLAYER"
			end

		end)

		return
	end

	-- This does NOT automatically submit a Roblox report.
	-- Roblox controls the official reporting system.

	report.Text = "USE ROBLOX REPORT MENU"

	task.delay(3, function()

		if report then
			report.Text = "REPORT PLAYER"
		end

	end)

	print(
		"Selected player for Roblox report:",
		selectedPlayer.Name
	)
end)

--========================================================
-- READY
--========================================================

print("======================================")
print("SeamusJukes Mod Checker")
print("Loaded successfully")
print("Admin:", LocalPlayer.Name)
print("Players:", #Players:GetPlayers() - 1)
print("======================================")
