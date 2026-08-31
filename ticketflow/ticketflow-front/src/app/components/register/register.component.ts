import {Component, inject} from '@angular/core';
import {CommonModule} from '@angular/common';
import {FormBuilder, ReactiveFormsModule, Validators} from '@angular/forms';
import {AuthService} from '@services/auth.service';
import {Router, RouterLink, RouterLinkActive} from '@angular/router';
import {passwordsMatchValidator} from '../../validators/passwordMatchValidator';
import {User} from '@models/user';
import {CreateUserComponent} from '@components/create-user/create-user.component';
import {CreateUserRequest} from '@models/createUserRequest';

/**
 * Composant affichant le formulaire d'inscription.
 * Valide les champs puis délègue l'appel API à AuthService.
 */
@Component({
  selector: 'app-register',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, RouterLink],
  templateUrl: './register.html',
  styleUrl: './register.css',
})
export class RegisterComponent {

  private fb = inject(FormBuilder);
  private authService = inject(AuthService);
  private router = inject(Router);

  errorMessage: string | null = null;

  registerForm = this.fb.group(
    {
      firstName: ['',[Validators.required]],
      lastName: ['', [Validators.required]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      confirmPassword: ['', [Validators.required]],
      phone: ['', [Validators.required]]
    },
    {
      validators: passwordsMatchValidator
    }
  );


  onSubmit(): void {
    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    const { firstName, lastName, email, password, phone} = this.registerForm.getRawValue();

    const newUser: CreateUserRequest= {
      firstName: firstName!,
      lastName: lastName!,
      email: email!,
      password: password!,
      phone: phone!,
    };

    this.authService.register(newUser).subscribe({
      next: () => this.router.navigate(['/login']),
      error: (err) => {
        this.errorMessage = err.status === 409
          ? 'Cet email est déjà utilisé.'
          : 'Une erreur est survenue.';
      }
    });
  }
}
