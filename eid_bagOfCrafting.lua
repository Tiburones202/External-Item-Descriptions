local pickupValues = {
  0x00000000, -- 0 None
  -- Hearts
  0x00000001, -- 1 Red heart
  0x00000004, -- 2 Soul Heart
  0x00000005, -- 3 Black Heart
  0x00000005, -- 4 Eternal Heart
  0x00000005, -- 5 Gold Heart
  0x00000005, -- 6 Bone Heart
  0x00000001, -- 7 Rotten Heart
  -- Pennies
  0x00000001, -- 8 Penny
  0x00000003, -- 9 Nickel
  0x00000005, -- 10 Dime
  0x00000008, -- 11 Lucky Penny
  -- Keys
  0x00000002, -- 12 Key
  0x00000005, -- 13 Golden Key
  0x00000005, -- 14 Charged Key
  -- Bombs
  0x00000002, -- 15 Bomb
  0x00000006, -- 16 Golden Bomb
  0x0000000a, -- 17 Giga Bomb
  -- Batteries
  0x00000002, -- 18 Micro Battery
  0x00000004, -- 19 Lil' Battery
  0x00000008, -- 20 Mega Battery
  -- Usables
  0x00000002, -- 21 Card
  0x00000002, -- 22 Pill
  0x00000004, -- 23 Rune
  0x00000004, -- 24 Dice Shard
  0x00000002, -- 25 Cracked Key
  0x00000001,
}
local pickupIDLookup = {
	["10.1"] = {1}, -- Red heart
	["10.2"] = {1}, -- half heart
	["10.3"] = {2}, -- soul heart
	["10.4"] = {4}, -- eternal heart
	["10.5"] = {1, 1}, -- double heart
	["10.6"] = {3}, -- black heart
	["10.7"] = {5}, -- gold heart
	["10.8"] = {2}, -- half soul heart
	["10.9"] = {1}, -- scared red heart
	["10.11"] = {6}, -- Bone heart
	["10.12"] = {7}, -- Rotten heart
	["20.1"] = {8}, -- Penny
	["20.2"] = {9}, -- Nickel
	["20.3"] = {10}, -- Dime
	["20.4"] = {8, 8}, -- Double penny
	["20.5"] = {11}, -- Lucky Penny
	["20.6"] = {9}, -- Sticky Nickel
	["20.7"] = {8}, -- Golden Penny
	["30.1"] = {12}, -- Key
	["30.2"] = {13}, -- golden Key
	["30.3"] = {12,12}, -- Key Ring
	["30.4"] = {14}, -- charged Key
	["40.1"] = {15}, -- bomb
	["40.2"] = {15,15}, -- double bomb
	["40.4"] = {16}, -- golden bomb
	["40.7"] = {15}, -- giga bomb
	["90.1"] = {19}, -- Lil Battery
	["90.2"] = {18}, -- Micro Battery
	["90.3"] = {20}, -- Mega Battery
	["90.4"] = {18}, -- Golden Battery
	["300.49"] = {24}, -- Dice shard
	["300.50"] = {21}, -- Emergency Contact
	["300.78"] = {25}, -- Cracked key
}

local componentShifts = {
    {0x00000001, 0x00000005, 0x00000010},
    {0x00000001, 0x00000005, 0x00000013},
    {0x00000001, 0x00000009, 0x0000001D},
    {0x00000001, 0x0000000B, 0x00000006},
    {0x00000001, 0x0000000B, 0x00000010},
    {0x00000001, 0x00000013, 0x00000003},
    {0x00000001, 0x00000015, 0x00000014},
    {0x00000001, 0x0000001B, 0x0000001B},
    {0x00000002, 0x00000005, 0x0000000F},
    {0x00000002, 0x00000005, 0x00000015},
    {0x00000002, 0x00000007, 0x00000007},
    {0x00000002, 0x00000007, 0x00000009},
    {0x00000002, 0x00000007, 0x00000019},
    {0x00000002, 0x00000009, 0x0000000F},
    {0x00000002, 0x0000000F, 0x00000011},
    {0x00000002, 0x0000000F, 0x00000019},
    {0x00000002, 0x00000015, 0x00000009},
    {0x00000003, 0x00000001, 0x0000000E},
    {0x00000003, 0x00000003, 0x0000001A},
    {0x00000003, 0x00000003, 0x0000001C},
    {0x00000003, 0x00000003, 0x0000001D},
    {0x00000003, 0x00000005, 0x00000014},
    {0x00000003, 0x00000005, 0x00000016},
    {0x00000003, 0x00000005, 0x00000019},
    {0x00000003, 0x00000007, 0x0000001D},
    {0x00000003, 0x0000000D, 0x00000007},
    {0x00000003, 0x00000017, 0x00000019},
    {0x00000003, 0x00000019, 0x00000018},
    {0x00000003, 0x0000001B, 0x0000000B},
    {0x00000004, 0x00000003, 0x00000011},
    {0x00000004, 0x00000003, 0x0000001B},
    {0x00000004, 0x00000005, 0x0000000F},
    {0x00000005, 0x00000003, 0x00000015},
    {0x00000005, 0x00000007, 0x00000016},
    {0x00000005, 0x00000009, 0x00000007},
    {0x00000005, 0x00000009, 0x0000001C},
    {0x00000005, 0x00000009, 0x0000001F},
    {0x00000005, 0x0000000D, 0x00000006},
    {0x00000005, 0x0000000F, 0x00000011},
    {0x00000005, 0x00000011, 0x0000000D},
    {0x00000005, 0x00000015, 0x0000000C},
    {0x00000005, 0x0000001B, 0x00000008},
    {0x00000005, 0x0000001B, 0x00000015},
    {0x00000005, 0x0000001B, 0x00000019},
    {0x00000005, 0x0000001B, 0x0000001C},
    {0x00000006, 0x00000001, 0x0000000B},
    {0x00000006, 0x00000003, 0x00000011},
    {0x00000006, 0x00000011, 0x00000009},
    {0x00000006, 0x00000015, 0x00000007},
    {0x00000006, 0x00000015, 0x0000000D},
    {0x00000007, 0x00000001, 0x00000009},
    {0x00000007, 0x00000001, 0x00000012},
    {0x00000007, 0x00000001, 0x00000019},
    {0x00000007, 0x0000000D, 0x00000019},
    {0x00000007, 0x00000011, 0x00000015},
    {0x00000007, 0x00000019, 0x0000000C},
    {0x00000007, 0x00000019, 0x00000014},
    {0x00000008, 0x00000007, 0x00000017},
    {0x00000008, 0x00000009, 0x00000017},
    {0x00000009, 0x00000005, 0x0000000E},
    {0x00000009, 0x00000005, 0x00000019},
    {0x00000009, 0x0000000B, 0x00000013},
    {0x00000009, 0x00000015, 0x00000010},
    {0x0000000A, 0x00000009, 0x00000015},
    {0x0000000A, 0x00000009, 0x00000019},
    {0x0000000B, 0x00000007, 0x0000000C},
    {0x0000000B, 0x00000007, 0x00000010},
    {0x0000000B, 0x00000011, 0x0000000D},
    {0x0000000B, 0x00000015, 0x0000000D},
    {0x0000000C, 0x00000009, 0x00000017},
    {0x0000000D, 0x00000003, 0x00000011},
    {0x0000000D, 0x00000003, 0x0000001B},
    {0x0000000D, 0x00000005, 0x00000013},
    {0x0000000D, 0x00000011, 0x0000000F},
    {0x0000000E, 0x00000001, 0x0000000F},
    {0x0000000E, 0x0000000D, 0x0000000F},
    {0x0000000F, 0x00000001, 0x0000001D},
    {0x00000011, 0x0000000F, 0x00000014},
    {0x00000011, 0x0000000F, 0x00000017},
    {0x00000011, 0x0000000F, 0x0000001A}
}

