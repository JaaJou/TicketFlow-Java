import {inject, Injectable} from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { AuthResponse } from '@models/auth/auth.response';
import {jwtDecode} from 'jwt-decode';
import {Router} from '@angular/router';
import { User } from '@models/user';
import {CreateUserRequest} from '@models/createUserRequest';

interface IJwtPayload {
  sub: string;
  roles: string[];
  exp: number;
  iat: number;
}

/**
 * Service gérant l'inscription, la connexion, la déconnexion,
 * et le stockage du token JWT côté client.
 */
@Injectable({ providedIn: 'root' })
export class AuthService {

  private readonly apiUrl: string = 'http://localhost:8080/api/auth';
  private readonly apiUrlUser: string = 'http://localhost:8080/api/users';
  private readonly http = inject(HttpClient);
  private readonly tokenKey = 'auth_token';

  private readonly router = inject(Router);

  /**
   * Envoie les identifiants d'inscription au backend.
   * Ne stocke rien : l'utilisateur doit ensuite se connecter.
   */
  register(newUser: CreateUserRequest): Observable<User> {
    return this.http.post<User>(`${this.apiUrlUser}`, newUser);
  }

  /**
   * Envoie les identifiants de connexion, stocke le token reçu en cas de succès.
   */
  login(email: string, password: string): Observable<AuthResponse> {
    return this.http.post<AuthResponse>(`${this.apiUrl}/login`, { email, password }).pipe(
      tap(response => this.setToken(response.token))
    );
  }

  /**
   * Supprime le token stocké, mettant fin à la session côté client.
   */
  logout(): void {
    localStorage.removeItem(this.tokenKey);
    this.router.navigate(['/login']);
  }

  /**
   * Retourne le token stocké, ou null si absent.
   */
  getToken(): string | null {
    return localStorage.getItem(this.tokenKey);
  }

  /**
   * Indique si un token est présent et valide, sinon logout
   */
  isAuthenticated(): boolean {
    const token = this.getToken();
    if(!token) {
      return false;
    }
    try {
      const decoded = jwtDecode<IJwtPayload>(token);
      const nowInSeconds = Math.floor(Date.now() / 1000);
      if (decoded.exp <= nowInSeconds) {
        this.logout();
        return false;
      }
      return true;
    } catch {
      this.logout();
      return false;
    }
  }

  getRoles(): string[] {
    if(this.isAuthenticated())
    {
      const token = this.getToken();
      const decoded = jwtDecode<IJwtPayload>(token!);
      return decoded.roles;
    }

    return [];
  }

  hasRole(role: string): boolean {
    const roles = this.getRoles();
    return roles.includes(role);
  }

  private setToken(token: string): void {
    localStorage.setItem(this.tokenKey, token);
  }
}
