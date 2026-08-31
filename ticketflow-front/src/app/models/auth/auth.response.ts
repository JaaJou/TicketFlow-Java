/**
 * Structure de la réponse reçue du backend après une connexion réussie.
 * Doit refléter exactement les champs du record Java AuthResponse.
 */
export interface AuthResponse {
  token: string;
}
