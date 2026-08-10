import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ProtheusLibCoreModule } from '@totvs/protheus-lib-core';
import { environment } from '../environments/environment';

@Injectable({ providedIn: 'root' })
export class ProtheusService {

  constructor(private http: HttpClient) {}

  /**
   * Obtém dados da sessão Protheus via protheus-lib-core
   */
  async getSession(): Promise<any> {
    try {
      await ProtheusLibCoreModule.initialize(environment.protheus);
      const session = ProtheusLibCoreModule.getSession();
      return session;
    } catch (error) {
      throw new Error('Falha ao conectar ao Protheus');
    }
  }

  /**
   * Exemplo: busca dados via REST endpoint do Protheus
   */
  async buscarExemplo(): Promise<any[]> {
    const url = `${environment.protheus.apiUrl}/api/exemplo/dados`;
    try {
      const response = await this.http.get<any>(url).toPromise();
      return response?.data || [];
    } catch (error) {
      console.error('Erro ao buscar dados do Protheus', error);
      return [];
    }
  }
}
