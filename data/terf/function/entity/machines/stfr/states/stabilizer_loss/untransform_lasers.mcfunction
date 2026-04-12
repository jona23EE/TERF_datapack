$execute as @e[tag=terf_related_$(machine_id),tag=terf_stab_loss_laser] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{scale:[8.01f,8.01f,0f]}}
playsound terf:opencore.lock_material master @a[distance=0..] ~ ~ ~ 10 2
