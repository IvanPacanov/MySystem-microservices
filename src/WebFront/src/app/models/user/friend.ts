import { Message } from "./message";

export interface Friend{
    id: number,
    userName: string,
    messageDTOs: Message[]
}
