import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Router, ActivatedRoute } from '@angular/router';
import { NgForm, NgModel } from '@angular/forms';
import { HttpLoginService } from 'src/app/services/http-login.service';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {


  user : Partial<User> = {};
  constructor(private httpService: HttpLoginService,
    private router: Router,) { }

  ngOnInit(): void {
  }

  onSubmit(){

   // this.sigR.loginToSignalR(this.user.username as string, this.user.username as string)
      // this.httpService.postLogIn(this.user as User).subscribe(
      //   result =>
      //   {
      //     console.log(result);
      //    // this.router.navigate(['/HomePage']);
      //   },
      //   error =>
      //   {

      //     console.log(error)

      //     }
      // );

      this.router.navigate(['/HomePage', this.user.username]);
    }
    printModel(title: NgModel)
    {
      console.log(title);
     var c = ['10','1','11114111234342'].map(parseInt)
        console.log(c);
    }


}


