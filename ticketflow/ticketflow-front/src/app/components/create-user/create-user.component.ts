import {Component, inject, OnInit} from '@angular/core';
import {User} from '@models/user';
import {UserService} from '@services/user.service';
import {Router} from '@angular/router';
import {Status} from '@models/status';
import {Role} from '@models/role';
import {FormBuilder, FormGroup, ReactiveFormsModule, Validators} from '@angular/forms';

@Component({
  selector: 'app-user-create',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './create-user.html',
  styleUrl: './create-user.css',
})
export class CreateUserComponent implements OnInit {

  private router = inject(Router);
  private userService = inject(UserService);
  private fb = inject(FormBuilder);

  statusOptions = Object.values(Status);
  rolesOptions = Object.values(Role);

  userForm!: FormGroup;

  ngOnInit(): void {
    this.buildForm();
  }

  buildForm(): void {
    this.userForm = this.fb.group({
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
      phone: [''],
      profilePictureUrl: ['']
    });
  }

  onSubmit(): void {
    if (this.userForm.invalid) {
      this.userForm.markAllAsTouched();
      return;
    }

    const newUser: Omit<User, 'id'> = {
      ...this.userForm.value
    };

    this.userService.createUser(newUser).subscribe({
      next: userFromService => {
        this.router.navigate(['/users', userFromService.id]);
      },
      error: error => console.error('Erreur api :', error)
    });
  }
}