--These are recipes that are precalculated to improve performance
local calculatedRecipes = {
    ["1,2,3,6,13,18,24,24"] = 161,
    ["7,8,13,17,21,22,23,24"] = 218,
    ["1,1,5,7,11,14,19,19"] = 225,
    ["1,2,5,10,10,12,12,15"] = 237,
    ["1,2,2,9,14,14,22,25"] = 248,
    ["5,7,8,13,13,15,18,23"] = 266,
    ["1,4,4,6,8,9,16,25"] = 283,
    ["1,2,2,6,7,7,12,23"] = 295,
    ["1,1,1,2,7,7,8,22"] = 312,
    ["2,2,4,6,9,9,12,24"] = 321,
    ["9,10,10,15,18,18,21,25"] = 378,
    ["8,9,10,12,15,16,22,23"] = 395,
    ["5,8,9,14,14,18,22,24"] = 491,
    ["2,3,7,7,8,10,17,22"] = 498,
    ["7,7,7,16,17,18,25,25"] = 536,
    ["1,1,2,9,13,15,18,19"] = 541,
    ["1,16,20,20,21,21,22,25"] = 559,
    ["4,8,8,9,15,19,23,24"] = 559,
    ["4,4,8,13,23,23,23,23"] = 581,
    ["2,6,7,7,7,10,14,16"] = 583,
    ["2,2,6,9,14,21,21,24"] = 604,
    ["1,2,7,7,23,25,25,25"] = 608,
    ["4,5,10,14,18,18,22,22"] = 657,
    ["6,7,8,10,10,10,19,24"] = 663
}

