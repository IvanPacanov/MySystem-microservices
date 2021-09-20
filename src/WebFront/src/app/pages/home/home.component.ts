import { Component, ElementRef, OnInit, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { UserDTO } from '@app/models/user/user';
import { SignalrService } from '@app/services/signalR/signalr.service';
import { UserService } from '@app/services/userServices/user.service';
import { Console } from 'console';
import { Subscription } from 'rxjs';

export interface AddUserDTO{
  id: number,
  userName: string
}

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {


  @ViewChild('toggleButton') toggleButton: ElementRef;
  @ViewChild('dialog') dialog: ElementRef;
  public subscriptions = new Subscription();
  user: Partial<UserDTO> = {};
  userName: string;
  constructor(private route: ActivatedRoute, private _userService: UserService, private _signalR: SignalrService) {}


  ngOnInit(): void {
    this.route.params.subscribe((params: Params) => this.userName = params['userName']);

    this._userService.getDataAboutUser(this.userName).subscribe(data =>
      {
        this.user = data ;

      });

      this._signalR.startConnection().then(() => {this._signalR.onLoginUser(this.userName)

      })
      // this.subscriptions.add(this._signalR.helloAnswer$.subscribe((user: UserInfo) => {
      //    console.log(user)
      //    console.log("Test1")
      //    console.log(this.user);
      // }));

  }
  isMenuOpen  = false;

  addNewUser(add: boolean){
    this.isMenuOpen = add;
  }
   aaa: AddUserDTO;

  addNewUserNice(nick: string){
    this.aaa = {
      id: 3,
      userName: nick
    }
    this._userService.AddNewFriend(this.aaa).subscribe()
    this.isMenuOpen  = false;
  }

}
