import { Message } from "./message";
import { User } from "./user";

export interface GroupOfUsers{
    groupName: string,
    users: User[]
    messages: Message[]
}