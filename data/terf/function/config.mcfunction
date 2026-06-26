#Here are the configs for the Troty Energy Research Facility (TERF) datapack!
#ONLY change numbers here and DO NOT use fractionals like 0.6, 7.5, etc!!! <- If you mess that up then the system will say "SYNTAX ERRORS! Config loading failed!"
#Do not change random stuff unless you know what your doing!

#Non Essential Tick (NET) rate, basically the delay between cable updates, structure checks and some other stuff (in ticks)
scoreboard players set NETrate terf_states 90

#Disable the ability of hadron beam to explode
scoreboard players set disable_block_damage terf_states 0

#Self explainatory
scoreboard players set playamongusjoinsound terf_states 1

#Self explainatory
scoreboard players set ender_pearls_explode_after_awhile terf_states 1

#Allow the datapack to change the weather of the world? (when meltdowns, fallout etc.)
scoreboard players set allow_weather_changes terf_states 1

#Should players die without air in space?
scoreboard players set enable_oxygen_system terf_states 1

#Should players start bleeding when they break glass or glass panes?
scoreboard players set glass_break_bleeding terf_states 1

######################################################################################################################################################################################

# HOVERBIKE

# Basically the air resistance of the hoverbike. 1000 = no resistance, 0 = cant even move
scoreboard players set hoverbike_floatyness terf_states 980

######################################################################################################################################################################################

# TOOLS

#If a player tries to use a fluid id tool on a tank that isnt empty, should it error instead of reseting the tanks amount?
scoreboard players set restricted_fluid_id terf_states 0

######################################################################################################################################################################################

# MRT

#How fast should the beam of the manual railgun turret go? (in 1/10 blocks per tick)
scoreboard players set photon_beam_speed terf_states 1000

#How many ticks should the trails of the photon beam last for?
scoreboard players set photon_beam_last terf_states 5

######################################################################################################################################################################################

# SOLAR PANEL

#How many lapis blocks to make one MW of power multiplied by 6000 (which is the peak daytime)
scoreboard players set solar_panel_generation_divider terf_states 54000

######################################################################################################################################################################################

# MCFR

#self explainatory
scoreboard players set mcfr_fuel_usage_divider terf_states 30

#total divider for the cooling rate of the mcfr
scoreboard players set mcfr_stfr_cooling_rate_divider terf_states 12000000

#multiplier for how much should the cooling rate cool the mcfr, basically the efficiency.
scoreboard players set mcfr_cooling_multiplier terf_states 120000

######################################################################################################################################################################################

# PRESSURIZER

#set this to a higher value for pressurizers to fill areas faster, and detect leaks faster but also cause more lag.
scoreboard players set pressurizer_particle_count terf_states 1

######################################################################################################################################################################################
# STORAGE TERMINAL

#how much power should the storage terminal need per item sent in mwt?
scoreboard players set storage_terminal_mwt_per_item terf_states 10

######################################################################################################################################################################################
# FLUID TANK

#what should be the maximum volume of the tanks?
scoreboard players set max_tank_volume terf_states 1000

######################################################################################################################################################################################

# BATTERY ARRAY

#how much mwt can a single battery block store?
#this is actually a pretty interisting number, a current (2025) real life battery bank is calculated to
#be able to store 720mwt, i used chatgpt to predict that a battery of this size (133 liters) will store
#11.5x more power in the next 50 years, which comes out to 5040. given that terf batteries are 339%
#bigger than the batteries i looked up, 339% of 5040 is 17085.
scoreboard players set mwt_per_battery_block terf_states 17085

######################################################################################################################################################################################

# MULTI-PISTON

#how many blocks can the multi-piston push or pull?
scoreboard players set multi_piston_push_limit terf_states 32

######################################################################################################################################################################################

# WARP CORE

#how high can the max ship size go on each axis?
scoreboard players set warp_core_max_size terf_states 75

#power required for teleporting one block with the warp core?
scoreboard players set warp_core_power_required_block terf_states 10000

######################################################################################################################################################################################

# METEORS

#meteor penetration
scoreboard players set meteor_penetration terf_states 1

######################################################################################################################################################################################
# STFR

#How much to divide shield permeability's effectiveness by?
scoreboard players set stfr_shield_permeability_divider terf_states 5000

#How much to divide shield permeability's effectiveness by?
scoreboard players set stfr_pressure_vent_divider terf_states 20000

#How many raycasts should the stfr explosion summon in total?
scoreboard players set stfr_explosion_raycasts terf_states 1000000

#How many vanilla explosions should the stfr explosion summon per tick maximum?
scoreboard players set stfr_max_explosions_per_tick terf_states 2

#How big of a square should the S.T.F.R load before exploding? (in chunks, make sure it fits the explosion size)
scoreboard players set stfr_explosion_load_radius terf_states 32

#Divider value for the STFR reactor's case pressure remove rate, higher value = less case pressure removed when the case is broken
scoreboard players set stfr_case_pressure_remove_rate_divider terf_states 101

#Divider value for the STFR reactor's pressure shield stress, lower value = more shield stress from increasing core pressure
scoreboard players set stfr_pressure_shield_stress_divider terf_states 60000

#Divider value for the STFR reactor's core spin shield stress, lower value = more shield stress from increasing core spin
scoreboard players set stfr_spin_shield_stress_divider terf_states 4000

#Divider value for the STFR reactor's magnetic shield stress reduction (MSSR) level, lower value = more effect the core spin has on reducing the core temp and core pressure shield stresses
scoreboard players set stfr_mssr_divider terf_states 2500

#Divider value for the STFR reactor's cooling rate per case temp, lower value = more the reactor cools with the same case temp and more power it makes
scoreboard players set stfr_cooling_rate_divider terf_states 420

#Use these to set when the spin shield stress starts increasing exponentially
scoreboard players set stfr_spin_shield_stress_exp_divider terf_states 200
scoreboard players set stfr_spin_shield_stress_exp_subtractor terf_states 800

######################################################################################################################################################################################

# TURBINES

#Divider value for the large turbine's power output, lower value = more power output per steam
scoreboard players set large_turbine_gen_divider terf_states 3

#Divider value for the medium turbine's power output, lower value = more power output per steam
scoreboard players set medium_turbine_gen_divider terf_states 3

#How much power in mw should the medium turbine be allowed to produce per drum?
scoreboard players set medium_turbine_mw_per_drum terf_states 400

######################################################################################################################################################################################

# DONT TOUCH

#Developer config
scoreboard players set dev_mode terf_states 0

scoreboard players set stfr_always_fail_startup terf_states 0