local itempools ={
    {{1,1},{2,1},{3,1},{4,1},{5,1},{6,1},{7,1},{8,1},{10,1},{12,0.5},{13,1},{14,1},{15,1},{17,0.1},{19,1},{36,1},{37,1},{39,1},{40,1},{41,1},{42,1},{44,1},{45,1},{46,1},{47,1},{48,1},{49,1},{52,1},{53,1},{55,1},{56,1},{57,1},{58,1},{62,1},{65,1},{66,1},{67,1},{68,1},{69,1},{71,1},{72,1},{75,1},{76,1},{77,1},{78,1},{85,1},{86,1},{87,1},{88,1},{89,1},{91,1},{92,1},{93,1},{94,1},{95,1},{96,1},{97,1},{98,0.2},{99,1},{100,1},{101,0.5},{102,1},{103,1},{104,1},{105,1},{106,1},{107,1},{108,1},{109,1},{110,1},{111,1},{113,1},{114,0.2},{115,1},{117,1},{120,1},{121,1},{123,1},{124,1},{125,1},{127,1},{128,1},{129,1},{131,1},{136,1},{137,1},{138,1},{140,1},{142,1},{143,1},{144,1},{146,1},{148,1},{149,1},{150,1},{151,1},{152,1},{153,1},{154,1},{155,1},{157,1},{160,1},{161,1},{162,1},{163,1},{166,1},{167,1},{169,1},{170,1},{171,1},{172,1},{173,1},{174,1},{175,1},{176,1},{178,1},{180,1},{186,1},{188,1},{189,1},{190,0.1},{191,1},{192,1},{200,1},{201,1},{202,1},{206,1},{209,1},{210,1},{211,1},{213,1},{214,1},{217,1},{220,1},{221,1},{222,1},{223,0.1},{224,1},{225,1},{227,1},{228,1},{229,1},{231,1},{233,1},{234,1},{236,1},{237,0.2},{240,1},{242,1},{244,1},{245,1},{256,1},{257,1},{261,1},{264,1},{265,1},{266,1},{267,1},{268,1},{269,1},{270,1},{271,1},{272,1},{273,1},{274,1},{275,1},{276,1},{277,1},{278,1},{279,1},{280,1},{281,1},{282,1},{283,1},{284,1},{285,1},{287,1},{288,1},{291,1},{292,1},{294,1},{295,1},{298,1},{299,1},{300,1},{301,1},{302,1},{303,1},{304,1},{305,1},{306,1},{307,1},{308,1},{309,1},{310,1},{312,1},{313,0.2},{314,1},{315,1},{316,1},{317,1},{318,1},{319,1},{320,1},{321,1},{322,1},{323,1},{324,1},{325,1},{329,1},{330,1},{332,1},{333,0.2},{334,0.2},{335,0.2},{336,1},{350,1},{351,1},{352,1},{353,1},{358,1},{359,1},{361,1},{362,1},{364,1},{365,1},{366,1},{367,1},{368,1},{369,1},{371,1},{373,1},{374,0.2},{375,1},{377,1},{378,1},{379,1},{381,1},{382,1},{384,1},{385,1},{386,1},{388,1},{389,1},{390,1},{391,1},{392,1},{393,1},{394,1},{395,1},{397,1},{398,1},{401,1},{404,1},{405,1},{406,1},{407,1},{410,1},{411,1},{418,1},{419,1},{421,1},{422,1},{426,1},{427,1},{430,1},{431,1},{432,1},{435,1},{436,1},{437,1},{440,1},{443,1},{444,1},{445,1},{446,1},{447,1},{448,1},{449,1},{452,1},{453,1},{454,1},{457,1},{458,1},{459,1},{460,1},{461,1},{463,1},{465,1},{466,1},{467,1},{469,1},{470,1},{471,1},{473,1},{476,1},{478,1},{481,1},{482,1},{485,1},{488,1},{491,1},{492,1},{493,1},{494,1},{495,1},{496,1},{497,1},{502,1},{504,1},{506,1},{507,1},{508,1},{509,1},{511,1},{512,1},{513,1},{516,1},{517,1},{522,1},{524,1},{525,1},{529,1},{531,1},{532,1},{537,1},{539,1},{540,1},{542,1},{543,1},{544,1},{545,1},{548,1},{549,1},{553,1},{555,1},{557,1},{558,1},{559,1},{560,1},{561,1},{563,1},{565,1},{570,1},{575,1},{576,1},{578,1},{581,1},{583,1},{605,1},{607,1},{608,1},{609,0.5},{610,1},{611,1},{612,1},{614,1},{615,1},{616,1},{617,1},{618,1},{625,0.1},{629,1},{631,1},{635,1},{637,1},{639,1},{641,1},{645,1},{649,1},{650,0.5},{652,1},{655,1},{657,1},{658,1},{661,1},{663,1},{671,1},{675,1},{676,1},{677,0.2},{680,1},{681,1},{682,1},{683,1},{687,1},{690,1},{693,1},{695,1},{703,0.5},{709,1},{717,1},{720,1},{722,1},{723,0.1},{724,1},{725,1},{726,1},{727,1},{728,0.5},{729,1},}, -- treasure
    {{21,1},{33,1},{54,1},{60,1},{63,1},{64,1},{75,1},{85,1},{102,1},{116,1},{137,1},{139,1},{147,1},{156,1},{164,1},{177,1},{195,1},{199,1},{203,1},{204,1},{205,1},{208,1},{227,1},{232,1},{246,1},{247,1},{248,1},{249,1},{250,1},{251,1},{252,1},{260,1},{286,0.2},{289,1},{290,1},{295,1},{296,1},{297,1},{337,1},{338,1},{347,1},{348,1},{349,1},{356,1},{357,1},{372,1},{376,1},{380,1},{383,1},{396,1},{402,0.5},{403,1},{414,1},{416,1},{422,1},{424,0.5},{425,1},{434,1},{439,1},{451,1},{472,1},{475,0.2},{479,1},{480,1},{483,0.5},{485,0.5},{486,1},{487,1},{505,1},{514,1},{515,1},{518,1},{520,1},{521,1},{523,1},{527,1},{534,1},{535,1},{566,1},{585,1},{599,1},{602,1},{603,1},{604,1},{619,1},{621,1},{623,1},{624,1},{638,1},{642,0.1},{647,1},{660,0.5},{670,1},{716,1},{719,0.5},}, -- shop
    {{14,1},{22,1},{23,1},{24,1},{25,1},{26,1},{27,1},{28,1},{29,1},{30,1},{31,1},{32,1},{51,1},{70,1},{92,0.5},{141,1},{143,1},{165,1},{176,1},{183,1},{193,1},{194,1},{195,1},{196,1},{197,1},{198,1},{218,1},{219,1},{240,1},{253,1},{254,1},{255,1},{339,1},{340,1},{341,1},{342,1},{343,1},{344,1},{345,1},{346,1},{354,1},{355,1},{370,1},{428,0.5},{438,1},{455,1},{456,1},{538,1},{541,1},{547,1},{564,1},{600,1},{624,1},{644,1},{659,1},{707,1},{708,1},}, -- boss
    {{8,1},{34,1},{35,1},{51,1},{67,1},{74,1},{79,1},{80,1},{81,1},{82,1},{83,1},{84,1},{97,1},{109,1},{113,1},{114,1},{115,1},{118,1},{122,1},{123,1},{126,1},{127,0.2},{133,1},{134,1},{145,1},{157,1},{159,1},{163,1},{172,1},{187,1},{212,1},{215,1},{216,1},{225,1},{230,1},{237,1},{241,1},{259,1},{262,1},{268,1},{269,1},{275,1},{278,1},{292,1},{311,1},{360,1},{391,1},{399,1},{408,1},{409,1},{411,1},{412,1},{417,1},{420,1},{431,1},{433,1},{441,0.2},{442,1},{462,1},{468,1},{475,0.2},{477,0.5},{498,1},{519,1},{526,1},{530,1},{536,1},{545,1},{554,1},{556,1},{569,1},{572,1},{577,1},{606,1},{634,1},{646,1},{654,1},{665,1},{672,1},{679,1},{684,1},{692,1},{694,0.5},{695,1},{698,1},{699,1},{702,1},{704,0.5},{705,0.5},{706,0.5},{712,0.5},{728,1},}, -- devil
    {{7,1},{33,1},{72,1},{98,1},{101,1},{108,1},{112,1},{124,1},{142,1},{146,1},{156,1},{162,1},{173,1},{178,1},{182,1},{184,1},{185,1},{243,1},{313,1},{326,1},{331,1},{332,1},{333,1},{334,1},{335,1},{363,1},{374,1},{387,1},{390,1},{400,1},{413,1},{415,1},{423,1},{464,1},{477,0.5},{490,1},{498,1},{499,1},{510,0.4},{519,1},{526,1},{528,1},{533,1},{543,1},{567,1},{568,1},{573,1},{574,1},{579,1},{584,0.5},{586,1},{601,1},{622,1},{634,1},{640,1},{643,1},{651,1},{653,1},{685,1},{686,1},{691,0.5},{696,1},}, -- angel
    {{11,1},{16,1},{17,1},{20,1},{35,1},{84,1},{120,1},{121,1},{127,1},{168,1},{190,1},{213,1},{226,1},{242,1},{258,1},{262,1},{263,1},{271,1},{286,1},{287,1},{316,1},{321,1},{348,1},{388,1},{389,1},{402,1},{405,1},{424,1},{450,1},{489,1},{500,1},{501,1},{546,1},{562,1},{571,1},{580,1},{582,1},{609,1},{612,1},{625,1},{628,1},{632,1},{636,1},{664,1},{667,1},{669,1},{674,1},{675,1},{677,1},{688,1},{689,1},{691,0.5},{697,0.5},{700,1},{701,1},{703,1},{716,1},{717,1},{719,1},{721,1},{723,1},}, -- secret
    {{33,1},{34,1},{35,1},{58,1},{65,1},{78,1},{97,1},{123,1},{192,1},{282,1},{287,1},{292,1},{545,1},{584,0.2},{712,0.2},}, -- library
    {{9,1},{36,1},{209,1},{378,1},{504,1},{576,1},}, -- shellGame
    {{28,1},{29,1},{32,1},{74,1},{179,0.5},{194,1},{196,1},{255,1},{341,1},{343,1},{344,1},{354,1},{355,1},{370,1},{428,0.5},{438,1},{444,0.1},{455,1},{456,1},{534,0.5},{571,0.1},{644,1},{708,1},}, -- goldenChest
    {{81,1},{133,1},{134,1},{140,1},{145,1},{212,1},{297,1},{316,1},{371,1},{475,0.1},{565,0.5},{580,0.1},{642,1},{654,0.2},{665,1},}, -- redChest
    {{21,1},{22,1},{23,1},{24,1},{25,1},{26,1},{46,1},{54,1},{102,1},{111,1},{144,1},{177,1},{180,1},{195,1},{198,1},{204,1},{246,1},{271,1},{294,1},{362,1},{376,1},{385,1},{447,1},{455,1},{456,1},{485,1},{707,1},}, -- beggar
    {{13,1},{14,1},{51,1},{70,1},{79,1},{80,1},{82,0.2},{83,1},{87,1},{102,1},{122,1},{126,1},{127,0.5},{143,1},{159,0.2},{195,1},{216,1},{225,1},{230,0.2},{240,1},{241,1},{259,1},{262,1},{278,1},{340,1},{345,1},{409,1},{420,1},{475,0.2},{487,1},{493,1},{496,1},{503,1},{672,0.5},{676,1},}, -- demonBeggar
    {{51,1},{79,1},{80,1},{81,1},{133,1},{134,1},{145,1},{212,1},{215,1},{216,1},{225,1},{241,1},{260,1},{371,1},{408,1},{442,1},{451,1},{468,1},{475,0.2},{496,1},{503,1},{508,1},{536,1},{565,1},{569,1},{580,1},{642,1},{654,0.5},{692,1},{694,0.5},{697,0.5},{702,1},}, -- curse
    {{10,1},{57,1},{128,1},{175,1},{199,1},{264,1},{272,1},{279,1},{320,1},{343,1},{364,1},{365,1},{388,1},{426,1},{430,1},{492,1},{527,1},{580,1},{581,1},{629,1},{649,1},{693,1},}, -- keyMaster
    {{63,1},{116,1},{205,1},{356,1},{372,1},{494,0.1},{520,1},{559,0.1},{603,1},{647,1},}, -- batteryBum
    {{29,1},{30,1},{31,1},{39,1},{41,1},{55,1},{102,1},{110,1},{114,0.1},{139,1},{195,1},{199,1},{200,1},{217,1},{228,1},{355,1},{439,1},{508,1},{580,0.5},}, -- momsChest
    {{1,1},{2,1},{3,1},{4,1},{5,1},{6,1},{7,1},{8,1},{10,1},{12,0.5},{13,1},{34,1},{35,1},{37,1},{38,1},{42,1},{45,1},{47,1},{48,1},{50,1},{52,1},{55,1},{56,1},{57,1},{62,1},{64,1},{65,1},{67,1},{68,1},{69,1},{73,1},{77,1},{78,1},{85,1},{87,1},{88,1},{89,1},{93,1},{94,1},{95,1},{96,1},{97,1},{98,0.2},{99,1},{100,1},{101,0.5},{102,1},{103,1},{104,1},{106,1},{107,1},{108,1},{110,1},{111,1},{114,0.2},{115,1},{117,1},{120,1},{124,1},{125,1},{128,1},{131,1},{132,1},{137,1},{138,1},{140,1},{142,1},{146,1},{148,1},{149,1},{150,1},{151,1},{152,1},{153,1},{154,1},{155,1},{157,1},{161,1},{162,1},{163,1},{167,1},{169,1},{170,1},{172,1},{174,1},{175,1},{186,1},{188,1},{189,1},{191,1},{192,1},{200,1},{201,1},{206,1},{209,1},{210,1},{213,1},{214,1},{217,1},{220,1},{221,1},{222,1},{223,1},{224,1},{226,1},{228,1},{229,1},{231,1},{233,1},{234,1},{236,1},{237,0.2},{242,1},{244,1},{245,1},{254,1},{256,1},{257,1},{258,0.1},{261,1},{264,1},{265,1},{266,1},{267,1},{268,1},{269,1},{271,1},{273,1},{274,1},{277,1},{279,1},{280,1},{281,1},{288,1},{291,1},{299,1},{300,1},{301,1},{302,1},{303,1},{305,1},{306,1},{307,1},{308,1},{309,1},{310,1},{312,1},{315,1},{316,1},{317,1},{318,1},{319,1},{320,1},{321,1},{322,1},{325,1},{329,1},{330,1},{332,1},{333,0.2},{334,0.2},{335,0.2},{336,1},{349,1},{351,1},{352,1},{353,1},{357,1},{358,1},{359,1},{362,1},{364,1},{365,1},{366,1},{367,1},{368,1},{369,1},{371,1},{373,1},{374,0.2},{375,1},{377,1},{378,1},{379,1},{380,1},{382,1},{383,1},{384,1},{389,1},{391,1},{392,1},{393,1},{394,1},{395,1},{397,1},{398,1},{401,1},{407,1},{410,1},{411,1},{416,1},{421,1},{425,1},{426,1},{430,1},{431,1},{432,1},{434,1},{436,1},{440,1},{443,1},{444,1},{445,1},{446,1},{447,1},{448,1},{449,1},{450,1},{452,1},{453,1},{454,1},{457,1},{458,1},{459,1},{460,1},{461,1},{463,1},{465,1},{466,1},{467,1},{469,1},{470,1},{471,1},{473,1},{493,1},{494,1},{495,1},{496,1},{497,1},{502,1},{503,1},{504,1},{506,1},{507,1},{508,1},{509,1},{511,1},{512,1},{513,1},{514,1},{515,1},{516,1},{517,1},{518,1},{520,1},{522,1},{524,1},{525,1},{529,1},{531,1},{532,1},{537,1},{539,1},{540,1},{542,1},{543,1},{544,1},{545,1},{548,1},{549,1},{553,1},{555,1},{557,1},{558,1},{559,1},{560,1},{561,1},{563,1},{565,1},{570,1},{575,1},{576,1},{578,1},{581,1},{583,1},{605,1},{607,1},{608,1},{609,0.5},{610,1},{611,1},{612,1},{614,1},{615,1},{616,1},{617,1},{618,1},{625,0.5},{629,1},{631,1},{635,1},{637,1},{639,1},{641,1},{645,1},{649,1},{650,0.5},{652,1},{655,1},{657,1},{658,1},{661,1},{663,1},{671,1},{675,1},{676,1},{677,0.5},{680,1},{681,1},{682,1},{683,1},{687,1},{690,1},{693,1},{695,1},{703,0.5},{709,1},{716,0.2},{717,0.2},{719,0.2},{720,1},{721,0.1},{722,0.1},{723,0.1},{724,1},{725,1},{726,1},{727,1},{728,0.5},{729,1},}, -- greedTreasure
    {{12,0.2},{14,1},{15,1},{16,1},{22,1},{23,1},{24,1},{25,1},{26,1},{27,1},{28,1},{29,1},{30,1},{31,1},{32,1},{70,1},{71,1},{73,1},{101,0.5},{120,1},{132,1},{143,1},{176,1},{183,1},{193,1},{194,1},{195,1},{196,1},{197,1},{198,1},{199,1},{240,1},{253,1},{254,1},{255,1},{314,1},{339,1},{340,1},{341,1},{342,1},{343,1},{344,1},{345,1},{346,1},{354,1},{355,1},{370,1},{428,0.5},{438,1},{455,1},{456,1},{538,1},{541,1},{547,1},{564,1},{600,1},{624,1},{644,1},{659,1},{707,1},{708,1},}, -- greedBoss
    {{11,0.1},{46,1},{63,1},{73,1},{75,1},{76,1},{84,1},{91,1},{105,1},{116,1},{139,1},{156,1},{166,1},{204,1},{208,1},{246,1},{247,1},{248,1},{251,1},{252,1},{260,1},{283,1},{284,1},{285,1},{286,0.2},{289,1},{297,1},{348,1},{356,1},{372,1},{380,1},{386,1},{402,0.5},{403,1},{405,1},{406,1},{416,1},{434,1},{439,1},{451,1},{472,1},{475,0.2},{476,1},{477,1},{478,1},{481,1},{482,1},{483,0.5},{485,0.5},{486,1},{487,1},{488,1},{489,1},{500,1},{505,1},{512,1},{515,1},{516,1},{518,1},{527,1},{534,1},{535,1},{566,1},{585,1},{603,1},{604,1},{619,1},{621,1},{623,1},{624,1},{636,0.1},{638,1},{647,1},{667,0.1},{674,0.1},{688,0.1},{689,0.1},{691,0.1},{692,1},{700,0.1},{701,0.1},{703,0.1},{721,0.1},{722,0.1},{723,0.1},}, -- greedShop
    {{73,1},{81,1},{133,1},{134,1},{145,1},{212,1},}, -- greedCurse
    {{34,1},{35,1},{51,1},{67,1},{68,0.2},{73,1},{74,1},{79,1},{80,1},{81,1},{82,1},{83,1},{97,1},{109,1},{113,1},{114,1},{115,1},{117,1},{118,1},{122,1},{123,1},{132,1},{133,1},{134,1},{145,1},{157,1},{159,1},{172,1},{187,1},{212,1},{216,1},{225,1},{230,1},{237,1},{259,1},{268,1},{269,1},{270,1},{292,1},{311,1},{360,1},{391,1},{399,1},{408,1},{409,1},{411,1},{412,1},{420,1},{431,1},{433,1},{441,0.2},{442,1},{451,1},{462,1},{468,1},{503,1},{519,1},{526,1},{530,1},{536,1},{545,1},{554,1},{556,1},{569,1},{572,1},{577,1},{606,1},{634,1},{646,1},{654,1},{665,1},{679,1},{684,1},{692,1},{694,0.5},{695,1},{698,1},{699,1},{702,1},{704,0.5},{705,0.5},{706,0.5},{712,0.5},{728,1},}, -- greedDevil
    {{7,1},{72,1},{73,1},{78,1},{112,1},{138,1},{162,1},{173,1},{178,1},{182,1},{184,1},{185,1},{197,1},{243,1},{313,1},{331,1},{333,1},{334,1},{335,1},{363,1},{387,1},{390,1},{400,1},{407,1},{413,1},{415,1},{423,1},{464,1},{490,1},{499,1},{526,1},{528,1},{533,1},{567,1},{568,1},{573,1},{574,1},{579,1},{584,0.5},{586,1},{601,1},{622,1},{634,1},{640,1},{643,1},{651,1},{653,1},{685,1},{686,1},{691,0.5},{696,1},}, -- greedAngel
    {{73,1},}, -- greedSecret
    {{1,1},{3,1},{4,1},{5,1},{21,1},{32,1},{38,1},{44,1},{46,1},{47,1},{48,1},{49,1},{51,1},{63,1},{66,1},{68,1},{77,1},{85,1},{89,1},{90,1},{91,1},{93,1},{95,1},{102,1},{105,1},{116,1},{136,1},{137,1},{147,1},{152,1},{153,1},{166,1},{189,1},{194,1},{196,1},{208,1},{212,1},{227,1},{232,1},{244,1},{251,1},{255,1},{263,1},{267,1},{283,1},{284,1},{285,1},{337,1},{338,1},{352,1},{357,1},{362,1},{370,1},{382,1},{383,1},{386,1},{395,1},{397,1},{403,1},{406,1},{419,1},{422,1},{425,1},{427,1},{437,1},{438,1},{439,1},{444,1},{451,1},{465,1},{476,1},{478,1},{488,1},{494,1},{505,1},{515,1},{516,1},{518,1},{524,1},{527,1},{538,1},{599,1},{604,1},{609,1},{617,1},{624,1},{629,1},{638,1},{644,1},{649,1},{655,1},{687,1},{709,1},{720,1},{723,1},}, -- craneGame
    {{1,1},}, -- unused24
    {{37,1},{106,1},{125,1},{137,1},{140,1},{190,0.2},{209,1},{220,1},{256,1},{353,0.2},{366,1},{367,1},{432,1},{483,1},{517,1},{563,1},{583,1},{614,1},{646,0.2},{727,1},}, -- bombBum
    {{588,1},{589,1},{590,1},{591,1},{592,1},{593,1},{594,1},{595,1},{596,1},{597,1},{598,1},}, -- planetarium
    {{29,1},{30,1},{31,1},{39,1},{41,1},{55,1},{102,1},{110,1},{114,0.2},{139,1},{175,1},{195,1},{199,1},{200,1},{217,1},{228,1},{341,1},{355,1},{439,1},{455,1},{508,1},{546,0.2},{547,1},{604,1},}, -- oldChest
    {{8,1},{10,1},{57,1},{67,1},{73,1},{88,1},{95,1},{96,1},{99,1},{100,1},{112,1},{113,1},{117,1},{128,1},{144,1},{155,1},{163,1},{167,1},{170,1},{172,1},{174,1},{188,1},{207,1},{264,1},{265,1},{266,1},{267,1},{268,1},{269,1},{270,1},{272,1},{273,1},{274,1},{275,1},{277,1},{278,1},{279,1},{280,1},{281,1},{320,1},{322,1},{360,1},{361,1},{363,1},{364,1},{365,1},{372,1},{384,1},{385,1},{388,1},{390,1},{403,1},{404,1},{417,1},{426,1},{430,1},{435,1},{468,1},{470,1},{471,1},{472,1},{473,1},{491,1},{492,1},{509,1},{511,1},{518,1},{519,1},{537,1},{575,1},{581,1},{607,1},{608,1},{610,1},{612,1},{615,1},{629,1},{635,1},{645,1},{649,1},{661,1},{679,1},{682,1},{698,1},}, -- babyShop
    {{7,1},{27,1},{60,1},{138,1},{183,1},{349,1},{362,1},{439,1},{488,1},{527,1},{719,1},}, -- woodenChest
    {{26,1},{42,1},{140,1},{268,1},{273,1},{336,0.5},{480,1},{618,0.5},{639,1},}, -- rottenBeggar
}

