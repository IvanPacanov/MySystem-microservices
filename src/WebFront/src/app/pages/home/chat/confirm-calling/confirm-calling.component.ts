import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { DialogData } from '../chat.component';

@Component({
  selector: 'app-confirm-calling',
  templateUrl: './confirm-calling.component.html',
  styleUrls: ['./confirm-calling.component.css']
})
export class ConfirmCallingComponent  {

  constructor(
    public dialogRef: MatDialogRef<ConfirmCallingComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

}
