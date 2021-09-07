import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { Observable } from 'rxjs';
import { switchMapTo } from "rxjs/operators";
import { Message } from 'src/app/models/user/message';
import { UserService } from 'src/app/services/userServices/user.service';

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.css']
})
export class MessagesComponent implements OnInit, OnChanges{

  @Input() messages: Message[];
  @Input() id: number;
  constructor(private _server: UserService) { }
  ngOnChanges(changes: SimpleChanges): void {
  }

  ngOnInit(): void {
  //  this.id.subscribe(data =>{
  //     switchMapTo(this.messages =  this._server.getDataAboutUserMesages(data))
  //   }
  //   );
  }

}
