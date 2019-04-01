--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================
--==================
-- America
--==================
-- American Rough Riders will now be a cav replacement
UPDATE Units SET Combat=62, Cost=340, PromotionClass='PROMOTION_CLASS_LIGHT_CAVALRY', PrereqTech='TECH_MILITARY_SCIENCE' WHERE UnitType='UNIT_AMERICAN_ROUGH_RIDER';
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_HELICOPTER' WHERE Unit='UNIT_AMERICAN_ROUGH_RIDER';
INSERT INTO UnitReplaces VALUES ('UNIT_AMERICAN_ROUGH_RIDER' , 'UNIT_CAVALRY');
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='ROUGH_RIDER_BONUS_ON_HILLS';
-- Reduce combat strength of mustangs due to them already having many extra combat bonuses over biplanes
UPDATE Units SET Combat=100 , RangedCombat=100 WHERE UnitType='UNIT_AMERICAN_P51';
-- Rough Riders cost Niter
INSERT INTO Units_XP2 (UnitType , ResourceCost)
	VALUES ('UNIT_AMERICAN_ROUGH_RIDER' , 20);
UPDATE Units SET StrategicResource ='RESOURCE_NITER' WHERE UnitType='UNIT_AMERICAN_ROUGH_RIDER';

--==================
-- Arabia
--==================
-- Arabia's Worship Building Bonus increased from 10% to 20%
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_CULTURE' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_FAITH' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_SCIENCE' AND Name='Multiplier';
-- Arabia gets +1 Great Prophet point per turn after getting a pantheon
INSERT INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS' , 'PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_PROPHET');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'Amount' , '1');
UPDATE TraitModifiers SET ModifierId='TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' WHERE ModifierId='TRAIT_GUARANTEE_ONE_PROPHET';
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'TechnologyType' , 'TECH_ASTROLOGY');

--==================
-- Australia
--==================
-- Digger gets +5 combat strength and requires niter
UPDATE Units SET Combat=77 , BaseMoves=3 WHERE UnitType='UNIT_DIGGER';
--INSERT INTO Units_XP2 (UnitType , ResourceCost  , ResourceMaintenanceAmount , ResourceMaintenanceType)
--	VALUES ('UNIT_DIGGER' , 1 , 1, 'RESOURCE_OIL');
-- Diggers cost Niter
INSERT INTO Units_XP2 (UnitType , ResourceCost)
	VALUES ('UNIT_DIGGER' , 40);
UPDATE Units SET StrategicResource ='RESOURCE_NITER'  WHERE UnitType='UNIT_DIGGER';
-- war production bonus reduced to 0% from 100%, liberation bonus reduced to +50% (from +100%)
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_DEFENSIVE_PRODUCTION' and Name='Amount';
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES
	('TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION_XP2', 'YieldType', 'YIELD_PRODUCTION'),
	('TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION_XP2', 'Amount', '50');

--==================
-- Aztec
--==================
-- Aztec Tlachtli Unique Building is now slightly cheaper and is +3 Culture instead of +2 Faith/+1 Culture
DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_TLACHTLI' AND YieldType='YIELD_FAITH';
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_TLACHTLI';
UPDATE Buildings SET Cost=100 WHERE BuildingType='BUILDING_TLACHTLI';

--==================
-- Brazil
--==================
UPDATE Units SET AntiAirCombat=95 WHERE UnitType='UNIT_BRAZILIAN_MINAS_GERAES';

--==================
-- Canada
--==================
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_LAST_BEST_WEST'       , 'TUNDRA_EXTRA_FOOD_CPLMOD'           ),
	('TRAIT_LEADER_LAST_BEST_WEST'       , 'TUNDRA_HILLS_EXTRA_FOOD_CPLMOD'     ),
	('TRAIT_LEADER_LAST_BEST_WEST'       , 'NATIONAL_PARK_FOOD_YIELDS_CPLMOD'   ),
	('TRAIT_LEADER_LAST_BEST_WEST'       , 'NATIONAL_PARK_PROD_YIELDS_CPLMOD'   );
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , OwnerRequirementSetId)
	VALUES
	('TUNDRA_EXTRA_FOOD_CPLMOD'            , 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD'               , 'PLOT_HAS_TUNDRA_REQUIREMENTS'        , NULL),
	('TUNDRA_HILLS_EXTRA_FOOD_CPLMOD'      , 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD'               , 'PLOT_HAS_TUNDRA_HILLS_REQUIREMENTS'  , NULL),
	('NATIONAL_PARK_FOOD_YIELDS_CPLMOD'    , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE' , 'CITY_HAS_NATIONAL_PARK_REQUREMENTS'  , NULL),
	('NATIONAL_PARK_PROD_YIELDS_CPLMOD'    , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE' , 'CITY_HAS_NATIONAL_PARK_REQUREMENTS'  , NULL);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('TUNDRA_EXTRA_FOOD_CPLMOD'            , 'YieldType' , 'YIELD_FOOD'      ),
	('TUNDRA_EXTRA_FOOD_CPLMOD'            , 'Amount'    , '1'               ),
	('TUNDRA_HILLS_EXTRA_FOOD_CPLMOD'      , 'YieldType' , 'YIELD_FOOD'      ),
	('TUNDRA_HILLS_EXTRA_FOOD_CPLMOD'      , 'Amount'    , '1'               ),
	('NATIONAL_PARK_FOOD_YIELDS_CPLMOD'    , 'YieldType' , 'YIELD_FOOD'      ),
	('NATIONAL_PARK_FOOD_YIELDS_CPLMOD'    , 'Amount'    , '8'               ),
	('NATIONAL_PARK_PROD_YIELDS_CPLMOD'    , 'YieldType' , 'YIELD_PRODUCTION'),
	('NATIONAL_PARK_PROD_YIELDS_CPLMOD'    , 'Amount'    , '8'               );
-- Hockey rink at Civil Service
UPDATE Improvements SET PrereqCivic='CIVIC_CIVIL_SERVICE' WHERE ImprovementType='IMPROVEMENT_ICE_HOCKEY_RINK';
-- Mounties get a base combat buff and combat buff from nearby parks radius increased
UPDATE Units SET Combat=70 , Cost=360 WHERE UnitType='UNIT_CANADA_MOUNTIE';
UPDATE RequirementArguments SET Value='4' WHERE RequirementId='UNIT_PARK_REQUIREMENT'       AND Name='MaxDistance';
UPDATE RequirementArguments SET Value='4' WHERE RequirementId='UNIT_OWNER_PARK_REQUIREMENT' AND Name='MaxDistance';

--==================
-- China
--==================
-- Great Wall gets +1 Production, and gets it's adjacency gold and culture a little easier
INSERT INTO Improvement_YieldChanges
	VALUES ('IMPROVEMENT_GREAT_WALL' , 'YIELD_PRODUCTION' , 1);
UPDATE Improvement_YieldChanges SET YieldChange='1' WHERE ImprovementType='IMPROVEMENT_GREAT_WALL' AND YieldType='YIELD_GOLD';
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqTech)
	VALUES ('202' , 'IMPROVEMENT_GREAT_WALL' , 'YIELD_CULTURE' , '1' , 'TECH_CASTLES');
	
DELETE FROM Adjacency_YieldChanges WHERE ID='GreatWall_Gold';
DELETE FROM Adjacency_YieldChanges WHERE ID='GreatWall_Culture';

INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GREATWALL_SELFADJACENCY_CULTURE_CPLMOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_GREATWALL_CULTURE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GREATWALL_SELFADJACENCY_CULTURE_CPLMOD' , 'YieldType' , 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GREATWALL_SELFADJACENCY_CULTURE_CPLMOD' , 'Amount' , '1');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_GREAT_WALL' , 'GREATWALL_SELFADJACENCY_CULTURE_CPLMOD');
	
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GREATWALL_SELFADJACENCY_GOLD_CPLMOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_GREATWALL_GOLD_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GREATWALL_SELFADJACENCY_GOLD_CPLMOD' , 'YieldType' , 'YIELD_GOLD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GREATWALL_SELFADJACENCY_GOLD_CPLMOD' , 'Amount' , '1');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_GREAT_WALL' , 'GREATWALL_SELFADJACENCY_GOLD_CPLMOD');

INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLOT_ADJACENT_GREATWALL_GOLD_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLOT_ADJACENT_GREATWALL_GOLD_REQUIREMENTS' , 'REQUIRES_PLOT_ADJACENT_GREATWALL');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLOT_ADJACENT_GREATWALL' , 'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_ADJACENT_GREATWALL' , 'ImprovementType' , 'IMPROVEMENT_GREAT_WALL');
	
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLOT_ADJACENT_GREATWALL_CULTURE_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');	
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLOT_ADJACENT_GREATWALL_CULTURE_REQUIREMENTS' , 'REQUIRES_PLOT_ADJACENT_GREATWALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLOT_ADJACENT_GREATWALL_CULTURE_REQUIREMENTS' , 'REQUIRES_TECHNOLOGY_CASTLES');

-- Crouching Tiger now a crossbowman replacement that gets +7 when adjacent to an enemy unit
INSERT INTO UnitReplaces (CivUniqueUnitType , ReplacesUnitType)
	VALUES ('UNIT_CHINESE_CROUCHING_TIGER' , 'UNIT_CROSSBOWMAN');
