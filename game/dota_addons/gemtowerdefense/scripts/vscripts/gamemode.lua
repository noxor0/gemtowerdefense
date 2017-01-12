
--Created by cro_madbomber
--Gem TD Reborn Dota 2 Version
--Version 0.2



function GemTowerDefenseReborn:InitGameMode()

	
	print("DEBUG: TOTAL PLAYER COUNT ", PLAYER_COUNT)

	towersKV 	= LoadKeyValues("scripts/kv/towers.kv")
	wavesKV 	= LoadKeyValues("scripts/kv/waves.kv")
	settingsKV 	= LoadKeyValues("scripts/kv/settings.kv")
	randomKV	= LoadKeyValues("scripts/kv/random.kv") 
	GameRules:SetCustomGameSetupAutoLaunchDelay( 0 )
    GameRules:LockCustomGameSetupTeamAssignment( true )
    GameRules:EnableCustomGameSetupAutoLaunch( true )
    
	Grid:Init()
	Builder:Init()
	Rounds:Init(wavesKV)
	Random:Init()
	Players:Init()
	HeroSelection:Init()

	GameRules:SetTimeOfDay(0.5)
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

	--ListenToGameEvent('entity_killed', Dynamic_Wrap(GemTowerDefenseReborn, 'OnEntityKilled'), self)
	ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GemTowerDefenseReborn, 'OnPlayerPickHero'), self)
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GemTowerDefenseReborn, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(GemTowerDefenseReborn, 'OnConnectFull'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GemTowerDefenseReborn, 'OnStateChange'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(GemTowerDefenseReborn, "OnPlayerChat"), self)
	ListenToGameEvent("entity_hurt", Dynamic_Wrap(GemTowerDefenseReborn, 'OnEntityHurt'), self)
	CustomGameEventManager:RegisterListener( "player_selected_hero", Dynamic_Wrap(GemTowerDefenseReborn, 'SetPlayerHero'))
	--ListenToGameEvent('round_end', Dynamic_Wrap(GemTowerDefenseReborn, 'CallBack'), self)


	local customXP =
	{
		0,
		600,
		1400,
		2000,
		3000
	}

	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(customXP)
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels ( true )
	GameRules:SetUseCustomHeroXPValues ( true )
end