EID.itemWeightsLookup= {
 [1]=3, [2]=2, [3]=3, [4]=4, [5]=0, [6]=2, [7]=3, [8]=0, [9]=0, [10]=3, [11]=2, [12]=4, [13]=0, [14]=2, [15]=2, [16]=2, [17]=3, [18]=2, [19]=0, [20]=3, [21]=2, [22]=1, [23]=1, 
 [24]=1, [25]=1, [26]=1, [27]=1, [28]=2, [29]=1, [30]=1, [31]=1, [32]=3, [33]=1, [34]=3, [35]=1, [36]=0, [37]=1, [38]=3, [39]=1, [40]=0, [41]=0, [42]=1, [44]=0, [45]=1, [46]=2,
 [47]=1, [48]=3, [49]=1, [50]=3, [51]=3, [52]=4, [53]=1, [54]=2, [55]=1, [56]=1, [57]=2, [58]=2, [60]=1, [62]=0, [63]=2, [64]=2, [65]=1, [66]=1, [67]=0, [68]=3, [69]=3, [70]=3, 
 [71]=2, [72]=1, [73]=2, [74]=2, [75]=2, [76]=2, [77]=1, [78]=3, [79]=3, [80]=3, [81]=3, [82]=3, [83]=3, [84]=0, [85]=1, [86]=1, [87]=1, [88]=1, [89]=2, [90]=3, [91]=2, [92]=2, 
 [93]=2, [94]=1, [95]=1, [96]=2, [97]=2, [98]=4, [99]=2, [100]=1, [101]=2, [102]=1, [103]=1, [104]=2, [105]=4, [106]=2, [107]=3, [108]=4, [109]=3, [110]=3, [111]=0, [112]=2, 
 [113]=2, [114]=4, [115]=2, [116]=2, [117]=0, [118]=4, [119]=2, [120]=3, [121]=2, [122]=2, [123]=0, [124]=1, [125]=2, [126]=0, [127]=3, [128]=1, [129]=1, [130]=2, [131]=2, 
 [132]=3, [133]=3, [134]=2, [135]=1, [136]=1, [137]=1, [138]=2, [139]=3, [140]=1, [141]=0, [142]=2, [143]=2, [144]=0, [145]=3, [146]=3, [147]=0, [148]=0, [149]=4, [150]=3, 
 [151]=3, [152]=2, [153]=3, [154]=1, [155]=0, [156]=3, [157]=3, [158]=2, [159]=3, [160]=2, [161]=2, [162]=1, [163]=1, [164]=2, [165]=3, [166]=2, [167]=1, [168]=4, [169]=4, 
 [170]=3, [171]=1, [172]=3, [173]=3, [174]=1, [175]=1, [176]=1, [177]=0, [178]=0, [179]=3, [180]=0, [181]=2, [182]=4, [183]=3, [184]=3, [185]=3, [186]=0, [187]=1, [188]=0, 
 [189]=3, [190]=3, [191]=2, [192]=0, [193]=2, [194]=1, [195]=1, [196]=3, [197]=2, [198]=1, [199]=3, [200]=1, [201]=3, [202]=2, [203]=3, [204]=1, [205]=1, [206]=3, [207]=2, 
 [208]=3, [209]=2, [210]=1, [211]=1, [212]=2, [213]=2, [214]=0, [215]=3, [216]=3, [217]=3, [218]=2, [219]=2, [220]=3, [221]=3, [222]=3, [223]=4, [224]=3, [225]=2, [226]=2, 
 [227]=1, [228]=2, [229]=2, [230]=4, [231]=2, [232]=4, [233]=0, [234]=4, [236]=1, [237]=3, [238]=0, [239]=0, [240]=1, [241]=3, [242]=2, [243]=3, [244]=3, [245]=4, [246]=2, 
 [247]=2, [248]=2, [249]=3, [250]=1, [251]=2, [252]=1, [253]=2, [254]=2, [255]=3, [256]=1, [257]=2, [258]=2, [259]=3, [260]=3, [261]=4, [262]=0, [263]=2, [264]=3, [265]=3, 
 [266]=2, [267]=0, [268]=3, [269]=1, [270]=1, [271]=2, [272]=1, [273]=1, [274]=0, [275]=3, [276]=0, [277]=1, [278]=4, [279]=2, [280]=1, [281]=1, [282]=1, [283]=3, [284]=3, 
 [285]=0, [286]=2, [287]=0, [288]=1, [289]=2, [290]=0, [291]=1, [292]=4, [293]=2, [294]=0, [295]=1, [296]=1, [297]=2, [298]=1, [299]=1, [300]=1, [301]=3, [302]=1, [303]=2, 
 [304]=1, [305]=2, [306]=3, [307]=3, [308]=0, [309]=2, [310]=1, [311]=4, [312]=2, [313]=4, [314]=1, [315]=0, [316]=0, [317]=1, [318]=1, [319]=0, [320]=2, [321]=1, [322]=2, 
 [323]=0, [324]=2, [325]=0, [326]=0, [327]=2, [328]=1, [329]=3, [330]=2, [331]=4, [332]=1, [333]=3, [334]=3, [335]=3, [336]=3, [337]=1, [338]=1, [339]=1, [340]=1, [341]=3, 
 [342]=3, [343]=2, [344]=1, [345]=3, [346]=1, [347]=3, [348]=2, [349]=1, [350]=3, [351]=1, [352]=1, [353]=2, [354]=2, [355]=2, [356]=3, [357]=1, [358]=1, [359]=3, [360]=4, 
 [361]=2, [362]=2, [363]=3, [364]=1, [365]=0, [366]=1, [367]=1, [368]=1, [369]=2, [370]=3, [371]=1, [372]=3, [373]=3, [374]=3, [375]=3, [376]=3, [377]=1, [378]=2, [379]=2, 
 [380]=2, [381]=3, [382]=1, [383]=1, [384]=1, [385]=1, [386]=0, [387]=3, [388]=0, [389]=3, [390]=3, [391]=0, [392]=1, [393]=4, [394]=0, [395]=4, [396]=1, [397]=2, [398]=1, 
 [399]=4, [400]=1, [401]=1, [402]=3, [403]=1, [404]=1, [405]=0, [406]=2, [407]=2, [408]=2, [409]=2, [410]=2, [411]=3, [412]=2, [413]=1, [414]=3, [415]=4, [416]=2, [417]=3, 
 [418]=2, [419]=2, [420]=1, [421]=0, [422]=1, [423]=1, [424]=3, [425]=2, [426]=0, [427]=1, [428]=2, [429]=2, [430]=1, [431]=1, [432]=2, [433]=0, [434]=2, [435]=1, [436]=1, 
 [437]=1, [438]=3, [439]=3, [440]=1, [441]=4, [442]=1, [443]=3, [444]=3, [445]=1, [446]=1, [447]=0, [448]=0, [449]=1, [450]=2, [451]=3, [452]=2, [453]=2, [454]=2, [455]=2, 
 [456]=1, [457]=2, [458]=3, [459]=3, [460]=2, [461]=3, [462]=3, [463]=2, [464]=1, [465]=2, [466]=2, [467]=1, [468]=0, [469]=1, [470]=0, [471]=2, [472]=0, [473]=1, [474]=0, 
 [475]=0, [476]=2, [477]=4, [478]=1, [479]=3, [480]=2, [481]=0, [482]=0, [483]=3, [484]=0, [485]=1, [486]=1, [487]=3, [488]=0, [489]=1, [490]=3, [491]=2, [492]=2, [493]=1, 
 [494]=2, [495]=2, [496]=3, [497]=0, [498]=1, [499]=3, [500]=3, [501]=1, [502]=1, [503]=3, [504]=0, [505]=0, [506]=1, [507]=2, [508]=1, [509]=1, [510]=1, [511]=1, [512]=1, 
 [513]=2, [514]=1, [515]=3, [516]=2, [517]=1, [518]=2, [519]=2, [520]=3, [521]=2, [522]=1, [523]=1, [524]=3, [525]=1, [526]=2, [527]=3, [528]=3, [529]=2, [530]=2, [531]=2, 
 [532]=2, [533]=2, [534]=3, [535]=1, [536]=2, [537]=1, [538]=2, [539]=1, [540]=2, [541]=1, [542]=2, [543]=1, [544]=2, [545]=2, [546]=3, [547]=2, [548]=1, [549]=3, [550]=4, 
 [551]=4, [552]=4, [553]=3, [554]=2, [555]=2, [556]=2, [557]=2, [558]=2, [559]=3, [560]=1, [561]=1, [562]=2, [563]=1, [564]=3, [565]=2, [566]=2, [567]=3, [568]=2, [569]=2, 
 [570]=3, [571]=1, [572]=3, [573]=3, [574]=2, [575]=3, [576]=2, [577]=2, [578]=2, [579]=3, [580]=3, [581]=3, [582]=1, [583]=2, [584]=3, [585]=2, [586]=3, [588]=2, [589]=2, 
 [590]=3, [591]=1, [592]=3, [593]=2, [594]=3, [595]=1, [596]=3, [597]=3, [598]=3, [599]=1, [600]=3, [601]=3, [602]=1, [603]=1, [604]=2, [605]=0, [606]=3, [607]=1, [608]=2, 
 [609]=2, [610]=1, [611]=2, [612]=2, [614]=1, [615]=0, [616]=2, [617]=3, [618]=1, [619]=2, [621]=0, [622]=2, [623]=1, [624]=1, [625]=4, [626]=0, [627]=0, [628]=4, [629]=3, 
 [631]=1, [632]=1, [633]=0, [634]=2, [635]=1, [636]=4, [637]=3, [638]=2, [639]=3, [640]=3, [641]=2, [642]=2, [643]=4, [644]=1, [645]=1, [646]=3, [647]=2, [649]=1, [650]=2, 
 [651]=2, [652]=1, [653]=3, [654]=2, [655]=1, [656]=2, [657]=2, [658]=1, [659]=1, [660]=3, [661]=1, [663]=2, [664]=3, [665]=2, [667]=2, [668]=0, [669]=3, [670]=2, [671]=2, 
 [672]=1, [673]=2, [674]=3, [675]=1, [676]=2, [677]=2, [678]=4, [679]=3, [680]=3, [681]=1, [682]=2, [683]=2, [684]=3, [685]=2, [686]=2, [687]=3, [688]=3, [689]=4, [690]=2, 
 [691]=4, [692]=1, [693]=2, [694]=3, [695]=3, [696]=2, [697]=3, [698]=4, [699]=3, [700]=2, [701]=3, [702]=2, [703]=2, [704]=3, [705]=2, [706]=4, [707]=1, [708]=3, [709]=3, 
 [710]=3, [711]=3, [712]=3, [713]=3, [714]=0, [715]=0, [716]=3, [717]=2, [719]=3, [720]=2, [721]=2, [722]=2, [723]=4, [724]=3, [725]=2, [726]=3, [727]=2, [728]=2, [729]=2,
}

