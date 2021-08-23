import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { User } from 'src/app/models/user/user';
import { Message } from 'src/app/models/user/message';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private url = "http://localhost:5006/Users"
  constructor(private httpClient: HttpClient) { }

  getDataAboutUser() :Observable<User> {
   return this.httpClient.get(this.url + "/users?UnserName=Admin").pipe(tap(console.log));
  }

  getDataAboutUserMesages(id:number) :Observable<Message[]> {
    return this.httpClient.get(this.url + '/mesagess?friendID='+id).pipe(tap(console.log));
   }
}
