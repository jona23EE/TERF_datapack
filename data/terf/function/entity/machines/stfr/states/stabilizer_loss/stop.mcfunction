scoreboard players set @s terf_data_A 3

function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:"none",level:1,text:'{"text":"Reactor Shield Has Been Succesfully Preserved."}'}
$kill @e[tag=terf_stab_loss_laser,tag=terf_related_$(machine_id)]


scoreboard objectives remove terf_shake_frequency
scoreboard objectives remove terf_shake_magnitude
scoreboard objectives add terf_shake_frequency dummy
scoreboard objectives add terf_shake_magnitude dummy

scoreboard players add @a[distance=..160] terf_data_P 30

tag @s remove terf_restabilizing