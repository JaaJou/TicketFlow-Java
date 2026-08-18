import { Component, output } from '@angular/core';
import { ICellRendererAngularComp } from 'ag-grid-angular';
import { ICellRendererParams } from 'ag-grid-community';
import { User } from '@models/user';

// Étend les paramètres standards fournis par AG Grid avec notre propre paramètre "onViewUser",
// une fonction qui permet au composant de renvoyer l'utilisateur sélectionné à UsersComponent.
type ViewDetailsCellParams = ICellRendererParams<User> & {
  onViewUser: (user: User) => void;
};

@Component({
  selector: 'app-view-details-cell',
  standalone: true,
  templateUrl: './view-details-cell.html',
  styleUrl: './view-details-cell.css',
})
export class ViewUserDetailsCellComponent implements ICellRendererAngularComp{

// L'utilisateur de la ligne AG Grid sur laquelle se trouve le bouton "View".
// Il est fourni par AG Grid via params.data.
  user: User | undefined;

// Fonction reçue de UsersComponent.
// Elle permet au composant du bouton de renvoyer l'utilisateur à UsersComponent.
// ? = propriété optionnelle. Signifie que cette fonction peut ne pas avoir été fournie.
  onViewUser?: (user: User) => void;

  agInit(params: ViewDetailsCellParams): void {

    // AG Grid fournit les données de la ligne dans params.data.
    // Il s'agit donc de l'utilisateur correspondant à cette ligne.
    this.user = params.data;

    // Récupère la fonction onViewUser fournie par UsersComponent.
    this.onViewUser = params.onViewUser;
  }

  refresh(params: ICellRendererParams<User>): boolean {
    this.user = params.data;
    return true;
  }

  // Lorsque l'utilisateur clique sur View, on transmet l'utilisateur
  // de la ligne à la fonction fournie par UsersComponent.
  viewUser(): void {
    if (this.user) {
      this.onViewUser?.(this.user);
    }
  }

}
