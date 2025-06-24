# Hesk Customization Documentation / Documentação de Customização do Hesk

---

## Visão Geral / Overview

**PT**: Este repositório contém uma versão customizada do [Hesk](https://www.hesk.com/), um sistema de help desk em PHP de código aberto desenvolvido e mantido por **Klemen Stirn**. Todas as credenciais, direitos autorais e avisos de licença originais permanecem inalterados e pertencem ao autor original. Este projeto não reivindica autoria nem redistribuição do código-fonte original.

**EN**: This repository contains a customized version of [Hesk](https://www.hesk.com/), a free, PHP-based help desk system developed and maintained by **Klemen Stirn**. All original copyright notices and license terms remain intact, and this project does not claim ownership or redistribution of the original source code.

---

## Finalidade / Purpose

**PT**: As customizações aqui documentadas têm como objetivo atender a requisitos específicos de TI da **Launer Química**. Este trabalho é realizado por um desenvolvedor (eu) como experiência de aprendizado e para aprimorar o sistema conforme as necessidades da empresa. Nenhuma parte deste projeto destina-se à redistribuição pública sem autorização prévia.

**EN**: The customizations documented here are intended solely to meet specific IT requirements of **Launer Química**. This work is carried out by a single developer (myself) as a learning experience and to improve the system according to the company’s needs. No part of this project is intended for public redistribution without prior authorization.

---

## Módulos e Funcionalidades Planejadas / Planned Modules and Features

### 1. Gestão de Ativos (Asset Management)

**PT**:
- Cadastro completo de ativos (computadores, impressoras, monitores etc.).
- Histórico de movimentação e manutenção.
- Relatórios de inventário e alertas para manutenção preventiva.

**EN**:
- Full asset registration (computers, printers, monitors, etc.).
- Movement and maintenance history tracking.
- Inventory reports and preventive maintenance alerts.

### 2. Verificação de Usuário por E-mail (User Verification)

**PT**:
- Envio automático de e-mail de confirmação ao criar nova conta.
- Validação de link expirável para ativação.
- Fluxo de redefinição de senha seguro.

**EN**:
- Automatic confirmation email upon account creation.
- Expirable activation link validation.
- Secure password reset workflow.

---

## Versionamento / Versioning

Este projeto segue o [Versionamento Semântico (SemVer)](https://semver.org/): **MAJOR.MINOR.PATCH**

- **MAJOR**: mudanças incompatíveis com versões anteriores / incompatible API changes.
- **MINOR**: novas funcionalidades retrocompatíveis / backward-compatible feature additions.
- **PATCH**: correções de bugs e pequenos ajustes / bug fixes and minor improvements.

### Fluxo de Branches / Branching Flow

- `main`: código pronto para produção / production-ready code.
- `develop`: integração das features antes do release / integration of features before release.
- `feature/<nome-da-feature>`: desenvolvimento de cada nova funcionalidade / development of individual features.

---

## Como Contribuir / How to Contribute

**PT**:
1. Faça um _fork_ deste repositório.
2. Crie uma branch para sua feature: `git checkout -b feature/nome-da-feature`.
3. Commit suas alterações com mensagens claras (`tipo(escopo): descrição`).
4. Abra um _Pull Request_ contra `develop` descrevendo suas mudanças.

**EN**:
1. Fork this repository.
2. Create a feature branch: `git checkout -b feature/your-feature-name`.
3. Commit your changes with clear messages (`type(scope): description`).
4. Open a Pull Request against `develop` describing your changes.

---

## Licença e Direitos Autorais / License and Copyright

- **PT**: Base original: Hesk © Klemen Stirn. Customizações: © Launer Química. Este repositório segue a mesma licença do Hesk (veja o arquivo LICENSE original).
- **EN**: Original base: Hesk © Klemen Stirn. Customizations: © Launer Química. This repository follows the same license as Hesk (see original LICENSE file).

---

## Portfolio Profissional / Professional Portfolio

**PT**: Manter este repositório público faz parte do meu portfólio pessoal. Busco demonstrar habilidades em:
- Customização e integração de sistemas.
- Boas práticas de versionamento e documentação.
- Desenvolvimento de novas funcionalidades.

**EN**: Keeping this repository public is part of my professional portfolio. I aim to showcase skills in:
- System customization and integration.
- Best practices in versioning and documentation.
- Development of new features.


---

*Feedback e sugestões são bem-vindos!* / *Feedback and suggestions are welcome!*

