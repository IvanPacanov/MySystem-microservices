import { Component, DoCheck, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges } from '@angular/core';
import { Friend } from 'src/app/models/user/friend';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit, OnChanges  {

  @Output() idFriend  = new EventEmitter<number>();
  @Input() friends: Friend[] | any;
  constructor() { }
  ngOnChanges(changes: SimpleChanges): void {
  }

  ngOnInit(): void {
  }

  onClick(id: number){
      this.idFriend.emit(id);
  }

}
