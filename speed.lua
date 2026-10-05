local P=game.Players.LocalPlayer
local UIS=game:GetService("UserInputService")
local Run=game:GetService("RunService")

local G=Instance.new("ScreenGui")
G.Name="MikSnowSpeed"
G.ResetOnSpawn=false
G.IgnoreGuiInset=true
G.Parent=P:WaitForChild("PlayerGui")

-- MAIN
local F=Instance.new("Frame",G)
F.Size=UDim2.fromScale(.42,.45)
F.Position=UDim2.fromScale(.29,.27)
F.BackgroundColor3=Color3.fromRGB(8,20,35)
F.BackgroundTransparency=.05
F.BorderSizePixel=0
F.ClipsDescendants=true

Instance.new("UICorner",F).CornerRadius=UDim.new(0,16)

local Stroke=Instance.new("UIStroke",F)
Stroke.Color=Color3.fromRGB(80,190,255)
Stroke.Thickness=2

-- SNOW
local SnowBG=Instance.new("Frame",F)
SnowBG.Size=UDim2.fromScale(1,1)
SnowBG.BackgroundTransparency=1
SnowBG.BorderSizePixel=0

task.spawn(function()
	while G.Parent do
		if F.Visible then
			local S=Instance.new("TextLabel",SnowBG)
			S.BackgroundTransparency=1
			S.Text="❄"
			S.TextColor3=Color3.fromRGB(190,235,255)
			S.TextTransparency=math.random(0,35)/100
			S.Font=Enum.Font.GothamBold
			S.TextSize=math.random(10,22)
			S.Size=UDim2.fromOffset(30,30)

			local x=math.random()
			local t0=os.clock()
			local dur=math.random(5,9)

			task.spawn(function()
				while S.Parent and F.Visible do
					local t=(os.clock()-t0)/dur
					if t>=1 then break end

					local wave=math.sin(t*math.pi*4)*.035
					S.Position=UDim2.fromScale(x+wave,-.08+t*1.15)

					task.wait()
				end

				if S.Parent then S:Destroy() end
			end)
		end

		task.wait(.12)
	end
end)

-- TITLE
local T=Instance.new("TextLabel",F)
T.Size=UDim2.fromScale(.9,.14)
T.Position=UDim2.fromScale(.05,.025)
T.BackgroundTransparency=1
T.Text="❄ 冰雪天速 ❄"
T.TextColor3=Color3.fromRGB(180,235,255)
T.TextScaled=true
T.Font=Enum.Font.GothamBold

local Credit=Instance.new("TextLabel",F)
Credit.Size=UDim2.fromScale(.9,.07)
Credit.Position=UDim2.fromScale(.05,.15)
Credit.BackgroundTransparency=1
Credit.Text="制作者 : Mik"
Credit.TextColor3=Color3.fromRGB(150,205,230)
Credit.TextScaled=true
Credit.Font=Enum.Font.Gotham

-- SCROLL
local Scroll=Instance.new("ScrollingFrame",F)
Scroll.Size=UDim2.fromScale(.9,.68)
Scroll.Position=UDim2.fromScale(.05,.25)
Scroll.BackgroundTransparency=1
Scroll.BorderSizePixel=0
Scroll.ScrollBarThickness=5
Scroll.ScrollBarImageColor3=Color3.fromRGB(80,190,255)
Scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
Scroll.CanvasSize=UDim2.new()

local Layout=Instance.new("UIListLayout",Scroll)
Layout.Padding=UDim.new(0,12)
Layout.HorizontalAlignment=Enum.HorizontalAlignment.Center

-- SPEED
local S=Instance.new("TextBox",Scroll)
S.Size=UDim2.new(.9,0,0,55)
S.Text="1000"
S.PlaceholderText="Speed 1-1000"
S.TextScaled=true
S.BackgroundColor3=Color3.fromRGB(20,55,80)
S.TextColor3=Color3.new(1,1,1)
S.ClearTextOnFocus=false

Instance.new("UICorner",S).CornerRadius=UDim.new(0,10)

