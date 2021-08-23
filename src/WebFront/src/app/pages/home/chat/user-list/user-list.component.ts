import { Component, DoCheck, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Friend } from 'src/app/models/user/friend';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit  {

  @Output() idFriend  = new EventEmitter<number>();
  @Input() friends: Friend[] | any;
  constructor() { }

  ngOnInit(): void {
  }

  onClick(id: number){
      this.idFriend.emit(id);
  }

}
