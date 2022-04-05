import {Component, ElementRef, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import {Subscription} from "rxjs";
import {Router} from "@angular/router";
import {UtilitiesService} from "../app.component";


@Component({
  selector: 'app-pages-main',
  template: `
    <div class="main-page">
      <header class="main-header">
        <ul class="main-menu" nz-menu nzMode="horizontal" style="margin: auto">
          <ng-container *ngFor="let item of menuItems">
            <li [routerLink]="item.link"
                *ngIf="item.link; else withoutLink"
                routerLinkActive
                class="main-menu__item"
                #link='routerLinkActive'
                [nzSelected]="link.isActive "
                nz-menu-item
            >
              <span>
                {{item.label}}
              </span>
            </li>
            <ng-template #withoutLink>
              <li class="main-menu__item" nz-menu-item>
              <span>
                {{item.label}}
              </span>
              </li>
            </ng-template>
          </ng-container>

        </ul>
        <i #burger class="hamburger" nz-icon nzType="menu" nzTheme="outline"></i>
      </header>
      <main class="main-page-content">
        <router-outlet></router-outlet>
      </main>
    </div>
  `,
  encapsulation: ViewEncapsulation.None
})
export class PagesMainComponent implements OnInit {
  sub: Subscription | undefined;
  isMobileMenuActive = false

  @ViewChild('mobileMenu', {read: ElementRef, static: false}) mobileMenu: ElementRef | undefined
  @ViewChild('burger', {read: ElementRef, static: false}) burger: ElementRef | undefined
  public menuItems = [
    {label: 'Rooms ', link: '/main/rooms'},
    {label: 'Patients', link: '/main/patients'},
    {label: 'Procedures', link: '/main/procedures'},
  ];

  constructor(private router: Router,
              private utilityService: UtilitiesService) {
  }

  ngOnInit() {
    this.sub = this.utilityService.documentClickedTarget.subscribe(
      target => this.documentClickListener(target)
    )
  }

  documentClickListener(target: any): void {
    if (this.burger && this.burger.nativeElement.contains(target)) this.toggleMobileMenu()
    else if (this.isMobileMenuActive)
      this.toggleMobileMenu()
  }

  toggleMobileMenu() {
    this.isMobileMenuActive = !this.isMobileMenuActive
  }

  goToTop() {
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    });
  }
}
