# Rules for Contribution:
!! By submitting a contribution, you agree that your code will be licensed under the project’s license !!
- Changes that break the balance or progression of the datapack will be rejected or rebalanced if possible
- Ask @jona23 before making extreme changes to the gameplay, like a new reactor or a big machine a long time before contributing. Don't waste your time making something that won't be added.
- Code that is bad, unoptimized or is laggy in nature will be rejected, use proper APIs
- Useless changes, like another machine that makes slimeballs will be rejected

# How to make your code professional:
## For machines:
- Name the function of your machine that runs every tick "tick"
- Name the function that runs only during slowticks "slower_tick", this could be your main tick function aswell with the tag "terf_slower_ticked"
- Name the function of your machine that is reponsible for its setup "setup"
- Name the function of your machine that runs when its online (if it isn't in tick.mcfunction) "operation"
- If it's a control panel, name the function that the parent machine runs "as_core_at_control_panel"

## For tools:
- Name the function(s) that runs when the player rclicks with the tool "activated" or "activated_offhand"
- Name the function(s) that run when the player holds the tool "held" or "held_offhand"