-- FLY
local Fly=Instance.new("TextButton",Scroll)
Fly.Size=UDim2.new(.9,0,0,55)
Fly.Text="🪽 FLY : OFF"
Fly.TextScaled=true
Fly.BackgroundColor3=Color3.fromRGB(35,110,160)
Fly.TextColor3=Color3.new(1,1,1)

Instance.new("UICorner",Fly).CornerRadius=UDim.new(0,10)

-- INFO
local Info=Instance.new("TextLabel",Scroll)
Info.Size=UDim2.new(.9,0,0,90)
Info.BackgroundColor3=Color3.fromRGB(15,45,65)
Info.Text="❄ 冰雪天速 ❄\n\nSpeed / Fly"
Info.TextColor3=Color3.fromRGB(190,235,255)
Info.TextScaled=true
Info.Font=Enum.Font.GothamBold

Instance.new("UICorner",Info).CornerRadius=UDim.new(0,10)

-- CLOSE
local Close=Instance.new("TextButton",Scroll)
Close.Size=UDim2.new(.9,0,0,50)
Close.Text="✕ CLOSE"
Close.TextScaled=true
Close.BackgroundColor3=Color3.fromRGB(25,65,85)
Close.TextColor3=Color3.new(1,1,1)

Instance.new("UICorner",Close).CornerRadius=UDim.new(0,10)

-- OPEN BUTTON
local Open=Instance.new("TextButton",G)
Open.Size=UDim2.fromOffset(70,70)
Open.Position=UDim2.fromScale(.05,.5)
Open.Text="❄"
Open.TextSize=36
Open.Font=Enum.Font.GothamBold
Open.TextColor3=Color3.fromRGB(220,250,255)
Open.BackgroundColor3=Color3.fromRGB(35,130,190)
Open.Visible=false

Instance.new("UICorner",Open).CornerRadius=UDim.new(1,0)

local OS=Instance.new("UIStroke",Open)
OS.Color=Color3.fromRGB(150,230,255)
OS.Thickness=3

-- OPEN / CLOSE
Close.MouseButton1Click:Connect(function()
	F.Visible=false
	Open.Visible=true
end)

Open.MouseButton1Click:Connect(function()
	F.Visible=true
	Open.Visible=false
end)

-- DRAG OPEN BUTTON
local dragging=false
local dragStart
local startPos

Open.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.Touch
	or input.UserInputType==Enum.UserInputType.MouseButton1 then

		dragging=true
		dragStart=input.Position
		startPos=Open.Position

		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then
				dragging=false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and
	(input.UserInputType==Enum.UserInputType.Touch
	or input.UserInputType==Enum.UserInputType.MouseMovement) then

		local d=input.Position-dragStart

		Open.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+d.X,
			startPos.Y.Scale,
			startPos.Y.Offset+d.Y
		)
	end
end)

-- FLY
local flying=false
local bv,bg
local flyConnection

local function stopFly()
	flying=false
	Fly.Text="🪽 FLY : OFF"

	if flyConnection then
		flyConnection:Disconnect()
		flyConnection=nil
	end

	if bv then
		bv:Destroy()
		bv=nil
	end

	if bg then
		bg:Destroy()
		bg=nil
	end
end

Fly.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
		return
	end

	local C=P.Character or P.CharacterAdded:Wait()
	local Root=C:FindFirstChild("HumanoidRootPart")

	if not Root then return end

	flying=true
	Fly.Text="🪽 FLY : ON"

	bv=Instance.new("BodyVelocity")
	bv.MaxForce=Vector3.new(1e6,1e6,1e6)
	bv.Parent=Root

	bg=Instance.new("BodyGyro")
	bg.MaxTorque=Vector3.new(1e6,1e6,1e6)
	bg.P=90000
	bg.Parent=Root

	flyConnection=Run.RenderStepped:Connect(function()
		if not flying or not Root.Parent then
			stopFly()
			return
		end

		local cam=workspace.CurrentCamera
		local speed=math.clamp(tonumber(S.Text) or 1000,1,1000)

		bv.Velocity=cam.CFrame.LookVector*speed
		bg.CFrame=cam.CFrame
	end)
end)

P.CharacterAdded:Connect(function()
	if flying then
		stopFly()
	end
end)
