import EventModule from "@/lib/decorators/EventModule";
import CheckIn from "@/events/chat/Checkin";
import KickMember from "@/events/chat/KickMember";
import Meeting from "@/events/chat/Meeting";
import Mention from "@/events/chat/Mentions";
import Rule from "@/events/chat/Rules";
import GetId from "@/events/chat/GetId";
import GetCheckInList from "@/events/chat/GetCheckInList";
import UserGetRole from "@/events/chat/UserGetRole";
import AddMember from "@/events/chat/AddMember";
import EndMeeting from "@/events/chat/EndMeeting";
import ThreadController from "@/events/chat/ThreadController";

@EventModule({
    Event: "MessageCreate",
    Handler: [
        CheckIn,
        AddMember,
        EndMeeting,
        KickMember,
        Meeting,
        Mention,
        Rule,
        GetId,
        GetCheckInList,
        UserGetRole,
        ThreadController,
    ],
})
class MessageCreate {}

export default MessageCreate;
