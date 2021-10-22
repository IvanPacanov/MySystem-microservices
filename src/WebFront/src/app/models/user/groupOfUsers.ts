import { Message } from "./message";
import { UserDTO } from "./user";

export interface GroupOfUsers{
    groupName: string,
    users: UserDTO[]
    messages: Message[]
}
