import {Component, inject, OnInit, signal} from '@angular/core';
import {User} from '@models/user';
import {UserService} from '@services/user.service';
import {ActivatedRoute, Router} from '@angular/router';
import { Status } from '@models/status';
import { Role } from '@models/role';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';


@Component({
  selector: 'app-user-details',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './user-details.html',
  styleUrl: './user-details.css',
})
export class UserDetailsComponent implements OnInit{

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private userService = inject(UserService);
  private fb = inject(FormBuilder);

  statusOptions = Object.values(Status);
  rolesOptions = Object.values(Role)

  isEdit: boolean = false;
  user = signal<User | null>(null);
  userForm!: FormGroup;

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.userService.getUserById(+id).subscribe({
        next: userFromService => {
          this.user.set(userFromService);
          this.buildForm(userFromService);
        },
        error: error => console.error('Erreur api :', error)
      });
    }
  }

  buildForm(u: User): void {
    this.userForm = this.fb.group({
      firstName: [u.firstName, Validators.required],
      lastName: [u.lastName, Validators.required],
      email: [u.email, [Validators.required, Validators.email]],
      phone: [u.phone],
      status: [u.status, Validators.required],
      roles: [u.roles, Validators.required]
    });
    this.userForm.disable();
  }

  onClickEdit(edit: boolean): void {
    this.isEdit = edit;
    if (edit) {
      this.userForm.enable();
    } else {
      this.userForm.reset(this.user());
      this.userForm.disable();
    }
  }

  onSubmit(): void {
    if (this.userForm.invalid) {
      return;
    }

    const updatedUser: User = {
      ...this.user()!,
      ...this.userForm.value
    };

    this.userService.updateUser(updatedUser.id, updatedUser).subscribe({
      next: userFromService => {
        this.user.set(userFromService);
        this.buildForm(userFromService);
        this.isEdit = false;
      },
      error: error => console.error('Erreur api :', error)
    });
  }

  onClickDelete(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.userService.deleteUser(+id).subscribe({
        next: () => {
          this.router.navigate(['/users']);
        },
        error: error => console.error('Erreur api :', error)
      });
    }
  }
}
