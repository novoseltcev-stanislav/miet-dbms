import {NgModule, Pipe, PipeTransform} from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoaderModule } from './loader/loader.module';
import { NzMenuModule } from 'ng-zorro-antd/menu';
import { NzPopoverModule } from 'ng-zorro-antd/popover';
import { NzListModule } from 'ng-zorro-antd/list';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzDatePickerModule } from "ng-zorro-antd/date-picker";
import { NzSwitchModule } from 'ng-zorro-antd/switch';
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import { NzBackTopModule } from 'ng-zorro-antd/back-top';
import {NzModalModule} from "ng-zorro-antd/modal";
import { NzMessageModule } from 'ng-zorro-antd/message';
import {NzTableModule} from "ng-zorro-antd/table";import {NzIconModule} from "ng-zorro-antd/icon";
import { NzTabsModule } from 'ng-zorro-antd/tabs';
import { NzPaginationModule } from 'ng-zorro-antd/pagination';
import { NzSelectModule } from 'ng-zorro-antd/select';

@Pipe({name: 'stringToSrc'})
export class stringToSrc implements PipeTransform {
  transform(value: string | undefined, args?: any): string {
    if (typeof value === 'string' && value.length) {
      return `url('${value}')`
    }
    return 'none';
  }
}

@NgModule({
  declarations: [
    stringToSrc
  ],
  imports: [
    CommonModule,
    LoaderModule,
    NzMenuModule,
    NzPopoverModule,
    NzButtonModule,
    NzListModule,
    ReactiveFormsModule,
    NzBackTopModule,
    NzModalModule,
    FormsModule,
    NzFormModule,
    NzBackTopModule,
    NzMessageModule,
    NzTableModule,
    NzDatePickerModule,
    NzIconModule,
    NzTabsModule,
    NzPaginationModule,
    NzSelectModule,
  ],
  exports: [
    LoaderModule,
    NzMenuModule,
    NzPopoverModule,
    NzButtonModule,
    NzListModule,
    NzFormModule,
    NzInputModule,
    NzSwitchModule,
    ReactiveFormsModule,
    NzDatePickerModule,
    NzBackTopModule,
    NzModalModule,
    FormsModule,
    NzFormModule,
    NzBackTopModule,
    NzMessageModule,
    stringToSrc,
    NzTableModule,
    NzIconModule,
    NzTabsModule,
    NzPaginationModule,
    NzSelectModule
  ],
})
export class SharedModule { }
