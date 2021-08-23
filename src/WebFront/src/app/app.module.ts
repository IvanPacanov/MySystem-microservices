import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { LoginComponent } from './pages/login-registration/login/login.component';
import { RegistrationComponent } from './pages/login-registration/registration/registration.component';
import { LoginRegistrationComponent } from './pages/login-registration/login-registration.component';
import { HomeComponent } from './pages/home/home.component';
import { ChatComponent } from './pages/home/chat/chat.component';
import { UserListComponent } from './pages/home/chat/user-list/user-list.component';
import { MessagesComponent } from './pages/home/chat/messages/messages.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegistrationComponent,
    LoginRegistrationComponent,
    HomeComponent,
    ChatComponent,
    UserListComponent,
    MessagesComponent,
  ],
  imports: [
    BrowserModule, HttpClientModule, AppRoutingModule, FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
