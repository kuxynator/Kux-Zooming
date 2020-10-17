return {
    MaxWorldZoomInLevel = 10, -- not a game limt with player.zoom 
    MAX_MAP_ZOOM_IN_LEVEL = 1,
    MAX_MAP_ZOOM_OUT_LEVEL = 0.0001,
    BASE_GAME_PLAYER_ZOOM_SENSITIVITY = 1.1,
    BASE_GAME_ANY_MAP_ZOOM_SENSITIVITY = 1.25,
	MIN_MAP_ZOOM_LEVEL_WITH_LABELS_VISIBLE = 0.0157,
	BaseMapMaxZoomLevel = 3.051757813,
    BaseMapMinZoomLevel = 0.00333,
	BaseMapWorldThreshold = 0.4,
	
    positiveMapZoomLevels = {
        1.25,
        1.5625,
        1.953125,
        2.44140625,
        3.051757813, -- max (vanilla)
        3.814697266,
        4.768371582,
        5.960464478,
        7.450580597,
        9.313225746,
        11.64153218
    },
    negativeMapZoomLevels = {
        0.8,
        0.64,
        0.512,
        0.4096, -- threshold (vanilla)
        0.32768,
        0.262144,
        0.2097152,
        0.16777216,
        0.134217728,
        0.1073741824,
        0.08589934592,
        0.06871947674,
        0.05497558139,
        0.04398046511,
        0.03518437209,
        0.02814749767,
        0.02251799814,
        0.01801439851,
        0.01441151881,
        0.01152921505,
        0.009223372037,
        0.007378697629,
        0.005902958104,
        0.004722366483,
        0.003777893186, -- min (vanilla)
        0.003022314549,
        0.002417851639,
        0.001934281311,
        0.001547425049,
        0.001237940039,
        0.0009903520314,
        0.0007922816251,
        0.0006338253001,
        0.0005070602401,
        0.0004056481921,
        0.0003245185537,
        0.0002596148429,
        0.0002076918743,
        0.0001661534995,
        0.0001329227996,
        0.0001063382397
    }
}
