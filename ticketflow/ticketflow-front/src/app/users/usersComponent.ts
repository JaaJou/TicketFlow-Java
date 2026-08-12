import { Component, OnInit, inject } from '@angular/core';
import { UserService } from '../services/userService';
import { User } from '../models/user';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [],
  templateUrl: './users.html',
  styleUrl: './users.css',
})
export class UsersComponent implements OnInit {
  private userService = inject(UserService);

  users: User[] = [];

  ngOnInit(): void {
    this.userService.getUsers().subscribe({
      next: users => {
        console.log('UTILISATEURS REÇUS :', users);
        this.users = users;
      },
      error: error => {
        console.error('ERREUR API :', error);
      }
    });
  }
}
