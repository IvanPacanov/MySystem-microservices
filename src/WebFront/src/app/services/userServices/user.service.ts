import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { UserDTO } from 'src/app/models/user/user';
import { Message } from 'src/app/models/user/message';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private url = "http://localhost:5006/Users"
  private api = "http://localhost:5006/api/Authenticate"
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
}