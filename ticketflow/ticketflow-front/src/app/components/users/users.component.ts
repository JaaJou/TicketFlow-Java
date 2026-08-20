import {Component, inject, signal, AfterViewInit, OnInit} from '@angular/core';
import { UserService } from '@services/user.service';
import { User } from '@models/user';
import { AgGridAngular } from 'ag-grid-angular';
import { ViewUserDetailsCellComponent } from '@components/view-details-cell/view-details-cell.component';
import {ColDef, themeQuartz, SelectionChangedEvent, RowSelectionOptions, ICellRendererParams} from 'ag-grid-community';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [AgGridAngular],
  templateUrl: './users.html',
  styleUrl: './users.css',
})
export class UsersComponent implements OnInit{

  private userService = inject(UserService);
  users = signal<User[]>([]);

  colDefs: ColDef<User>[] = [
    {field: 'firstName', headerName: 'Prénom', sortable: true, filter: true},
    {field: 'lastName', headerName: 'Nom', sortable: true, filter: true},
    {field: 'email', headerName: 'Mail', sortable: true, filter: true},
    {
      headerName: 'Actions',
      cellRenderer: ViewUserDetailsCellComponent
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

  // Retire le focus de l'élément actif avant que Bootstrap masque la modale,
  // afin d'éviter le conflit entre le focus et l'attribut aria-hidden.
  ngAfterViewInit(): void {
    const modal = document.getElementById('userModal');

    modal?.addEventListener('hide.bs.modal', () => {
      if (document.activeElement instanceof HTMLElement) {
        document.activeElement.blur();
      }
    });
  }

  ngOnInit(): void {
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
