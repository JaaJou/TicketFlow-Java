import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { User } from '@models/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private http = inject(HttpClient);
  private apiUrl: string = 'http://localhost:8080/api'

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(`${this.apiUrl}/users`);
  }

  getUserById(id: number) : Observable<User>{
    return this.http.get<User>(`${this.apiUrl}/users/${id}`);
  }

  updateUser(id: number, userUpdated: User) : Observable<User>{
    return this.http.put<User>(`${this.apiUrl}/users/${id}`, userUpdated);
  }

  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/users/${id}`);
  }

  createUser(user: Omit<User, 'id'>): Observable<User> {
    return this.http.post<User>(`${this.apiUrl}/users`, user);
  }
}
