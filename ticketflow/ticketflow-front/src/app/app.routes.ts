import { Routes } from '@angular/router';
import { UsersComponent } from '@components/users/users.component';
import { HomeComponent } from '@components/home/home.component';

export const routes: Routes = [
  {
    path: 'users',
    component: UsersComponent
  },
  {
    path: '',
    component: HomeComponent
  }
];
