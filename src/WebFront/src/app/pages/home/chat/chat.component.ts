import { Component, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { Observable } from 'rxjs';
import { Friend } from 'src/app/models/user/friend';
import { GroupOfUsers } from 'src/app/models/user/groupOfUsers';
import { UserService } from 'src/app/services/userServices/user.service';
import { SignalrService } from 'src/app/services/signalR/signalr.service';



export interface User{
  userName: string,
  friendDTOs: Friend[],
  groupOfUserDTOs: GroupOfUsers[]
}

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit {


  user: Partial<User> = {};
  id: Subject<number> = new Subject<number>();
  constructor(private _userService: UserService, private _signalR: SignalrService) {

    this.user.friendDTOs! = [];
   }



  ngOnInit(): void {
   this._userService.getDataAboutUser().subscribe(data =>
    {
      this.user = data ;
    });
    this._signalR.startConnection();

  }
  selectChat(id:number){
    this.id.next(id);
  }

}


