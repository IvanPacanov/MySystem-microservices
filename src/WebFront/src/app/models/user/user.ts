import { Friend } from "./friend";
import { GroupOfUsers } from "./groupOfUsers";

export interface User{
    userName: string,
    friendlyUsers: Friend[],
    groupOfUsers: GroupOfUsers[]
}