UPDATE Units SET Cost=190 , RangedCombat=40 , Range=2 WHERE UnitType='UNIT_CHINESE_CROUCHING_TIGER';

INSERT INTO Tags (Tag , Vocabulary)
	VALUES ('CLASS_CROUCHING_TIGER' , 'ABILITY_CLASS');
INSERT INTO TypeTags (Type , Tag)
	VALUES ('UNIT_CHINESE_CROUCHING_TIGER' , 'CLASS_CROUCHING_TIGER');
INSERT INTO Types (Type , Kind)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'KIND_ABILITY');
INSERT INTO TypeTags (Type , Tag)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'CLASS_CROUCHING_TIGER');
INSERT INTO UnitAbilities (UnitAbilityType , Name , Description)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'LOC_ABILITY_TIGER_ADJACENCY_NAME' , 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION');
INSERT INTO UnitAbilityModifiers (UnitAbilityType , ModifierId)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'TIGER_ADJACENCY_DAMAGE');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('TIGER_ADJACENCY_DAMAGE' , 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH' , 'TIGER_ADJACENCY_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TIGER_ADJACENCY_DAMAGE', 'Amount' , '7'); 
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'PLAYER_IS_ATTACKER_REQUIREMENTS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'ADJACENT_UNIT_REQUIREMENT');
INSERT INTO ModifierStrings (ModifierId , Context , Text)
    VALUES ('TIGER_ADJACENCY_DAMAGE' , 'Preview' , 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION');

--==================
-- Egypt
--==================
-- Maryannu Chariot Archer no longer a Heavy Chariot replacement
DELETE FROM UnitReplaces WHERE CivUniqueUnitType='UNIT_EGYPTIAN_CHARIOT_ARCHER';
-- Sphinx now allowed to be adjacent to each other, along with yield improvements
UPDATE Improvements SET SameAdjacentValid=1 WHERE ImprovementType='IMPROVEMENT_SPHINX';
-- Base Faith Increased to 2 (from 1)
UPDATE Improvement_YieldChanges SET YieldChange=2 WHERE ImprovementType='IMPROVEMENT_SPHINX' AND YieldType='YIELD_FAITH';
-- +1 Faith and +1 Culture if adjacent to a wonder, insteaf of 2 Faith.
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='SPHINX_WONDERADJACENCY_FAITH' AND Name='Amount';
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_TO_WONDER_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'YieldType' , 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'Amount' , 1);
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_WONDERADJACENCY_CULTURE_CPLMOD');
-- Add +1 faith per adjacent holy site
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
	VALUES ( 'Sphinx_HolySiteAdjacency' , 'Placeholder' , 'YIELD_FAITH' , 1 , 1 , 'DISTRICT_HOLY_SITE');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_SPHINX' , 'Sphinx_HolySiteAdjacency');
-- Increased +1 Culture moved to Diplomatic Service (Was Natural History)
UPDATE Improvement_BonusYieldChanges SET PrereqCivic = 'CIVIC_DIPLOMATIC_SERVICE' WHERE Id = 18;
-- Now grants 1 food and 1 production on desert tiles without floodplains. Go Go Gadget bad-start fixer.
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_FOOD_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_FOOD_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_PRODUCTION_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER');
-- No bonus on Floodplains
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
-- Requires Desert or Desert Hills
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');

--==========
-- ELEANOR
--==========
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_ELEANOR_LOYALTY' , 'THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , OwnerRequirementSetId)
	VALUES
	('THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION' , NULL , NULL);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD' , 'DistrictType' , 'DISTRICT_THEATER'),
	('THEATER_BUILDING_PRODUCTION_BONUS_CPLMOD' , 'Amount'       , '100'                     );

--==================
-- England
--==================
-- Sea Dog available at Exploration now
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_ENGLISH_SEADOG';

--==================
-- France
--==================
-- Chateau now gives 1 housing, only +1 culture from adjacent wonders (but now stacks), and ajacent luxes now give stacking food and gold instead of non-stacking gold 
DELETE FROM Modifiers WHERE ModifierId='CHATEAU_WONDERADJACENCY_CULTURE';
DELETE FROM Modifiers WHERE ModifierId='CHATEAU_LUXURYADJACENCY_GOLD';
DELETE FROM ImprovementModifiers WHERE ModifierId='CHATEAU_WONDERADJACENCY_CULTURE';
DELETE FROM ImprovementModifiers WHERE ModifierId='CHATEAU_LUXURYADJACENCY_GOLD';

INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_CHATEAU' , 'YIELD_FOOD' , '0');
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_CHATEAU' , 'YIELD_GOLD' , '0');

INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_CHATEAU' , 'Chateau_Wonder_Culture');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_CHATEAU' , 'Chateau_Luxury_Food');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_CHATEAU' , 'Chateau_Luxury_Gold');

INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentWonder)
	VALUES ('Chateau_Wonder_Culture' , 'Placeholder' , 'YIELD_CULTURE' , '1' , '1' , '1');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentResourceClass)
	VALUES ('Chateau_Luxury_Food' , 'Placeholder' , 'YIELD_FOOD' , '1' , '1' , 'RESOURCECLASS_LUXURY');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentResourceClass)
	VALUES ('Chateau_Luxury_Gold' , 'Placeholder' , 'YIELD_GOLD' , '1' , '1' , 'RESOURCECLASS_LUXURY');

UPDATE Improvements SET Housing='1' , PreReqCivic='CIVIC_FEUDALISM' WHERE ImprovementType='IMPROVEMENT_CHATEAU';

--==================
-- Georgia
--==================
-- Georgia Tsikhe changed to a stronger Ancient Wall replacement instead of a Renaissance Wall replacement
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_TSIKHE';
UPDATE BuildingReplaces SET ReplacesBuildingType='BUILDING_WALLS' WHERE CivUniqueBuildingType='BUILDING_TSIKHE';
UPDATE Buildings SET Cost=80 , PrereqTech='TECH_MASONRY' , OuterDefenseHitPoints=150 WHERE BuildingType='BUILDING_TSIKHE';
-- Georgian Khevsur unit becomes sword replacement
UPDATE Units SET Combat=35, Cost=100, Maintenance=2, PrereqTech='TECH_IRON_WORKING' WHERE UnitType='UNIT_GEORGIAN_KHEVSURETI';
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='KHEVSURETI_HILLS_BUFF' AND Name='Amount';
INSERT INTO UnitReplaces (CivUniqueUnitType , ReplacesUnitType)
	VALUES ('UNIT_GEORGIAN_KHEVSURETI', 'UNIT_SWORDSMAN');
-- Georgia gets 50% faith kills instead of Protectorate War Bonus
INSERT INTO Modifiers (ModifierId, ModifierType)
	VALUES ('TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' , 'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' , 'PercentDefeatedStrength' , '50');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' , 'YieldType' , 'YIELD_FAITH');
UPDATE TraitModifiers SET ModifierId='TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' WHERE ModifierId='TRAIT_PROTECTORATE_WAR_FAITH';

--==================
-- Germany
--==================
-- Extra district comes at Guilds
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'CivicType' , 'CIVIC_GUILDS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_GUILDS');
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_GUILDS_REQUIREMENTS' WHERE ModifierId='TRAIT_EXTRA_DISTRICT_EACH_CITY';

--==================
-- Greece
--==================
-- Greece gets their extra envoy at amphitheater instead of acropolis
DELETE FROM DistrictModifiers WHERE DistrictType='DISTRICT_ACROPOLIS';
INSERT INTO TraitModifiers
	VALUES ('TRAIT_CIVILIZATION_PLATOS_REPUBLIC' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'BUILDING_IS_AMPHITHEATER');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'ModifierId' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD');
INSERT INTO Modifiers (ModifierId, ModifierType)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'Amount' , '1');
--Wildcard delayed to Political Philosophy
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY' WHERE ModifierId='TRAIT_WILDCARD_GOVERNMENT_SLOT';

--==================
-- Greece (Gorgo)
--==================
-- 25% culture from kills instead of 50%
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='UNIQUE_LEADER_CULTURE_KILLS' AND Name='PercentDefeatedStrength';

--==================
-- Hungary
--==================
-- only +1 combat strength from each alliance instead of 3
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='HUSZAR_ALLIES_COMBAT_BONUS';
-- Remove extra movement from levied units
DELETE FROM UnitAbilityModifiers WHERE ModifierId='RAVEN_LEVY_MOVEMENT';

--==================
-- India
--==================
-- India Stepwell Unique Improvement gets +1 base Faith and +1 Food moved from Professional Sports to Feudalism
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_STEPWELL' AND YieldType='YIELD_FAITH'; 
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_FEUDALISM' WHERE Id='20';
-- India Varu maintenance too high
UPDATE Units SET Maintenance=2 WHERE UnitType='UNIT_INDIAN_VARU';

--==================
-- India (Chandra)
--==================
-- replace Territorial Expansion Declaration Bonus with +1 movement
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_ARTHASHASTRA';

INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_ARTHASHASTRA' , 'TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' , 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' , 'ModifierId', 'EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD');

INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
	VALUES ('EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' , 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT' , 'REQUIREMENTSET_LAND_MILITARY_CPLMOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' , 'Amount' , '1');

INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIREMENTS_LAND_MILITARY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIRES_UNIT_IS_RELIGIOUS_ALL');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIREMENTS_LAND_MILITARY_CPLMOD', 'REQUIREMENT_UNIT_FORMATION_CLASS_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIREMENTS_LAND_MILITARY_CPLMOD' , 'UnitFormationClass' , 'FORMATION_CLASS_LAND_COMBAT');

