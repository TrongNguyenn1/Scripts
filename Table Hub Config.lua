repeat wait() until game:IsLoaded() --????????????????? synx ?????????????????????
_G.Fruit1 = {
    ['BuyFruit'] = true, -- true / false
    ['SelectDevil'] = {"String-String","Human-Human: Buddha","Rumble-Rumble","Bird-Bird: Phoenix","Rumble-Rumble","Paw-Paw","Gravity-Gravity","Dough-Dough","Shadow-Shadow","Venom-Venom","Control-Control","Soul-Soul","Dragon-Dragon","Leopard-Leopard"},
    ['SinperFruit_mode'] = false
}
_G.Setting1 = {['WhiteScreen'] = true}


if type(_G.Setting1) ~= "table" then _G.Setting1 = {} end
    _G.Setting1['Team'] = "Pirates"  -- Marines / Pirates
    _G.Setting1['FPS_Boost'] = true -- true / false -- ?????
    _G.Setting1['AutoRedeem'] = true -- true / false
    _G.Setting1['RedeemOnLv'] = 100
    _G.Setting1['HideUI'] = true
if type(_G.SaveSettingSync) ~= "table" then _G.SaveSettingSync = {} end
    _G.SaveSettingSync = {
            ['3meleebe'] = true ,--3 melee before sea3
            ['HopNoMob'] = true,
            ['BuyLegndarySword'] = true,
            ['AutoSetting_Skill'] = true,
            ['WebHookUrl'] = "x",
            ['BestSheetUrl'] = "x",
            ['LineToken'] = 'xxxxxxxxxxxxxxxxx'
     }  

    _G.farmer1 = {
        ['AutoFarm'] = true, -- true / false
        ["GetMaterialGodhuman"] = true,
        ['Mastery_Farm'] = true, -- true / false
        ['Mastery_Mode'] = "Fruit", --"Fruit", "Gun","Sword"
        ['FruitMastery_MaxLv'] = true,
        ['AllSwordMas_MaxLv'] = true
    }
    _G.Sword_Farm = {"Wando","Shisui","Saddi","Tushita","Yama","Spikey Trident"}
    _G.tool1 = {
        ['AutoMeleeWeapon'] = true, -- true / false
        ['Make_Melee'] = {"Superhuman","Electric Claw","Dargon Talon","Sharkman Karate","Death Step","Godhuman"}
    }
    _G.Shop1 = {
        ['BuyEctoplasItem'] = true,
        ['BuyCommon'] = true,
        ['BuyHaki'] = true ,-- autobuy Buso haki Skyjump
        ['BuyKabcha'] = true, -- true / false
        ['BuyBisento'] = true,
        ['BuyPole2'] = true
    }
    if type(_G.Fruit1) ~= "table" then _G.Fruit1 = {} end
    _G.Fruit1['RandomFruit'] = true
    _G.Fruit1['StoreFruit'] = true
    _G.Fruit1['BringFruit'] = true
    _G.Fullystats = true
    if game.PlaceId == 2753915549 then -- sea1
        _G.farmer1['Farm_Mode'] =  "Level"
        _G.sea_I = {
            ['AutoSea2'] = true, -- true
            ['SecretQuest'] = true,
            ['Open_Saber'] = true,
            ['Pole_v1'] = true
        }
    elseif game.PlaceId == 4442272183 then -- sea2
        _G.farmer1['Farm_Mode'] =  "Level"
        _G.sea_II = {
            ['AutoSea3'] = true,
            ['Bartilo'] = true,
            ['AutoFlower'] = true,
            ['AutoDarkbeard'] = true
        }
        _G.Raid1 = {
            ['AutoRaid'] = true, -- true / false
            ['RaidMode'] = "Awake Skill",-- "Raid Normal" , "Awake Skill"
            ['GetFruit_Method'] = "FruitInventory + BringFruit"-- "BringFruit" , "BringFruit + Hop" , "FruitInventory" , "FruitInventory + BringFruit" , "FruitInventory + BringFruit + Hop"
        
        }
    elseif game.PlaceId == 7449423635 then -- sea3
        _G.sea_III = {
            ['AutoCDK'] = true,
            ['SoulGuitar'] = true,
            ['PirateRaid'] = true,
            ['AutoScythe'] = true,
            ['BuddySword'] = true,
            ['AutoRipIndra'] = true,
            ['AutoCakePrince'] = true,
            ['Canvander'] = true,
            ['Tushita'] = true,
            ['EliteHunt'] = true,
            ['Elite_mode'] = "Yama Hop on 2400"--"Elite","Yama","Yama Hop on 2400","God Chalice"
        }
        _G.Raid1 = {
            ['AutoRaid'] = true, -- true / false
            ['RaidMode'] = "Awake Skill",-- "Raid Normal" , "Awake Skill"
            ['GetFruit_Method'] = "FruitInventory + BringFruit"-- "BringFruit" , "BringFruit + Hop" , "FruitInventory" , "FruitInventory + BringFruit" , "FruitInventory + BringFruit + Hop"
        
        }
        _G.farmer1['Farm_Mode'] =  "Level , NearMob" --  "Level" / "Bone" /  "Level , Bone"  / "Level , NearMob" /  "Ectoplas" / "Rengoku" / "DripMama" / "NearMob"
        _G.Shop1['BoneTrade'] = true
       
    end

local isExecuted = false
local request = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request

task.spawn(function()
	repeat task.wait() until isExecuted == true
	
end);

(function()
	_G.Key = 'x'
	_G.DiscordId = 'x'
	local Status, Script;
	repeat
	    task.wait()
	    Status, Script = pcall(request, { Url = 'https://raw.githubusercontent.com/AltsegoD/scripts/egoD/tablekhoc.lua' });
	until
	    Status == true and Script ~= nil
	    
	loadstring(Script.Body)();
	isExecuted = true
end)()