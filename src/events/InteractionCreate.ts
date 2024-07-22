import type { DiscordClient } from "@/lib/client";
import { Logger } from "@/lib/logger";
import EventModule from "@/lib/decorators/EventModule";
import {Interaction} from "discord.js";

@EventModule({
    Event: "InteractionCreate",
    Handler: async (interaction: Interaction) => {
        console.log("interactioncreate")
    },
})
class InteractionCreate {}

export default InteractionCreate;
