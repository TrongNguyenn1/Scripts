repeat wait()
until game:IsLoaded() and game:GetService("Players").LocalPlayer and 
game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen") == nil
for i,v in next, workspace:GetDescendants() do
    pcall(function()
        v.Transparency = 1
    end)
end
for i,v in next, getnilinstances() do
    pcall(function()
        v.Transparency = 1
        for i1,v1 in next, v:GetDescendants() do
            v1.Transparency = 1
        end
    end)
end
a = workspace
a.DescendantAdded:Connect(function(v)
    pcall(function()
        v.Transparency = 1
    end)
end)
workspace.ClientAnimatorThrottling = Enum.ClientAnimatorThrottlingMode.Enabled
workspace.InterpolationThrottling = Enum.InterpolationThrottlingMode.Enabled
settings():GetService("RenderSettings").EagerBulkExecution = false
workspace.LevelOfDetail = Enum.ModelLevelOfDetail.Disabled
game:GetService("Lighting").GlobalShadows = false

settings().Rendering.QualityLevel = "Level01"
