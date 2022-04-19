import {LOCALE_ID, NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {NZ_I18N, ru_RU} from 'ng-zorro-antd/i18n';
import {registerLocaleData} from '@angular/common';
import ru from '@angular/common/locales/ru';
import {HttpClientModule} from '@angular/common/http';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {SharedModule} from "./shared/shared.module";
import { ProceduresComponent } from './pages/procedures/procedures.component';
import { PatientsComponent } from './pages/patients/patients.component';
import { RoomsComponent } from './pages/rooms/rooms.component';
import {PagesMainComponent} from "./pages/pages.main.comnonent";

registerLocaleData(ru);

@NgModule({
  declarations: [
    AppComponent,
    PagesMainComponent,
    ProceduresComponent,
    PatientsComponent,
    RoomsComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    SharedModule
  ],
  providers: [
    {provide: LOCALE_ID, useValue: 'ru'},
    {provide: NZ_I18N, useValue: ru_RU}
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
