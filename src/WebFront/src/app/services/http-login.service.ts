import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class HttpLoginService {
  private url = "http://localhost:5005/api/Authenticate/login"
  constructor(private httpClient: HttpClient) { 

  }
  

  getHelloServer(){
    return this.httpClient.get("http://localhost:5005/api/Authenticate/HelloServer").pipe(tap(console.log));
  }

  postLogIn(user: User){
    return this.httpClient.post(this.url, user).pipe(tap(console.log));
  }

}
