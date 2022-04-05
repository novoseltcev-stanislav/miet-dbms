import {
  ComponentRef,
  Directive,
  Renderer2,
  ViewContainerRef,
} from '@angular/core';
import { Subscription } from 'rxjs';
import { LoaderComponent } from './loader.component';
import { LoaderService } from './loader.service';

@Directive({
  selector: '[loader]',
})
export class LoaderDirective {
  private loaderRef!: ComponentRef<LoaderComponent>;
  private loading: boolean = false;
  private subscription: Subscription = new Subscription();

  constructor(
    private viewContainer: ViewContainerRef,
    private loaderService: LoaderService,
    private renderer: Renderer2
  ) {}

  ngOnInit() {
    this.subscription.add(this.loaderService.loading$.subscribe((loading) => this.checkLoader(loading)));
  }

  private checkLoader(loading: boolean): void {
    if (loading === this.loading) return;
    this.loading = loading;
    if (this.loading) {
      this.viewContainer.element.nativeElement.style.position = 'relative';
      this.showLoadingBody();
    } else {
      this.loaderRef?.destroy();
    }
  }

  private showLoadingBody(): void {
    this.initializeLoaderBodyRef();
    this.renderer.appendChild(this.viewContainer.element.nativeElement, this.loaderRef.location.nativeElement);
  }

  private initializeLoaderBodyRef(): void {
    this.loaderRef = this.viewContainer.createComponent(LoaderComponent);
  }
}
