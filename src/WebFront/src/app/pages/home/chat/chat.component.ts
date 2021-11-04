import { Component, ElementRef, EventEmitter, Inject, Input, OnInit, Output, Renderer2, ViewChild } from '@angular/core';
import { Subject, Subscription } from 'rxjs';
import { Observable } from 'rxjs';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';
import { GroupOfUsers } from '@app/models/user/groupOfUsers';
import { Friend } from '@app/models/user/friend';
import { Message } from '@app/models/user/message';
import { UserService } from '@app/services/userServices/user.service';
import { SignalInfo, SignalrService } from '@app/services/signalR/signalr.service';
import { DialogComponent } from './dialog/dialog.component';
import { PeerData, RtcService, UserInfo } from '@app/services/RtcServices/rtc.services';
import { map, switchMapTo, takeUntil } from "rxjs/operators";
import { ConfirmCallingComponent } from './confirm-calling/confirm-calling.component';


export interface DialogData {
  animal: string;
  name: string;
}

export interface aspInterf{
  UserName: string,
  ConnectionId: string
}

export interface User{
  userName: string,
  friendDTOs: Friend[],
  groupOfUserDTOs: GroupOfUsers[]
}

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit {
  public subscriptions = new Subscription();
  @Input() user: Partial<User>;
  @Output() addNewUser  = new EventEmitter<boolean>();
  @ViewChild('toggleButton') toggleButton: ElementRef;
  @ViewChild('videoPlayer') videoPlayer: ElementRef;
  message: string;

  private stream;
  animal: string;
  name: string;
  messageDTO: Message[];
  //id: Subject<number> = new Subject<number>();
  id: number = 0;
  userIN: UserInfo[] = [];

private isConnecting: boolean = false;

  constructor(
    private rtcService: RtcService,
    private _signalR: SignalrService,
    public dialog: MatDialog,
    private renderer: Renderer2) {
      this.renderer.listen('window', 'click',(e:Event)=>{
         if(e.target !== this.toggleButton.nativeElement){
           const z = e.target as HTMLInputElement;
          if(z.id !== "dialog")
             this.addNewUser.emit(false);
        }
        else{
          this.addNewUser.emit(true);
        }
      });
    }


   ngOnInit() {
    this.subscriptions.add(this.rtcService.onSignalToSend$.subscribe((data: PeerData) => {
      this._signalR.sendSignalToUser(data.data, data.id);
    }));

    this.subscriptions.add(this._signalR.signal$.subscribe((signalData: SignalInfo) => {
      if(!this.isConnecting){
        this.openDialog(signalData)
        this.isConnecting = true;
      }
      else{
        this.rtcService.signalPeer(signalData.user, signalData.signal, this.stream);
      }
    }));






      // this.messages = new Array();

      this.subscriptions.add(this._signalR.newPeer$.subscribe((user: UserInfo) => {
        this.rtcService.newUser(user);
        this._signalR.onLoginUser(this.name);
      }));

      this.subscriptions.add(this._signalR.helloAnswer$.subscribe((user: UserInfo) => {

        console.log("HELOO")
        this.rtcService.newUser(user);
      }));

      // this.subscriptions.add(this._signalR.disconnectedPeer$.subscribe((user: UserInfo) => {
      //   this.rtcService.disconnectedUser(user);
      // }));





      // this.subscriptions.add(this.rtcService.onData$.subscribe((data: PeerData) => {
      //   this.messages = [...this.messages, { own: false, message: data.data }];
      //   console.log(`Data from user ${data.id}: ${data.data}`);
      // }));


         this.subscriptions.add(this._signalR.messageResponse$.subscribe((data: Message) => {
           const message: Message = {
        sendingBy: data.sendingBy,
        sending: data.sending,
        text: data.text
      }
        this.user.friendDTOs![0].messageDTOs.push(message);
      }));

   this.subscriptions.add(this._signalR.updateOnlineUser$.subscribe((data: UserInfo) =>
   {
      const user: UserInfo = {
        userName: data[0].Username,
        connectionId: data[0].ConnectionId
      }
      this.userIN.push(user);
    }))

      this.subscriptions.add(this.rtcService.onStream$.subscribe((data: PeerData) => {
       // this.userVideo = data.id;
       console.log(data)
        this.videoPlayer.nativeElement.srcObject = data.data;
        this.videoPlayer.nativeElement.load();
        this.videoPlayer.nativeElement.play();
      }));
    }



  public onUserSelected(userInfo: number) {
    console.log("POCZĄTEK")
   console.log(this.stream);
   console.log(this.userIN[userInfo].connectionId)
   console.log("KONIEC")

    const peer = this.rtcService.createPeer(this.stream, this.userIN[userInfo].connectionId, true);
     this.rtcService.currentPeer = peer;
  }


  openDialog(signalData: SignalInfo): void {
    const dialogRef = this.dialog.open(ConfirmCallingComponent, {
      width: '250px',
      data: {name: this.name, animal: this.animal}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
      if(result)
      {
        this.rtcService.signalPeer(signalData.user, signalData.signal, this.stream);
      }
    });
  }













  selectChat(id:number){
    this.id= id;
  }

  onEnter(){
    const str: Message = {
      sendingBy: "Guest",
      sending: new Date().toLocaleTimeString() + " " + new Date().toLocaleDateString(),
      text: this.message
     }
     console.log(str)
    this._signalR.sendMessageToUser("Admin", str);
    this.user.friendDTOs![0].messageDTOs.push(str);
    console.log(this.user.friendDTOs)
  }

  public blad:string;
  public async saveUsername(): Promise<void> {
    try {
      this.stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
    } catch (error) {
      this.blad = `Can't join room, error ${error}`;
    }
  }

}