--==================
-- India (Gandhi)
--==================
-- Extra belief when founding a Religion
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('EXTRA_BELIEF_MODIFIER', 'MODIFIER_PLAYER_ADD_BELIEF', 'HAS_A_RELIGION');
INSERT INTO TraitModifiers (TraitType, ModifierId)
    VALUES ('TRAIT_LEADER_SATYAGRAHA', 'EXTRA_BELIEF_MODIFIER');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('HAS_A_RELIGION', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('HAS_A_RELIGION', 'REQUIRES_PLAYER_HAS_FOUNDED_A_RELIGION');
-- +1 movement to builders
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_SATYAGRAHA' , 'GANDHI_FAST_BUILDERS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GANDHI_FAST_BUILDERS' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'UNIT_IS_BUILDER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GANDHI_FAST_BUILDERS' , 'Amount' , '1');
-- +1 movement to settlers
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_SATYAGRAHA' , 'GANDHI_FAST_SETTLERS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GANDHI_FAST_SETTLERS' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'UNIT_IS_SETTLER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GANDHI_FAST_SETTLERS' , 'Amount' , '1');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('UNIT_IS_SETTLER' , 'REQUIREMENT_UNIT_IS_SETTLER');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('UNIT_IS_SETTLER' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIREMENT_UNIT_IS_SETTLER' , 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIREMENT_UNIT_IS_SETTLER' , 'UnitType' , 'UNIT_SETTLER');

--==================
-- Indonesia
--==================
-- Jongs cost Niter
INSERT INTO Units_XP2 (UnitType , ResourceCost)
	VALUES ('UNIT_INDONESIAN_JONG' , 20);
UPDATE Units SET StrategicResource ='RESOURCE_NITER'  WHERE UnitType='UNIT_INDONESIAN_JONG';

--==================
-- Japan
--==================
-- Commercial Hubs no longer get adjacency from rivers
INSERT INTO ExcludedAdjacencies (TraitType , YieldChangeId)
    VALUES
    ('TRAIT_CIVILIZATION_ADJACENT_DISTRICTS' , 'River_Gold');
-- Samurai come at Feudalism now
UPDATE Units SET PrereqCivic='CIVIC_FEUDALISM' , PrereqTech=NULL WHERE UnitType='UNIT_JAPANESE_SAMURAI';

--==================
-- Khmer
--==================
-- Prasat gives a free Missionary when built
INSERT INTO Modifiers (ModifierId , ModifierType , RunOnce , Permanent)
    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY' , 1 , 1);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'UnitType' , 'UNIT_MISSIONARY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'Amount' , '1');
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
    VALUES ('BUILDING_PRASAT' , 'PRASAT_GRANT_MISSIONARY_CPLMOD');
-- Domrey Unique Unit will now be a Catapult replacement that has a higher melee strength and bombard strength
UPDATE Units SET Combat=33, Bombard=45, Cost=160, Maintenance=2, PrereqTech='TECH_ENGINEERING', MandatoryObsoleteTech='TECH_STEEL' WHERE UnitType='UNIT_KHMER_DOMREY';
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_BOMBARD' WHERE Unit='UNIT_KHMER_DOMREY';
INSERT INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType)
	VALUES ('UNIT_KHMER_DOMREY', 'UNIT_CATAPULT');
-- Trade routes to or from other civilizations give +2 Faith to both parties
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER' , 'Amount' , '2');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_FROM_OTHERS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES' , 'Amount' , '2');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES' , 'Amount' , '2');
INSERT INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER');
INSERT INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES');
INSERT INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES');
-- Holy Sites +2 faith for an adjacent river
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_MONASTERIES_KING' , 'TRAIT_HOLY_SITE_RIVER_FAITH_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_HOLY_SITE_RIVER_FAITH_CPLMOD' , 'MODIFIER_PLAYER_CITIES_RIVER_ADJACENCY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_HOLY_SITE_RIVER_FAITH_CPLMOD' , 'Amount' , '2');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_HOLY_SITE_RIVER_FAITH_CPLMOD' , 'DistrictType' , 'DISTRICT_HOLY_SITE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_HOLY_SITE_RIVER_FAITH_CPLMOD' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_HOLY_SITE_RIVER_FAITH_CPLMOD' , 'Description' , 'LOC_DISTRICT_HOLY_SITE_RIVER_FAITH');
-- +100% production to aquaducts and holy sites
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_MONASTERIES_KING' , 'TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD'),
	('TRAIT_LEADER_MONASTERIES_KING' , 'TRAIT_BOOST_HOLYSITE_PRODUCTION_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , OwnerRequirementSetId)
	VALUES
	('TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION' , NULL , NULL),
	('TRAIT_BOOST_HOLYSITE_PRODUCTION_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION' , NULL , NULL);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD' , 'DistrictType' , 'DISTRICT_AQUEDUCT' ),
	('TRAIT_BOOST_AQUEDUCT_PRODUCTION_CPLMOD' , 'Amount'       , '100'               ),
	('TRAIT_BOOST_HOLYSITE_PRODUCTION_CPLMOD' , 'DistrictType' , 'DISTRICT_HOLY_SITE'),
	('TRAIT_BOOST_HOLYSITE_PRODUCTION_CPLMOD' , 'Amount'       , '100'               );

--==================
-- Korea
--==================
-- only +5% science and culture from gov promotions in the city
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='TRAIT_ADJUST_CITY_CULTURE_PER_GOVERNOR_TITLE_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='TRAIT_ADJUST_CITY_SCIENCE_PER_GOVERNOR_TITLE_MODIFIER' AND Name='Amount';
-- Seowon gets +2 science base yield instead of 4, +1 for every 2 mines adjacent instead of 1 to 1
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID='BaseDistrict_Science';
INSERT INTO Adjacency_YieldChanges
	(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement)
	VALUES ('Mine_Science', 'LOC_DISTRICT_MINE_SCIENCE', 'YIELD_SCIENCE', 1, 2, 'IMPROVEMENT_MINE');
INSERT INTO District_Adjacencies
	(DistrictType , YieldChangeId)
	VALUES ('DISTRICT_SEOWON', 'Mine_Science');
-- seowon gets +1 adjacency from theater squares instead of -1
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
	VALUES
	('Theater_Science' , 'LOC_DISTRICT_SEOWON_THEATER_BONUS' , 'YIELD_SCIENCE' , '2' , '1' , 'DISTRICT_THEATER'),
	('Seowon_Culture'  , 'LOC_DISTRICT_THEATER_SEOWON_BONUS' , 'YIELD_CULTURE' , '1' , '1' , 'DISTRICT_SEOWON' );
INSERT INTO District_Adjacencies (DistrictType , YieldChangeId)
	VALUES
	('DISTRICT_SEOWON'  , 'Theater_Science'),
	('DISTRICT_THEATER' , 'Seowon_Culture' );

--==================
-- Kongo
--==================
UPDATE Units_XP2 SET ResourceCost=10 WHERE UnitType='UNIT_KONGO_SHIELD_BEARER';

--==========
-- Macedon
--==========
-- Hypaspists cost 20 Iron instead of 5
UPDATE Units_XP2 SET ResourceCost=10 WHERE UnitType='UNIT_MACEDONIAN_HYPASPIST';
-- +20% Production for 10 turns after conquering a city
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION' , 'TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'MODIFIER_PLAYER_ADD_DIPLOMATIC_YIELD_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES 
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'DiplomaticYieldSource' , 'CITY_CAPTURED'   ),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'TurnsActive'           , '10'              ),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'YieldType'             , 'YIELD_PRODUCTION'),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'Amount'                , '20'              );
-- Hetairoi no longer a Horseman replacement
DELETE FROM UnitReplaces WHERE CivUniqueUnitType='UNIT_MACEDONIAN_HETAIROI';
-- Now receives +1 Combat Strength for every Great General recruited this game <-- couldn't figure out

--==========
-- Mali
--==========
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_LESS_BUILDING_PRODUCTION';
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_LESS_UNIT_PRODUCTION'    ;

--==================
-- Maori
--==================
UPDATE Units SET Maintenance=2 WHERE UnitType='UNIT_MAORI_TOA';

--==================
-- Mapuche
--==================
-- Combat bonus against Golden Age Civs set to 5 instead of 10
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='TRAIT_TOQUI_COMBAT_BONUS_VS_GOLDEN_AGE_CIV';
-- Malon Raiders become Courser replacement and territory bonus replaced with +1 movement
UPDATE Units SET Combat=44 , Cost=200 , Maintenance=3 , BaseMoves=6 , PrereqTech='TECH_CASTLES' , MandatoryObsoleteTech='TECH_SYNTHETIC_MATERIALS' WHERE UnitType='UNIT_MAPUCHE_MALON_RAIDER';
INSERT INTO UnitReplaces (CivUniqueUnitType , ReplacesUnitType)
	VALUES ('UNIT_MAPUCHE_MALON_RAIDER' , 'UNIT_COURSER');
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_CAVALRY' WHERE Unit='UNIT_MAPUCHE_MALON_RAIDER';
DELETE FROM UnitAbilityModifiers WHERE ModifierId='MALON_RAIDER_TERRITORY_COMBAT_BONUS';
-- Malons cost Horses
INSERT INTO Units_XP2 (UnitType , ResourceCost)
	VALUES ('UNIT_MAPUCHE_MALON_RAIDER' , 20);
