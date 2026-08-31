import { Routes } from '@angular/router';
import { UsersComponent } from '@components/users/users.component';
import { HomeComponent } from '@components/home/home.component';
import { UserDetailsComponent } from '@components/user-details/user-details.component';
import {CreateUserComponent} from '@components/create-user/create-user.component';
import {authGuard} from '@guards/auth.guard';
import {LoginComponent} from '@components/login/login.component';
import {RegisterComponent} from '@components/register/register.component';
import {AuthLayoutComponent} from '@components/layout/auth-layout/auth-layout.component';
import {MainLayoutComponent} from '@components/layout/main-layout/main-layout.component';
import {HomeRedirectGuard} from '@guards/home.guard';
import {adminGuard} from '@guards/role.guard';

export const routes: Routes = [
  // Route racine
  {
    path: '',
    canActivate: [HomeRedirectGuard],
    children: []
  },

  // Routes non authentifiées
  {
    path: '',
    component: AuthLayoutComponent,
    children: [
      { path: 'login', component: LoginComponent },
      { path: 'register', component: RegisterComponent }
    ]
  },

  // Routes authentifiées
  {
    path: '',
    component: MainLayoutComponent,
    canActivate: [authGuard],
    children: [
      { path: 'home', component: HomeComponent },
      { path: 'users', component: UsersComponent, canActivate: [adminGuard] },
      { path: 'users/new', component: CreateUserComponent, canActivate: [adminGuard] },
      { path: 'users/:id', component: UserDetailsComponent, canActivate: [adminGuard] }
    ]
  },

  {
    path: '**',
    redirectTo: ''
  }
];