local customRNGSeed = 0x77777770
local customRNGShift = {0,0,0}

local function RNGNext()
    local num = customRNGSeed
    num = num ~ ((num >> customRNGShift[1]) & 4294967295)
    num = num ~ ((num << customRNGShift[2]) & 4294967295)
    num = num ~ ((num >> customRNGShift[3]) & 4294967295)
    customRNGSeed = num >> 0;
    return customRNGSeed;
end

local function nextFloat()
    local multi = 2.3283061589829401E-10;
    return RNGNext() * multi;
end

function EID:getBagOfCraftingID(Variant, SubType)
	local entry = pickupIDLookup[""..Variant.."."..SubType]
	if entry ~= nil then
		return entry
	elseif Variant == 300 then
		if SubType > 80 or (SubType >= 32 and SubType <= 41) or SubType == 55 then -- runes
			return {23}
		else -- cards
			return {21}
		end 
	elseif Variant == 70 then -- pills
		return {22}
	end
	return nil
end

function EID:calculateBagOfCrafting(components)
    if components == nil or #components ~= 8 then
        return 0
    end
	customRNGSeed = 0x77777770
    table.sort(components)

    local cacheResult = calculatedRecipes[table.concat(components, ",")]
    if cacheResult ~= nil then
        return cacheResult
    end
    local compTotalWeight = 0
    local compCounts = {}
    for i = 1, #componentShifts do
        compCounts[i] = 0
    end
    for _, compId in ipairs(components) do
        compCounts[compId + 1] = compCounts[compId + 1] + 1
        compTotalWeight = compTotalWeight + pickupValues[compId + 1]
        customRNGShift = componentShifts[compId + 1]
        RNGNext()
    end
    customRNGShift = componentShifts[7]
    local poolWeights = {
        {idx = 0, weight = 1},
        {idx = 1, weight = 2},
        {idx = 2, weight = 2},
        {idx = 3, weight = compCounts[4] * 10},
        {idx = 4, weight = compCounts[5] * 10},
        {idx = 5, weight = compCounts[7] * 5},
        {idx = 8, weight = compCounts[6] * 10},
        {idx = 9, weight = compCounts[26] * 10},
        {idx = 12, weight = compCounts[8] * 10},
    }
    if compCounts[9] + compCounts[2] + compCounts[13] + compCounts[16] == 0 then
        table.insert(poolWeights, {idx = 26, weight = compCounts[24] * 10})
    end

    local totalWeight = 0

    local itemWeights = {}

    local maxItemID = 729
    for i = 1, maxItemID do
        itemWeights[i] = 0
    end

    for _, poolWeight in ipairs(poolWeights) do
        if poolWeight.weight > 0 then
            local qualityMin = 0
            local qualityMax = 1
            local n = compTotalWeight
            if (poolWeight.idx >= 3) and (poolWeight.idx <= 5) then
                n = n - 5
            end
            if n > 34 then
                qualityMin = 4
                qualityMax = 4
            elseif n > 30 then
                qualityMin = 3
                qualityMax = 4
            elseif n > 26 then
                qualityMin = 2
                qualityMax = 4
            elseif n > 22 then
                qualityMin = 1
                qualityMax = 4
            elseif n > 18 then
                qualityMin = 1
                qualityMax = 3
            elseif n > 14 then
                qualityMin = 1
                qualityMax = 2
            elseif n > 8 then
                qualityMin = 0
                qualityMax = 2
            end
            local pool = itempools[poolWeight.idx + 1]
			
            for _, item in ipairs(pool) do
				local quality = EID.itemWeightsLookup[item[1]]
				if quality >= qualityMin and quality <= qualityMax  then
					local w = item[2] * poolWeight.weight
					itemWeights[item[1]] = itemWeights[item[1]] + w
					totalWeight = totalWeight + w
				end
            end
        end
    end
    if totalWeight <= 0 then
        return 25
    end
	local t = nextFloat()
    local target = t * totalWeight
	for k,v in pairs(itemWeights) do
		target = target - v
		if target < 0 then
            calculatedRecipes[table.concat(components, ",")] = k
			return k
		end
	end
    return 25
