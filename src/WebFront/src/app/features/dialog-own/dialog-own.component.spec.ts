import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DialogOwnComponent } from './dialog-own.component';

describe('DialogOwnComponent', () => {
  let component: DialogOwnComponent;
  let fixture: ComponentFixture<DialogOwnComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DialogOwnComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DialogOwnComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
