import { Friend } from "./friend";
import { GroupOfUsers } from "./groupOfUsers";

export interface UserDTO{
    userName: string,
    friendlyUsers: Friend[],
    groupOfUsers: GroupOfUsers[]
}
