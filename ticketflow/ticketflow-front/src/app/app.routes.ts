import { Routes } from '@angular/router';
import { UsersComponent } from '@components/users/users.component';
import { HomeComponent } from '@components/home/home.component';
import { UserDetailsComponent } from '@components/user-details/user-details.component';
import {CreateUserComponent} from '@components/create-user/create-user.component';

export const routes: Routes = [
  {
    path: '',
    component: HomeComponent
  },
  {
    path: 'users',
    component: UsersComponent
  },
  {
    path: 'users/new',
    component: CreateUserComponent
  },
  {
    path: 'users/:id',
    component: UserDetailsComponent
  }
];
