import { TestBed } from '@angular/core/testing';

import { HttpLoginService } from './http-login.service';

describe('HttpLoginService', () => {
  let service: HttpLoginService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HttpLoginService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
