#!/bin/bash
sudo apt install make curl -y

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

rm get-docker.sh

mkdir /home/ubuntu/conan

file_string=$(echo -e "$(cat <<"EOF"

version: "3.5"

services:
  ce0:
    image: alinmear/docker-conanexiles:latest
    restart: unless-stopped
    environment:
      - "CONANEXILES_ServerSettings_ServerSettings_AdminPassword=ThanksForThisSmartSolution"
      - "CONANEXILES_Engine_OnlineSubSystemSteam_ServerName=My Cool Server 1"
      - "CONANEXILES_Engine_OnlineSubSystemSteam_ServerPassword=MySecret"
      - "CONANEXILES_INSTANCENAME=exiles0"
      - "CONANEXILES_Game_RconPlugin_RconEnabled=1"
      - "CONANEXILES_Game_RconPlugin_RconPassword=REDACTED"
      - "CONANEXILES_Game_RconPlugin_RconPort=25575"
      - "CONANEXILES_Game_RconPlugin_RconMaxKarma=60"
      - "CONANEXILES_UPDATE_SHUTDOWN_TIMER=15"
      # Mods
      ## Pippi: 880454836                                    # Servermanagemnt on another level
      ## Fashionist: 1159180273                              # Nice Styles, also restyle ingame
      ## Barbarian Barber: 2050780234                        # Very Nice Mod, with alot new hair styles; works well in combination with fashionist
      ## Nilfhein minimap: 1389908968                        # Very nice minimap
      ## Less Building Placement Restrictions: 1369743238    # Stop limitations of building system
      ## Lexa's Exiled Lands Improved: 2356146223            # Dual Wield (Sword, Axe) and some other nice enhacements
      ## Javelin Improved: 1701136207                        # One of the best, new javelin combos and styles, well balanced
      - "CONANEXILES_MODS=880454836,1159180273,1389908968,1369743238,2050780234,2356146223,1701136207"
      # Very Good Defaults
      - "CONANEXILES_Engine_/script/onlinesubsystemutils.ipnetdriver_NetServerMaxTickRate=30" #INSERT A VALUE OF 30 OR HIGHER
      - "CONANEXILES_Engine_/script/onlinesubsystemutils.ipnetdriver_MaxClientRate=600000"
      - "CONANEXILES_Engine_/script/onlinesubsystemutils.ipnetdriver_MaxInternetClientRate=600000"
      - "CONANEXILES_Engine_SystemSettings_dw.NetClientFloatsDuringNavWalking=0"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.EnableAISpawning=1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.EnableInitialAISpawningPass=1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NPCsTargetBuildings=1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.nav.AvoidNonPawns=1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.EnableStaticRoamingPaths=1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.nav.InterpolateAvoidanceResult=1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.AILOD1Distance=4000"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.AILOD2Distance=8000"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.AILOD3Distance=11500"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.SkeletalMeshTickRate=0.1"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD2ListenServerControllerTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD3ListenServerControllerTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD3ListenServerBehaviorTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD2ListenServerMovementTickRate=2.0f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD3ListenServerMovementTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD2ControllerTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD3ControllerTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD3BehaviorTickRate=20.f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD2MovementTickRate=2.0f"
      - "CONANEXILES_Engine_/script/conansandbox.systemsettings_dw.NpcLOD3MovementTickRate=20.f"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.GraphicsAdapter=-1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.Cache.LightingCacheDimension=75"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.AllowLandscapeShadows=1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.HighQualityLightMaps=1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.AOTrimOldRecordsFraction=0.5"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.AOInterpolationAngleScale=1.1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.AOInterpolationRadiusScale=1.1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.AOHeightfieldOcclusion=1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.TemporalAASamples=4"
      - "CONANEXILES_Engine_/script/engine.renderersettings_r.TemporalAACurrentFrameWeight=0.1"
      - "CONANEXILES_Engine_/script/engine.renderersettings_grass.densityScale=1.5"
      - "CONANEXILES_Engine_/script/engine.physicssettings_RagdollAggregateThreshold=2"
      - "CONANEXILES_Engine_/script/engine.physicssettings_bDefaultHasComplexCollision=True"
      - "CONANEXILES_Engine_/script/engine.physicssettings_bSubstepping=True"
      - "CONANEXILES_Engine_/script/engine.physicssettings_bSubsteppingAsync=True"
      - "CONANEXILES_Engine_/script/engine.physicssettings_MaxSubstepDeltaTime=0.025"
      - "CONANEXILES_Engine_/script/engine.physicssettings_MaxSubsteps=4"
      - "CONANEXILES_Engine_/script/aimodule.crowdmanager_NavmeshCheckInterval=0.100000"
      - "CONANEXILES_Engine_/script/aimodule.crowdmanager_PathOptimizationInterval=0.100000"
      - "CONANEXILES_Engine_/script/aimodule.crowdmanager_bResolveCollisions=True"
      - "CONANEXILES_Engine_/script/aimodule.aisystem_bAllowStrafing=True"
      - "CONANEXILES_Engine_/script/engine.audiosettings_bAllowCenterChannel3DPanning=True"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_TotalNetBandwidth=80000000"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MaxDynamicBandwidth=100000"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MinDynamicBandwidth=10000"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MoveRepSize=512.0f"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MAXPOSITIONERRORSQUARED=3.0f"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MAXCLIENTUPDATEINTERVAL=0.25f"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MaxMoveDeltaTime=0.125f"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_MaxClientSmoothingDeltaTime=1.0f"
      - "CONANEXILES_Game_/script/engine.gamenetworkmanager_ClientAuthorativePosition=true"
      - "CONANEXILES_Game_/script/engine.granitesettings_bAdvanced=True"
      - "CONANEXILES_Game_/script/engine.granitesettings_r.GraniteStreamLightMaps=True"
      - "CONANEXILES_Game_/script/conansandbox.aisense_newsight_MaxTracesPerTick=2000"
      - "CONANEXILES_Game_/script/conansandbox.aisenseconfig_newsight_PeripheralVisionAngleDegrees=75"
      - "CONANEXILES_Game_/script/aimodule.envquerymanager_MaxAllowedTestingTime=0.003"
      - "CONANEXILES_Game_/script/aimodule.envquerymanager_bTestQueriesUsingBreadth=false"
      - "CONANEXILES_Game_Settings.Physics.Cloth_MaxClothSimuatingActors=3"
      - "CONANEXILES_Game_Settings.Physics.Cloth_ClothSimulationAdjustmentInterval=0.650000"
      - "CONANEXILES_ServerSettings_ServerSettings_RegionBlockList="
      - "CONANEXILES_ServerSettings_ServerSettings_CorpsesPerPlayer=3"
      - "CONANEXILES_ServerSettings_ServerSettings_MaxDeathMapMarkers=3"
      - "CONANEXILES_ServerSettings_ServerSettings_BuildingPreloadRadius=90"
      - "CONANEXILES_ServerSettings_ServerSettings_EnforceRotationRateWhenRoaming_2=False"
      - "CONANEXILES_ServerSettings_ServerSettings_EnforceRotationRateInCombat_2=False"
      - "CONANEXILES_ServerSettings_ServerSettings_TargetPredictionMaxSeconds=0.5"
      - "CONANEXILES_ServerSettings_ServerSettings_TargetPredictionAllowSecondsForAttack=0.2"
      - "CONANEXILES_ServerSettings_ServerSettings_PlayerKnockbackMultiplier=0.25"
      - "CONANEXILES_ServerSettings_ServerSettings_ClipVelocityOnNavmeshBoundary=True"
      - "CONANEXILES_ServerSettings_ServerSettings_ValidatePhysNavWalkWithRaycast=true"
      - "CONANEXILES_ServerSettings_ServerSettings_LocalNavMeshVisualizationFrequency=0.1"
      - "CONANEXILES_ServerSettings_ServerSettings_RotateToTargetSendsAngularVelocity=True"
      - "CONANEXILES_ServerSettings_ServerSettings_PathFollowingSendsAngularVelocity=True"
      - "CONANEXILES_ServerSettings_ServerSettings_UseLocalQuadraticAngularVelocityPrediction=true"
      - "CONANEXILES_ServerSettings_ServerSettings_LQAVPUseTime=0.150000"
      - "CONANEXILES_ServerSettings_ServerSettings_LQAVPFadeTime=0.100000"
      - "CONANEXILES_ServerSettings_ServerSettings_LQAVPMethod=2"
      - "CONANEXILES_ServerSettings_ServerSettings_NetworkSimulatedSmoothRotationTimeWithLQAVP=0.100000"
      - "CONANEXILES_ServerSettings_ServerSettings_NPCRespawnMultiplier=5.000000"
      - "CONANEXILES_ServerSettings_ServerSettings_NPCMaxSpawnCapMultiplier=1.000000 "
      - "CONANEXILES_Scalability_AntiAliasingQuality@0_r.MSAA.CompositingSampleCount=0"
      - "CONANEXILES_Scalability_AntiAliasingQuality@1_r.MSAA.CompositingSampleCount=2"
      - "CONANEXILES_Scalability_AntiAliasingQuality@2_r.MSAA.CompositingSampleCount=4"
      - "CONANEXILES_Scalability_AntiAliasingQuality@3_r.MSAA.CompositingSampleCount=4"
      - "CONANEXILES_Scalability_ViewDistanceQuality@0_r.ViewDistanceScale=3.4"
      - "CONANEXILES_Scalability_ViewDistanceQuality@1_r.ViewDistanceScale=3.6"
      - "CONANEXILES_Scalability_ViewDistanceQuality@2_r.ViewDistanceScale=3.8"
      - "CONANEXILES_Scalability_ViewDistanceQuality@3_r.ViewDistanceScale=4.0"
      - "CONANEXILES_Scalability_ShadowQuality@0_r.Shadow.CSM.MaxCascades=1"
      - "CONANEXILES_Scalability_ShadowQuality@0_r.Shadow.MaxResolution=512"
      - "CONANEXILES_Scalability_ShadowQuality@0_r.Shadow.DistanceScale=0.6"
      - "CONANEXILES_Scalability_ShadowQuality@0_r.Shadow.MaxPointCasters=0"
      - "CONANEXILES_Scalability_ShadowQuality@0_r.Shadow.CSMDepthBias=30"
      - "CONANEXILES_Scalability_ShadowQuality@1_r.Shadow.CSM.MaxCascades=1"
      - "CONANEXILES_Scalability_ShadowQuality@1_r.Shadow.RadiusThreshold=0.05"
      - "CONANEXILES_Scalability_ShadowQuality@1_r.Shadow.DistanceScale=0.7"
      - "CONANEXILES_Scalability_ShadowQuality@1_r.Shadow.MaxPointCasters=0"
      - "CONANEXILES_Scalability_ShadowQuality@1_r.Shadow.CSMDepthBias=25"
      - "CONANEXILES_Scalability_ShadowQuality@2_r.DistanceFieldAO=1"
      - "CONANEXILES_Scalability_ShadowQuality@2_r.Shadow.MaxPointCasters=1"
      - "CONANEXILES_Scalability_ShadowQuality@2_r.Shadow.CSMDepthBias=20"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.CSM.MaxCascades=10"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.CSM.TransitionScale=2"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.CSMDepthBias=100"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.MaxResolution=4096"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.FadeExponent=0"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.Faderesolution=1024"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.DistanceFieldAO=1"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.PerObjectDirectionalDepthBias=10000"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.PointLightDepthBias=10000"
      - "CONANEXILES_Scalability_ShadowQuality@3_r.Shadow.SpotLightDepthBias=10000"
      - "CONANEXILES_Scalability_PostProcessQuality@0_r.AllowLandscapeShadows=0"
      - "CONANEXILES_Scalability_PostProcessQuality@0_r.HighQualityLightMaps=0"
      - "CONANEXILES_Scalability_PostProcessQuality@0_r.TonemapperQuality=1"
      - "CONANEXILES_Scalability_PostProcessQuality@1_r.AllowLandscapeShadows=0"
      - "CONANEXILES_Scalability_PostProcessQuality@1_r.HighQualityLightMaps=0"
      - "CONANEXILES_Scalability_PostProcessQuality@1_r.TonemapperQuality=1"
      - "CONANEXILES_Scalability_PostProcessQuality@2_r.BloomQuality=4"
      - "CONANEXILES_Scalability_PostProcessQuality@2_r.TonemapperQuality=1"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.AmbientOcclusionLevels=2"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.DepthOfFieldQuality=4"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.RenderTargetPoolMin=1000"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.LensFlareQuality=3"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.EyeAdaptationQuality=3"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.Bloom.Cross=1"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.Tonemapper.Quality=1"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.Tonemapper.Sharpen=0.2"
      - "CONANEXILES_Scalability_PostProcessQuality@3_r.ReflectionEnvironmentLightmapMixLargestWeight=7500"
      - "CONANEXILES_Scalability_TextureQuality@0_r.Streaming.LimitPoolSizeToVRAM=1"
      - "CONANEXILES_Scalability_TextureQuality@0_r.Streaming.PoolSize=500"
      - "CONANEXILES_Scalability_TextureQuality@1_r.Streaming.LimitPoolSizeToVRAM=1"
      - "CONANEXILES_Scalability_TextureQuality@1_r.Streaming.PoolSize=800"
      - "CONANEXILES_Scalability_TextureQuality@2_r.Streaming.LimitPoolSizeToVRAM=1"
      - "CONANEXILES_Scalability_TextureQuality@2_r.Streaming.PoolSize=1500"
      - "CONANEXILES_Scalability_TextureQuality@3_r.Streaming.LimitPoolSizeToVRAM=0"
      - "CONANEXILES_Scalability_TextureQuality@3_r.Streaming.PoolSize=3000"
      - "CONANEXILES_Scalability_EffectsQuality@0_r.SSS.Scale=0"
      - "CONANEXILES_Scalability_EffectsQuality@0_r.SSS.Quality=0"
      - "CONANEXILES_Scalability_EffectsQuality@0_r.SSS.HalfRes=1"
      - "CONANEXILES_Scalability_EffectsQuality@0_r.ParticleLightQuality=0"
      - "CONANEXILES_Scalability_EffectsQuality@1_r.SSS.Scale=0.75"
      - "CONANEXILES_Scalability_EffectsQuality@1_r.SSS.Quality=0"
      - "CONANEXILES_Scalability_EffectsQuality@1_r.SSS.HalfRes=1"
      - "CONANEXILES_Scalability_EffectsQuality@1_r.ParticleLightQuality=0"
      - "CONANEXILES_Scalability_EffectsQuality@2_r.ReflectionEnvironment=1"
      - "CONANEXILES_Scalability_EffectsQuality@2_r.SubsurfaceQuality=0"
      - "CONANEXILES_Scalability_EffectsQuality@2_r.SSS.Scale=1"
      - "CONANEXILES_Scalability_EffectsQuality@2_r.SSS.Quality=-1"
      - "CONANEXILES_Scalability_EffectsQuality@2_r.SSS.HalfRes=1"
      - "CONANEXILES_Scalability_EffectsQuality@2_r.ParticleLightQuality=1"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.ReflectionEnvironment=1"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.SubsurfaceQuality=1"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.EmitterSpawnRateScale=1.5"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.SSR.Quality=4"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.SSS.Scale=1"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.SSS.Quality=1"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.SSS.HalfRes=0"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.ParticleLightQuality=2"
      - "CONANEXILES_Scalability_EffectsQuality@3_r.FluidQuality=2"
      - "CONANEXILES_Scalability_GraniteTextureQuality@0_r.GraniteSDK.MipBias=1"
      - "CONANEXILES_Scalability_GraniteTextureQuality@0_r.GraniteSDK.MaxAnisotropy=1"
      - "CONANEXILES_Scalability_GraniteTextureQuality@0_r.GraniteSDK.GPUCacheSizeScale=1.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@0_r.GraniteSDK.CPUCacheSizeScale=1.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@0_r.GraniteSDK.MinGPUCacheSizeInMB=10"
      - "CONANEXILES_Scalability_GraniteTextureQuality@0_r.GraniteSDK.MinCPUCacheSizeInMB=10"
      - "CONANEXILES_Scalability_GraniteTextureQuality@1_r.GraniteSDK.MipBias=0.5"
      - "CONANEXILES_Scalability_GraniteTextureQuality@1_r.GraniteSDK.MaxAnisotropy=2"
      - "CONANEXILES_Scalability_GraniteTextureQuality@1_r.GraniteSDK.GPUCacheSizeScale=3.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@1_r.GraniteSDK.CPUCacheSizeScale=2.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@1_r.GraniteSDK.MinGPUCacheSizeInMB=10"
      - "CONANEXILES_Scalability_GraniteTextureQuality@1_r.GraniteSDK.MinCPUCacheSizeInMB=10"
      - "CONANEXILES_Scalability_GraniteTextureQuality@2_r.GraniteSDK.MipBias=0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@2_r.GraniteSDK.MaxAnisotropy=4"
      - "CONANEXILES_Scalability_GraniteTextureQuality@2_r.GraniteSDK.GPUCacheSizeScale=5.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@2_r.GraniteSDK.CPUCacheSizeScale=3.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@2_r.GraniteSDK.MinGPUCacheSizeInMB=20"
      - "CONANEXILES_Scalability_GraniteTextureQuality@2_r.GraniteSDK.MinCPUCacheSizeInMB=20"
      - "CONANEXILES_Scalability_GraniteTextureQuality@3_r.GraniteSDK.MipBias=0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@3_r.GraniteSDK.MaxAnisotropy=8"
      - "CONANEXILES_Scalability_GraniteTextureQuality@3_r.GraniteSDK.GPUCacheSizeScale=10.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@3_r.GraniteSDK.CPUCacheSizeScale=4.0"
      - "CONANEXILES_Scalability_GraniteTextureQuality@3_r.GraniteSDK.MinGPUCacheSizeInMB=20"
      - "CONANEXILES_Scalability_GraniteTextureQuality@3_r.GraniteSDK.MinCPUCacheSizeInMB=20 "
      - "CONANEXILES_CharacterLOD_/script/conansandbox.characterlodsystem_SimultaneousIK=8"
      - "CONANEXILES_CharacterLOD_/script/conansandbox.characterlodsystem_IKLodUpdateInterval=0.3"
      - "CONANEXILES_CharacterLOD_/script/conansandbox.characterlodsystem_IKRange=6000.000000"
      - "CONANEXILES_CharacterLOD_/script/conansandbox.characterlodsystem_SimultaneousHighQualityHair=8"
      - "CONANEXILES_CharacterLOD_/script/conansandbox.characterlodsystem_HairLodUpdateInterval=0.75 "
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_NumIrradianceCalculationPhotons=2000"
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_NumIrradianceCalculationPhotons=4096"
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_IndirectPhotonSearchDistance=1000"
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_IndirectPhotonSearchDistance=180"
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_DirectIrradiancePhotonDensity=1024"
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_IndirectPhotonDensity=20000"
      - "CONANEXILES_Lightmass_DevOptions.PhotonMapping_IndirectIrradiancePhotonDensity=16000"
      - "CONANEXILES_Lightmass_DevOptions.StaticLightingProductionQuality_NumHemisphereSamplesScale=100"
      - "CONANEXILES_Lightmass_DevOptions.StaticLightingProductionQuality_NumDirectPhotonsScale=1"
      - "CONANEXILES_Lightmass_DevOptions.StaticLightingProductionQuality_NumIndirectPhotonsScale=1"
      - "CONANEXILES_Lightmass_DevOptions.StaticLightingProductionQuality_NumIndirectIrradiancePhotonsScale=1"
      - "CONANEXILES_Lightmass_DevOptions.StaticLightingProductionQuality_AdaptiveBrightnessThresholdScale=.01"
      - "CONANEXILES_Lightmass_DevOptions.ImportanceTracing_NumHemisphereSamples=256" 
    ports:
        - 7777:7777/udp
        - 7778:7778/udp
        - 27015:27015/udp
    volumes:
        - data:/conanexiles

volumes:
    data:

EOF
)")

echo "$file_string" > /home/ubuntu/conan/docker-compose.yml



file_string=$(echo -e "$(cat <<"EOF"
up:
\tsudo docker-compose up -d
down:
\tsudo docker-compose down
logs:
\tsudo docker-compose logs -f
EOF
)")

echo "$file_string" > /home/ubuntu/conan/makefile