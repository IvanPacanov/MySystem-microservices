import { CommonModule } from "@angular/common";
import { NgModule } from "@angular/core";
import { FormsModule } from "@angular/forms";
import { MatDialogModule, MatDialogRef } from "@angular/material/dialog";
import { ChatComponent } from "@app/pages/home/chat/chat.component";
import { MessagesComponent } from "@app/pages/home/chat/messages/messages.component";
import { UserListComponent } from "@app/pages/home/chat/user-list/user-list.component";
import { HomeComponent } from "@app/pages/home/home.component";
import { LoginRegistrationComponent } from "@app/pages/login-registration/login-registration.component";
import { LoginComponent } from "@app/pages/login-registration/login/login.component";
import { RegistrationComponent } from "@app/pages/login-registration/registration/registration.component";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from "@app/material.module";
import { DialogComponent } from "@app/pages/home/chat/dialog/dialog.component";
import { DialogOwnComponent } from "@app/features/dialog-own/dialog-own.component";
import { ConfirmCallingComponent } from "@app/pages/home/chat/confirm-calling/confirm-calling.component";

@NgModule({
    imports: [
      FormsModule,
      MaterialModule,
      BrowserAnimationsModule
    ],
    declarations: [
      DialogOwnComponent,
      DialogComponent,
      LoginComponent,
      RegistrationComponent,
      LoginRegistrationComponent,
      HomeComponent,
      ChatComponent,
      UserListComponent,
      MessagesComponent,
      ConfirmCallingComponent

    ],
    providers: [
      {
        provide: MatDialogRef,
        useValue: {}
      },
   ],
})
export class MainModule { }
