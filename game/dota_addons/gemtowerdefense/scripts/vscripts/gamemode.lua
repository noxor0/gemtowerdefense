
--Created by cro_madbomber
--Gem TD Reborn Dota 2 Version
--Version 0.2



function GemTowerDefenseReborn:InitGameMode()

	
	print("DEBUG: TOTAL PLAYER COUNT ", PLAYER_COUNT)

	towersKV 	= LoadKeyValues("scripts/kv/towers.kv")
	towersT = {}
	GetTowerTable()
	wavesKV 	= LoadKeyValues("scripts/kv/waves.kv")
	settingsKV 	= LoadKeyValues("scripts/kv/settings.kv")
	randomKV	= LoadKeyValues("scripts/kv/random.kv") 

	GameRules:SetCustomGameSetupAutoLaunchDelay( 0 )
	GameRules:LockCustomGameSetupTeamAssignment( true )
	GameRules:EnableCustomGameSetupAutoLaunch( true )
	GameRules:GetGameModeEntity():SetAnnouncerDisabled(true)
	GameRules:SetSameHeroSelectionEnabled(true)
	GameRules:SetUseUniversalShopMode(true)
	GameRules:GetGameModeEntity():GetRecommendedItemsDisabled()
	GameRules:GetGameModeEntity():SetStashPurchasingDisabled(true)

	Grid:Init()
	Builder:Init()
	Wave:Init(wavesKV)
	Random:Init()
	Players:Init()
	HeroSelection:Init()
	Sandbox:Init()
	GameRules:SetTimeOfDay(0.5)
	Throne:Init()
	GameData:Init()
	Gem_Items:Init()

	-- GameRules:GetGameModeEntity():SetCameraDistanceOverride(1400)
	GameRules:SetHeroSelectionTime(20.0)
	GameRules:SetPreGameTime(0)
	GameRules:SetGoldPerTick(0)
	GameRules:SetGoldTickTime(0)
	GameRules:SetStartingGold(0)
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
	GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_wisp")
	
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 4)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)

	PlayerResource:SetCustomPlayerColor(0, 255, 0, 0)
	PlayerResource:SetCustomPlayerColor(1, 0, 255, 0)
	PlayerResource:SetCustomPlayerColor(2, 0, 0, 255)
	PlayerResource:SetCustomPlayerColor(3, 255, 255, 255)

	ListenToGameEvent('entity_killed', Dynamic_Wrap(GemTowerDefenseReborn, 'OnEntityKilled'), self)
	ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GemTowerDefenseReborn, 'OnPlayerPickHero'), self)
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GemTowerDefenseReborn, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(GemTowerDefenseReborn, 'OnConnectFull'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GemTowerDefenseReborn, 'OnStateChange'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(GemTowerDefenseReborn, "OnPlayerChat"), self)
	CustomNetTables:SetTableValue( "game_state", "towers_table", towersT )

	local customXP =
	{
		[1] = 0,
		[2] = 600,
		[3] = 1400,
		[4] = 2000,
		[5] = 3000
	}
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(5)
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels ( true )
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(customXP)
	GameRules:SetUseCustomHeroXPValues ( true )

end

function GetTowerTable()

	for key, value in pairs(towersKV) do

		if key ~= "gem_Null" then

			towersT[key] = {}

			for tkey, value in pairs(towersKV[key]) do

					if tkey == 'Requirements' or tkey == 'Type' or tkey == 'UINum' then

							towersT[key][tkey] = value
							towersT[key]['BoardPulled'] = 0
							towersT[key]['BoardPicked'] = 0

							if tkey == 'Requirements' and towersT[key][tkey]['Count'] then
									towersT[key][tkey]['Count'] = nil
							end

					end
			end

			towersT[key].State = 'initial'
		end
	end

end

function PrintEndWaveMessage( message )
	print(message)
end

function GetState( keys )
	print(keys.state)
end