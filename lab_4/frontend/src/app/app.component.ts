import {Component, HostListener, Injectable, OnInit} from '@angular/core';
import {Subject} from "rxjs";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'DBMS';

  constructor(private utilitiesService: UtilitiesService) {
  }

  @HostListener('document:click', ['$event'])
  documentClick(event: any): void {
    this.utilitiesService.documentClickedTarget.next(event.target)
  }

  ngOnInit(): void {
  }
}

@Injectable({ providedIn: 'root' })
export class UtilitiesService {
  documentClickedTarget: Subject<HTMLElement> = new Subject<HTMLElement>()
}