UPDATE Units SET StrategicResource ='RESOURCE_HORSES'  WHERE UnitType='UNIT_MAPUCHE_MALON_RAIDER';
-- Chemamull Unique Improvement gets +1 Production (another at Civil Service Civic)
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_CHEMAMULL' , 'YIELD_PRODUCTION' , 1);
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('203' , 'IMPROVEMENT_CHEMAMULL' , 'YIELD_PRODUCTION' , '1' , 'CIVIC_CIVIL_SERVICE');

--=========
--Mongolia
--=========
-- No longer receives +1 diplo visibility for trading post
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_TRADING_POST_DIPLO_VISIBILITY';
DELETE FROM DiplomaticVisibilitySources WHERE VisibilitySourceType='SOURCE_TRADING_POST_TRAIT';
DELETE FROM DiplomaticVisibilitySources_XP1 WHERE VisibilitySourceType='SOURCE_TRADING_POST_TRAIT';
DELETE FROM ModifierArguments WHERE ModifierId='TRAIT_TRADING_POST_DIPLO_VISIBILITY';
DELETE FROM Modifiers WHERE ModifierId='TRAIT_TRADING_POST_DIPLO_VISIBILITY';
-- +100% production to Ordu
UPDATE Buildings SET Cost=60 WHERE BuildingType='BUILDING_ORDU';

--==================
-- Netherlands
--==================
-- UU requires 10 Niter
UPDATE Units_XP2 SET ResourceCost=20 WHERE UnitType='UNIT_DUTCH_ZEVEN_PROVINCIEN';

--==================
-- Norway
--==================
-- Berserker no longer gets +10 on attack and -5 on defense... simplified to be base on defense and +15 on attack
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='UNIT_STRONG_WHEN_ATTACKING';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='UNIT_WEAK_WHEN_DEFENDING';
-- Berserker unit now gets unlocked at Feudalism instead of Military Tactics, and can be purchased with Faith
UPDATE Units SET Combat=35 , PrereqTech=NULL , PrereqCivic='CIVIC_FEUDALISM' WHERE UnitType='UNIT_NORWEGIAN_BERSERKER';
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_UNIT_NORWEGIAN_BERSERKER' , 'BERSERKER_FAITH_PURCHASE_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'Tag' , 'CLASS_MELEE_BERSERKER');
--Berserker Movement bonus extended to all water tiles	
UPDATE RequirementSets SET RequirementSetType='REQUIREMENTSET_TEST_ANY' WHERE RequirementSetId='BERSERKER_PLOT_IS_ENEMY_TERRITORY';
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES 
	('BERSERKER_PLOT_IS_ENEMY_TERRITORY' , 'REQUIRES_PLOT_HAS_COAST'),
	('BERSERKER_PLOT_IS_ENEMY_TERRITORY' , 'REQUIRES_TERRAIN_OCEAN' );
-- Melee Naval production reduced to 25% from 50%
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ANCIENT_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_CLASSICAL_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MEDIEVAL_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RENAISSANCE_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INDUSTRIAL_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MODERN_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ATOMIC_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INFORMATION_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
-- Stave Church now gives +1 Faith to resource tiles in the city, instead of standard adjacency bonus for woods
INSERT INTO Modifiers (ModifierID , ModifierType , SubjectRequirementSetId)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD' , 'STAVE_CHURCH_RESOURCE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'Amount' , '1');
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_STAVE_CHURCH' , 'STAVECHURCH_RESOURCE_FAITH');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('STAVE_CHURCH_RESOURCE_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('STAVE_CHURCH_RESOURCE_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_VISIBLE_RESOURCE');
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='STAVE_CHURCH_FAITHWOODSADJACENCY' AND Name='Amount';
-- +2 gold harbor adjacency if adjacent to holy sites
INSERT INTO ExcludedAdjacencies (YieldChangeId , TraitType)
    VALUES
    ('District_HS_Gold_Negative' , 'TRAIT_LEADER_MELEE_COASTAL_RAIDS');
INSERT INTO District_Adjacencies (DistrictType , YieldChangeId)
    VALUES
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Positive'),
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Negative');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
    VALUES
    ('District_HS_Gold_Positive' , 'LOC_HOLY_SITE_HARBOR_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' , '2'  , '1' , 'DISTRICT_HOLY_SITE'),
    ('District_HS_Gold_Negative' , 'LOC_HOLY_SITE_HARBOR_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' , '-2' , '1' , 'DISTRICT_HOLY_SITE');
-- Holy Sites coastal adjacency
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'DistrictType' , 'DISTRICT_HOLY_SITE'             			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'TerrainType'  , 'TERRAIN_COAST'                  			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'YieldType'    , 'YIELD_FAITH'                    			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'Amount'       , '1'                              			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'TilesRequired', '1'                              			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'Description'  , 'LOC_DISTRICT_HOLY_SITE_NORWAY_COAST_FAITH');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS' , 'TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY');
-- +50% production towards Holy Sites and associated Buildings
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES 
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS'          , 'THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'              ),
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS'          , 'THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'              );
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES 
	('THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'               , 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION'                 , null                               ),
	('THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'               , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION'                 , null                               );
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra , SecondExtra)
	VALUES 
	('THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'               , 'DistrictType' , 'DISTRICT_HOLY_SITE' , null , null),
	('THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'               , 'Amount'       , '50'                 , null , null),
	('THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'               , 'DistrictType' , 'DISTRICT_HOLY_SITE' , null , null),
	('THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'               , 'Amount'       , '50'                 , null , null);

--==================
-- Nubia
--==================
-- Nubia ranged production and experience cut to 25% (from %50) and ranged experience cut in half to 25%... Also, Pitati Archers have same ranged strength as regular Archers (25 instead of 30)
UPDATE Units SET RangedCombat=25 WHERE UnitType='UNIT_NUBIAN_PITATI';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ANCIENT_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_CLASSICAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MEDIEVAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RENAISSANCE_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INDUSTRIAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MODERN_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ATOMIC_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INFORMATION_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RANGED_EXPERIENCE_MODIFIER' and Name='Amount';
-- Nubian Pyramid can also be built on flat plains, but not adjacent to each other
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'TERRAIN_PLAINS');
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_PYRAMID';
-- Nubian Pyramid gets double adjacency yields
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CityCenterAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CampusAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CommercialHubAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_HarborAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_HolySiteAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_IndustrialZoneAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_TheaterAdjacency";

--==================
-- Persia
--==================
-- Persia surprise war movement bonus nullified
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_FALLBABYLON_SURPRISE_MOVEMENT' and Name='Amount';
-- Immortals defense buffed and ranged nerfed (since it is affected by double oligarchy)
UPDATE Units SET Combat=35 WHERE UnitType='UNIT_PERSIAN_IMMORTAL';

--==================
-- Poland
--==================
-- Poland's Winged Hussar moved to Divine Right
UPDATE Units SET PrereqCivic='CIVIC_DIVINE_RIGHT' WHERE UnitType='UNIT_POLISH_HUSSAR';
-- Poland gets a relic when founding and completeing a religion
--Grants Relic Upon Founding Religion
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , RunOnce , Permanent)
	VALUES ('TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD' , 'MODIFIER_PLAYER_GRANT_RELIC' , 'PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' , 1 , 1);	
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD' , 'Amount' , '1');	
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_LITHUANIAN_UNION' , 'TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');	
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' , 'REQUIRES_PLAYER_HAS_FOUNDED_A_RELIGION');
--Grants Relic Upon completing Religion
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , RunOnce , Permanent)
	VALUES ('TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD' , 'MODIFIER_PLAYER_GRANT_RELIC' , 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 1 , 1);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD' , 'Amount' , '1');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_LITHUANIAN_UNION' , 'TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
