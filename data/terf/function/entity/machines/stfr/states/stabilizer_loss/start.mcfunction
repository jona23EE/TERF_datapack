playsound terf:music.hacknet_labyrinths_ogre_snidelywhiplash ui @a[distance=0..,tag=!terf_disable_music] ~ ~ ~ 10 1
scoreboard players set @s terf_data_A 16
scoreboard players set @s terf_data_E 0
scoreboard players set @s terf_data_Ab 0

function terf:entity/machines/stfr/broadcast {bcd:"return 1",voiceline:"none",level:5,text:'{"text":"Complete Stabilization Loss Detected! Preparing Contingency Protocols.","color":"red"}'}

#assemble stabilizer rotors
execute rotated 0 -90 run function terf:entity/machines/stfr/states/stabilizer_loss/check_stabilizer_rotor {stab:"u"}
execute rotated 0 90 run function terf:entity/machines/stfr/states/stabilizer_loss/check_stabilizer_rotor {stab:"d"}

execute rotated 0 0 run function terf:entity/machines/stfr/states/stabilizer_loss/check_stabilizer_rotor {stab:"s"}
execute rotated 180 0 run function terf:entity/machines/stfr/states/stabilizer_loss/check_stabilizer_rotor {stab:"n"}

execute rotated 90 0 run function terf:entity/machines/stfr/states/stabilizer_loss/check_stabilizer_rotor {stab:"w"}
execute rotated -90 0 run function terf:entity/machines/stfr/states/stabilizer_loss/check_stabilizer_rotor {stab:"e"}
