import { Injectable } from '@angular/core';
import * as signalR from "@microsoft/signalr"
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SignalrService {

  private hubConnection: signalR.HubConnection;

  private newPeer = new Subject<void>();
  public newPeer$ = this.newPeer.asObservable();


  constructor() { }

  public async startConnection(): Promise<void>{

    console.log("Połączenie")
    this.hubConnection = new signalR.HubConnectionBuilder()
        .withUrl('https://localhost:5000/ConnectionHub')
        .build();

        await this.hubConnection.start();
        console.log('Connection started');

        
    this.hubConnection.invoke('NewUser', "Eloo");
  }

}