--Checks Requirement Set for each belief type
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'RELIGION_HAS_FOUNDER_BELIEF_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'RELIGION_HAS_WORSHIP_BELIEF_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'RELIGION_HAS_ENHANCER_BELIEF_CPLMOD');
--Creates Belief Requirement Sets
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
--Attaches Requirement Sets
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
--RequirementSet For FOUNDER Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PILGRIMAGE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_STEWARDSHIP_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_TITHE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD');
--RequirementSet For WORSHIP Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CATHEDRAL_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_GURDWARA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MOSQUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PAGODA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_SYNAGOGUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_WAT_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_STUPA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD');
--RequirementSet For ENHANCER Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_HOLY_ORDER_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_JUST_WAR_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_SCRIPTURE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD');
--Checks for FOUNDER Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PILGRIMAGE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_STEWARDSHIP_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_TITHE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--Checks for WORSHIP Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CATHEDRAL_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_GURDWARA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MOSQUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PAGODA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_SYNAGOGUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_WAT_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_STUPA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--Checks for ENHANCER Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_HOLY_ORDER_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_JUST_WAR_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_SCRIPTURE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--RequirementArguments
--Checks RequirementSets
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD');
--FOUNDER	
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD' , 'BeliefType' , 'BELIEF_CHURCH_PROPERTY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD' , 'BeliefType' , 'BELIEF_LAY_MINISTRY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD' , 'BeliefType' , 'BELIEF_PAPAL_PRIMACY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_PILGRIMAGE_CPLMOD' , 'BeliefType' , 'BELIEF_PILGRIMAGE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_STEWARDSHIP_CPLMOD' , 'BeliefType' , 'BELIEF_STEWARDSHIP');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_TITHE_CPLMOD' , 'BeliefType' , 'BELIEF_TITHE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD' , 'BeliefType' , 'BELIEF_WORLD_CHURCH');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD' , 'BeliefType' , 'BELIEF_CROSS_CULTURAL_DIALOGUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD' , 'BeliefType' , 'BELIEF_RELIGIOUS_UNITY');
--WORSHIP	
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_CATHEDRAL_CPLMOD' , 'BeliefType' , 'BELIEF_CATHEDRAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_GURDWARA_CPLMOD' , 'BeliefType' , 'BELIEF_GURDWARA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD' , 'BeliefType' , 'BELIEF_MEETING_HOUSE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MOSQUE_CPLMOD' , 'BeliefType' , 'BELIEF_MOSQUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_PAGODA_CPLMOD' , 'BeliefType' , 'BELIEF_PAGODA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_SYNAGOGUE_CPLMOD' , 'BeliefType' , 'BELIEF_SYNAGOGUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_WAT_CPLMOD' , 'BeliefType' , 'BELIEF_WAT');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_STUPA_CPLMOD' , 'BeliefType' , 'BELIEF_STUPA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD' , 'BeliefType' , 'BELIEF_DAR_E_MEHR');
--ENHANCER
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD' , 'BeliefType' , 'BELIEF_DEFENDER_OF_FAITH');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_HOLY_ORDER_CPLMOD' , 'BeliefType' , 'BELIEF_HOLY_ORDER');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD' , 'BeliefType' , 'BELIEF_ITINERANT_PREACHERS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_JUST_WAR_CPLMOD' , 'BeliefType' , 'BELIEF_JUST_WAR');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD' , 'BeliefType' , 'BELIEF_MISSIONARY_ZEAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD' , 'BeliefType' , 'BELIEF_MONASTIC_ISOLATION');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_SCRIPTURE_CPLMOD' , 'BeliefType' , 'BELIEF_SCRIPTURE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD' , 'BeliefType' , 'BELIEF_BURIAL_GROUNDS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD' , 'BeliefType' , 'BELIEF_RELIGIOUS_COLONIZATION');

--==================
-- Rome
--==================
-- Baths get +1 Culture per adjacent district
INSERT INTO District_Adjacencies (DistrictType , YieldChangeId)
	VALUES ('DISTRICT_BATH' , 'District_Culture_Standard');

--==================
-- Russia
--==================
-- Only gets 4 extra tiles when founding a new city instead of 8 
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='TRAIT_INCREASED_TILES';
-- Cossacks have same base strength as cavalry instead of +5
UPDATE Units SET Combat=62 WHERE UnitType='UNIT_RUSSIAN_COSSACK';
-- Lavra district does not acrue Great Person Points until Drama & Poetry
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_ARTIST';
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_MUSICIAN';
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_WRITER';
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_DRAMA_POETRY' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_DRAMA_POETRY' , 'CivicType' , 'CIVIC_DRAMA_POETRY');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_DRAMA_POETRY');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIRES_DISTRICT_IS_HOLY_SITE');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
    VALUES ('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_ARTIST');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
    VALUES ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_MUSICIAN');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
    VALUES ('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_WRITER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'Amount' , '1');
INSERT INTO DistrictModifiers ( DistrictType , ModifierId )
	VALUES ( 'DISTRICT_LAVRA' , 'DELAY_LAVRA_ARTIST_GPP_MODIFIER' );
INSERT INTO DistrictModifiers ( DistrictType , ModifierId )
	VALUES ( 'DISTRICT_LAVRA' , 'DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' );
INSERT INTO DistrictModifiers ( DistrictType , ModifierId )
	VALUES ( 'DISTRICT_LAVRA' , 'DELAY_LAVRA_WRITER_GPP_MODIFIER' );

--==================
-- Scotland
--==================
-- Golf Course moved to Games and Recreation
UPDATE Improvements SET PrereqCivic='CIVIC_GAMES_RECREATION' WHERE ImprovementType='IMPROVEMENT_GOLF_COURSE';
-- Golf Course base yields are 1 Culture and 2 Gold... +1 to each if next to City Center (+1 Culture at Civil Service and +1 Gold at Guilds)
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_GOLF_COURSE' AND YieldType='YIELD_CULTURE';
-- Golf Course extra housing moved to Urbanization
UPDATE RequirementArguments SET Value='CIVIC_URBANIZATION' WHERE RequirementId='REQUIRES_PLAYER_HAS_GLOBALIZATION' AND Name='CivicType';
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
	VALUES ('GOLFCOURSE_CITYCENTERADJACENCY_GOLD' , 'Placeholder' , 'YIELD_GOLD' , 1 , 1 , 'DISTRICT_CITY_CENTER');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_GOLF_COURSE' , 'GOLFCOURSE_CITYCENTERADJACENCY_GOLD');
-- Golf Course gets extra yields a bit earlier
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('204' , 'IMPROVEMENT_GOLF_COURSE' , 'YIELD_GOLD' , '1' , 'CIVIC_GUILDS');
INSERT INTO Improvement_BonusYieldChanges (Id , ImprovementType , YieldType , BonusYieldChange , PrereqCivic)
	VALUES ('205' , 'IMPROVEMENT_GOLF_COURSE' , 'YIELD_CULTURE' , '1' , 'CIVIC_DIPLOMATIC_SERVICE');

--==================
-- Scythia
--==================
-- Scythia no longer gets an extra light cavalry unit when building/buying one
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRASAKAHORSEARCHER' and NAME='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRALIGHTCAVALRY' and NAME='Amount';
-- Scythian Horse Archer gets a little more offense and defense, less maintenance, and can upgrade to Crossbowman before Field Cannon now
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_CROSSBOWMAN' WHERE Unit='UNIT_SCYTHIAN_HORSE_ARCHER';
UPDATE Units SET Range=2, Cost=70 WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';
-- Adjacent Pastures now give +1 production in addition to faith
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_KURGAN' , 'KURGAN_PASTURE_PRODUCTION');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentImprovement)
	VALUES ('KURGAN_PASTURE_PRODUCTION' , 'Placeholder' , 'YIELD_PRODUCTION' , 1 , 1 , 'IMPROVEMENT_PASTURE');
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN' , 'YIELD_PRODUCTION' , 0);
-- Can now purchase cavalry units with faith
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'Tag' , 'CLASS_LIGHT_CAVALRY'); 
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'Tag' , 'CLASS_HEAVY_CAVALRY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'Tag' , 'CLASS_RANGED_CAVALRY'); 

