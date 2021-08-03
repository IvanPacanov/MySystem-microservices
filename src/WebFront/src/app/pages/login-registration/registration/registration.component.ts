import { Component, OnInit } from '@angular/core';
import { NgForm, NgModel } from '@angular/forms';
import { RegistrationUser } from 'src/app/models/registrationUser';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  registrationUser = {} as RegistrationUser;
  constructor() { }

  ngOnInit(): void {
  }

  onSubmit(){
    console.log(this.registrationUser);
  }
  printModel(title: NgModel)
  {
    console.log(title);
  }
}
