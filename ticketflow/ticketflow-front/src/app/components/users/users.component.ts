import { Component, inject, signal } from '@angular/core';
import { UserService } from '@services/user.service';
import { User } from '@models/user';
import { AgGridAngular } from 'ag-grid-angular';
import {ColDef, themeQuartz, SelectionChangedEvent, RowSelectionOptions, ICellRendererParams} from 'ag-grid-community';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [AgGridAngular],
  templateUrl: './users.html',
  styleUrl: './users.css',
})
export class UsersComponent {

  private userService = inject(UserService);
  users = signal<User[]>([]);

  colDefs: ColDef<User>[] = [
    {field: 'firstName', headerName: 'Prénom', sortable: true, filter: true},
    {field: 'lastName', headerName: 'Nom', sortable: true, filter: true},
    {field: 'email', headerName: 'Mail', sortable: true, filter: true},
    {
      headerName: 'Actions',
      cellRenderer: (params: ICellRendererParams<User>) => {
        const button = document.createElement('button');

        button.innerText = 'View';
        button.classList.add('btn', 'btn-secondary', 'align-item-center', 'justify-content-between');

        button.addEventListener('click', () => {
          console.log('Utilisateur :', params.data);
        });

        return button;
      }
    }
  ]

  theme = themeQuartz;

  rowSelection: RowSelectionOptions<User> = {
    mode: 'singleRow'
  };

  onSelectionChanged(event: SelectionChangedEvent<User>): void {
    const selectedUser = event.api.getSelectedRows()[0];

    if (selectedUser) {
      console.log('Utilisateur sélectionné :', selectedUser);
    }
  }

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

  emptyUsers(): void {
    this.users.set([]);
  }
}
