import { NgModule } from '@angular/core';
import { RouterModule} from '@angular/router';
import {routes} from "./app.states";

@NgModule({
  imports: [RouterModule.forRoot(routes, {scrollPositionRestoration: 'enabled'})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
