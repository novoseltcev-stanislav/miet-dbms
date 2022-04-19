import {Routes} from "@angular/router";
import {RoomsComponent} from "./pages/rooms/rooms.component";
import {ProceduresComponent} from "./pages/procedures/procedures.component";
import {PatientsComponent} from "./pages/patients/patients.component";
import {PagesMainComponent} from "./pages/pages.main.comnonent";

export const routes: Routes = [
  {
    path: 'main', component: PagesMainComponent,
    children: [
      {path: '', redirectTo: 'rooms', pathMatch: 'full'},
      {path: 'rooms', component: RoomsComponent},
      {path: 'patients', component: PatientsComponent},
      {path: 'procedures', component: ProceduresComponent},
    ]
  },
  {path: '**', redirectTo: 'main/rooms'}
]
