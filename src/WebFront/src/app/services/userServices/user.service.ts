import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { UserDTO } from '@app/models/user/user';
import { Message } from '@app/models/user/message';
import { AddUserDTO } from '@app/pages/home/home.component';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private url = "https://192.168.1.106:5007/Users"
  private api = "https://192.168.1.106:5007/api/Authenticate"
  constructor(private httpClient: HttpClient) { }

  // loginUser(user: User): Observable<any>{
    //       return this.httpClient.post(this.api + "/users?UnserName=Admin", user).pipe(tap(console.log));
    // }

    getDataAboutUser(userName: string) :Observable<UserDTO> {
      console.log("Logowanie1")
      return this.httpClient.get(this.url + `/users?UnserName=${userName}`).pipe(tap(console.log));
    }

    getDataAboutUserMesages(id:number) :Observable<Message[]> {
      return this.httpClient.get(this.url + '/mesagess?friendID='+id).pipe(tap(console.log));
    }
    AddNewFriend(nick: AddUserDTO):Observable<void> {
      console.log(nick)
      return this.httpClient.put<void>(this.url + `/usersFriend` , nick);
    }
  }
