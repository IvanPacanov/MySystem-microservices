import { Component, Input, OnInit } from '@angular/core';
import { Subject, Subscription } from 'rxjs';
import { Observable } from 'rxjs';
import { Friend } from 'src/app/models/user/friend';
import { GroupOfUsers } from 'src/app/models/user/groupOfUsers';
import { UserService } from 'src/app/services/userServices/user.service';
import { SignalrService, UserInfo } from 'src/app/services/signalR/signalr.service';
import { Message } from 'src/app/models/user/message';




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
  public subscriptions = new Subscription();
  @Input() user: Partial<User>;
  message: string;
  messageDTO: Message[];
  //id: Subject<number> = new Subject<number>();
  id: number = 0;
  constructor(private _userService: UserService, private _signalR: SignalrService) {

   }



   ngOnInit(): void {
     this.subscriptions.add(this._signalR.messageResponse$.subscribe((data: Message) => {
           const message: Message = {
        sendingBy: data.sendingBy,
        sending: data.sending,
        text: data.text
      }
        this.user.friendDTOs![0].messageDTOs.push(message);
   }));

  }
  selectChat(id:number){
    this.id= id;
  }

  onEnter(){
    const str: Message = {
      sendingBy: "Guest",
      sending: new Date().toLocaleTimeString() + " " + new Date().toLocaleDateString(),
      text: this.message
     }
     console.log(str)
    this._signalR.sendMessageToUser("Admin", str);
    this.user.friendDTOs![0].messageDTOs.push(str);
    console.log(this.user.friendDTOs)
  }

}


