import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import {catchError, tap} from 'rxjs/operators';

@Injectable({ providedIn: 'any' })
export class LoaderService {
  public loading$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);

  public startLoading<T>(request: Observable<T>): Observable<T> {
    this.loading$.next(true);
    return request.pipe(tap(() => this.loading$.next(false)),
      catchError((err) => {
        this.loading$.next(false);
        throw err;
      }));
  }
}
