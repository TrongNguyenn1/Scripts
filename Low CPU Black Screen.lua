local screenSaver = Instance.new("ScreenGui")
local savingFrame = Instance.new("Frame")
local dvd_logo = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")

screenSaver.Name = "screenSaver"
screenSaver.Enabled = false
screenSaver.Parent = game:GetService("CoreGui")
screenSaver.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

savingFrame.Name = "savingFrame"
savingFrame.Parent = screenSaver
savingFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
savingFrame.BorderSizePixel = 0
if _G.ShowUp == true then
savingFrame.Position = UDim2.new(0, 0, 0, 0)
savingFrame.Size = UDim2.new(1, 0,1, 0)
else
    savingFrame.Position = UDim2.new(0, 0, -0.0984251946, 0)
savingFrame.Size = UDim2.new(1, 0, 1.09842515, 0)
end

dvd_logo.Name = "dvd_logo"
dvd_logo.Parent = savingFrame
dvd_logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dvd_logo.BackgroundTransparency = 1.000
dvd_logo.Position = UDim2.new(0.5, -50, 0.5, -50)
dvd_logo.Size = UDim2.new(0, 100, 0, 100)
dvd_logo.Image = "http://www.roblox.com/asset/?id=7371850353"

TextLabel.Parent = dvd_logo
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.049999997, 0, 1, 0)
TextLabel.Size = UDim2.new(0, 89, 0, 30)
TextLabel.Font = Enum.Font.Michroma
TextLabel.Text = "Currently Saving GPU"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 20.000
TextLabel.TextWrapped = true

-- Scripts:

local function SOVAXG_fake_script() -- savingFrame.LocalScript 
	local script = Instance.new('LocalScript', savingFrame)

	local rs = game:GetService("RunService")
	
	local x
	local y
	
	local xspeed = 10
	local yspeed = 10
	
	local dvd = script.Parent.dvd_logo
	local cam = workspace.CurrentCamera
	
	local r, g, b
	
	local width = cam.ViewportSize.X
	local height = cam.ViewportSize.Y
	
	function pickColor()
		r = math.random(100, 256)
		g = math.random(100, 256)
		b = math.random(100, 256)
	end
	
	x = math.random(0, width)
	y = math.random(0, height)
	
	pickColor()
	
	rs.RenderStepped:Connect(function()
		x = x + xspeed
		y = y + yspeed
		
		dvd.Position = UDim2.fromOffset(x, y)
		dvd.ImageColor3 = Color3.fromRGB(r, g, b)
		
		if x + dvd.AbsoluteSize.X >= width then
			xspeed = -xspeed
			x = width - dvd.AbsoluteSize.X
			pickColor()
		elseif x <= 0 then
			xspeed = -xspeed
			x = 0
			pickColor()
		end
		
		if y + dvd.AbsoluteSize.Y >= height then
			yspeed = -yspeed
			y = height - dvd.AbsoluteSize.Y
			pickColor()
		elseif y <= 0 then
			yspeed = -yspeed
			y = 0
			pickColor()
		end
	end)
end
coroutine.wrap(SOVAXG_fake_script)()

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

function savegpu()
setfpscap(10)
screenSaver.Enabled = true
RunService:Set3dRenderingEnabled(false)
end

function unsavegpu()
    setfpscap(360)
screenSaver.Enabled = false
RunService:Set3dRenderingEnabled(true)
end


local WindowFocusReleasedFunction = function()
	savegpu()
	return
end

local WindowFocusedFunction = function()
	unsavegpu()
	return
end

local Initialize = function()
	UserInputService.WindowFocusReleased:Connect(WindowFocusReleasedFunction)
	UserInputService.WindowFocused:Connect(WindowFocusedFunction)
	return
end

Initialize()