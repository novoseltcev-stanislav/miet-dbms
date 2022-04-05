import {Component, OnInit, ViewContainerRef} from '@angular/core';
import {LoaderService} from "../../shared/loader/loader.service";
import {IRoom} from "../../models/IRoom";
import {BehaviorSubject, filter, map, Observable, of, Subscription, switchMap} from "rxjs";
import {Router} from "@angular/router";
import {RequestsService} from "../../services/requests.service";
import {NzModalService} from "ng-zorro-antd/modal";
import {IServerResponse} from "../../models/IServerResponse";
import {catchError} from "rxjs/operators";

@Component({
  selector: 'app-rooms',
  templateUrl: './rooms.component.html',
  providers: [LoaderService],
})
export class RoomsComponent implements OnInit {
  sub: Subscription
  events: Partial<IRoom[]> = []
  public rows: Observable<IRoom[]>;
  public page: number;
  public activePage = 1;

  private _data: BehaviorSubject<{page: number}> = new BehaviorSubject<{page: number}>({page: 1});

  constructor(private router: Router,
              private requests: RequestsService,
              private modal: NzModalService,
              private viewContainerRef: ViewContainerRef,
              private loader: LoaderService,) { }

  ngOnInit(): void {

    this.rows = this._data.pipe(
      switchMap(({page}) => {
        return this.loader.startLoading(this.requests.getRooms(page)).pipe(
          catchError((err) => of(null))
        )
      }),
      filter((value: any) => value),
      map((data: IServerResponse<IRoom>) => {
        this.page = data?.meta?.pages * 10 || 10;
        return data.data;
      })
    );
  }


  onChangePage(value: number) {
    this._data.next({page: value});
  }

  deleteEvent(id: number | undefined) {
    if (typeof id === 'number') {
      this.requests.deleteRoom(id).subscribe(
        () => {
         this._data.next({page: this.activePage});
        }
      )
    }
  }
}
