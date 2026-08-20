import {Component, inject, output} from '@angular/core';
import { ICellRendererAngularComp } from 'ag-grid-angular';
import { ICellRendererParams } from 'ag-grid-community';
import { User } from '@models/user';
import {Router} from '@angular/router';

@Component({
  selector: 'app-view-details-cell',
  standalone: true,
  templateUrl: './view-details-cell.html',
  styleUrl: './view-details-cell.css',
})
export class ViewUserDetailsCellComponent implements ICellRendererAngularComp{

  private router = inject(Router);

  selectedUser!: User;

  viewUser(): void {
    console.log(this.selectedUser);
    this.router.navigate(['/users', this.selectedUser.id]);
  }

  agInit(params: ICellRendererParams<User>): void {
    this.selectedUser = params.data!;
  }

  refresh(params: ICellRendererParams<User>): boolean {
    this.selectedUser = params.data!;
    return true;
  }
}