end

------------------------------------------
------------------------------------------
-----------Bag content detection ---------
------------------------------------------
------------------------------------------


local pickupsOnInit = {}

EID:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, function(_, pickup,collider,_)
	if collider.Type ~= EntityType.ENTITY_PLAYER then
		return
	end
	-- Remove pickups picked up normally
	local pickupsOnInitCorrected = {}
	for _,e in ipairs (pickupsOnInit) do
		if GetPtrHash(pickup) ~= GetPtrHash(e) then
			table.insert(pickupsOnInitCorrected, e)
		end
	end
	pickupsOnInit = pickupsOnInitCorrected
end)

EID:AddCallback(ModCallbacks.MC_POST_KNIFE_INIT, function(_, entity)
	if entity.Variant ~= 4 then
		return
	end
	pickupsOnInit = {}
	for _,e in ipairs (Isaac.FindByType(EntityType.ENTITY_PICKUP, -1, -1, false, false)) do
		if e:GetSprite():GetAnimation() ~= "Collect" then
			table.insert(pickupsOnInit, e)
		end
	end
end, 4)

EID:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, bag)
	if bag.Variant ~= 4 or bag.SubType ~= 4 then
		return
	end
	for _,e in ipairs (pickupsOnInit) do
		if e:GetSprite():GetAnimation() == "Collect" then
			local craftingIDs = EID:getBagOfCraftingID(e.Variant, e.SubType)
			if craftingIDs ~= nil then
				for _,v in ipairs(craftingIDs) do
					if #EID.BagItems >= 8 then
						table.remove(EID.BagItems, 1)
					end
					table.insert(EID.BagItems, v)
				end
			end
		end
	end
