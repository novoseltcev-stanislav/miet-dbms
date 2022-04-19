import {Component} from '@angular/core';

@Component({
  template: `
    <div class="loader">
      <nz-spin nzSimple [nzSize]="'large'"></nz-spin>
    </div>`,
  styles: [
    ' .loader { position: absolute; display: flex; width: 100%; height: 100%; left:0; top:0; justify-content: center; align-items: center; background: rgba(204, 204, 204, 0.24)}',
  ],
})
export class LoaderComponent {
  constructor() {
  }
}
