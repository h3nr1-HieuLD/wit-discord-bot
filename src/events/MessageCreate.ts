import EventModule from "@/lib/decorators/EventModule";
import ThreadController from "@/events/chat/ThreadController";

@EventModule({
    Event: "MessageCreate",
    Handler: [
        ThreadController,
    ],
})
class MessageCreate {}

export default MessageCreate;