end, EntityType.ENTITY_KNIFE)

local holdCounter = 0
local function trackBagHolding()
	local isCardHold = Input.IsActionPressed(ButtonAction.ACTION_PILLCARD, 0)
	if isCardHold and string.match(Isaac.GetPlayer(0):GetSprite():GetAnimation(), "PickupWalk") and #EID.BagItems>=8 then
		holdCounter = holdCounter + 1
		if holdCounter >= 55 then
			EID.BagItems = {}
		end
	else
		holdCounter = 0
	end
end

local function shiftBagContent()
	local newContent = {}
	for i=2,#EID.BagItems do
		table.insert(newContent, EID.BagItems[i])
	end
	table.insert(newContent, EID.BagItems[1])
	EID.BagItems = newContent
end

local function detectBagContentShift()
	if Input.IsActionTriggered(ButtonAction.ACTION_DROP, 0) or  Input.IsActionTriggered(ButtonAction.ACTION_DROP, 1) then
		shiftBagContent()
	end
end

-----------------------------
-----------------------------
-----------RENDERING---------
-----------------------------
-----------------------------

local randResultCache = {}

EID.bagOfCraftingOffset = 0
EID.bagOfCraftingCurPickupCount = -1
EID.bagOfCraftingLastQuery = {}
EID.BagItems = {}


