import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { MainModule } from './main/main.module';
import { DialogComponent } from './pages/home/chat/dialog/dialog.component';
import { DialogOwnComponent } from './features/dialog-own/dialog-own.component';
import { ConfirmCallingComponent } from './pages/home/chat/confirm-calling/confirm-calling.component';


@NgModule({
  declarations: [
    AppComponent

  ],
  imports: [
    BrowserModule, HttpClientModule, AppRoutingModule,
    MainModule
  ],
  exports:[ ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
