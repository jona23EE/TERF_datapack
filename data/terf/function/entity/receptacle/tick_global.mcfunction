scoreboard players remove receptacle_tick terf_states 1
execute as @e[type=interaction,tag=terf_receptacle] at @s run function terf:entity/receptacle/tick_dispatch
