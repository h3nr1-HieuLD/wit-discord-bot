import MessageListener from "@/lib/decorators/MessageListener";
import { Filter } from "@/lib/filter";
import { IMessageListenerHandler } from "@/lib/interfaces/IMessageListenerHandler";
import MessageData from "@/lib/decorators/Message";
import {Message, TextChannel} from "discord.js";
import useDiscordClient from "@/lib/hooks/useDiscordClient";

@MessageListener([Filter.anyMessage()])
class ThreadController implements IMessageListenerHandler {
    async handler(@MessageData() message: Message) {
        if (message.author.bot && message.author.username != "Jenkins") return;
        try {
            const client = useDiscordClient()
            const channel = await client.channels.fetch(message.channelId)
            await message.delete()
            if (channel instanceof TextChannel) {
                const exitThread =
                    channel.threads.cache.filter(thread => thread.name == "Builds")
                if (exitThread.size > 0) {
                    exitThread.first()?.send({
                        embeds: message.embeds,
                        content: message.content + '-----------------------------------------------------------'
                    })
                } else {
                    const thread = await channel.threads.create({
                        name: "Builds",
                        autoArchiveDuration: 60,
                        reason: "Thread for builds",
                    })
                    // if (message.content)
                    // await thread.send(message.content)
                    console.log("before sending")
                    await thread.send({
                        embeds: message.embeds,
                        content: message.content + '.'
                    })
                }
            }
        }
        catch (err) {}
    }
}

export default ThreadController;
