import { Component } from '@angular/core';
import { ProtheusService } from './services/protheus.service';

@Component({
  selector: 'app-root',
  standalone: true,
  template: `
    <po-page-default p-title="Protheus PO-UI Template">
      <p>Conectado ao Protheus: {{ status }}</p>
      <p>Usuário: {{ usuario }}</p>

      <po-button p-label="Buscar Dados" (p-click)="buscarDados()"></po-button>

      <po-table
        [p-columns]="colunas"
        [p-items]="dados"
        p-hide-table-search>
      </po-table>
    </po-page-default>
  `
})
export class AppComponent {
  status = 'Conectando...';
  usuario = '';
  dados: any[] = [];
  colunas = [
    { property: 'codigo', label: 'Código' },
    { property: 'descricao', label: 'Descrição' }
  ];

  constructor(private protheusService: ProtheusService) {
    this.init();
  }

  async init() {
    try {
      const session = await this.protheusService.getSession();
      this.status = 'Conectado';
      this.usuario = session.userName;
    } catch {
      this.status = 'Desconectado';
    }
  }

  async buscarDados() {
    this.dados = await this.protheusService.buscarExemplo();
  }
}
