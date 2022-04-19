import { NgModule } from '@angular/core';
import { LoaderComponent } from './loader.component';
import { LoaderDirective } from './loader.directive';
import { LoaderService } from './loader.service';
import { NzSpinModule } from 'ng-zorro-antd/spin';

@NgModule({
  declarations: [LoaderComponent, LoaderDirective],
  imports: [NzSpinModule],
  exports: [LoaderDirective],
  providers: [LoaderService],
})
export class LoaderModule {}
