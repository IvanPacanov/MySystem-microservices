import { Component, Input, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { switchMapTo } from "rxjs/operators";
import { Message } from 'src/app/models/user/message';
import { UserService } from 'src/app/services/userServices/user.service';

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.css']
})
export class MessagesComponent implements OnInit {

  messages: Observable<Message[]>;
  @Input() id: Observable<number>;
  constructor(private _server: UserService) { }

  ngOnInit(): void {
   this.id.subscribe(data =>{
      switchMapTo(this.messages =  this._server.getDataAboutUserMesages(data))
    }
    );
  }

}