function EID:handleBagOfCraftingRendering()
	trackBagHolding()
	detectBagContentShift()
	local results = {}
	local floorItems = {}
	local pickups = Isaac.FindByType(5, -1, -1, true, false)
	if EID.bagOfCraftingCurPickupCount ~= #pickups then 
		for i, entity in ipairs(pickups) do
			local craftingIDs = EID:getBagOfCraftingID(entity.Variant, entity.SubType)
			if craftingIDs ~= nil then
				for _,v in ipairs(craftingIDs) do
					table.insert(floorItems, v)
				end
			end
		end
		EID.bagOfCraftingLastQuery = floorItems
		EID.bagOfCraftingCurPickupCount = #pickups
	else
		floorItems = EID.bagOfCraftingLastQuery
	end
	
	local itemQuery = {}
	for i, v in ipairs(floorItems) do
		table.insert(itemQuery, v)
	end
	
	for i, v in ipairs(EID.BagItems) do
		table.insert(itemQuery, v)
	end
	-- Calculate result from pickups on floor
	if #itemQuery < 8 then
		return false
	end
	table.sort(itemQuery, function(a, b) return a > b end)
	
	local queryString = table.concat(itemQuery,",")
	if randResultCache[queryString] == nil then
		local randResults = {}
		for i = 0, 250 do
			local newTable = {}
			local tableCopy = {table.unpack(itemQuery)}
			for k = 1, 8 do
				local pos = math.random(1, #tableCopy)
				table.insert(newTable, tableCopy[pos])
				table.remove(tableCopy, pos)
			end
			table.sort(newTable, function(a, b) return a > b end)
			randResults[table.concat(newTable,",")] = newTable
		end
		local calcResults = {}
		for k, v in pairs(randResults) do
			local resultID = EID:calculateBagOfCrafting(v)
			if resultID > 0 then
				table.insert(calcResults, {v, resultID})
			end
		end
		randResultCache[queryString] = calcResults
		results = calcResults
		EID.bagOfCraftingOffset = 0
	else
		results = randResultCache[queryString]
	end
	
	if #results == 0 then
		EID.bagOfCraftingOffset = 0
		return false
	end
	
	local customDescObj = EID:getDescriptionObj(5, 100, 710)
	local roomDesc = EID.descriptions[EID.Config["Language"]].CraftingRoomContent or EID.descriptions["en_us"].CraftingRoomContent
	local bagContentDesc = EID.descriptions[EID.Config["Language"]].CraftingBagContent or EID.descriptions["en_us"].CraftingBagContent
	local resultDesc = EID.descriptions[EID.Config["Language"]].CraftingResults or EID.descriptions["en_us"].CraftingResults
	customDescObj.Description = bagContentDesc.."#"..EID:tableToCraftingIconsMerged(EID.BagItems).."#"
	customDescObj.Description = customDescObj.Description ..roomDesc.."#"..EID:tableToCraftingIconsMerged(floorItems).."#"..resultDesc
	
	if Input.IsActionPressed(ButtonAction.ACTION_MAP, 0) or Input.IsActionPressed(ButtonAction.ACTION_MAP, 1) then
		if Input.IsActionTriggered(ButtonAction.ACTION_SHOOTDOWN, 0) or  Input.IsActionTriggered(ButtonAction.ACTION_SHOOTDOWN, 1) then
			EID.bagOfCraftingOffset = math.min(#results-(#results%EID.Config["BagOfCraftingResults"]), EID.bagOfCraftingOffset + EID.Config["BagOfCraftingResults"])
		elseif Input.IsActionTriggered(ButtonAction.ACTION_SHOOTUP, 0) or  Input.IsActionTriggered(ButtonAction.ACTION_SHOOTUP, 1) then
			EID.bagOfCraftingOffset = math.max(0, EID.bagOfCraftingOffset - EID.Config["BagOfCraftingResults"])
		end
		Isaac.GetPlayer(0).ControlsEnabled = false
	else
		Isaac.GetPlayer(0).ControlsEnabled = true
	end
	
	local resultCount = 0
	local skips = 0
	for quality = 4, 0, -1 do -- sort by result quality
		for i, v in ipairs(results) do
			if EID.itemWeightsLookup[v[2]]== quality then
				if skips < EID.bagOfCraftingOffset then
					skips = skips + 1
					if skips == EID.bagOfCraftingOffset then
						customDescObj.Description = customDescObj.Description.."#{{Blank}} ...+"..skips.." more"
					end
				else
					customDescObj.Description = customDescObj.Description.."# {{Collectible"..v[2].."}} ="
					customDescObj.Description = customDescObj.Description..EID:tableToCraftingIconsMerged(v[1])
					resultCount = resultCount + 1
					if resultCount > EID.Config["BagOfCraftingResults"]-1 then
						if #results > EID.Config["BagOfCraftingResults"] then
							customDescObj.Description = customDescObj.Description.."#{{Blank}} ...+"..(#results-EID.Config["BagOfCraftingResults"]- skips).." more"
						end
						break
					end
				end
			end
		end
		if resultCount > EID.Config["BagOfCraftingResults"]-1 then
			break
		end
	end
	EID:printDescription(customDescObj)
	return true
end

--[[
Isaac.DebugString("Calculating: {1, 1, 1, 1, 1, 1, 1, 1}")
Isaac.DebugString(EID:calculateBagOfCrafting({1, 1, 1, 1, 1, 1, 1, 1}))
Isaac.DebugString("Calculating: {1, 1, 1, 1, 1, 1, 1, 2}")
Isaac.DebugString(EID:calculateBagOfCrafting({1, 1, 1, 1, 1, 1, 1, 2}))
Isaac.DebugString("Calculating: {1, 1, 1, 1, 1, 1, 1, 3}")
Isaac.DebugString(EID:calculateBagOfCrafting({1, 1, 1, 1, 1, 1, 1, 3}))
]]--