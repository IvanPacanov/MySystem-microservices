import { Injectable } from '@angular/core';
import { Message } from '@app/models/user/message';
import { Subject } from 'rxjs';
import * as signalR from "@microsoft/signalr";
import { UserInfo } from '../RtcServices/rtc.services';


export interface SignalInfo {
  user: string;
  signal: any;
}

export interface HangUp {
  user: string;
  message: string;
}

@Injectable({
  providedIn: 'root'
})
export class SignalrService {


  private helloAnswer = new Subject<UserInfo>();
  public helloAnswer$ = this.helloAnswer.asObservable();


  private updateOnlineUser = new Subject<UserInfo>();
  public updateOnlineUser$ = this.updateOnlineUser.asObservable();


  private messageResponse = new Subject<Message>();
  public messageResponse$ = this.messageResponse.asObservable();

  private signal = new Subject<SignalInfo>();
  public signal$ = this.signal.asObservable();


  private hangUp = new Subject<HangUp>();
  public hangUp$ = this.hangUp.asObservable();


  private hubConnection: signalR.HubConnection;

  private newPeer = new Subject<UserInfo>();
  public newPeer$ = this.newPeer.asObservable();


  constructor() { }

  public async startConnection(): Promise<void>{

    console.log("Połączenie")
    this.hubConnection = new signalR.HubConnectionBuilder()
    .withUrl('https://192.168.1.106:5000/ConnectionHub')
    .build();
    this.hubConnection.serverTimeoutInMilliseconds = 100000;

        await this.hubConnection.start();
        console.log('Connection started');

        this.hubConnection.on('SendMessageToUser', (data) => {
          this.messageResponse.next(JSON.parse(data));
        });

        this.hubConnection.on('UpdateUserList', (data) => {
          this.updateOnlineUser.next(JSON.parse(data));
        });

        this.hubConnection.on('SendSignal', (user, signal) => {
          this.signal.next({ user, signal });
        });
  }

  public sendMessageToUser(signal: string, message: Message) {
    this.hubConnection.invoke('SendMessage', message, signal);
  }


  public callToUser(signal: string, message: Message) {
    this.hubConnection.invoke('SendMessage', message, signal);
  }

  public onLoginUser(name: string) {
    this.hubConnection.invoke('Join', name);
  }

  public sendSignalToUser(signal: string, user: string) {
    this.hubConnection.invoke('SendSignal', signal, user);
  }

}
