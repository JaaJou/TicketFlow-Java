import { inject } from '@angular/core';
import {CanActivateFn, Router} from '@angular/router';
import { AuthService } from '@services/auth.service';

/**
 * Guard empêchant l'accès à une route si l'utilisateur n'est pas authentifié.
 * Redirige vers /login en cas d'échec.
 */
export const authGuard: CanActivateFn = (route, state) => {
  const authService = inject(AuthService);
  const router = inject(Router);

  if (authService.isAuthenticated()) {
    return true;
  }

  router.navigate(['/login']);
  return false;
};
