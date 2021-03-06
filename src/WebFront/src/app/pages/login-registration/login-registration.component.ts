import { Component, OnInit } from '@angular/core';
import { SignalrService } from '@app/services/signalR/signalr.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-login-registration',
  templateUrl: './login-registration.component.html',
  styleUrls: ['./login-registration.component.css']
})
export class LoginRegistrationComponent implements OnInit {


  public subscriptions = new Subscription();

  constructor(private signalR: SignalrService) { }

  ngOnInit(): void {


    this.subscriptions.add(this.signalR.newPeer$.subscribe(() => {
           this.signalR.startConnection();
    }));

    this.saveUsername();
  }

  public async saveUsername(): Promise<void> {
    try {
      console.log("mordeczko");
      await this.signalR.startConnection();
  }
  catch{

  }
}

}
