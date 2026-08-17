import { Component, inject, signal } from '@angular/core';
import { UserService } from '@services/user.service';
import { User } from '@models/user';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [],
  templateUrl: './users.html',
  styleUrl: './users.css',
})
export class UsersComponent {

  private userService = inject(UserService);

  users = signal<User[]>([]);

  loadUsers() : void {
    this.userService.getUsers().subscribe({
        next: usersFromService =>{
          this.users.set(usersFromService)
        },
        error: error => {
          console.error('Erreur api :', error);
        }
      });
  }
}