--==================
-- Spain
--==================
-- Missions moved to Theology
UPDATE Improvements SET PrereqCivic='CIVIC_THEOLOGY' WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions get +1 housing at Exploration
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('MISSION_HOUSING_WITH_CIVIL_SERVICE' , 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 'PLAYER_HAS_CIVIL_SERVICE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('MISSION_HOUSING_WITH_CIVIL_SERVICE' , 'Amount' , 1);
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_MISSION' , 'MISSION_HOUSING_WITH_CIVIL_SERVICE');
-- Missions get bonus yields at Enlightenment
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_THE_ENLIGHTENMENT' WHERE Id='17';
-- Early Fleets moved to Mercenaries
UPDATE ModifierArguments SET Value='CIVIC_MERCENARIES' WHERE Name='CivicType' AND ModifierId='TRAIT_NAVAL_CORPS_EARLY';
-- 30% discount on missionaries
INSERT INTO TraitModifiers ( TraitType , ModifierId )
	VALUES ('TRAIT_LEADER_EL_ESCORIAL' , 'HOLY_ORDER_MISSIONARY_DISCOUNT_MODIFIER');

--==================
-- Sumeria
--==================
-- Sumerian War Carts are no longer free to maintain so that you cannot have unlimited and have 28 combat strength instead of 30
UPDATE Units SET Maintenance=1 WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
UPDATE Units SET Combat=28 WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
-- Sumeria's Ziggurat gets +1 Culture at Diplomatic Service instead of Natural History
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_DIPLOMATIC_SERVICE' WHERE ImprovementType='IMPROVEMENT_ZIGGURAT';

--==================
-- Zulu
--==================
-- Zulu get corps/armies bonus at mobilization
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('PLAYER_HAS_MOBILIZATION_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_MOBILIZATION' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_MOBILIZATION' , 'CivicType' , 'CIVIC_MOBILIZATION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('PLAYER_HAS_MOBILIZATION_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_MOBILIZATION');
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_MOBILIZATION_REQUIREMENTS' WHERE ModifierId='TRAIT_LAND_CORPS_COMBAT_STRENGTH';
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_MOBILIZATION_REQUIREMENTS' WHERE ModifierId='TRAIT_LAND_ARMIES_COMBAT_STRENGTH';



--==============================================================
--******			  C I T Y - S T A T E S				  ******
--==============================================================
-- nan-modal culture per district no longer applies to city center or wonders
UPDATE Modifiers SET ModifierType='MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS';
-- fix valetta's bonus to work on Georgian walls
INSERT INTO TraitModifiers (TraitType , ModifierId)
    VALUES ('MINOR_CIV_VALLETTA_TRAIT' , 'MINOR_CIV_VALLETTA_UNIQUE_INFLUENCE_PURCHASE_CHEAPER_TSIKHE_BONUS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
    VALUES ('MINOR_CIV_VALLETTA_UNIQUE_INFLUENCE_PURCHASE_CHEAPER_TSIKHE_BONUS' , 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER' , 'PLAYER_IS_SUZERAIN');
INSERT INTO Modifiers (ModifierId , ModifierType)
    VALUES ('MINOR_CIV_VALLETTA_PURCHASE_CHEAPER_TSIKHE_BONUS' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PURCHASE_COST');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('MINOR_CIV_VALLETTA_UNIQUE_INFLUENCE_PURCHASE_CHEAPER_TSIKHE_BONUS' , 'ModifierId' , 'MINOR_CIV_VALLETTA_PURCHASE_CHEAPER_TSIKHE_BONUS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('MINOR_CIV_VALLETTA_PURCHASE_CHEAPER_TSIKHE_BONUS' , 'BuildingType' , 'BUILDING_TSIKHE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('MINOR_CIV_VALLETTA_PURCHASE_CHEAPER_TSIKHE_BONUS' , 'Amount' , '50');



--==============================================================
--******		C U L T U R E   V I C T O R I E S		  ******
--==============================================================
-- moon landing worth 5x science in culture instead of 10x
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_SCIENCE_RATE';
-- computers and environmentalism tourism boosts to 50% (from 25%)
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='COMPUTERS_BOOST_ALL_TOURISM';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='ENVIRONMENTALISM_BOOST_ALL_TOURISM'; 
-- base wonder tourism adjusted to 5
UPDATE GlobalParameters SET Value='5' WHERE Name='TOURISM_BASE_FROM_WONDER';
-- double tourism from improvements
UPDATE Improvement_Tourism SET ScalingFactor=200;
-- Reduce amount of tourism needed for foreign tourist from 200 to 150
UPDATE GlobalParameters SET Value='150' WHERE Name='TOURISM_TOURISM_TO_MOVE_CITIZEN';
-- no longer have to wait any number of turns to move greatworks between cities
UPDATE GlobalParameters SET Value='0' WHERE Name='GREATWORK_ART_LOCK_TIME';
-- relics give 6 tourism instead of 8
UPDATE GreatWorks SET Tourism=6 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIC';

-- fix same artist, same archelogist culture and tourism from bing 1 and 1 to being default numbers
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonYield=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';

-- fyi: books give 4 culture and 4 tourism each (8 and 8 for each great person)
-- artworks give 4 culture and 4 tourism instead of 3 and 2 ( 12/12 for each GP)
-- artifacts give 6 culture and 6 tourism instead of 3 and 3 ( 18/18 for each GP)
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIGIOUS';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_SCULPTURE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_LANDSCAPE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_PORTRAIT';
UPDATE GreatWorks SET Tourism=6 WHERE GreatWorkObjectType='GREATWORKOBJECT_ARTIFACT';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_RUBLEV_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_RUBLEV_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_RUBLEV_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_BOSCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_BOSCH_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_BOSCH_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_DONATELLO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_DONATELLO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_DONATELLO_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_MICHELANGELO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_MICHELANGELO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_MICHELANGELO_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_YING_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_YING_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_YING_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_TITIAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_TITIAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_TITIAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GRECO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GRECO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GRECO_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_REMBRANDT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_REMBRANDT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_REMBRANDT_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_ANGUISSOLA_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_ANGUISSOLA_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_ANGUISSOLA_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_KAUFFMAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_KAUFFMAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_KAUFFMAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_HOKUSAI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_HOKUSAI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_HOKUSAI_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_EOP_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_EOP_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_EOP_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GOGH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GOGH_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GOGH_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_LEWIS_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_LEWIS_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_LEWIS_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_COLLOT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_COLLOT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_COLLOT_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_MONET_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_MONET_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_MONET_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_ORLOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_ORLOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_ORLOVSKY_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_KLIMT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_KLIMT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_KLIMT_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GIL_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GIL_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_GIL_3';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_CASSATT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_CASSATT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='4' WHERE GreatWorkType='GREATWORK_CASSATT_3';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_3';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_4';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_5';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_6';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_7';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_8';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_9';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_10';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_11';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_12';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_13';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_14';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_15';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_16';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_17';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_18';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_19';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_20';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_21';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_22';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_23';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_24';
UPDATE GreatWork_YieldChanges SET YieldChange='6' WHERE GreatWorkType='GREATWORK_ARTIFACT_25';

-- music gives 12 culture and 8 tourism instead of 4 and 4 (16/16 per GP)
UPDATE GreatWorks SET Tourism=8 WHERE GreatWorkObjectType='GREATWORKOBJECT_MUSIC';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_2';



--==============================================================
--******			  D E D I C A T I O N S				  ******
--==============================================================
-- Pen and Brush gives +2 Culture and +2 Gold per District
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'YieldType' , 'YIELD_GOLD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'Amount' , '2');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_CULTURAL', 'COMMEMORATION_CULTURAL_DISTRICTGOLD');
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='COMMEMORATION_CULTURAL_DISTRICTCULTURE' and Name='Amount';



--==============================================================
--******				G O V E R N M E N T				  ******
--==============================================================
-- Audience Hall gets +3 Food and +3 Housing instead of +4 Housing
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_GOV_TALL' , 'GOV_TALL_FOOD_BUFF');
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='GOV_TALL_HOUSING_BUFF';
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GOV_TALL_FOOD_BUFF' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE' , 'CITY_HAS_GOVERNOR_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GOV_TALL_FOOD_BUFF' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GOV_TALL_FOOD_BUFF' , 'Amount' , '3');
--Warlord's Throne gives +25% production to naval and land military units... also reduces unit maintenance by 1
DELETE FROM BuildingModifiers WHERE ModifierId='GOV_PRODUCTION_BOOST_FROM_CAPTURE';
DELETE FROM ModifierArguments WHERE ModifierId='GOV_PRODUCTION_BOOST_FROM_CAPTURE';
DELETE FROM Modifiers WHERE ModifierId='GOV_PRODUCTION_BOOST_FROM_CAPTURE';
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES 
	('BUILDING_GOV_CONQUEST' , 'GOV_CONQUEST_PRODUCTION_BONUS'),
	('BUILDING_GOV_CONQUEST' , 'GOV_CONQUEST_REDUCED_MAINTENANCE'                       );
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES 
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION'),
	('GOV_CONQUEST_REDUCED_MAINTENANCE' , 'MODIFIER_PLAYER_ADJUST_UNIT_MAINTENANCE_DISCOUNT'       );
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES 
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'Amount'   , '25'             ),
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'StartEra' , 'ERA_ANCIENT'    ),
	('GOV_CONQUEST_PRODUCTION_BONUS'    , 'EndEra'   , 'ERA_INFORMATION'),
	('GOV_CONQUEST_REDUCED_MAINTENANCE' , 'Amount'   , '1'              );
-- Warlord's Throne extra resource stockpile
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES
	('BUILDING_GOV_CONQUEST' , 'BUILDING_GOV_CONQUEST_RESOURCE_STOCKPILE');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , OwnerRequirementSetId)
	VALUES
	('BUILDING_GOV_CONQUEST_RESOURCE_STOCKPILE' , 'MODIFIER_PLAYER_ADJUST_RESOURCE_STOCKPILE_CAP' , NULL , NULL);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('BUILDING_GOV_CONQUEST_RESOURCE_STOCKPILE' , 'Amount' , '30');



--==============================================================
--******				P A N T H E O N S				  ******
--==============================================================
UPDATE ModifierArguments SET Value=3 WHERE ModifierId='STONE_CIRCLES_QUARRY_FAITH_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value=3 WHERE ModifierId='RELIGIOUS_IDOLS_BONUS_MINE_FAITH_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value=3 WHERE ModifierId='RELIGIOUS_IDOLS_LUXURY_MINE_FAITH_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value=2 WHERE ModifierId='GOD_OF_CRAFTSMEN_STRATEGIC_MINE_PRODUCTION_MODIFIER' and Name='Amount';
-- Goddess of the Harvest is +50% faith from chops instead of +100%
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='GODDESS_OF_THE_HARVEST_HARVEST_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='GODDESS_OF_THE_HARVEST_REMOVE_FEATURE_MODIFIER' and Name='Amount';
-- Monument to the Gods affects all wonders... not just Ancient and Classical Era
UPDATE ModifierArguments SET Value='ERA_INFORMATION' WHERE ModifierId='MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER' AND Name='EndEra';
-- God of War now God of War and Plunder (similar to divine spark)
DELETE FROM BeliefModifiers WHERE BeliefType='BELIEF_GOD_OF_WAR';
INSERT INTO Modifiers  ( ModifierId , ModifierType , SubjectRequirementSetId )
	VALUES
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_COMMERCIAL_HUB' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_HARBOR' 		),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_ENCAMPMENT' 	);
INSERT INTO ModifierArguments ( ModifierId , Name , Type , Value )
	VALUES
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_MERCHANT' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_ADMIRAL'  ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_GENERAL'  ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' );
INSERT INTO BeliefModifiers ( BeliefType , ModifierId )
	VALUES
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_COMHUB' ),
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_HARBOR' ),
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' );
-- Goddess of the Hunt gives +2 Food
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='GODDESS_OF_THE_HUNT_CAMP_FOOD_MODIFIER' AND Name='Amount';
-- Goddess of Festivals gives +2 Food per plantation
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='GODDESS_OF_FESTIVALS_PLANTATION_TAG_FOOD_MODIFIER' AND Name='Amount';



