import { Injectable } from '@angular/core';
import * as signalR from "@microsoft/signalr"
import { Subject } from 'rxjs';
import { Message } from 'src/app/models/user/message';

export interface UserInfo {
  userName: string;
  connectionId: string;
}

@Injectable({
  providedIn: 'root'
})
export class SignalrService {


  private helloAnswer = new Subject<UserInfo>();
  public helloAnswer$ = this.helloAnswer.asObservable();


  private messageResponse = new Subject<Message>();
  public messageResponse$ = this.messageResponse.asObservable();


  private hubConnection: signalR.HubConnection;

  private newPeer = new Subject<void>();
  public newPeer$ = this.newPeer.asObservable();


  constructor() { }

  public async startConnection(): Promise<void>{

    console.log("Połączenie")
    this.hubConnection = new signalR.HubConnectionBuilder()
    .withUrl('https://localhost:5000/ConnectionHub')
    .build();
    this.hubConnection.serverTimeoutInMilliseconds = 100000;

        await this.hubConnection.start();
        console.log('Connection started');

        this.hubConnection.on('SendMessageToUser', (data) => {
          console.log(data)
          this.messageResponse.next(JSON.parse(data));
        });

        // this.hubConnection.on('sendMessageToUser', (data: string) => {
        //   this.messageResponse.next(JSON.parse(data));
        // });

  }

  public sendMessageToUser(signal: string, message: Message) {
    this.hubConnection.invoke('SendMessage', message, signal);
  }

  public onLoginUser(name: string) {
    this.hubConnection.invoke('Join', name);
  }

  public sendSignalToUser(signal: string, user: string) {
    this.hubConnection.invoke('SendSignal', signal, user);
  }

}
