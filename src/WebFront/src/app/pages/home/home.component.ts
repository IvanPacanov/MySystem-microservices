import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Console } from 'console';
import { Subscription } from 'rxjs';
import { UserDTO } from 'src/app/models/user/user';
import { SignalrService, UserInfo } from 'src/app/services/signalR/signalr.service';
import { UserService } from 'src/app/services/userServices/user.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  public subscriptions = new Subscription();
  user: Partial<UserDTO> = {};
  userName: string;
  constructor(private route: ActivatedRoute, private _userService: UserService, private _signalR: SignalrService) { }



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

}
