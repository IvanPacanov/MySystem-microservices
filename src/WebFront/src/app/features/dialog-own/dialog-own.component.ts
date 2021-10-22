import { Component, EventEmitter, OnInit, Output } from '@angular/core';

@Component({
  selector: 'app-dialog-own',
  templateUrl: './dialog-own.component.html',
  styleUrls: ['./dialog-own.component.css']
})
export class DialogOwnComponent implements OnInit {

  @Output() addUserNick= new EventEmitter<string>();
userNick: string;
  constructor() { }

  ngOnInit(): void {
  }
  onAddUser(){
    this.addUserNick.emit(this.userNick);
  }
}
