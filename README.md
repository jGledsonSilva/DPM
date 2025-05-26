# DPM - Domus Power Monitor

## Descrição

O Domus Power Monitor (DPM) é um aplicativo móvel projetado para ajudar os usuários a monitorar e gerenciar o consumo de energia elétrica de seus eletrodomésticos em tempo real. Utilizando tomadas inteligentes, o DPM oferece uma visão detalhada do uso de energia, permitindo que os usuários tomem decisões mais conscientes para economizar energia e reduzir custos.

## Soluções Oferecidas

O DPM visa fornecer uma solução completa para o gerenciamento de energia residencial, incluindo:

*   **Monitoramento em Tempo Real:** Acompanhe o consumo de energia de cada eletrodoméstico conectado.
*   **Controle Remoto:** Ligue ou desligue seus aparelhos de qualquer lugar através do aplicativo.
*   **Notificações Inteligentes:** Receba alertas sobre consumo excessivo, uso prolongado sem atividade ou padrões anormais detectados por Inteligência Artificial.
*   **Histórico e Relatórios:** Acesse gráficos e relatórios detalhados do consumo diário, semanal e mensal.
*   **Sugestões de Economia:** Obtenha recomendações personalizadas para otimizar o uso de energia com base nos seus hábitos de consumo.
*   **Previsão de Consumo:** A IA do aplicativo pode prever o consumo futuro com base no histórico de uso.
*   **Cadastro de Eletrodomésticos:** Identifique e gerencie facilmente cada aparelho conectado.

## Tecnologias Utilizadas

*   **Frontend:** Flutter (aplicativo móvel multiplataforma Android/iOS)
*   **Backend:** Python (Django)
*   **Banco de Dados:** PostgreSQL
*   **Inteligência Artificial:** scikit-learn, TensorFlow, Prophet (para previsão de consumo), PyOD (para detecção de anomalias)
*   **Comunicação com Dispositivos:** MQTT ou HTTP com ESP32
*   **Nuvem:** Google Cloud

## Funcionalidades Principais (Requisitos Funcionais)

*   Monitorar o consumo de energia em tempo real.
*   Exibir o histórico de consumo (diário, semanal, mensal).
*   Enviar alertas de consumo excessivo.
*   Detectar uso prolongado de aparelhos sem atividade.
*   Controlar remotamente os dispositivos conectados.
*   Gerar relatórios de consumo de energia.
*   Cadastrar e identificar eletrodomésticos no aplicativo.
*   Prever o consumo de energia com base no histórico de uso.
*   Sugerir ações para economia de energia com base nos hábitos do usuário.
*   Notificar sobre padrões de consumo ou anomalias detectadas pela IA.

## Requisitos Não Funcionais

*   Compatibilidade com os sistemas operacionais Android e iOS.
*   Interface de usuário amigável, intuitiva e responsiva.
*   Baixo consumo de bateria do dispositivo móvel.
*   Criptografia dos dados para garantir a segurança e privacidade do usuário.
*   Alta disponibilidade e desempenho do sistema.

## O que NÃO está no Escopo deste Projeto

*   Integração com sistemas de painéis solares.
*   Manutenção do hardware físico das tomadas inteligentes.
*   Aplicação destinada a uso industrial ou comercial de grande porte.

## Gestão do Projeto

*   **Gestor do Projeto:** José Gledson da Silva Oliveira (gledson.silva60@aluno.ifce.edu.br)
*   **Patrocinador:** Henrique Leitão (henriqueleitao@ifce.edu.br)