--==============================================================
--******			P O L I C Y   C A R D S				  ******
--==============================================================
-- Limes should not become obselete
DELETE FROM ObsoletePolicies WHERE PolicyType='POLICY_LIMES';
-- Adds +100% Siege Unit Production to Limes Policy Card (the +100% to walls card)
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
--
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'EraType' , 'ERA_ANCIENT' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'EraType' , 'ERA_CLASSICAL' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'EraType' , 'ERA_MEDIEVAL' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'EraType' , 'ERA_RENAISSANCE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'EraType' , 'ERA_INDUSTRIAL' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'EraType' , 'ERA_MODERN' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'EraType' , 'ERA_ATOMIC' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'EraType' , 'ERA_INFORMATION' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'Amount' , '100' , '-1');

INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_ANCIENT_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_CLASSICAL_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_MODERN_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_ATOMIC_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_INFORMATION_ERA_CPLMOD');



--==============================================================
--******				R E L I G I O N S				  ******
--==============================================================
-- Crusader +7 instead of +10
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='JUST_WAR_COMBAT_BONUS_MODIFIER';
-- Lay Ministry now +2 Culture and +2 Faith per Theater and Holy Site
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_CULTURE_DISTRICTS_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_FAITH_DISTRICTS_MODIFIER' AND Name='Amount';
-- Itinerant Preachers now causes a Religion to spread 40% father away instead of only 30%
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='ITINERANT_PREACHERS_SPREAD_DISTANCE';
-- Cross-Cultural Dialogue is now +1 Science for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='CROSS_CULTURAL_DIALOGUE_SCIENCE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Pilgrimmage now gives 3 Faith instead of 2 for each foreign city converted
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='PILGRIMAGE_FAITH_FOREIGN_CITY_MODIFIER' AND Name='Amount';
-- Tithe is now +1 Gold for every 3 followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TITHE_GOLD_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- World Church is now +1 Culture for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='WORLD_CHURCH_CULTURE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Zen Meditation now only requires 1 District to get the +1 Amentity
UPDATE RequirementArguments SET Value='1' WHERE RequirementId='REQUIRES_CITY_HAS_2_SPECIALTY_DISTRICTS' AND Name='Amount';
-- Religious Communities now gives +1 Housing to Holy Sites, like it does for Shines and Temples
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'ModifierId' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'Amount' , '1');
INSERT INTO BeliefModifiers (BeliefType , ModifierId)
	VALUES ('BELIEF_RELIGIOUS_COMMUNITY' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_FOLLOWS_RELIGION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_HAS_HOLY_SITE');
-- Warrior Monks +3 Combat Strength
UPDATE Units SET Combat=38 WHERE UnitType='UNIT_WARRIOR_MONK';
-- Religious spread from trade routes increased
UPDATE GlobalParameters SET Value='3.0' WHERE Name='RELIGION_SPREAD_TRADE_ROUTE_PRESSURE_FOR_DESTINATION';
UPDATE GlobalParameters SET Value='3.0' WHERE Name='RELIGION_SPREAD_TRADE_ROUTE_PRESSURE_FOR_ORIGIN'     ;



--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================
UPDATE Units SET Combat=75 , BaseMoves=3 WHERE UnitType='UNIT_INFANTRY';
UPDATE Units_XP2 SET ResourceMaintenanceAmount=0 , ResourceCost=40 , ResourceMaintenanceType=NULL WHERE UnitType='UNIT_INFANTRY';
UPDATE Units SET StrategicResource ='RESOURCE_NITER'  WHERE UnitType='UNIT_INFANTRY';
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER';
UPDATE Units SET PrereqTech='TECH_STEEL' WHERE UnitType='UNIT_ANTIAIR_GUN';
UPDATE Units SET AntiAirCombat=90 WHERE UnitType='UNIT_BATTLESHIP';
UPDATE Units SET AntiAirCombat=90 WHERE UnitType='UNIT_DESTROYER';
UPDATE Units SET AntiAirCombat=110 WHERE UnitType='UNIT_MISSILE_CRUISER';
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES ('SIEGE_DEFENSE_BONUS_VS_RANGED_COMBAT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'SIEGE_DEFENSE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('SIEGE_DEFENSE_BONUS_VS_RANGED_COMBAT', 'Amount', '10');
INSERT INTO ModifierStrings (ModifierId, Context, Text)
	VALUES ('SIEGE_DEFENSE_BONUS_VS_RANGED_COMBAT', 'Preview', '+{1_Amount} Combat Strength against ranged attacks');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('SIEGE_DEFENSE_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('SIEGE_DEFENSE_REQUIREMENTS', 'RANGED_COMBAT_REQUIREMENTS');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('SIEGE_DEFENSE_REQUIREMENTS', 'PLAYER_IS_DEFENDER_REQUIREMENTS');
INSERT INTO Types (Type, Kind)
	VALUES ('ABILITY_SIEGE_RANGED_DEFENSE', 'KIND_ABILITY');
INSERT INTO TypeTags (Type , Tag)
	VALUES ('ABILITY_SIEGE_RANGED_DEFENSE', 'CLASS_SIEGE');
INSERT INTO UnitAbilities (UnitAbilityType , Name , Description)
	VALUES ('ABILITY_SIEGE_RANGED_DEFENSE', 'LOC_ABILITY_SIEGE_RANGED_DEFENSE_NAME', 'LOC_ABILITY_SIEGE_RANGED_DEFENSE_DESCRIPTION');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	VALUES ('ABILITY_SIEGE_RANGED_DEFENSE', 'SIEGE_DEFENSE_BONUS_VS_RANGED_COMBAT');



--==============================================================
--******			W O N D E R S  (MAN-MADE)			  ******
--==============================================================
-- Wonders Provide +5 score instead of +15
UPDATE ScoringLineItems SET Multiplier=5 WHERE LineItemType='LINE_ITEM_WONDERS';
-- Jebel Barkal bugfix
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='JEBELBARKAL_GRANT_FOUR_IRON_PER_TURN' AND Name='Amount';
-- Hanging Gardens gives +1 housing to cities within 6 tiles
UPDATE Buildings SET Housing='1' WHERE BuildingType='BUILDING_HANGING_GARDENS';
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_HANGING_GARDENS' , 'HANGING_GARDENS_REGIONAL_HOUSING');
INSERT INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_HOUSING' , 'HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING' , 'Amount' , '1');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'BuildingType' ,'BUILDING_HANGING_GARDENS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'MaxRange' ,'6');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'MinRange' ,'0');
-- Apadana +1 envoy instead of 2
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='APADANA_AWARD_TWO_INFLUENCE_TOKEN_MODIFIER';
-- Great Library unlocks at Drama & Poetry instead of Recorded History
UPDATE Buildings SET PrereqCivic='CIVIC_DRAMA_POETRY' WHERE BuildingType='BUILDING_GREAT_LIBRARY';
-- Mausoleum at Halicarnassus gives 1 extra retirement Admirals and Generals instead of Admirals and Engineers
UPDATE RequirementArguments SET Value='GREAT_PERSON_CLASS_GENERAL' WHERE RequirementId='REQUIREMENT_UNIT_IS_ENGINEER';
-- Venetian Arsenal gives 100% production boost to all naval units in all cities instead of an extra naval unit in its city each time you build one
DELETE FROM BuildingModifiers WHERE	BuildingType='BUILDING_VENETIAN_ARSENAL';

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_MELEE_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RANGED_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RAIDER_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_CARRIER_PRODUCTION');



--==============================================================
--******			W O N D E R S  (NATURAL)			  ******
--==============================================================
-- Several lack-luster wonders improved
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_PANTANAL', 'YIELD_SCIENCE', 2);
-- Eye of the Sahara gets 2 Food, 2 Production, and 2 Science
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='EYESAHARA_PRODUCTION_ATOMIC' AND Name='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='EYESAHARA_SCIENCE_ATOMIC' AND Name='Amount';
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_EYE_OF_THE_SAHARA', 'YIELD_FOOD', 2);
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_EYE_OF_THE_SAHARA' AND YieldType='YIELD_PRODUCTION';
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_EYE_OF_THE_SAHARA', 'YIELD_SCIENCE', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CLIFFS_DOVER', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_LAKE_RETBA', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_DEAD_SEA', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CRATER_LAKE', 'YIELD_FOOD', 2);
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_CRATER_LAKE' AND YieldType='YIELD_SCIENCE'; 
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW' AND YieldType='YIELD_PRODUCTION';
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW' AND YieldType='YIELD_FOOD';
INSERT INTO Feature_AdjacentYields (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_GALAPAGOS', 'YIELD_FOOD', 1);
-- GS
UPDATE Feature_YieldChanges SET YieldChange='4' WHERE FeatureType='FEATURE_GOBUSTAN'       AND YieldType='YIELD_CULTURE'   ;
UPDATE Feature_YieldChanges SET YieldChange='4' WHERE FeatureType='FEATURE_GOBUSTAN'       AND YieldType='YIELD_PRODUCTION';
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_CULTURE'   ;
UPDATE Feature_YieldChanges SET YieldChange='2' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_SCIENCE'   ;
UPDATE Feature_YieldChanges SET YieldChange='6' WHERE FeatureType='FEATURE_WHITEDESERT'    AND YieldType='YIELD_GOLD'      ;
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_CHOCOLATEHILLS' AND YieldType='YIELD_FOOD'      ;
UPDATE Feature_YieldChanges SET YieldChange='3' WHERE FeatureType='FEATURE_CHOCOLATEHILLS' AND YieldType='YIELD_PRODUCTION';
UPDATE Feature_YieldChanges SET YieldChange='1' WHERE FeatureType='FEATURE_CHOCOLATEHILLS' AND YieldType='YIELD_SCIENCE'   ;

UPDATE Feature_AdjacentYields SET YieldChange='2' WHERE FeatureType='FEATURE_DEVILSTOWER' AND YieldType='YIELD_FAITH';



--==============================================================
--******				    O T H E R					  ******
--==============================================================
-- add 1 production to fishing boat improvement
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_FISHING_BOATS' AND YieldType='YIELD_PRODUCTION';
-- Amani Abuse Fix... can immediately re-declare war when an enemy suzerian removes Amani
UPDATE GlobalParameters SET Value='1' WHERE Name='DIPLOMACY_PEACE_MIN_TURNS';
-- Offshore Oil can be improved at Refining
UPDATE Improvements SET PrereqTech='TECH_REFINING' WHERE ImprovementType='IMPROVEMENT_OFFSHORE_OIL_RIG';
-- Research Labs give +5 base Science instead of +3
UPDATE Building_YieldChanges SET YieldChange=5 WHERE BuildingType='BUILDING_RESEARCH_LAB';
-- Citizen specialists give +1 main yield
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_ACROPOLIS";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_CAMPUS";
UPDATE District_CitizenYieldChanges SET YieldChange=5 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_COMMERCIAL_HUB";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_COTHON";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_ENCAMPMENT";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_HANSA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_HARBOR";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_HOLY_SITE";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_IKANDA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_INDUSTRIAL_ZONE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_LAVRA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_ROYAL_NAVY_DOCKYARD";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_SEOWON";
UPDATE District_CitizenYieldChanges SET YieldChange=5 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_SUGUBA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_THEATER";
-- GATHERING STORM WAR GOSSIP --
DELETE FROM Gossips WHERE GossipType='GOSSIP_MAKE_DOW';
-- Give production for Medieval Naval Units for all applicable policies
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES
	('MEDIEVAL_NAVAL_MELEE_PRODUCTION_CPLMOD'  , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('MEDIEVAL_NAVAL_RAIDER_PRODUCTION_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('MEDIEVAL_NAVAL_RANGED_PRODUCTION_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES
	('MEDIEVAL_NAVAL_MELEE_PRODUCTION_CPLMOD'  , 'UnitPromotionClass' , 'PROMOTION_CLASS_NAVAL_MELEE'  , '-1'),
	('MEDIEVAL_NAVAL_MELEE_PRODUCTION_CPLMOD'  , 'EraType'            , 'ERA_MEDIEVAL'                 , '-1'),
	('MEDIEVAL_NAVAL_MELEE_PRODUCTION_CPLMOD'  , 'Amount'             , '100'                          , '-1'),
	('MEDIEVAL_NAVAL_RAIDER_PRODUCTION_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_NAVAL_RAIDER' , '-1'),
	('MEDIEVAL_NAVAL_RAIDER_PRODUCTION_CPLMOD' , 'EraType'            , 'ERA_MEDIEVAL'                 , '-1'),
	('MEDIEVAL_NAVAL_RAIDER_PRODUCTION_CPLMOD' , 'Amount'             , '100'                          , '-1'),
	('MEDIEVAL_NAVAL_RANGED_PRODUCTION_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_NAVAL_RANGED' , '-1'),
	('MEDIEVAL_NAVAL_RANGED_PRODUCTION_CPLMOD' , 'EraType'            , 'ERA_MEDIEVAL'                 , '-1'),
	('MEDIEVAL_NAVAL_RANGED_PRODUCTION_CPLMOD' , 'Amount'             , '100'                          , '-1');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES
	('POLICY_INTERNATIONAL_WATERS' , 'MEDIEVAL_NAVAL_MELEE_PRODUCTION_CPLMOD' ),
	('POLICY_INTERNATIONAL_WATERS' , 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION_CPLMOD'),
	('POLICY_INTERNATIONAL_WATERS' , 'MEDIEVAL_NAVAL_RANGED_PRODUCTION_CPLMOD'),
	('POLICY_PRESS_GANGS'          , 'MEDIEVAL_NAVAL_MELEE_PRODUCTION_CPLMOD' ),
	('POLICY_PRESS_GANGS'          , 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION_CPLMOD'),
	('POLICY_PRESS_GANGS'          , 'MEDIEVAL_NAVAL_RANGED_PRODUCTION_CPLMOD');



--==============================================================
--******				START BIASES					  ******
--==============================================================
-- take up essential coastal spots first
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_ENGLAND' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_PHOENICIA' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_INDONESIA' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_NORWAY' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_NETHERLANDS' AND TerrainType='TERRAIN_COAST';
-- must haves
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_SPAIN' AND TerrainType='TERRAIN_COAST';
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES ('CIVILIZATION_JAPAN' , 'TERRAIN_COAST' , 2);
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_NUBIA' AND TerrainType='TERRAIN_DESERT_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_NUBIA' AND TerrainType='TERRAIN_DESERT';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_MALI' AND TerrainType='TERRAIN_DESERT_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_MALI' AND TerrainType='TERRAIN_DESERT';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_TUNDRA';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_SNOW_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_CANADA' AND TerrainType='TERRAIN_SNOW';
-- identities
UPDATE StartBiasFeatures SET Tier=3 WHERE CivilizationType='CIVILIZATION_EGYPT' AND FeatureType='FEATURE_FLOODPLAINS';
UPDATE StartBiasResources SET Tier=3 WHERE CivilizationType='CIVILIZATION_SCYTHIA' AND ResourceType='RESOURCE_HORSES';
UPDATE StartBiasResources SET Tier=3 WHERE CivilizationType='CIVILIZATION_MONGOLIA' AND ResourceType='RESOURCE_HORSES';
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES
	('CIVILIZATION_NUBIA' , 'TERRAIN_PLAINS'  , 3),
	('CIVILIZATION_NUBIA' , 'TERRAIN_PLAINS_HILLS' , 3);
-- river mechanics
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_NETHERLANDS';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_HUNGARY';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_KHMER';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_SUMERIA';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_FRANCE';
-- other mechanics
UPDATE StartBiasFeatures SET Tier=4 WHERE CivilizationType='CIVILIZATION_EGYPT' AND FeatureType='FEATURE_FLOODPLAINS_PLAINS';
UPDATE StartBiasFeatures SET Tier=4 WHERE CivilizationType='CIVILIZATION_EGYPT' AND FeatureType='FEATURE_FLOODPLAINS_GRASSLAND';
UPDATE StartBiasFeatures SET Tier=4 WHERE CivilizationType='CIVILIZATION_BRAZIL' AND FeatureType='FEATURE_JUNGLE';
UPDATE StartBiasFeatures SET Tier=4 WHERE CivilizationType='CIVILIZATION_KONGO' AND FeatureType='FEATURE_JUNGLE';
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES
	('CIVILIZATION_GEORGIA' , 'TERRAIN_PLAINS_HILLS' , 4),
	('CIVILIZATION_GEORGIA' , 'TERRAIN_GRASS_HILLS' , 4);
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_GRASS_HILLS';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_PLAINS_HILLS';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_INCA' AND TerrainType='TERRAIN_DESERT_MOUNTAIN';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_INCA' AND TerrainType='TERRAIN_GRASS_MOUNTAIN';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_INCA' AND TerrainType='TERRAIN_PLAINS_MOUNTAIN';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_KOREA' AND TerrainType='TERRAIN_GRASS_MOUNTAIN';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_KOREA' AND TerrainType='TERRAIN_PLAINS_MOUNTAIN';
UPDATE StartBiasResources SET Tier=4 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_CATTLE';
UPDATE StartBiasResources SET Tier=4 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_HORSES';
UPDATE StartBiasResources SET Tier=4 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_SHEEP';
--scythia
INSERT INTO StartBiasResources (CivilizationType , ResourceType , Tier)
	VALUES
	('CIVILIZATION_SCYTHIA' , 'RESOURCE_SHEEP'  , 4),
	('CIVILIZATION_SCYTHIA' , 'RESOURCE_CATTLE' , 4);
-- other
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_DESERT_HILLS';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_KOREA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_KOREA' AND TerrainType='TERRAIN_DESERT_HILLS';
UPDATE StartBiasFeatures SET Tier=5 WHERE CivilizationType='CIVILIZATION_KONGO' AND FeatureType='FEATURE_FOREST';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_MAPUCHE' AND TerrainType='TERRAIN_PLAINS_MOUNTAIN';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_MAPUCHE' AND TerrainType='TERRAIN_GRASS_MOUNTAIN';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_MAPUCHE' AND TerrainType='TERRAIN_DESERT_MOUNTAIN';
DELETE FROM StartBiasTerrains WHERE CivilizationType='CIVILIZATION_MAPUCHE' AND TerrainType='TERRAIN_TUNDRA_MOUNTAIN';

