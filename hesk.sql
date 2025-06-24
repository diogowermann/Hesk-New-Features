-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 24/06/2025 às 16:15
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `hesk`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_attachments`
--

CREATE TABLE `hesk_attachments` (
  `att_id` mediumint(8) UNSIGNED NOT NULL,
  `ticket_id` varchar(13) NOT NULL DEFAULT '',
  `saved_name` varchar(255) NOT NULL DEFAULT '',
  `real_name` varchar(255) NOT NULL DEFAULT '',
  `size` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `type` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_attachments`
--

INSERT INTO `hesk_attachments` (`att_id`, `ticket_id`, `saved_name`, `real_name`, `size`, `type`) VALUES
(1, 'VLA-1QS-H9SD', 'VLA-1QS-H9SD_5074fcd3e44d84a15b9c38c343333e94.docx', 'Erro-E-mail.docx', 358223, '0'),
(2, 'NGS-S5N-QN3A', 'NGS-S5N-QN3A_587e0cc6951b8c80b9d8df186679bcd6.png', 'imagem_2024-06-06_100547470.png', 78716, '0'),
(3, 'A27', 'A27_904a0d326ce4e44baf5f1fba65843c4b.png', 'Captura-de-tela-2024-07-01-080839.png', 109285, '0'),
(4, 'A28', 'A28_0f1a3c76f90dad3e11ee6bef450d9af6.png', 'erro-impressora0107.png', 1920, '0'),
(5, 'A38', 'A38_6b896a1a95b89c4d5ee6e79ab1319cc2.jpg', '01d688f8-1447-4bbf-b5e4-289d58d6c515.jpg', 31396, '0'),
(6, 'A43', 'A43_ab13fb514abaf26064f27c2f372eb5c7.docx', 'Alerta-Ativacao-Windows.docx', 102239, '0'),
(7, 'A62', 'A62_bd631cf006c5f3e7374e912897fea629.png', 'Captura-de-tela-2024-09-24-070245.png', 46750, '0'),
(8, 'A88', 'A88_33a9a3e4cddb09df1822ad2371398b40.docx', 'Questionario-de-Acompanhamento-Pos-RNC.docx', 334062, '0'),
(9, 'B06', 'B06_ceb88910ee75250e892c2c62fadd439d.jpg', 'Imagem-do-WhatsApp-de-2025-03-14-as-10.54.17_b91394e1.jpg', 151771, '0'),
(10, 'B15', 'B15_dafea71b1e29b013679a2f0bbfe16fb4.png', 'Sem-titulo.png', 81620, '0'),
(11, 'B19', 'B19_41d58d0dfdc0427706fdb59c1da8564e.docx', 'Erro-Gateway.docx', 49225, '0');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_auth_tokens`
--

CREATE TABLE `hesk_auth_tokens` (
  `id` int(11) UNSIGNED NOT NULL,
  `selector` char(12) DEFAULT NULL,
  `token` char(64) DEFAULT NULL,
  `user_id` smallint(5) UNSIGNED NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `hesk_auth_tokens`
--

INSERT INTO `hesk_auth_tokens` (`id`, `selector`, `token`, `user_id`, `created`, `expires`) VALUES
(16, 'G9gaLPxyRn2R', '0bef845fc10f8f75b9100f8f8548cf5366aaa015b80157dfbe03d7026e7d6dfe', 2, '2025-06-16 12:36:04', '2026-06-11 13:49:11'),
(15, 'lGphuq6eEqt7', 'a6821ba4a4a7a0f6dfc9fcd54baf7b982a27440fc2520ea0ff24f25e95ba8fa9', 1, '2025-06-13 14:51:40', '2026-06-05 17:05:43'),
(14, '3koNXp0oVVO+', 'd9435c4718100203dc0274e4a7aa6591b8962471ba94171e95f5162e1c94f090', 1, '2025-05-26 21:36:11', '2026-05-26 21:36:11'),
(13, 'TpDpqne+B3ld', '8ebdc5ce10cf301ff56ebb7636c651d790fb347d882b41ca34b298b0bf660e0f', 1, '2025-06-23 10:58:18', '2026-05-22 14:52:46'),
(17, 'LyF4SiY6CZiP', '11d5047ffdb059c2b7ddd689a47d1630cb6f5b55d87fdb97a6c8e44902447132', 1, '2025-06-24 13:43:39', '2026-06-24 11:12:45');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_banned_emails`
--

CREATE TABLE `hesk_banned_emails` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `banned_by` smallint(5) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_banned_ips`
--

CREATE TABLE `hesk_banned_ips` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `ip_from` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ip_to` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ip_display` varchar(100) NOT NULL,
  `banned_by` smallint(5) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_categories`
--

CREATE TABLE `hesk_categories` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `cat_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `autoassign` enum('0','1') NOT NULL DEFAULT '1',
  `autoassign_config` varchar(1000) DEFAULT NULL,
  `type` enum('0','1') NOT NULL DEFAULT '0',
  `priority` enum('0','1','2','3') NOT NULL DEFAULT '3',
  `default_due_date_amount` int(11) DEFAULT NULL,
  `default_due_date_unit` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_categories`
--

INSERT INTO `hesk_categories` (`id`, `name`, `cat_order`, `autoassign`, `autoassign_config`, `type`, `priority`, `default_due_date_amount`, `default_due_date_unit`) VALUES
(1, 'Protheus', 10, '1', NULL, '0', '1', NULL, NULL),
(2, 'Impressora', 40, '1', NULL, '0', '3', NULL, NULL),
(3, 'Computador', 30, '1', NULL, '0', '1', NULL, NULL),
(4, 'Office/E-mail', 50, '1', NULL, '0', '3', NULL, NULL),
(5, 'Internet', 20, '1', NULL, '0', '2', NULL, NULL),
(6, 'Celular', 60, '1', NULL, '0', '3', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_custom_fields`
--

CREATE TABLE `hesk_custom_fields` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `use` enum('0','1','2') NOT NULL DEFAULT '0',
  `place` enum('0','1') NOT NULL DEFAULT '0',
  `type` varchar(20) NOT NULL DEFAULT 'text',
  `req` enum('0','1','2') NOT NULL DEFAULT '0',
  `category` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `value` text DEFAULT NULL,
  `order` smallint(5) UNSIGNED NOT NULL DEFAULT 10
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_custom_fields`
--

INSERT INTO `hesk_custom_fields` (`id`, `use`, `place`, `type`, `req`, `category`, `name`, `value`, `order`) VALUES
(1, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(2, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(3, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(4, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(5, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(6, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(7, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(8, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(9, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(10, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(11, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(12, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(13, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(14, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(15, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(16, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(17, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(18, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(19, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(20, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(21, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(22, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(23, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(24, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(25, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(26, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(27, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(28, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(29, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(30, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(31, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(32, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(33, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(34, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(35, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(36, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(37, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(38, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(39, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(40, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(41, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(42, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(43, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(44, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(45, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(46, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(47, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(48, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(49, '0', '0', 'text', '0', NULL, '', NULL, 1000),
(50, '0', '0', 'text', '0', NULL, '', NULL, 1000);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_custom_statuses`
--

CREATE TABLE `hesk_custom_statuses` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `color` varchar(6) NOT NULL,
  `can_customers_change` enum('0','1') NOT NULL DEFAULT '1',
  `order` smallint(5) UNSIGNED NOT NULL DEFAULT 10
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_custom_statuses`
--

INSERT INTO `hesk_custom_statuses` (`id`, `name`, `color`, `can_customers_change`, `order`) VALUES
(6, '{\"Portugu\\u00eas Brasileiro\":\"Em An\\u00e1lise\"}', '9cecff', '0', 10),
(7, '{\"Portugu\\u00eas Brasileiro\":\"Excluido\"}', 'ffae3b', '0', 20);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_kb_articles`
--

CREATE TABLE `hesk_kb_articles` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `catid` smallint(5) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `author` smallint(5) UNSIGNED NOT NULL,
  `subject` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `keywords` mediumtext NOT NULL,
  `rating` float NOT NULL DEFAULT 0,
  `votes` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `views` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `type` enum('0','1','2') NOT NULL DEFAULT '0',
  `html` enum('0','1') NOT NULL DEFAULT '0',
  `sticky` enum('0','1') NOT NULL DEFAULT '0',
  `art_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `history` mediumtext NOT NULL,
  `attachments` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_kb_articles`
--

INSERT INTO `hesk_kb_articles` (`id`, `catid`, `dt`, `author`, `subject`, `content`, `keywords`, `rating`, `votes`, `views`, `type`, `html`, `sticky`, `art_order`, `history`, `attachments`) VALUES
(2, 5, '2025-02-27 19:13:11', 1, 'Não consigo imprimir meu documento', '<h3>Introdução</h3>\r\n<p>Caso  o problema seja adicionar a impressora ao seu computador, vá para o passo \"5\".</p>\r\n<hr />\r\n<h3>Soluções e Passos de Verificação</h3>\r\n<ol>\r\n<li>\r\n<p><strong>Verifique a Conexão de Rede (Notebooks e MiniPCs):</strong></p>\r\n<ul>\r\n<li>Confirme se o seu computador está conectado à rede correta (por exemplo, \"LaunerADM\" e não \"LaunerConvidados\").</li>\r\n<li>Caso necessário, altere a rede manualmente nas configurações de wi-fi.</li>\r\n</ul>\r\n</li>\r\n<li>\r\n<p><strong>Reinicie a Impressora:</strong></p>\r\n<ul>\r\n<li>Desligue a impressora.</li>\r\n<li>Desconecte-a da tomada e aguarde cerca de 30 a 60 segundos.</li>\r\n<li>Ligue novamente a impressora.</li>\r\n</ul>\r\n</li>\r\n<li>\r\n<p><strong>Reinicie o Computador Hospedando a Impressora:</strong></p>\r\n<ul>\r\n<li>Se a impressora é compartilhada via outro computador (por exemplo, <code>\\\\vendas -&gt; &lt;nome da impressora&gt;</code>), reinicie esse computador.\r\n<ul>\r\n<li><span style=\"font-size:10pt;\">Um jeito mais prático de descobrir onde ela está conectada, se não souber, é apenas ver até onde o cabo da impressora vai.</span></li>\r\n</ul>\r\n</li>\r\n<li>Essa ação pode restabelecer a conexão e corrigir eventuais travamentos no compartilhamento.</li>\r\n</ul>\r\n</li>\r\n<li>\r\n<p><strong>Verifique a Impressora Selecionada no Windows:</strong></p>\r\n<ul>\r\n<li>Pressione <strong>Win + R</strong> e digite <code>control printers</code> para abrir a lista de impressoras.</li>\r\n<li>Verifique se a impressora correta aparece na lista (geralmente identificada pelo modelo e pelo computador que a compartilha).</li>\r\n</ul>\r\n</li>\r\n<li>\r\n<p><strong>Instale a Impressora Manualmente (caso não esteja na lista):</strong></p>\r\n<ul>\r\n<li>Abra o <strong>Explorador de Arquivos</strong>.</li>\r\n<li>Na barra de endereços, digite <code>\\\\vendas</code> (ou o nome do computador que compartilha a impressora) e pressione <strong>Enter</strong>.</li>\r\n<li>Na lista que aparecer, localize a impressora e dê um duplo clique para que ela seja instalada automaticamente.</li>\r\n<li><em>(Opcional)</em> Se desejar que essa seja a sua impressora padrão:\r\n<ul>\r\n<li>Ao instalar, aparecerá uma caixa com o nome da impressora.</li>\r\n<li>Clique em <strong>Impressora</strong> e depois em <strong>Definir como padrão</strong>.</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n</li>\r\n</ol>\r\n<hr />\r\n<h3>Dicas Adicionais</h3>\r\n<ul>\r\n<li>\r\n<p><strong>Verifique Conexões Físicas:</strong><br />Para impressoras conectadas via cabo, confira se os cabos estão bem encaixados e se não há problemas físicos na impressora.</p>\r\n</li>\r\n<li>\r\n<p><strong>Configurações de Compartilhamento:</strong><br />Se a impressora é compartilhada por meio de outro computador, certifique-se de que as configurações de compartilhamento estão corretas. Apenas siga esses passos:</p>\r\n<ul>\r\n<li>Abra o <strong>Explorador de Arquivos</strong>.</li>\r\n<li>Na <strong>aba lateral</strong>, role até encontrar <strong>rede</strong> então clique com o <strong>botão direito</strong> e depois em <strong>propriedades</strong>.</li>\r\n<li>Clique em <strong>Alterar as configurações de compartilhamento</strong> <strong>avançadas</strong>.</li>\r\n<li>Em <strong>redes do domínio</strong>, certifique-se de que a opção <strong>descoberta de rede </strong>está ativada.</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n<hr />\r\n<h3>Conclusão</h3>\r\n<p>Seguindo essas etapas, a maioria dos problemas de impressão pode ser resolvida sem a necessidade de abrir um chamado. Se mesmo após esses passos o problema persistir, pode ser necessário um suporte técnico mais detalhado.</p>\r\n<p> </p>', 'impressora', 0, 0, 4, '1', '1', '0', 10, '<li class=\"smaller\">27/02/2025 16:13:11 | enviado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 16:33:17 | modificado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 16:36:54 | modificado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 16:37:07 | modificado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 16:51:36 | modificado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 16:51:44 | modificado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 17:19:28 | modificado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 17:19:48 | modificado por TI (Administrador)</li><li class=\"smaller\">06/03/2025 14:46:55 | modificado por TI (Administrador)</li><li class=\"smaller\">06/03/2025 15:46:06 | modificado por TI (Administrador)</li><li class=\"smaller\">22/04/2025 14:29:43 | modificado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 15:36:16 | modificado por TI (Administrador)</li>', ''),
(6, 5, '2025-03-07 13:10:54', 1, 'Brother', '<h3>Como resetar o cilindro:</h3>\r\n<ol>\r\n<li>Menu;</li>\r\n<li>Opção <strong>5</strong>;</li>\r\n<li>Opção <strong>9</strong>;</li>\r\n<li>Segurar botão <strong>OK</strong>;</li>\r\n<li>Apertar <strong>INICIAR</strong>;</li>\r\n<li>Em seguida segure <strong>OK</strong> e aperte seta para <strong>cima</strong>;</li>\r\n<li>Se aparecer na tela <strong>\"ACEITO\"</strong>, significa que funcionou e a impressora vai continuar funcionando depois;</li>\r\n</ol>\r\n<p> </p>', 'resetar brother impressora reiniciar cilindro toner', 0, 0, 11, '1', '1', '0', 20, '<li class=\"smaller\">07/03/2025 10:10:54 | enviado por TI (Administrador)</li><li class=\"smaller\">10/03/2025 09:02:23 | modificado por TI (Administrador)</li><li class=\"smaller\">10/03/2025 09:16:03 | modificado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:11:31 | modificado por TI (Administrador)</li>', ''),
(7, 5, '2025-03-10 12:15:51', 1, 'Laserjet-1010', '<h3>Siga estes passos para fazer a instalação</h3>\r\n<ol>\r\n<li>Existe um pacote <code>.msi</code> (<em>Dot4x64.msi</em>) dentro do caminho <code>\\\\backup\\backup\\Ti\\Laserjet-1010</code>, execute este pacote então <strong>reinicie </strong>o computador.</li>\r\n<li>Depois que o computador reiniciar, <strong>adicione uma impressora manualmente</strong>, selecionando a opção de <strong>impressora local ou de rede usando configurações manuais</strong>.</li>\r\n<li>Utilize uma porta existente (aqui entra o porque de instalar o pacote Dot4) que vai ter o nome de <strong>Dot4</strong>...</li>\r\n<li>Avance e então <strong>selecione os drivers da impressora Laserjet-1010</strong> e <span style=\"text-decoration:underline;\">ative o compartilhamento e a instalação dos drivers automaticamente</span>.</li>\r\n</ol>\r\n<p><strong>Coloque um nome que faça sentido com o computador no qual a impressora está compartilhado para manter organização e ser mais fácil de manter caso haja algum problema com o compartilhamento.</strong></p>', '1010 \r\nlaserjet-1010 \r\nlaserjet \r\nimpressora', 0, 0, 4, '1', '1', '0', 30, '<li class=\"smaller\">10/03/2025 09:15:51 | enviado por TI (Administrador)</li>', ''),
(8, 6, '2025-03-21 11:24:14', 1, 'Configurando Pendrive Bootavel', '<p>Utilize o AnyBurn na pasta compartilhada <strong>TI→Formatação</strong> para editar o arquivo ISO, caso o arquivo <em>ei.cfg</em> não esteja presente na pasta <em>Sources</em>. Em seguida, use o Ventoy para criar o pendrive bootável, de modo que, na partição Ventoy do pendrive, o arquivo <em>ventoy.json</em> seja adicionado e, dentro da pasta <em>VTOY_WIN_PE</em> (crie-a se não existir), as ISOs do Windows sejam inseridas. É possível que seja necessário ajustar o nome dos arquivos; portanto, verifique o conteúdo do arquivo JSON para assegurar a correta referência.</p>\r\n<p> </p>', 'anyburn iso formatação cfg formatar windows', 0, 0, 5, '1', '1', '0', 10, '<li class=\"smaller\">21/03/2025 08:24:13 | enviado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:12:39 | modificado por TI (Administrador)</li>', ''),
(9, 7, '2025-04-22 17:25:19', 1, 'Anydesk', '<p> </p>\r\n<h2>Administrativo</h2>\r\n<table style=\"border-collapse:collapse;width:100%;margin-left:auto;margin-right:auto;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:48.111%;\">Artes</td>\r\n<td style=\"width:48.111%;\">1086166426</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Assessoria</td>\r\n<td style=\"width:48.111%;\">1221314883</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Compras</td>\r\n<td style=\"width:48.111%;\">126746248</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Custos</td>\r\n<td style=\"width:48.111%;\">507078928</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Financeiro</td>\r\n<td style=\"width:48.111%;\">1283688352</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Fiscal</td>\r\n<td style=\"width:48.111%;\">1144624978</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Gerente</td>\r\n<td style=\"width:48.111%;\">1051071940</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Marketing</td>\r\n<td style=\"width:48.111%;\">1108625960</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Recepção</td>\r\n<td style=\"width:48.111%;\">614588281</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">RH1</td>\r\n<td style=\"width:48.111%;\">1564066758</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">RH2</td>\r\n<td style=\"width:48.111%;\">1325049781</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">TI</td>\r\n<td style=\"width:48.111%;\">593737589</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h2>Comercial</h2>\r\n<table style=\"border-collapse:collapse;width:100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:48.111%;\">Comercial1</td>\r\n<td style=\"width:48.111%;\">851087872</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Comercial2</td>\r\n<td style=\"width:48.111%;\">1789346196</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Coordenador</td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Faturamento</td>\r\n<td style=\"width:48.111%;\">1705584139</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Gerente</td>\r\n<td style=\"width:48.111%;\">412585125</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Vendas</td>\r\n<td style=\"width:48.111%;\">1674635833</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h2>Produção</h2>\r\n<table style=\"border-collapse:collapse;width:100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:48.111%;\">Agrícola</td>\r\n<td style=\"width:48.111%;\">1369400948</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Almoxarifado</td>\r\n<td style=\"width:48.111%;\">434251096</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Envase</td>\r\n<td style=\"width:48.111%;\">1027969940</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Expedição</td>\r\n<td style=\"width:48.111%;\">1841667970</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Formulação</td>\r\n<td style=\"width:48.111%;\">1260831408</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Manutenção</td>\r\n<td style=\"width:48.111%;\">1125600075</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">P&amp;D Agrícola</td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">PCP</td>\r\n<td style=\"width:48.111%;\">477148908</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Rótulos</td>\r\n<td style=\"width:48.111%;\">931254026</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Recebimento</td>\r\n<td style=\"width:48.111%;\">781981272</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Supervisor</td>\r\n<td style=\"width:48.111%;\">1722145735</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Veterinária</td>\r\n<td style=\"width:48.111%;\">1229757998</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h2>Laboratório</h2>\r\n<table style=\"border-collapse:collapse;width:100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:50%;\">Laboratório01</td>\r\n<td style=\"width:50%;\">1137377438</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:50%;\">Laboratório02</td>\r\n<td style=\"width:50%;\">261636198</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:50%;\">Laboratório04</td>\r\n<td style=\"width:50%;\">879873481</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:50%;\">P&amp;D</td>\r\n<td style=\"width:50%;\">1027709874</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:50%;\">Rovian</td>\r\n<td style=\"width:50%;\">1297652004</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h2>Externo</h2>\r\n<table style=\"border-collapse:collapse;width:100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:48.111%;\">Luana</td>\r\n<td style=\"width:48.111%;\">1603179784</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Diego</td>\r\n<td style=\"width:48.111%;\">1588637945</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\">Evandro</td>\r\n<td style=\"width:48.111%;\">1270903855</td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:48.111%;\"> </td>\r\n<td style=\"width:48.111%;\"> </td>\r\n</tr>\r\n</tbody>\r\n</table>', 'anydesk computadores lista todos', 0, 0, 79, '1', '1', '0', 10, '<li class=\"smaller\">22/04/2025 14:25:19 | enviado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:03:52 | modificado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:13:04 | modificado por TI (Administrador)</li><li class=\"smaller\">28/04/2025 13:22:44 | modificado por TI (Administrador)</li><li class=\"smaller\">29/04/2025 14:55:06 | modificado por TI (Administrador)</li><li class=\"smaller\">06/05/2025 14:57:08 | modificado por TI (Administrador)</li><li class=\"smaller\">07/05/2025 15:14:53 | modificado por TI (Administrador)</li><li class=\"smaller\">26/05/2025 15:51:09 | modificado por Diogo (administrador)</li><li class=\"smaller\">28/05/2025 16:35:39 | modificado por Diogo (administrador)</li><li class=\"smaller\">29/05/2025 08:38:27 | modificado por Diogo (administrador)</li><li class=\"smaller\">03/06/2025 10:22:43 | modificado por Diogo (administrador)</li><li class=\"smaller\">06/06/2025 10:22:01 | modificado por Diogo (administrador)</li><li class=\"smaller\">06/06/2025 15:10:55 | modificado por Diogo (administrador)</li>', ''),
(10, 9, '2025-04-22 20:02:11', 1, 'Instagram', '<p></p>\r\n<p><span style=\"font-size:12pt;\"><span><span style=\"line-height:107%;\"><strong>Login:</strong> </span></span><a href=\"mailto:marketing@launer.com.br\"><span><span style=\"line-height:107%;color:#FF0000;\"><span style=\"text-decoration:underline;\"><span style=\"color:#000000;text-decoration:underline;\">marketing@launer.com.br</span></span></span></span></a></span></p>\r\n<p><span style=\"font-size:12pt;\"><span><span style=\"line-height:107%;\"><strong>Senha:</strong> <span style=\"color:#000000;\">launer1100</span></span></span></span></p>\r\n<p> </p>', '', 0, 0, 0, '1', '1', '0', 10, '<li class=\"smaller\">22/04/2025 17:02:11 | enviado por TI (Administrador)</li>', ''),
(11, 9, '2025-04-22 20:20:40', 1, 'Gerais', '<h2>Mikrotik</h2>\r\n<table style=\"border-collapse:collapse;width:100%;height:224px;border-style:dashed;float:left;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><colgroup><col style=\"width:38.3493%;\" width=\"160\" /> <col style=\"width:61.6507%;\" width=\"276\" /> </colgroup>\r\n<tbody>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;width:120pt;text-align:center;\" width=\"160\" height=\"21\"><strong>Admin:</strong></td>\r\n<td class=\"xl65\" style=\"border-left:medium;width:207pt;text-align:center;height:22.4px;\" width=\"276\"><em>Jshd#s8dS</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>IP Lan1:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>192.168.0.254/24</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>IP Lan2:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>172.16.0.1/23</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>IP Wan1:</strong></td>\r\n<td class=\"xl66\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>177.53.103.30 (Trip)</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>IP Wan2:</strong></td>\r\n<td class=\"xl66\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>200.6.129.4 (Nexsul)</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>Cloud:</strong></td>\r\n<td class=\"xl67\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em><a href=\"http://d1260b7c5266.sn.mynetname.net/\"><span style=\"color:#0000ff;\">d1260b7c5266.sn.mynetname.net</span></a></em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>SSID1:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>LaunerAdm</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>Senha1:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>Jsu#9s7df2</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>SSID2:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>LaunerConvidados</em></td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;border-top:medium;text-align:center;\" height=\"21\"><strong>Senha2:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;height:22.4px;\"><em>launer2020</em></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<h2>VMs</h2>\r\n<h3>PostgreSQL</h3>\r\n<table style=\"border-collapse:collapse;width:100%;border-style:dashed;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><colgroup><col style=\"width:38.6243%;\" width=\"101\" /> <col style=\"width:61.3757%;\" width=\"127\" /> </colgroup>\r\n<tbody>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;width:76pt;text-align:center;\" width=\"101\" height=\"17\"><strong>Nome:</strong></td>\r\n<td class=\"xl65\" style=\"border-left:medium;width:95pt;text-align:center;\" width=\"127\"><em>launer-postgresql</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>root:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Gst#98dfD</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>IP Lan:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>192.168.0.204</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>OS:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Debian 12</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>Postgresql admin:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Hsydt2837</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>sudo Protheus:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Hsdr$s3d4</em></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3>Protheus</h3>\r\n<table style=\"border-collapse:collapse;width:100%;border-style:dashed;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><colgroup><col style=\"width:38.6242%;\" width=\"88\" /> <col style=\"width:61.3758%;\" width=\"192\" /> </colgroup>\r\n<tbody>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;width:66pt;text-align:center;\" width=\"88\" height=\"17\"><strong>Nome:</strong></td>\r\n<td class=\"xl65\" style=\"border-left:medium;width:144pt;text-align:center;\" width=\"192\"><em>launer-protheus-app</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>.\\Administrador:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Gst#98dfD</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>IP Lan:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>192.168.0.205</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>OS:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Windows Server 2022 Standard</em></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3>SFA</h3>\r\n<table style=\"border-collapse:collapse;width:100%;border-color:#000000;border-style:dashed;float:left;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><colgroup><col style=\"width:38.7566%;\" width=\"88\" /> <col style=\"width:61.2434%;\" width=\"192\" /> </colgroup>\r\n<tbody>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;width:66pt;text-align:center;\" width=\"88\" height=\"17\"><strong>Nome:</strong></td>\r\n<td class=\"xl65\" style=\"border-left:medium;width:144pt;text-align:center;\" width=\"192\"><em>launer-sfa</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>.\\Administrador:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Gst#98dfD</em></td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>IP Lan:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>192.168.0</em>.206</td>\r\n</tr>\r\n<tr style=\"height:12.75pt;\">\r\n<td class=\"xl65\" style=\"height:12.75pt;border-top:medium;text-align:center;\" height=\"17\"><strong>OS:</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;text-align:center;\"><em>Windows Server 2022 Standard</em></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3>Proxmox</h3>\r\n<table style=\"border-collapse:collapse;width:100%;border-color:#000000;border-style:dashed;\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:38.7715%;text-align:center;\"><strong>Navegador</strong></td>\r\n<td style=\"width:61.2285%;text-align:center;\"><a><em>192.168.0.203:8006</em></a></td>\r\n</tr>\r\n<tr>\r\n<td style=\"width:38.7715%;text-align:center;\"><strong>root</strong></td>\r\n<td style=\"width:61.2285%;text-align:center;\"><em>KhdY#937yT$5</em></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<h2>LaunerAPI</h2>\r\n<table style=\"border-collapse:collapse;width:100%;height:32.4px;border-style:dashed;\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><colgroup><col style=\"width:67pt;\" width=\"89\" /> <col style=\"width:107pt;\" width=\"142\" /> </colgroup>\r\n<tbody>\r\n<tr style=\"height:22.4px;\">\r\n<td class=\"xl65\" style=\"height:22.4px;width:67pt;text-align:center;\" width=\"89\" height=\"17\"><strong>User</strong></td>\r\n<td class=\"xl65\" style=\"border-left:medium;width:107pt;height:22.4px;text-align:center;\" width=\"142\"><em>Usuário Protheus (admin)</em></td>\r\n</tr>\r\n<tr style=\"height:10px;\">\r\n<td class=\"xl65\" style=\"height:10px;border-top:medium;text-align:center;\" height=\"17\"><strong>Senha Padrão</strong></td>\r\n<td class=\"xl65\" style=\"border-top:medium;border-left:medium;height:10px;text-align:center;\"><em>Mi(tUY014sD</em></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<h2>Chamados</h2>\r\n<table style=\"border-collapse:collapse;width:100%;height:44.8px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:48.111%;text-align:center;height:22.4px;\"><a href=\"https://glpi.launer.com.br/admin.php\" target=\"_blank\" rel=\"noreferrer noopener\"><strong>administrador</strong></a></td>\r\n<td style=\"width:48.111%;text-align:center;height:22.4px;\">Lq3720*1100</td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:48.111%;text-align:center;height:22.4px;\"><a href=\"https://launer.com.br/phpmyadmin\" target=\"_blank\" rel=\"noreferrer noopener\"><strong>adminpma</strong></a></td>\r\n<td style=\"width:48.111%;text-align:center;height:22.4px;\">Lq3720*1100</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p> </p>\r\n<h2><a href=\"https://www.maxmind.com/en/geolite2/signup\">MaxMind</a></h2>\r\n<table style=\"border-collapse:collapse;width:100%;\" border=\"1\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width:48.111%;text-align:center;\"><strong>compras@launer.com.br</strong></td>\r\n<td style=\"width:48.111%;text-align:center;\">_d*.kaT7Fz</td>\r\n</tr>\r\n</tbody>\r\n</table>', 'senhas protheus servidor banco dados api launerapi postgre', 0, 0, 31, '1', '1', '0', 20, '<li class=\"smaller\">22/04/2025 17:20:40 | enviado por TI (Administrador)</li><li class=\"smaller\">22/04/2025 17:23:54 | modificado por TI (Administrador)</li><li class=\"smaller\">22/04/2025 17:24:17 | modificado por TI (Administrador)</li><li class=\"smaller\">22/04/2025 17:24:55 | modificado por TI (Administrador)</li><li class=\"smaller\">22/04/2025 17:25:16 | modificado por TI (Administrador)</li><li class=\"smaller\">22/04/2025 17:25:29 | modificado por TI (Administrador)</li><li class=\"smaller\">22/05/2025 15:29:39 | modificado por TI (administrador)</li><li class=\"smaller\">22/05/2025 15:30:05 | modificado por TI (administrador)</li><li class=\"smaller\">22/05/2025 15:30:19 | modificado por TI (administrador)</li><li class=\"smaller\">22/05/2025 15:30:53 | modificado por TI (administrador)</li><li class=\"smaller\">23/05/2025 07:42:16 | modificado por TI (administrador)</li>', ''),
(12, 9, '2025-04-22 20:22:47', 1, 'OpenVPN', '<p> </p>\r\n<table style=\"border-collapse:collapse;width:100%;border-color:#000000;border-style:dashed;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"><colgroup><col style=\"width:97pt;\" width=\"129\" /> <col style=\"width:110pt;\" width=\"147\" /> <col style=\"width:108pt;\" width=\"144\" /> <col style=\"width:80pt;\" width=\"106\" /> </colgroup>\r\n<tbody>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl65\" style=\"height:15.75pt;width:97pt;text-align:center;\" width=\"129\" height=\"21\"><strong>Protocolo:</strong></td>\r\n<td class=\"xl65\" style=\"width:110pt;text-align:center;\" width=\"147\"><strong>Login:</strong></td>\r\n<td class=\"xl65\" style=\"width:108pt;text-align:center;\" width=\"144\"><strong>Senha:</strong></td>\r\n<td class=\"xl65\" style=\"width:80pt;text-align:center;\" width=\"106\"><strong>Chave Certificado</strong></td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-alexandre-zang</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">UsTs45dFsA</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-andre-8bit</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">Hsy9s8De2</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-lucas-8bit</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">AfEr4376y</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-divair-8bit</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">Bsg65sP2</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-felipe-zimmermann</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">Nch6s7dG</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-neri-xavier</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">Psi6s5F</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-rodrigo-boito</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">Us68F4sW</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-clei-8bit</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">Bgs6s5dA</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">ppp-mario-zimmermann</td>\r\n<td class=\"xl67\" style=\"text-align:center;\">1uH8\"0gX\'&#96;V\'</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n<tr style=\"height:15.75pt;\">\r\n<td class=\"xl66\" style=\"height:15.75pt;text-align:center;\" height=\"21\">OpenVPN</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">ppp-launer-convidado</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">Bsg837Hs6vc</td>\r\n<td class=\"xl66\" style=\"text-align:center;\">launer2023</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><span style=\"font-size:14pt;\">Utilize este <strong><a title=\"OpenVPN Connect\" href=\"https://openvpn.net/downloads/openvpn-connect-v3-windows.msi\" target=\"_blank\" rel=\"noreferrer noopener\">link</a></strong> para instalar o <strong>OpenVPN </strong>na máquina e depois use o arquivo <code>.txt</code><sub>(Launer-OpenVPN.txt)</sub>, <span style=\"text-decoration:underline;\">modificando sua extensão</span> para <code>.ovpn</code>.</span></p>', '', 0, 0, 2, '1', '1', '0', 30, '<li class=\"smaller\">22/04/2025 17:22:46 | enviado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 07:59:40 | modificado por TI (Administrador)</li>', '1#Launer-OpenVPN.txt,'),
(13, 8, '2025-04-23 11:18:56', 1, 'Servidor de Email', '<h3>Entrada:</h3>\r\n<p><strong>Server:</strong> mail14-ssl.m9.network<br /><strong>Porta:</strong> 995<br /><strong>Segurança:</strong> SSL</p>\r\n<h3>Saída: </h3>\r\n<p><strong>Server:</strong> mail-ssl.m9.network<br /><strong>Porta:</strong> 587<br /><strong>Segurança:</strong> TLS ou STARTTLS<br /><br /></p>', 'email e-mail servidor entrada saída', 0, 0, 4, '1', '1', '0', 10, '<li class=\"smaller\">23/04/2025 08:18:56 | enviado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:10:44 | modificado por TI (Administrador)</li>', ''),
(14, 8, '2025-04-23 11:38:46', 1, 'Servidores da Launer', '<h3>Máquinas</h3>\r\n<table style=\"border-collapse:collapse;width:100%;height:134.4px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:50%;height:22.4px;\">Active Directory</td>\r\n<td style=\"width:25%;height:22.4px;\">192.168.0.200</td>\r\n<td style=\"width:25%;height:22.4px;\">Físico</td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:50%;height:22.4px;\">Servidor WS2012</td>\r\n<td style=\"width:25%;height:22.4px;\">192.168.0.201</td>\r\n<td style=\"width:25%;height:22.4px;\">Físico</td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:50%;height:22.4px;\">Proxmox</td>\r\n<td style=\"width:25%;height:22.4px;\">192.168.0.203</td>\r\n<td style=\"width:25%;height:22.4px;\">Físico</td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:50%;height:22.4px;\">PostgreSQL</td>\r\n<td style=\"width:25%;height:22.4px;\">192.168.0.204</td>\r\n<td style=\"width:25%;height:22.4px;\">Virtual (203)</td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:50%;height:22.4px;\">Servidor WS2022 - Protheus</td>\r\n<td style=\"width:25%;height:22.4px;\">192.168.0.205</td>\r\n<td style=\"width:25%;height:22.4px;\">Virtual (203)</td>\r\n</tr>\r\n<tr style=\"height:22.4px;\">\r\n<td style=\"width:50%;height:22.4px;\">TOTVS - SFA</td>\r\n<td style=\"width:25%;height:22.4px;\">192.168.0.206</td>\r\n<td style=\"width:25%;height:22.4px;\">Virtual (203)</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h3>Acessos</h3>\r\n<p>192.168.0.201:50 → Página Inicial - Chamados<br />192.168.0.203:8006 → Proxmox (Gerenciador das  Máquinas Virtuais)<br />192.168.0.205/webapp → Protheus</p>', 'servidor servidores launer 201 ad active directory proxmox post postgre postgresql protheus 204 205 totvs sfa força vendas', 0, 0, 4, '1', '1', '0', 20, '<li class=\"smaller\">23/04/2025 08:38:46 | enviado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:10:02 | modificado por TI (Administrador)</li>', ''),
(15, 5, '2025-04-23 12:03:36', 1, 'ERRO 0x0000011B', '<p><span style=\"font-size:12pt;\">1- Abra o <strong>control panel</strong> e em <strong>programas</strong> desinstale a atualização <strong>KB5005565</strong> do Windows e <strong>reinicie</strong>. Durante o processo de reinicialização, o Windows instalará automaticamente a atualização <strong>KB5005033</strong>. Isso permite que outros computadores na rede usem os compartilhamentos.<br /><br />2- Abra o<strong> regedit</strong>.</span></p>\r\n<p><span style=\"font-size:12pt;\">Com o \"Editor do Registro\" aberto, vá em <em>HKEY_LOCAL_MACHINE &gt; System &gt; CurrentControlSet &gt; Control &gt; Print</em></span></p>\r\n<p><span style=\"font-size:12pt;\">Na pasta \"Print\", crie um novo registro <strong>DWORD (32 bits)</strong> e nomeie como <code>RpcAuthnLevelPrivacyEnabled</code> e coloque ele como valor <code>0</code>.</span></p>\r\n<p><span style=\"font-size:12pt;\"><strong>Reinicie </strong>o computador.</span></p>\r\n<p> </p>', 'erro impressora', 0, 0, 8, '1', '1', '0', 40, '<li class=\"smaller\">23/04/2025 09:03:36 | enviado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 09:11:58 | modificado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 15:34:10 | modificado por TI (Administrador)</li><li class=\"smaller\">23/04/2025 15:35:43 | modificado por TI (Administrador)</li><li class=\"smaller\">08/05/2025 11:18:12 | modificado por TI (Administrador)</li><li class=\"smaller\">08/05/2025 11:18:27 | modificado por TI (Administrador)</li><li class=\"smaller\">08/05/2025 11:19:15 | modificado por TI (Administrador)</li>', ''),
(17, 10, '2025-05-21 11:35:52', 1, 'Problemas com Corel', '<p>Segue um resumo das principais causas e soluções conhecidas para o erro de “sem conexão com a internet” ao tentar fazer login no instalador do CorelDRAW 2024:</p>\r\n<ul>\r\n<li>\r\n<p>Muitas vezes o problema ocorre porque o Windows está bloqueando domínios da Corel (via arquivo HOSTS) ou porque o cache/arquivos temporários de internet estão corrompidos.</p>\r\n</li>\r\n<li>\r\n<p>Outra causa comum é alguma configuração de proxy/VPN/firewall impedindo o instalador de acessar os servidores de ativação.</p>\r\n</li>\r\n<li>\r\n<p>Também pode ser necessário restaurar as configurações padrão de segurança do Internet Explorer (que são usadas pelo instalador) e garantir que o TLS 1.2 esteja habilitado.</p>\r\n</li>\r\n<li>\r\n<p>Em alguns casos, pingar o servidor de licenciamento ajuda a diagnosticar bloqueios de rede (por ex. <code>ping ipm.corel.com</code>).</p>\r\n</li>\r\n</ul>\r\n<p>Abaixo segue um passo‐a‐passo detalhado para resolver o problema:</p>\r\n<h2>1. Limpar cache e arquivos temporários de Internet</h2>\r\n<ol>\r\n<li>\r\n<p>Feche o navegador e qualquer instância do CorelDRAW/Central de Licenciamento.</p>\r\n</li>\r\n<li>\r\n<p>Abra o Painel de Controle (ou pesquise por <strong>Opções da Internet</strong> no menu Iniciar).</p>\r\n</li>\r\n<li>\r\n<p>Na guia <strong>Geral</strong>, clique em <strong>Excluir…</strong>, marque ao menos <strong>Arquivos de Internet Temporários</strong> e confirme.</p>\r\n</li>\r\n<li>\r\n<p>Reinicie o Windows e tente novamente.</p>\r\n</li>\r\n</ol>\r\n<h2>2. Esvaziar a pasta Temp do usuário</h2>\r\n<ol>\r\n<li>\r\n<p>Pressione <code>Win + R</code>, digite <code>%temp%</code> e pressione Enter.</p>\r\n</li>\r\n<li>\r\n<p>Selecione tudo (<code>Ctrl + A</code>) e exclua permanentemente (<code>Shift + Del</code>).</p>\r\n</li>\r\n<li>\r\n<p>Reinicie o computador.</p>\r\n</li>\r\n</ol>\r\n<h2>3. Verificar e limpar o arquivo HOSTS</h2>\r\n<ol>\r\n<li>\r\n<p>Pressione <code>Win + R</code>, digite <code>drivers</code> e entre na pasta <strong>etc</strong>.</p>\r\n</li>\r\n<li>\r\n<p>Copie o arquivo <strong>HOSTS</strong> para a Área de trabalho (permite edição).</p>\r\n</li>\r\n<li>\r\n<p>Abra-o com o Bloco de Notas e remova <em>todas</em> as linhas que mencionam domínios da Corel, por exemplo:<br /><code>0.0.0.0 apps.corel.com  <br />0.0.0.0 mc.corel.com  <br />127.0.0.1 origin-mc.corel.com  <br />127.0.0.1 iws.corel.com  <br /></code></p>\r\n</li>\r\n<li>\r\n<p>Salve, retorne o arquivo ao diretório <strong>etc</strong> e confirme a substituição.</p>\r\n</li>\r\n</ol>\r\n<p> </p>\r\n<h2>4. Restaurar configurações de Internet e garantir TLS 1.2</h2>\r\n<p> </p>\r\n<ol>\r\n<li>\r\n<p>No <strong>Painel de Controle</strong>, abra <strong>Opções da Internet</strong>.</p>\r\n</li>\r\n<li>\r\n<p>Na guia <strong>Segurança</strong>, selecione cada zona e clique em <strong>Nível padrão</strong>. Aplique.</p>\r\n</li>\r\n<li>\r\n<p>Na guia <strong>Avançadas</strong>, clique em <strong>Restaurar as configurações avançadas</strong> e confirme.</p>\r\n</li>\r\n<li>\r\n<p>Ainda em <strong>Avançadas</strong>, desça até <strong>Segurança</strong> e marque <strong>Usar TLS 1.2</strong> (se disponível).</p>\r\n</li>\r\n<li>\r\n<p>Reinicie o Windows.</p>\r\n</li>\r\n</ol>\r\n<p> </p>', '', 0, 0, 3, '0', '1', '0', 10, '<li class=\"smaller\">21/05/2025 08:35:51 | enviado por TI (Administrador)</li>', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_kb_attachments`
--

CREATE TABLE `hesk_kb_attachments` (
  `att_id` mediumint(8) UNSIGNED NOT NULL,
  `saved_name` varchar(255) NOT NULL DEFAULT '',
  `real_name` varchar(255) NOT NULL DEFAULT '',
  `size` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_kb_attachments`
--

INSERT INTO `hesk_kb_attachments` (`att_id`, `saved_name`, `real_name`, `size`) VALUES
(1, 'e9b1094984c1b4f38b4c94fc850aef14.txt', 'Launer-OpenVPN.txt', 5031);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_kb_categories`
--

CREATE TABLE `hesk_kb_categories` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent` smallint(5) UNSIGNED NOT NULL,
  `articles` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `articles_private` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `articles_draft` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `cat_order` smallint(5) UNSIGNED NOT NULL,
  `type` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_kb_categories`
--

INSERT INTO `hesk_kb_categories` (`id`, `name`, `parent`, `articles`, `articles_private`, `articles_draft`, `cat_order`, `type`) VALUES
(1, 'Knowledgebase', 0, 0, 0, 0, 10, '0'),
(2, 'Principal', 1, 0, 0, 0, 20, '0'),
(4, 'Todos', 1, 0, 0, 0, 30, '0'),
(5, 'Impressoras', 1, 0, 4, 0, 40, '1'),
(6, 'Formatação', 1, 0, 1, 0, 50, '1'),
(7, 'Computadores', 1, 0, 1, 0, 60, '1'),
(10, 'Softwares', 1, 1, 0, 0, 90, '1'),
(8, 'Rede', 1, 0, 2, 0, 70, '1'),
(9, 'Senhas', 8, 0, 3, 0, 80, '1');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_logins`
--

CREATE TABLE `hesk_logins` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(45) NOT NULL,
  `number` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `last_attempt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_logins`
--

INSERT INTO `hesk_logins` (`id`, `ip`, `number`, `last_attempt`) VALUES
(52, '192.168.0.140', 3, '2024-06-06 12:33:05'),
(204, '192.168.0.113', 5, '2025-03-12 17:57:28'),
(209, '172.16.0.62', 5, '2025-03-14 14:36:39'),
(244, '192.168.0.130', 3, '2025-04-30 12:41:56'),
(290, '172.16.0.33', 1, '2025-06-05 17:05:29');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_log_overdue`
--

CREATE TABLE `hesk_log_overdue` (
  `id` int(10) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `ticket` mediumint(8) UNSIGNED NOT NULL,
  `category` smallint(5) UNSIGNED NOT NULL,
  `priority` enum('0','1','2','3') NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `owner` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `due_date` timestamp NOT NULL DEFAULT '2000-01-01 03:00:00',
  `comments` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_mail`
--

CREATE TABLE `hesk_mail` (
  `id` int(10) UNSIGNED NOT NULL,
  `from` smallint(5) UNSIGNED NOT NULL,
  `to` smallint(5) UNSIGNED NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` mediumtext NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `read` enum('0','1') NOT NULL DEFAULT '0',
  `deletedby` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_mail`
--

INSERT INTO `hesk_mail` (`id`, `from`, `to`, `subject`, `message`, `dt`, `read`, `deletedby`) VALUES
(2, 9999, 1, 'Congratulations on your 100th ticket!', '</p><div style=\"text-align:justify; padding-left: 10px; padding-right: 10px;\">\r\n\r\n<h2 style=\"padding-left:0px\">You are now part of the Hesk family, and we want to serve you better!</h2>\r\n\r\n<h3>&raquo; Help us improve</h3>\r\n\r\n<p>Suggest what features we should add to Hesk by posting them <a href=\"https://hesk.uservoice.com/forums/69851-general\" target=\"_blank\">here</a>.</p>\r\n\r\n<h3>&raquo; Stay updated</h3>\r\n\r\n<p>Hesk regularly receives improvements and bug fixes; make sure you know about them!</p>\r\n<ul>\r\n<li>for fast notifications, <a href=\"https://twitter.com/HESKdotCOM\">follow Hesk on <b>Twitter</b></a></li>\r\n<li>for email notifications, subscribe to our low-volume zero-spam <a href=\"https://www.hesk.com/newsletter.php\">newsletter</a></li>\r\n</ul>\r\n\r\n<h3>&raquo; Look professional</h3>\r\n\r\n<p>To not only support Hesk development but also look more professional, <a href=\"https://www.hesk.com/get/hesk3-license\">remove &quot;Powered by&quot; links</a> from your help desk.</p>\r\n\r\n<h3>&raquo; Upgrade to Hesk Cloud for the ultimate experience</h3>\r\n\r\n<p>Experience the best of Hesk by moving your help desk into the Hesk Cloud:</p>\r\n<ul>\r\n<li>exclusive advanced modules,</li>\r\n<li>automated updates,</li>\r\n<li>free migration of your existing Hesk tickets and settings,</li>\r\n<li>we take care of maintenance, server setup and optimization, backups, and more!</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br><a href=\"https://www.hesk.com/get/hesk3-cloud\" class=\"btn btn--blue-border\" style=\"text-decoration:none\">Click here to learn more about Hesk Cloud</a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Best regards,</p>\r\n\r\n<p>Klemen Stirn<br>\r\nFounder<br>\r\n<a href=\"https://www.hesk.com\">https://www.hesk.com</a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n</div><p>', '2024-10-01 10:22:56', '1', 9999);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_mfa_backup_codes`
--

CREATE TABLE `hesk_mfa_backup_codes` (
  `id` int(10) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` smallint(5) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_mfa_verification_tokens`
--

CREATE TABLE `hesk_mfa_verification_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` smallint(5) UNSIGNED NOT NULL,
  `verification_token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT '2000-01-01 03:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_notes`
--

CREATE TABLE `hesk_notes` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `ticket` mediumint(8) UNSIGNED NOT NULL,
  `who` smallint(5) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `message` mediumtext NOT NULL,
  `attachments` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_notes`
--

INSERT INTO `hesk_notes` (`id`, `ticket`, `who`, `dt`, `message`, `attachments`) VALUES
(1, 177, 1, '2025-05-30 10:45:53', 'O Servidor está muito cheio, e a pasta de arquivos do Marketing ocupa de 70 a 80% do espaço total disponível.', ''),
(2, 175, 1, '2025-05-30 10:53:11', 'Ocorreram problemas na hora da execução, no qual resultou em falha catastrófica na cópia do arquivo de emails do financeiro, que tinha mais de 30GB de tamanho em arquivo. Isso aconteceu devido à TI deixar o usuário utilizar o computador enquanto fazia o backup, sem avisar as consequências de abrir o Outlook durante a cópia, além de não verificar após o bakcup estar completo se os arquivos haviam sido copiados corretamente. A TI  agora tenta recuperar os dados perdidos com um serviço de terceiros.', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_oauth_providers`
--

CREATE TABLE `hesk_oauth_providers` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `authorization_url` text NOT NULL,
  `token_url` text NOT NULL,
  `client_id` text NOT NULL,
  `client_secret` text NOT NULL,
  `scope` text NOT NULL,
  `no_val_ssl` tinyint(4) NOT NULL DEFAULT 0,
  `verified` smallint(6) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_oauth_tokens`
--

CREATE TABLE `hesk_oauth_tokens` (
  `id` int(11) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `token_value` text DEFAULT NULL,
  `token_type` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_online`
--

CREATE TABLE `hesk_online` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` smallint(5) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tmp` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_pipe_loops`
--

CREATE TABLE `hesk_pipe_loops` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `hits` smallint(1) UNSIGNED NOT NULL DEFAULT 0,
  `message_hash` char(32) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_replies`
--

CREATE TABLE `hesk_replies` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `replyto` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `message` mediumtext NOT NULL,
  `message_html` mediumtext DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `attachments` mediumtext DEFAULT NULL,
  `staffid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `rating` enum('1','5') DEFAULT NULL,
  `read` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_replies`
--

INSERT INTO `hesk_replies` (`id`, `replyto`, `name`, `message`, `message_html`, `dt`, `attachments`, `staffid`, `rating`, `read`) VALUES
(1, 9, 'TI', 'Resposta.', 'Resposta.', '2024-05-14 11:31:40', '', 1, NULL, '1'),
(2, 10, 'TI', 'Resolvido  ;)', 'Resolvido  ;)', '2024-05-16 11:04:43', '', 1, NULL, '0'),
(4, 11, 'TI', 'Resolvido ;)', 'Resolvido ;)', '2024-05-16 11:17:33', '', 1, NULL, '0'),
(5, 12, 'TI', 'O problema deve ter sido resolvido, se o sistema continuar lento, continue a responder o chamado ;)', 'O problema deve ter sido resolvido, se o sistema continuar lento, continue a responder o chamado ;)', '2024-05-16 12:44:32', '', 1, NULL, '0'),
(6, 13, 'TI', 'Pedão a demora, a página está liberada agora ;)', 'Pedão a demora, a página está liberada agora ;)', '2024-05-17 12:12:06', '', 1, NULL, '1'),
(7, 14, 'TI', 'Bom dia. Não há como resolver os problemas de travamento do servidor,  já está sendo preparado uma nova forma de corrigir isto ;)', 'Bom dia. Não há como resolver os problemas de travamento do servidor,  já está sendo preparado uma nova forma de corrigir isto ;)', '2024-05-17 13:05:29', '', 1, NULL, '0'),
(8, 16, 'TI', 'Não podemos ;)', 'Não podemos ;)', '2024-05-17 17:18:28', '', 1, NULL, '0'),
(9, 17, 'TI', 'Continue respondendo se o problema persistir ;)', 'Continue respondendo se o problema persistir ;)', '2024-05-20 12:35:08', '', 1, NULL, '0'),
(10, 21, 'TI', 'Resolvido ;)', 'Resolvido ;)', '2024-05-22 10:46:43', '', 1, NULL, '0'),
(11, 19, 'TI', 'Se houver mais problemas, responda o chamado aqui ;)', 'Se houver mais problemas, responda o chamado aqui ;)', '2024-05-23 11:21:20', '', 1, NULL, '0'),
(12, 24, 'TI', 'Se der problema de novo, tente trocar o USB e espere mais um pouquinho ;)', 'Se der problema de novo, tente trocar o USB e espere mais um pouquinho ;)', '2024-05-24 11:18:30', '', 1, NULL, '0'),
(13, 26, 'TI', 'Diose recebeu o auxílio ;)', 'Diose recebeu o auxílio ;)', '2024-05-27 12:38:06', '', 1, NULL, '1'),
(14, 30, 'TI', 'Resolvido ;)', 'Resolvido ;)', '2024-05-31 12:03:12', '', 1, NULL, '0'),
(15, 29, 'TI', 'Resolvido ;)', 'Resolvido ;)', '2024-05-31 12:14:13', '', 1, NULL, '1'),
(16, 31, 'TI', 'Resolvido;)', 'Resolvido;)', '2024-06-03 14:58:07', '', 1, NULL, '0'),
(17, 32, 'TI', 'O problema  deve ter sido resolvido ;)', 'O problema  deve ter sido resolvido ;)', '2024-06-06 10:46:36', '', 1, NULL, '1'),
(18, 33, 'TI', 'Oi. Manda um print da tela ou tenta reenviar o arquivo para outro lugar, ou fecha e abre o whatsapp.', 'Oi. Manda um print da tela ou tenta reenviar o arquivo para outro lugar, ou fecha e abre o whatsapp.', '2024-06-06 10:49:02', '', 1, NULL, '1'),
(19, 34, 'TI', 'O problema deve ter sido resolvido ;)', 'O problema deve ter sido resolvido ;)', '2024-06-06 12:34:57', '', 1, NULL, '1'),
(20, 34, 'Adrieli', 'Problema não resolvido.', 'Problema não resolvido.', '2024-06-06 12:54:22', '', 0, NULL, '0'),
(21, 34, 'TI', 'Agora sim ;)', 'Agora sim ;)', '2024-06-06 13:06:22', '2#imagem_2024-06-06_100547470.png,', 1, NULL, '1'),
(22, 36, 'TI', 'E-mail criado.', 'E-mail criado.', '2024-06-06 14:36:15', '', 1, NULL, '0'),
(23, 37, 'TI', 'Bom dia, a página está bloqueada devido ao certificado do site não ser seguro, o BitDefender vai bloquear mesmo tirando o site do filtro de conteúdo.', 'Bom dia, a página está bloqueada devido ao certificado do site não ser seguro, o BitDefender vai bloquear mesmo tirando o site do filtro de conteúdo.', '2024-06-07 10:49:35', '', 1, NULL, '0'),
(25, 40, 'TI', 'Cabo VGA e monitor foram trocados.<br />\n<br />\nTi-Launer<br />\n', 'Cabo VGA e monitor foram trocados.<br/><br/>Ti-Launer<br/>', '2024-06-10 11:43:35', '', 1, NULL, '1'),
(26, 40, 'Vivian', 'Teclado não funciona<br /><br /><i>Resposta do cliente inserida por: TI</i>', 'Teclado não funciona<br /><br /><i>Resposta do cliente inserida por: TI</i>', '2024-06-10 12:17:02', '', 0, NULL, '0'),
(27, 40, 'TI', 'Passado limpa contato.<br />\n<br />\nTi-Launer<br />\n', 'Passado limpa contato.<br/><br/>Ti-Launer<br/>', '2024-06-10 12:34:35', '', 1, NULL, '1'),
(28, 41, 'TI', 'Email criado: <a href=\"mailto:nutricaoanimal@launer.com.br\">nutricaoanimal@launer.com.br</a><br />\n<br />\nTi-Launer<br />\n', 'Email criado: <a href=\"mailto:nutricaoanimal@launer.com.br\">nutricaoanimal@launer.com.br</a><br/><br/>Ti-Launer<br/>', '2024-06-10 13:47:00', '', 1, NULL, '1'),
(29, 42, 'TI', 'Instalado Drivers de impressora e atalho do chamado.<br />\n<br />\nTi-Launer<br />\n', 'Instalado Drivers de impressora e atalho do chamado.<br/><br/>Ti-Launer<br/>', '2024-06-11 11:38:11', '', 1, NULL, '0'),
(30, 43, 'TI', 'Favor, verificar se o site está disponível.<br />\n<br />\nTi-Launer<br />\n', 'Favor, verificar se o site está disponível.<br/><br/>Ti-Launer<br/>', '2024-06-13 10:43:37', '', 1, NULL, '0'),
(31, 44, 'TI', 'E-mails enviados a este endereço serão redirecionados para o e-mail do colega Diego <a href=\"mailto:assitencia03@launer.com.br\">assitencia03@launer.com.br</a><br />\n<br />\nTi-Launer<br />\n', 'E-mails enviados a este endereço serão redirecionados para o e-mail do colega Diego <a href=\"mailto:assitencia03@launer.com.br\">assitencia03@launer.com.br</a><br/><br/>Ti-Launer<br/>', '2024-06-13 19:39:11', '', 1, '5', '1'),
(32, 45, 'TI', 'Adicionado às exceções<br />\n<br />\nTi-Launer<br />\n', 'Adicionado às exceções<br/><br/>Ti-Launer<br/>', '2024-06-14 18:32:11', '', 1, NULL, '0'),
(33, 46, 'TI', 'Liberado, favor verificar se o site está disponível.<br />\n<br />\nTi-Launer<br />\n', 'Liberado, favor verificar se o site está disponível.<br/><br/>Ti-Launer<br/>', '2024-06-17 11:06:39', '', 1, NULL, '0'),
(34, 48, 'TI', 'Licença renovada.<br />\n<br />\nTi-Launer<br />\n', 'Licença renovada.<br/><br/>Ti-Launer<br/>', '2024-06-17 12:08:05', '', 1, '5', '1'),
(35, 50, 'TI', 'Bom dia, o computador está sendo verificado pelo antivírus, logo estará seguro.<br />\n<br />\nTi-Launer<br />\n', 'Bom dia, o computador está sendo verificado pelo antivírus, logo estará seguro.<br/><br/>Ti-Launer<br/>', '2024-06-19 10:54:38', '', 1, NULL, '0'),
(36, 51, 'TI', 'Oi, as supostas mensagens de vírus são o próprio vírus, não abra elas e se continuar a receber notificações, desative as notificações do google.<br />\n<br />\nTi-Launer<br />\n', 'Oi, as supostas mensagens de vírus são o próprio vírus, não abra elas e se continuar a receber notificações, desative as notificações do google.<br/><br/>Ti-Launer<br/>', '2024-06-19 14:02:15', '', 1, NULL, '0'),
(37, 53, 'TI', 'Não há  vírus, são outros antivírus que querem que instale eles, por favor, não clique em mais informações sobre nas notificações ou em como resolver, já temos um antivírus muito bom e o computador está protegido.<br />\r\nQuanto ao teclado não estar funcionando corretamente, deve ser por que ele estava inicializando  o sistema.<br />\n<br />\nTi-Launer<br />\n', 'Não há  vírus, são outros antivírus que querem que instale eles, por favor, não clique em mais informações sobre nas notificações ou em como resolver, já temos um antivírus muito bom e o computador está protegido.<br />\r\nQuanto ao teclado não estar funcionando corretamente, deve ser por que ele estava inicializando  o sistema.<br/><br/>Ti-Launer<br/>', '2024-06-20 11:06:15', '', 1, NULL, '0'),
(38, 52, 'TI', 'Teclado foi trocado por outro.<br />\n<br />\nTi-Launer<br />\n', 'Teclado foi trocado por outro.<br/><br/>Ti-Launer<br/>', '2024-06-20 11:06:54', '', 1, NULL, '0'),
(39, 54, 'TI', 'Fui verificar e a TV ligou.<br />\n<br />\nTi-Launer<br />\n', 'Fui verificar e a TV ligou.<br/><br/>Ti-Launer<br/>', '2024-06-20 11:14:06', '', 1, NULL, '0'),
(40, 55, 'TI', 'Email criado <a href=\"mailto:assistencia12@launer.com.br\">assistencia12@launer.com.br</a>.<br />\n<br />\nTi-Launer<br />\n', 'Email criado <a href=\"mailto:assistencia12@launer.com.br\">assistencia12@launer.com.br</a>.<br/><br/>Ti-Launer<br/>', '2024-06-20 16:11:48', '', 1, NULL, '1'),
(41, 57, 'TI', 'Memória RAM muito cheia.<br />\n<br />\nTi-Launer<br />\n', 'Memória RAM muito cheia.<br/><br/>Ti-Launer<br/>', '2024-06-20 16:23:46', '', 1, NULL, '0'),
(42, 59, 'TI', 'Agora o acesso está liberado.<br />\n<br />\nTi-Launer<br />\n', 'Agora o acesso está liberado.<br/><br/>Ti-Launer<br/>', '2024-06-20 18:11:46', '', 1, NULL, '0'),
(43, 60, 'TI', 'Bom dia, o site está liberado.<br />\n<br />\nTi-Launer<br />\n', 'Bom dia, o site está liberado.<br/><br/>Ti-Launer<br/>', '2024-06-21 11:32:09', '', 1, NULL, '1'),
(44, 61, 'TI', 'Favor verificar se está liberado<br />\n<br />\nTi-Launer<br />\n', 'Favor verificar se está liberado<br/><br/>Ti-Launer<br/>', '2024-06-24 12:06:11', '', 1, NULL, '1'),
(45, 62, 'TI', 'Favor verificar se o site está disponível agora.<br />\n<br />\nTi-Launer<br />\n', 'Favor verificar se o site está disponível agora.<br/><br/>Ti-Launer<br/>', '2024-06-27 14:45:30', '', 1, NULL, '0'),
(46, 69, 'TI', 'Licença ativada.<br />\n<br />\nTi-Launer<br />\n', 'Licença ativada.<br/><br/>Ti-Launer<br/>', '2024-07-15 11:20:25', '', 1, NULL, '0'),
(47, 70, 'TI', 'Não é possível instalar a impressora em notebooks particulares, use somente o note disponibilizado pela empresa.<br />\n<br />\nTi-Launer<br />\n', 'Não é possível instalar a impressora em notebooks particulares, use somente o note disponibilizado pela empresa.<br/><br/>Ti-Launer<br/>', '2024-07-15 11:21:57', '', 1, NULL, '0'),
(48, 72, 'TI', 'Favor, verificar se a página está liberada.<br />\n<br />\nTi-Launer<br />\n', 'Favor, verificar se a página está liberada.<br/><br/>Ti-Launer<br/>', '2024-07-16 16:32:30', '', 1, NULL, '1'),
(49, 71, 'TI', 'Removidos os arquivos temporários, se o problema persistir, reabrir o chamado.<br />\n<br />\nTi-Launer<br />\n', 'Removidos os arquivos temporários, se o problema persistir, reabrir o chamado.<br/><br/>Ti-Launer<br/>', '2024-07-16 16:33:41', '', 1, NULL, '0'),
(50, 74, 'TI', 'Gateway ativado novamente.<br />\n<br />\nTi-Launer<br />\n', 'Gateway ativado novamente.<br/><br/>Ti-Launer<br/>', '2024-07-30 16:34:16', '', 1, NULL, '0'),
(51, 77, 'TI', 'computador do Jeferson não pode compartilhar a impressora, vamos em breve consertar isso.<br />\n<br />\nTi-Launer<br />\n', 'computador do Jeferson não pode compartilhar a impressora, vamos em breve consertar isso.<br/><br/>Ti-Launer<br/>', '2024-08-07 10:40:26', '', 1, NULL, '1'),
(52, 79, 'TI', 'Windows ativado com chave.<br />\n<br />\nTi-Launer<br />\n', 'Windows ativado com chave.<br/><br/>Ti-Launer<br/>', '2024-08-07 10:50:52', '', 1, NULL, '0'),
(53, 77, 'jacson wegner', 'fico no aguardo.', 'fico no aguardo.', '2024-08-07 17:41:25', '', 0, NULL, '0'),
(54, 75, 'TI', 'Recebido um computador novo!<br />\n<br />\nTi-Launer<br />\n', 'Recebido um computador novo!<br/><br/>Ti-Launer<br/>', '2024-08-23 10:56:19', '', 1, NULL, '0'),
(55, 89, 'TI', 'No momento não é possível pois envolve a compra de licenças e não estamos mais &quot;pirateando&quot;.<br />\n<br />\nTi-Launer<br />\n', 'No momento não é possível pois envolve a compra de licenças e não estamos mais &quot;pirateando&quot;.<br/><br/>Ti-Launer<br/>', '2024-09-16 13:29:25', '', 1, NULL, '1'),
(56, 95, 'TI', 'Criado o usuário Protheus: SABRINA.SEHN | Senha: 123<br />\r\nA senha terá de ser trocada no primeiro logon no sistema, o próprio usuário faz isso.<br />\n<br />\nTi-Launer<br />\n', 'Criado o usuário Protheus: SABRINA.SEHN | Senha: 123<br />\r\nA senha terá de ser trocada no primeiro logon no sistema, o próprio usuário faz isso.<br/><br/>Ti-Launer<br/>', '2024-09-18 10:53:08', '', 1, NULL, '0'),
(57, 96, 'TI', 'Não é possível, o no-break só aguenta UM computador.<br />\n<br />\nTi-Launer<br />\n', 'Não é possível, o no-break só aguenta UM computador.<br/><br/>Ti-Launer<br/>', '2024-09-23 10:56:08', '', 1, NULL, '1'),
(58, 100, 'TI', 'Pacote Office reinstalado novamente.<br />\n<br />\nTi-Launer<br />\n', 'Pacote Office reinstalado novamente.<br/><br/>Ti-Launer<br/>', '2024-10-01 11:04:54', '', 1, NULL, '0'),
(59, 99, 'TI', 'Pacote Office reinstalado e ativado.<br />\n<br />\nTi-Launer<br />\n', 'Pacote Office reinstalado e ativado.<br/><br/>Ti-Launer<br/>', '2024-10-01 11:19:44', '', 1, NULL, '0'),
(60, 98, 'Cláudia Schlabitz', 'A mensagem continua aparecendo', 'A mensagem continua aparecendo', '2024-10-02 10:19:44', '', 0, NULL, '0'),
(61, 101, 'TI', 'criado o email <a href=\"mailto:assistenciaagro02@launer.com.br\">assistenciaagro02@launer.com.br</a>.<br />\n<br />\nTi-Launer<br />\n', 'criado o email <a href=\"mailto:assistenciaagro02@launer.com.br\">assistenciaagro02@launer.com.br</a>.<br/><br/>Ti-Launer<br/>', '2024-10-02 16:21:14', '', 1, NULL, '0'),
(62, 98, 'TI', 'Oi, se acontecer amanhã, tente me chamar na hora que eu vou dar uma olhada com o aviso na tela.<br />\n<br />\nTi-Launer<br />\n', 'Oi, se acontecer amanhã, tente me chamar na hora que eu vou dar uma olhada com o aviso na tela.<br/><br/>Ti-Launer<br/>', '2024-10-02 17:21:42', '', 1, NULL, '1'),
(63, 102, 'TI', 'Limpados os arquivos temporários que poderiam estar afetando o funcionamento da impressora.<br />\n<br />\nTi-Launer<br />\n', 'Limpados os arquivos temporários que poderiam estar afetando o funcionamento da impressora.<br/><br/>Ti-Launer<br/>', '2024-10-10 16:50:06', '', 1, NULL, '1'),
(64, 102, 'Maiquel', 'Impressora continua com problemas.<br /><br /><i>Resposta do cliente inserida por: TI</i>', 'Impressora continua com problemas.<br /><br /><i>Resposta do cliente inserida por: TI</i>', '2024-10-30 10:33:34', '', 0, NULL, '0'),
(65, 110, 'Wanderson', 'Além de alinhar com o Marketing a foto, veja com o RH a questão do nome e demais necessidades', 'Além de alinhar com o Marketing a foto, veja com o RH a questão do nome e demais necessidades', '2024-10-31 19:58:55', '', 0, NULL, '0'),
(66, 102, 'TI', 'Dispositivo está em observação para verificar se há mais problemas.<br />\r\nOutra impressora foi colocada no lugar.<br />\n<br />\nTi-Launer<br />\n', 'Dispositivo está em observação para verificar se há mais problemas.<br />\r\nOutra impressora foi colocada no lugar.<br/><br/>Ti-Launer<br/>', '2024-11-01 14:09:23', '', 1, NULL, '1'),
(67, 108, 'TI', 'Computador formatado e pronto.<br />\r\nSurgiram algumas complicações no processo, mas está funcionando.<br />\n<br />\nTi-Launer<br />\n', 'Computador formatado e pronto.<br />\r\nSurgiram algumas complicações no processo, mas está funcionando.<br/><br/>Ti-Launer<br/>', '2024-11-04 12:30:19', '', 1, NULL, '0'),
(68, 110, 'TI', 'E-mail <a href=\"mailto:fernandamallmann@launer.com.br\">fernandamallmann@launer.com.br</a> criado e assinatura em andamento.<br />\n<br />\nTi-Launer<br />\n', 'E-mail <a href=\"mailto:fernandamallmann@launer.com.br\">fernandamallmann@launer.com.br</a> criado e assinatura em andamento.<br/><br/>Ti-Launer<br/>', '2024-11-05 10:40:27', '', 1, NULL, '1'),
(69, 111, 'TI', 'Power BI foi transferido para rodar no servidor NOVO, foi criado um usuário com suas credencias para o acesso ao servidor.<br />\n<br />\nTi-Launer<br />\n', 'Power BI foi transferido para rodar no servidor NOVO, foi criado um usuário com suas credencias para o acesso ao servidor.<br/><br/>Ti-Launer<br/>', '2024-11-05 10:42:23', '', 1, NULL, '1'),
(70, 109, 'TI', 'Estamos analisando opções e preços, mas está em andamento.<br />\n<br />\nTi-Launer<br />\n', 'Estamos analisando opções e preços, mas está em andamento.<br/><br/>Ti-Launer<br/>', '2024-11-05 10:53:13', '', 1, NULL, '1'),
(71, 113, 'TI', 'Email <a href=\"mailto:assistencia13@launer.com.br\">assistencia13@launer.com.br</a> criado.<br />\n<br />\nTi-Launer<br />\n', 'Email <a href=\"mailto:assistencia13@launer.com.br\">assistencia13@launer.com.br</a> criado.<br/><br/>Ti-Launer<br/>', '2024-11-12 13:10:24', '', 1, NULL, '0'),
(72, 115, 'TI', 'Impressora adicionada e colocada como padrão.<br />\n<br />\nTi-Launer<br />\n', 'Impressora adicionada e colocada como padrão.<br/><br/>Ti-Launer<br/>', '2024-11-19 13:51:30', '', 1, NULL, '1'),
(73, 116, 'TI', 'Bom dia, é possível que eu não tenha compreendido, os relatórios parecem estar funcionando.<br />\r\nZang disse que vocês conversaram no mesmo dia, se estiver resolvido, marque o chamado como *resolvido*<br />\n<br />\nTi-Launer<br />\n', 'Bom dia, é possível que eu não tenha compreendido, os relatórios parecem estar funcionando.<br />\r\nZang disse que vocês conversaram no mesmo dia, se estiver resolvido, marque o chamado como *resolvido*<br/><br/>Ti-Launer<br/>', '2024-11-21 11:19:28', '', 1, NULL, '0'),
(74, 117, 'TI', 'Boa tarde, por favor, avisar então quando posso ir recolher o Pc.<br />\r\nSó ligar pro Zang quando sim.<br />\n<br />\nTi-Launer<br />\n', 'Boa tarde, por favor, avisar então quando posso ir recolher o Pc.<br />\r\nSó ligar pro Zang quando sim.<br/><br/>Ti-Launer<br/>', '2024-11-21 17:06:30', '', 1, NULL, '1'),
(75, 117, 'Adriéli', 'Favor realizar o serviço na sexta-feira (22/11/24), às 09h.', 'Favor realizar o serviço na sexta-feira (22/11/24), às 09h.', '2024-11-21 18:23:56', '', 0, NULL, '0'),
(76, 129, 'TI', 'Estes e-mails automáticos ainda não estão funcionando?<br />\n<br />\nTi-Launer<br />\n', 'Estes e-mails automáticos ainda não estão funcionando?<br/><br/>Ti-Launer<br/>', '2025-02-03 11:24:01', '', 1, NULL, '1'),
(77, 129, 'Wanderson', 'Bom dia!<br />\r\n<br />\r\nNão estamos recebendo ainda...', 'Bom dia!<br />\r\n<br />\r\nNão estamos recebendo ainda...', '2025-02-03 11:32:27', '', 0, NULL, '0'),
(78, 130, 'TI', 'Olá, quais seriam essas planilhas?<br />\r\n<br />\r\nTi-Launer', 'Olá, quais seriam essas planilhas?<br />\r\n<br />\r\nTi-Launer', '2025-02-13 16:41:29', '', 1, NULL, '1'),
(79, 130, 'TI', 'Depois da migração do banco de dados, temos um limite de usuários para se conectarem com este banco de dados que está conectado nesta planilha, portanto não é possível atualizá-la em mais dispostivos além dos já existentes.<br />\n<br />\nTi-Launer<br />\n', 'Depois da migração do banco de dados, temos um limite de usuários para se conectarem com este banco de dados que está conectado nesta planilha, portanto não é possível atualizá-la em mais dispostivos além dos já existentes.<br/><br/>Ti-Launer<br/>', '2025-02-17 14:58:25', '', 1, NULL, '1'),
(80, 131, 'TI', 'Favor, verificar se o computador do Almoxarifado está ligado.<br />\n<br />\nTi-Launer<br />\n', 'Favor, verificar se o computador do Almoxarifado está ligado.<br/><br/>Ti-Launer<br/>', '2025-02-25 12:41:18', '', 1, NULL, '0'),
(81, 133, 'TI', 'Concluído sem problemas.<br />\n<br />\nTi-Launer<br />\n', 'Concluído sem problemas.<br/><br/>Ti-Launer<br/>', '2025-02-26 19:57:11', '', 1, NULL, '1'),
(82, 132, 'TI', 'Conlcuido.<br />\n<br />\nTi-Launer<br />\n', 'Conlcuido.<br/><br/>Ti-Launer<br/>', '2025-02-26 19:57:55', '', 1, NULL, '0'),
(83, 134, 'TI', 'Criado uma conta com o email <a href=\"mailto:custos@launer.com.br\">custos@launer.com.br</a>.<br />\r\nSenha: Padrão emails.<br />\n<br />\nTi-Launer<br />\n', 'Criado uma conta com o email <a href=\"mailto:custos@launer.com.br\">custos@launer.com.br</a>.<br />\r\nSenha: Padrão emails.<br/><br/>Ti-Launer<br/>', '2025-02-27 12:09:39', '', 1, NULL, '0'),
(84, 135, 'TI', 'Pacote instalado e pronto para uso.<br />\n<br />\nTi-Launer<br />\n', 'Pacote instalado e pronto para uso.<br/><br/>Ti-Launer<br/>', '2025-02-27 18:35:24', '', 1, NULL, '1'),
(85, 136, 'TI', 'Resolvido, o problema parecia ser a memória RAM do computador, foi resolvido passando uma borracha nos contatos.<br />\n<br />\nTi-Launer<br />\n', 'Resolvido, o problema parecia ser a memória RAM do computador, foi resolvido passando uma borracha nos contatos.<br/><br/>Ti-Launer<br/>', '2025-03-06 20:09:30', '', 1, NULL, '1'),
(86, 124, 'TI', 'As meninas do Marketing estão no processo de desenvolvimento desse Questionário usando o Microsoft FORMS.<br />\r\nO chamado será atualizado para resolvido quando finalizado o questionário.<br />\n<br />\nTi-Launer<br />\n', 'As meninas do Marketing estão no processo de desenvolvimento desse Questionário usando o Microsoft FORMS.<br />\r\nO chamado será atualizado para resolvido quando finalizado o questionário.<br/><br/>Ti-Launer<br/>', '2025-03-06 20:13:10', '', 1, NULL, '1'),
(87, 138, 'TI', 'Cabos foram conectados, não surgiram problemas no caminho.<br />\n<br />\nTi-Launer<br />\n', 'Cabos foram conectados, não surgiram problemas no caminho.<br/><br/>Ti-Launer<br/>', '2025-03-11 17:53:31', '', 1, NULL, '0'),
(88, 141, 'TI', 'Resolvido, cabo VGA do monitor foi trocado e passado um Limpa Contato no slot da memória RAM, além de ter passado borracha nos contatos da memória RAM para limpar<br />\n<br />\nTi-Launer<br />\n', 'Resolvido, cabo VGA do monitor foi trocado e passado um Limpa Contato no slot da memória RAM, além de ter passado borracha nos contatos da memória RAM para limpar<br/><br/>Ti-Launer<br/>', '2025-03-14 14:49:37', '', 1, NULL, '0'),
(89, 142, 'TI', 'Bom dia.<br />\r\nO que está acontecendo,  é que o office somente está avisando sobre a ativação, não está te impossibilitando de usar o pacote. Pode usar tranquilo, e caso perder o acesso ou precisar de reativação, lembra de reabrir o chamado, não tem necessidade de abrir outro.<br />\n<br />\nTi-Launer<br />\n', 'Bom dia.<br />\r\nO que está acontecendo,  é que o office somente está avisando sobre a ativação, não está te impossibilitando de usar o pacote. Pode usar tranquilo, e caso perder o acesso ou precisar de reativação, lembra de reabrir o chamado, não tem necessidade de abrir outro.<br/><br/>Ti-Launer<br/>', '2025-03-17 11:04:34', '', 1, NULL, '0'),
(90, 143, 'TI', 'Email <a href=\"mailto:renanparmejiani@launer.com.br\">renanparmejiani@launer.com.br</a>, criado.<br />\n<br />\nTi-Launer<br />\n', 'Email <a href=\"mailto:renanparmejiani@launer.com.br\">renanparmejiani@launer.com.br</a>, criado.<br/><br/>Ti-Launer<br/>', '2025-03-18 18:50:13', '', 1, NULL, '0'),
(91, 145, 'TI', 'Email criado: <a href=\"mailto:roviangirelli@launer.com.br\">roviangirelli@launer.com.br</a><br />\n<br />\nTi-Launer<br />\n', 'Email criado: <a href=\"mailto:roviangirelli@launer.com.br\">roviangirelli@launer.com.br</a><br/><br/>Ti-Launer<br/>', '2025-03-20 13:48:42', '', 1, NULL, '1'),
(92, 146, 'TI', 'Inicialmente, o computador foi formatado. Contudo, devido a alguns problemas e à limitação do desempenho do equipamento, foi necessário dedicar um tempo maior para que ele ficasse plenamente operacional. Utilizou-se um recurso do sistema operacional para otimizar seu desempenho, colocando-o no modo de alta performance. Adicionalmente, aplicou-se o ativador do Office 2019, proporcionando ao usuário acesso completo aos recursos do pacote Office. Por fim, o usuário já dispõe do acesso à impressora do laboratório e está devidamente integrado ao domínio, identificado como <a href=\"mailto:rovian@corp.launer.com.br\">rovian@corp.launer.com.br</a>.<br />\n<br />\nTi-Launer<br />\n', 'Inicialmente, o computador foi formatado. Contudo, devido a alguns problemas e à limitação do desempenho do equipamento, foi necessário dedicar um tempo maior para que ele ficasse plenamente operacional. Utilizou-se um recurso do sistema operacional para otimizar seu desempenho, colocando-o no modo de alta performance. Adicionalmente, aplicou-se o ativador do Office 2019, proporcionando ao usuário acesso completo aos recursos do pacote Office. Por fim, o usuário já dispõe do acesso à impressora do laboratório e está devidamente integrado ao domínio, identificado como <a href=\"mailto:rovian@corp.launer.com.br\">rovian@corp.launer.com.br</a>.<br/><br/>Ti-Launer<br/>', '2025-03-21 10:58:43', '', 1, NULL, '1'),
(93, 148, 'TI', 'Computador pronto e Protheus já está configurado para utilizar o usuário: DEISE.DELWING | senha : 123 (exigindo troca de senha no primeiro logon do usuário).<br />\r\nAconselha-se o usuário colocar itens importantes na Área de Trabalho para evitar perda de arquivos importantes.<br />\r\nImpressora padrão também configurada: M1132 MFP<br />\n<br />\nTi-Launer<br />\n', 'Computador pronto e Protheus já está configurado para utilizar o usuário: DEISE.DELWING | senha : 123 (exigindo troca de senha no primeiro logon do usuário).<br />\r\nAconselha-se o usuário colocar itens importantes na Área de Trabalho para evitar perda de arquivos importantes.<br />\r\nImpressora padrão também configurada: M1132 MFP<br/><br/>Ti-Launer<br/>', '2025-03-28 14:49:02', '', 1, NULL, '1'),
(94, 149, 'TI', 'Foram substituídos por dispositivos novos, tanto o mouse quanto o no-break. O no-break antigo foi encaminhado para reparo, enquanto o mouse passou por manutenção para utilização futura.<br />\n<br />\nTi-Launer<br />\n', 'Foram substituídos por dispositivos novos, tanto o mouse quanto o no-break. O no-break antigo foi encaminhado para reparo, enquanto o mouse passou por manutenção para utilização futura.<br/><br/>Ti-Launer<br/>', '2025-04-02 10:40:43', '', 1, NULL, '0'),
(95, 150, 'TI', 'Opa, essa OS aí é de Prevenção, então ela não tem email de destino.<br />\n<br />\nTi-Launer<br />\n', 'Opa, essa OS aí é de Prevenção, então ela não tem email de destino.<br/><br/>Ti-Launer<br/>', '2025-04-08 19:38:42', '', 1, NULL, '0'),
(96, 153, 'TI', 'Nosso suporte de terceiros, Felipe, reiniciou todos os processos e reinstalou o Power BI, o problema deve ter sido resolvido.<br />\n<br />\nTi-Launer<br />\n', 'Nosso suporte de terceiros, Felipe, reiniciou todos os processos e reinstalou o Power BI, o problema deve ter sido resolvido.<br/><br/>Ti-Launer<br/>', '2025-04-10 10:35:56', '', 1, NULL, '0'),
(97, 154, 'TI', 'Devido a uma provável queda de energia e ao fato de o gerador da empresa estar configurado no modo manual, todos os servidores estavam desligados na manhã de hoje. Isso causou a indisponibilidade do gateway do BI.<br />\r\nO problema já está corrigido.<br />\n<br />\nTi-Launer<br />\n', 'Devido a uma provável queda de energia e ao fato de o gerador da empresa estar configurado no modo manual, todos os servidores estavam desligados na manhã de hoje. Isso causou a indisponibilidade do gateway do BI.<br />\r\nO problema já está corrigido.<br/><br/>Ti-Launer<br/>', '2025-04-23 10:49:01', '', 1, NULL, '0'),
(98, 155, 'TI', 'Impressora foi reiniciada e desconectada da energia, depois de 30s, reconectada novamente.<br />\n<br />\nTi-Launer<br />\n', 'Impressora foi reiniciada e desconectada da energia, depois de 30s, reconectada novamente.<br/><br/>Ti-Launer<br/>', '2025-04-28 11:27:09', '', 1, NULL, '0'),
(99, 155, 'M180 MARKETING', 'Impressora voltou a desfuncionar com os mesmos problemas.<br /><br /><i>Resposta do cliente inserida por: TI</i>', 'Impressora voltou a desfuncionar com os mesmos problemas.<br /><br /><i>Resposta do cliente inserida por: TI</i>', '2025-04-28 11:28:28', '', 0, NULL, '0'),
(100, 155, 'TI', 'Feito o mesmo processo de reinicialização da impressora que anteriormente e ela está funcional novamente.<br />\n<br />\nTi-Launer<br />\n', 'Feito o mesmo processo de reinicialização da impressora que anteriormente e ela está funcional novamente.<br/><br/>Ti-Launer<br/>', '2025-04-28 11:29:18', '', 1, NULL, '0'),
(101, 155, 'M180 MARKETING', 'O problema voltou à tona.<br /><br /><i>Resposta do cliente inserida por: TI</i>', 'O problema voltou à tona.<br /><br /><i>Resposta do cliente inserida por: TI</i>', '2025-04-28 11:30:04', '', 0, NULL, '0'),
(102, 155, 'TI', 'Feita reinicialização padrão, somente desligando e ligando a impressora, nas próximas vezes, aconselha-se ao usuário repetir os mesmos processos feitos pela TI.<br />\n<br />\nTi-Launer<br />\n', 'Feita reinicialização padrão, somente desligando e ligando a impressora, nas próximas vezes, aconselha-se ao usuário repetir os mesmos processos feitos pela TI.<br/><br/>Ti-Launer<br/>', '2025-04-28 11:30:59', '', 1, NULL, '0'),
(103, 158, 'TI', 'Liberado o acesso à conta <a href=\"mailto:faturamento@launer.com.br\">faturamento@launer.com.br</a>.<br />\n<br />\nTi-Launer<br />\n', 'Liberado o acesso à conta <a href=\"mailto:faturamento@launer.com.br\">faturamento@launer.com.br</a>.<br/><br/>Ti-Launer<br/>', '2025-04-29 17:57:38', '', 1, NULL, '0'),
(104, 159, 'TI', 'Favor, ligar para o setor de compras quando estiver com o computador ligado para eu poder acessar o Anydesk.<br />\n<br />\nTi-Launer<br />\n', 'Favor, ligar para o setor de compras quando estiver com o computador ligado para eu poder acessar o Anydesk.<br/><br/>Ti-Launer<br/>', '2025-04-29 19:06:11', '', 1, NULL, '0'),
(105, 160, 'TI', 'Zang trocou a impressora com a atual que estava no setor de Compras.<br />\r\nAmbas as impressoras são do mesmo modelo.<br />\n<br />\nTi-Launer<br />\n', 'Zang trocou a impressora com a atual que estava no setor de Compras.<br />\r\nAmbas as impressoras são do mesmo modelo.<br/><br/>Ti-Launer<br/>', '2025-05-08 16:34:47', '', 1, NULL, '0'),
(106, 165, 'TI', 'O computador foi movido *sem consultar a TI* para um local inadequado. O calor e a eletricidade estática gerados pelo nobreak (onde se encontrava o computador) acabaram prejudicando o desempenho e a integridade do disco rígido.<br />\n<br />\nTi-Launer<br />\n', 'O computador foi movido *sem consultar a TI* para um local inadequado. O calor e a eletricidade estática gerados pelo nobreak (onde se encontrava o computador) acabaram prejudicando o desempenho e a integridade do disco rígido.<br/><br/>Ti-Launer<br/>', '2025-05-20 13:37:07', '', 1, NULL, '0'),
(107, 166, 'TI', 'O Corel solicitou uma nova licença, que já foi providenciada, agora como um produto vitalício. Durante a instalação, surgiram alguns imprevistos. Seguimos procedimentos adicionais para garantir o funcionamento correto do produto.<br />\n<br />\nTi-Launer<br />\n', 'O Corel solicitou uma nova licença, que já foi providenciada, agora como um produto vitalício. Durante a instalação, surgiram alguns imprevistos. Seguimos procedimentos adicionais para garantir o funcionamento correto do produto.<br/><br/>Ti-Launer<br/>', '2025-05-21 11:25:46', '', 1, NULL, '0'),
(108, 167, 'TI', 'Realizei uma limpeza nos arquivos temporários do sistema que estavam muito pesados.<br />\r\nAumentei a memória virtual do computador para garantir que excesso de processos não deixem o dispositivo em sobrecarga e ativei configurações de desempenho do Windows.<br />\n<br />\nTi-Launer<br />\n', 'Realizei uma limpeza nos arquivos temporários do sistema que estavam muito pesados.<br />\r\nAumentei a memória virtual do computador para garantir que excesso de processos não deixem o dispositivo em sobrecarga e ativei configurações de desempenho do Windows.<br/><br/>Ti-Launer<br/>', '2025-05-21 19:09:35', '', 1, NULL, '1'),
(109, 170, 'Diogo', 'Foi instalado o Agente | Bitdefender nos seguintes endpoints:<br />\r\nTI;<br />\r\nComercial02;<br />\r\nGerente;<br />\r\nCoordenador;<br />\r\nVendas;<br />\r\nRH;<br />\r\nAssessoria;<br />\r\nRecepção;<br />\r\nFaturamento;<br />\r\n<br />\r\nSeguintes endpoints não foram instalados o Agente | Bitdefender devido à falta de licenças disponíveis (25):<br />\r\nAgrícola;<br />\r\nP&amp;D;<br />\r\nSupervisor;<br />\r\nCustos;<br />\r\n<br />\r\nReorganizadas as políticas e grupos dentro do gerenciamento da seguinte forma:<br />\r\n    - Separado de modo que, de acordo com o usuário, diferentes políticas serão aplicadas ao seu grupo de usuários:<br />\r\n        * Grupo de usuários com Filtro Médio;<br />\r\n           Usuários com a menor experiência ou usuários menos liberados à acessos diferentes na navegação;<br />\r\n        * Grupo de usuários com Filtro Baixo;<br />\r\n            Usuários pouco mais entendidos com computadores e navegação;<br />\r\n            Políticas aplicadas ao grupo de filtro Médio também serão aplicadas a este grupo;<br />\r\n        * Grupo de usuários Sem Filtro;<br />\r\n           Apenas usuários mais acomodados e com experiência em computadores;<br />\r\n           Políticas e exceções aplicadas a ambos grupos com filtro Médio e Baixo serão aplicadas também a este grupo;<br />\r\n<br />\r\n    - Hierarquia:<br />\r\n        * Computadores da Launer:<br />\r\n            + Ativados:<br />\r\n                &gt;Filtro Baixo;<br />\r\n                &gt;Filtro Médio;<br />\r\n                &gt;Sem Filtro;<br />\r\n            + Desativados;<br />\n<br />\nDiogo<br />\n', 'Foi instalado o Agente | Bitdefender nos seguintes endpoints:<br />\r\nTI;<br />\r\nComercial02;<br />\r\nGerente;<br />\r\nCoordenador;<br />\r\nVendas;<br />\r\nRH;<br />\r\nAssessoria;<br />\r\nRecepção;<br />\r\nFaturamento;<br />\r\n<br />\r\nSeguintes endpoints não foram instalados o Agente | Bitdefender devido à falta de licenças disponíveis (25):<br />\r\nAgrícola;<br />\r\nP&amp;D;<br />\r\nSupervisor;<br />\r\nCustos;<br />\r\n<br />\r\nReorganizadas as políticas e grupos dentro do gerenciamento da seguinte forma:<br />\r\n    - Separado de modo que, de acordo com o usuário, diferentes políticas serão aplicadas ao seu grupo de usuários:<br />\r\n        * Grupo de usuários com Filtro Médio;<br />\r\n           Usuários com a menor experiência ou usuários menos liberados à acessos diferentes na navegação;<br />\r\n        * Grupo de usuários com Filtro Baixo;<br />\r\n            Usuários pouco mais entendidos com computadores e navegação;<br />\r\n            Políticas aplicadas ao grupo de filtro Médio também serão aplicadas a este grupo;<br />\r\n        * Grupo de usuários Sem Filtro;<br />\r\n           Apenas usuários mais acomodados e com experiência em computadores;<br />\r\n           Políticas e exceções aplicadas a ambos grupos com filtro Médio e Baixo serão aplicadas também a este grupo;<br />\r\n<br />\r\n    - Hierarquia:<br />\r\n        * Computadores da Launer:<br />\r\n            + Ativados:<br />\r\n                &gt;Filtro Baixo;<br />\r\n                &gt;Filtro Médio;<br />\r\n                &gt;Sem Filtro;<br />\r\n            + Desativados;<br/><br/>Diogo<br/>', '2025-05-26 11:18:39', '', 1, NULL, '0'),
(110, 169, 'Diogo', 'O produto foi reativado com sucesso, mas ainda não foi possível identificar a causa dos imprevistos durante o uso.<br />\r\n<br />\r\nPara ajudar na análise, por favor, informe quais ações foram realizadas no sistema antes do problema ocorrer. Isso pode ajudar a entender melhor o que levou à falha.<br />\n<br />\nDiogo<br />\n', 'O produto foi reativado com sucesso, mas ainda não foi possível identificar a causa dos imprevistos durante o uso.<br />\r\n<br />\r\nPara ajudar na análise, por favor, informe quais ações foram realizadas no sistema antes do problema ocorrer. Isso pode ajudar a entender melhor o que levou à falha.<br/><br/>Diogo<br/>', '2025-05-26 11:40:54', '', 1, NULL, '1'),
(111, 171, 'Diogo', 'O computador não foi formatado, mas substituído por uma das máquinas de reserva previamente separadas, com desempenho superior ao equipamento original.<br />\r\n<br />\r\nFoi realizado um mapeamento dos computadores disponíveis para identificar aquele com melhor performance antes da troca.<br />\n<br />\nDiogo<br />\n', 'O computador não foi formatado, mas substituído por uma das máquinas de reserva previamente separadas, com desempenho superior ao equipamento original.<br />\r\n<br />\r\nFoi realizado um mapeamento dos computadores disponíveis para identificar aquele com melhor performance antes da troca.<br/><br/>Diogo<br/>', '2025-05-26 19:17:39', '', 1, NULL, '0'),
(112, 162, 'Diogo', 'Foi providenciado ambos os periféricos.<br />\n<br />\nDiogo<br />\n', 'Foi providenciado ambos os periféricos.<br/><br/>Diogo<br/>', '2025-05-26 19:24:40', '', 1, NULL, '1'),
(113, 174, 'Diogo', 'Olá, arquivos em PDF estarem demorando para baixar não significa nenhum problema de desempenho.<br />\r\nPorém, quando puder liberar para eu poder acessar e fazer uma limpeza, avise por favor.<br />\n<br />\nDiogo<br />\n', 'Olá, arquivos em PDF estarem demorando para baixar não significa nenhum problema de desempenho.<br />\r\nPorém, quando puder liberar para eu poder acessar e fazer uma limpeza, avise por favor.<br/><br/>Diogo<br/>', '2025-05-29 18:10:02', '', 1, NULL, '1'),
(114, 176, 'Diogo', 'Olá, poderia ser mais específica? Mande um print se aparece algum erro ou me diga o processo que foi feito antes de imprimir tal documento.<br />\n<br />\nDiogo<br />\n', 'Olá, poderia ser mais específica? Mande um print se aparece algum erro ou me diga o processo que foi feito antes de imprimir tal documento.<br/><br/>Diogo<br/>', '2025-05-30 10:39:53', '', 1, NULL, '1'),
(115, 177, 'Diogo', 'Os arquivos foram movidos, será dado 10 dias para o setor de Marketing analisar os arquivos movidos e se estão corretos.<br />\r\nO setor deve começar AGORA a usar os arquivos de dentro do onedrive, e não de dentro do servidor.<br />\r\nA pasta está compartilhada com ambos, Marketing e Artes.<br />\r\nA demora do chamado se deve ao fato de existirem mais de 150GB de dados, que levam tempo para serem exportados para dentro do OneDrive.<br />\n<br />\nDiogo<br />\n', 'Os arquivos foram movidos, será dado 10 dias para o setor de Marketing analisar os arquivos movidos e se estão corretos.<br />\r\nO setor deve começar AGORA a usar os arquivos de dentro do onedrive, e não de dentro do servidor.<br />\r\nA pasta está compartilhada com ambos, Marketing e Artes.<br />\r\nA demora do chamado se deve ao fato de existirem mais de 150GB de dados, que levam tempo para serem exportados para dentro do OneDrive.<br/><br/>Diogo<br/>', '2025-05-30 10:49:00', '', 1, NULL, '0'),
(116, 174, 'Diogo', 'Foi realizada uma limpeza completa em arquivos do sistema que são inúteis, arquivos temporários e CACHE.<br />\n<br />\nDiogo<br />\n', 'Foi realizada uma limpeza completa em arquivos do sistema que são inúteis, arquivos temporários e CACHE.<br/><br/>Diogo<br/>', '2025-05-30 10:55:21', '', 1, NULL, '1'),
(117, 178, 'Diogo', 'Site liberado<br />\n<br />\nDiogo<br />\n', 'Site liberado<br/><br/>Diogo<br/>', '2025-06-02 14:58:53', '', 1, NULL, '1'),
(118, 180, 'Diogo', 'Foi identificado que na verdade, o problema era no computador no qual compartilhava a impressora, LABORATORIO01.<br />\r\nEle foi restaurado e reconfigurado a impressora, agora como Laboratorio.<br />\n<br />\nDiogo<br />\n', 'Foi identificado que na verdade, o problema era no computador no qual compartilhava a impressora, LABORATORIO01.<br />\r\nEle foi restaurado e reconfigurado a impressora, agora como Laboratorio.<br/><br/>Diogo<br/>', '2025-06-03 16:20:44', '', 1, NULL, '0'),
(119, 181, 'Diogo', 'Conforme conversado, será formatado o computador na sexta feira dia 06/06/2025 durante a tarde.<br />\n<br />\nDiogo<br />\n', 'Conforme conversado, será formatado o computador na sexta feira dia 06/06/2025 durante a tarde.<br/><br/>Diogo<br/>', '2025-06-03 19:53:39', '', 1, NULL, '0'),
(120, 175, 'Diogo', 'O computador foi formatado com sucesso, apenas o arquivo de email não foi copiado devido à erros meus.<br />\n<br />\nDiogo<br />\n', 'O computador foi formatado com sucesso, apenas o arquivo de email não foi copiado devido à erros meus.<br/><br/>Diogo<br/>', '2025-06-03 19:58:11', '', 1, NULL, '0'),
(121, 176, 'deise', 'Problema resolvido.', 'Problema resolvido.', '2025-06-05 13:50:10', '', 0, NULL, '0'),
(122, 181, 'Diogo', 'Computador formatado, instalado o certificado digital da Launer e não ocorreu nenhum imprevisto.<br />\n<br />\nDiogo<br />\n', 'Computador formatado, instalado o certificado digital da Launer e não ocorreu nenhum imprevisto.<br/><br/>Diogo<br/>', '2025-06-09 11:33:31', '', 1, NULL, '0'),
(123, 176, 'Diogo', 'Ok, chamado será encerrado.<br />\n<br />\nDiogo<br />\n', 'Ok, chamado será encerrado.<br/><br/>Diogo<br/>', '2025-06-09 11:34:53', '', 1, NULL, '1'),
(124, 184, 'Diogo', 'Resolvido<br />\n<br />\nDiogo<br />\n', 'Resolvido<br/><br/>Diogo<br/>', '2025-06-13 13:01:45', '', 1, NULL, '0'),
(125, 185, 'Alexandre', 'Resolvido.<br />\n<br />\nAlexandre Zang<br />\n', 'Resolvido.<br/><br/>Alexandre Zang<br/>', '2025-06-16 20:15:30', '', 2, NULL, '0');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_reply_drafts`
--

CREATE TABLE `hesk_reply_drafts` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner` smallint(5) UNSIGNED NOT NULL,
  `ticket` mediumint(8) UNSIGNED NOT NULL,
  `message` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message_html` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_reply_drafts`
--

INSERT INTO `hesk_reply_drafts` (`id`, `owner`, `ticket`, `message`, `message_html`, `dt`) VALUES
(68, 1, 110, 'E-mail fernandamallmann@launer.com.br criado e assinatura em andamento.', 'E-mail <a href=\"mailto:fernandamallmann@launer.com.br\">fernandamallmann@launer.com.br</a> criado e assinatura em andamento.', '2024-11-05 10:40:31'),
(39, 1, 55, 'Email criado assistencia12@launer.com.br.', 'Email criado <a href=\"mailto:assistencia12@launer.com.br\">assistencia12@launer.com.br</a>.', '2024-06-20 16:11:53'),
(41, 1, 59, 'Agora o acesso está liberado.', 'Agora o acesso está liberado.', '2024-06-20 18:11:50'),
(58, 1, 99, 'Pacote Office reinstalado e ativado.', 'Pacote Office reinstalado e ativado.', '2024-10-01 11:19:49'),
(62, 1, 103, 'Pc foi reiniciado e impressora', 'Pc foi reiniciado e impressora', '2024-10-15 10:38:45'),
(72, 1, 114, 'Res', 'Res', '2024-11-13 10:45:57'),
(121, 1, 176, 'Ok, chamado será encerrado.', 'Ok, chamado será encerrado.', '2025-06-09 11:34:58'),
(122, 1, 184, 'Resolvido', 'Resolvido', '2025-06-13 13:01:50');

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_reset_password`
--

CREATE TABLE `hesk_reset_password` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `user` smallint(5) UNSIGNED NOT NULL,
  `hash` char(40) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_service_messages`
--

CREATE TABLE `hesk_service_messages` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `author` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` mediumtext NOT NULL,
  `language` varchar(50) DEFAULT NULL,
  `style` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `type` enum('0','1') NOT NULL DEFAULT '0',
  `order` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_std_replies`
--

CREATE TABLE `hesk_std_replies` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `message` mediumtext NOT NULL,
  `message_html` mediumtext DEFAULT NULL,
  `reply_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_temp_attachments`
--

CREATE TABLE `hesk_temp_attachments` (
  `att_id` mediumint(8) UNSIGNED NOT NULL,
  `unique_id` varchar(255) NOT NULL DEFAULT '',
  `saved_name` varchar(255) NOT NULL DEFAULT '',
  `real_name` varchar(255) NOT NULL DEFAULT '',
  `size` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_temp_attachments_limits`
--

CREATE TABLE `hesk_temp_attachments_limits` (
  `ip` varchar(45) NOT NULL DEFAULT '',
  `upload_count` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `last_upload_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_tickets`
--

CREATE TABLE `hesk_tickets` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `trackid` varchar(13) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(1000) NOT NULL DEFAULT '',
  `category` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `priority` enum('0','1','2','3') NOT NULL DEFAULT '3',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` mediumtext NOT NULL,
  `message_html` mediumtext DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT '2000-01-01 03:00:00',
  `lastchange` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `firstreply` timestamp NULL DEFAULT NULL,
  `closedat` timestamp NULL DEFAULT NULL,
  `articles` varchar(255) DEFAULT NULL,
  `ip` varchar(45) NOT NULL DEFAULT '',
  `language` varchar(50) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `openedby` mediumint(8) DEFAULT 0,
  `firstreplyby` smallint(5) UNSIGNED DEFAULT NULL,
  `closedby` mediumint(8) DEFAULT NULL,
  `replies` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `staffreplies` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `owner` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `assignedby` mediumint(8) DEFAULT NULL,
  `time_worked` time NOT NULL DEFAULT '00:00:00',
  `lastreplier` enum('0','1') NOT NULL DEFAULT '0',
  `replierid` smallint(5) UNSIGNED DEFAULT NULL,
  `archive` enum('0','1') NOT NULL DEFAULT '0',
  `locked` enum('0','1') NOT NULL DEFAULT '0',
  `attachments` mediumtext NOT NULL,
  `merged` mediumtext NOT NULL,
  `history` mediumtext NOT NULL,
  `custom1` mediumtext NOT NULL,
  `custom2` mediumtext NOT NULL,
  `custom3` mediumtext NOT NULL,
  `custom4` mediumtext NOT NULL,
  `custom5` mediumtext NOT NULL,
  `custom6` mediumtext NOT NULL,
  `custom7` mediumtext NOT NULL,
  `custom8` mediumtext NOT NULL,
  `custom9` mediumtext NOT NULL,
  `custom10` mediumtext NOT NULL,
  `custom11` mediumtext NOT NULL,
  `custom12` mediumtext NOT NULL,
  `custom13` mediumtext NOT NULL,
  `custom14` mediumtext NOT NULL,
  `custom15` mediumtext NOT NULL,
  `custom16` mediumtext NOT NULL,
  `custom17` mediumtext NOT NULL,
  `custom18` mediumtext NOT NULL,
  `custom19` mediumtext NOT NULL,
  `custom20` mediumtext NOT NULL,
  `custom21` mediumtext NOT NULL,
  `custom22` mediumtext NOT NULL,
  `custom23` mediumtext NOT NULL,
  `custom24` mediumtext NOT NULL,
  `custom25` mediumtext NOT NULL,
  `custom26` mediumtext NOT NULL,
  `custom27` mediumtext NOT NULL,
  `custom28` mediumtext NOT NULL,
  `custom29` mediumtext NOT NULL,
  `custom30` mediumtext NOT NULL,
  `custom31` mediumtext NOT NULL,
  `custom32` mediumtext NOT NULL,
  `custom33` mediumtext NOT NULL,
  `custom34` mediumtext NOT NULL,
  `custom35` mediumtext NOT NULL,
  `custom36` mediumtext NOT NULL,
  `custom37` mediumtext NOT NULL,
  `custom38` mediumtext NOT NULL,
  `custom39` mediumtext NOT NULL,
  `custom40` mediumtext NOT NULL,
  `custom41` mediumtext NOT NULL,
  `custom42` mediumtext NOT NULL,
  `custom43` mediumtext NOT NULL,
  `custom44` mediumtext NOT NULL,
  `custom45` mediumtext NOT NULL,
  `custom46` mediumtext NOT NULL,
  `custom47` mediumtext NOT NULL,
  `custom48` mediumtext NOT NULL,
  `custom49` mediumtext NOT NULL,
  `custom50` mediumtext NOT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `overdue_email_sent` tinyint(1) DEFAULT 0,
  `satisfaction_email_sent` tinyint(1) DEFAULT 0,
  `satisfaction_email_dt` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_tickets`
--

INSERT INTO `hesk_tickets` (`id`, `trackid`, `name`, `email`, `category`, `priority`, `subject`, `message`, `message_html`, `dt`, `lastchange`, `firstreply`, `closedat`, `articles`, `ip`, `language`, `status`, `openedby`, `firstreplyby`, `closedby`, `replies`, `staffreplies`, `owner`, `assignedby`, `time_worked`, `lastreplier`, `replierid`, `archive`, `locked`, `attachments`, `merged`, `history`, `custom1`, `custom2`, `custom3`, `custom4`, `custom5`, `custom6`, `custom7`, `custom8`, `custom9`, `custom10`, `custom11`, `custom12`, `custom13`, `custom14`, `custom15`, `custom16`, `custom17`, `custom18`, `custom19`, `custom20`, `custom21`, `custom22`, `custom23`, `custom24`, `custom25`, `custom26`, `custom27`, `custom28`, `custom29`, `custom30`, `custom31`, `custom32`, `custom33`, `custom34`, `custom35`, `custom36`, `custom37`, `custom38`, `custom39`, `custom40`, `custom41`, `custom42`, `custom43`, `custom44`, `custom45`, `custom46`, `custom47`, `custom48`, `custom49`, `custom50`, `due_date`, `overdue_email_sent`, `satisfaction_email_sent`, `satisfaction_email_dt`) VALUES
(50, 'A14', 'Patricia', 'peickmartins@gmail.com', 3, '1', 'Alerta de vírus e pc hackeado', 'Não para de entrar mensagem de alerta de virus e pc hackeado....<br />\r\nre-captha-version-3-278.buzz', 'Não para de entrar mensagem de alerta de virus e pc hackeado....<br />\r\nre-captha-version-3-278.buzz', '2024-06-19 10:11:26', '2024-06-19 12:03:03', '2024-06-19 10:54:38', '2024-06-19 12:03:03', NULL, '192.168.0.168', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:05:55', '1', 1, '0', '0', '', '', '<li class=\"smaller\">19/06/2024 07:11:26 | enviado por Cliente</li><li class=\"smaller\">19/06/2024 07:11:26 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">19/06/2024 07:53:41 | tempo dedicado atualizado para 00:05:00 por TI (Administrador)</li><li class=\"smaller\">19/06/2024 07:54:38 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">19/06/2024 09:03:03 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(49, 'A13', 'Admin', 'ti@launer.com.br', 2, '3', 'Atualização', 'Deve ter sido feita uma atualização nos códigos.', 'Deve ter sido feita uma atualização nos códigos.', '2024-06-17 12:15:07', '2024-06-17 12:39:39', NULL, '2024-06-17 12:39:39', NULL, '192.168.0.155', NULL, 3, 1, NULL, 1, 0, 0, 1, 1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/06/2024 09:15:07 | chamado criado por TI (Administrador)</li><li class=\"smaller\">17/06/2024 09:15:07 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">17/06/2024 09:39:39 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(47, 'A11', 'Alexandre', 'compras@launer.com.br', 5, '2', 'qualquer coisa', 'qualquer coisa', 'qualquer coisa', '2024-06-17 11:41:42', '2024-06-17 12:09:02', NULL, '2024-06-17 12:09:02', NULL, '192.168.0.117', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/06/2024 08:41:42 | enviado por Cliente</li><li class=\"smaller\">17/06/2024 08:41:42 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/06/2024 09:09:02 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(46, 'A10', 'Cláudia Schlabitz', 'ped02@launer.com.br', 5, '2', 'Liberar site Laborglass', 'Favor liberar site <a href=\"https://www.laborglas.com.br/\">https://www.laborglas.com.br/</a>', 'Favor liberar site <a href=\"https://www.laborglas.com.br/\">https://www.laborglas.com.br/</a>', '2024-06-17 10:54:20', '2024-06-17 11:40:27', '2024-06-17 11:06:39', '2024-06-17 11:40:27', NULL, '192.168.0.127', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:07:27', '1', 1, '0', '0', '', '', '<li class=\"smaller\">17/06/2024 07:54:20 | enviado por Cliente</li><li class=\"smaller\">17/06/2024 07:54:20 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/06/2024 08:40:22 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(48, 'A12', 'Jeferson', 'almoxarifado@launer.com.br', 1, '1', 'Necessidade de  renovação manual do LS', 'Aparece uma mensagem em cada aba que acesso no protheus.', 'Aparece uma mensagem em cada aba que acesso no protheus.', '2024-06-17 11:50:36', '2024-06-17 12:08:05', '2024-06-17 12:08:05', '2024-06-17 12:08:05', NULL, '192.168.0.136', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:12:36', '1', 1, '0', '0', '', '', '<li class=\"smaller\">17/06/2024 08:50:36 | enviado por Cliente</li><li class=\"smaller\">17/06/2024 08:50:36 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/06/2024 09:08:05 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(45, 'A09', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Internet - liberação de página bloqueada', '<a href=\"https://magazinemedica.com.br/media/images/ProductFile/339e65ee8a46c1db94bb449da13bdf1a.pdf\">https://magazinemedica.com.br/media/images/ProductFile/339e65ee8a46c1db94bb449da13bdf1a.pdf</a>', '<a href=\"https://magazinemedica.com.br/media/images/ProductFile/339e65ee8a46c1db94bb449da13bdf1a.pdf\">https://magazinemedica.com.br/media/images/ProductFile/339e65ee8a46c1db94bb449da13bdf1a.pdf</a>', '2024-06-14 18:27:04', '2024-06-14 18:32:11', '2024-06-14 18:32:11', '2024-06-14 18:32:11', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:04', '1', 1, '0', '0', '', '', '<li class=\"smaller\">14/06/2024 15:27:04 | enviado por Cliente</li><li class=\"smaller\">14/06/2024 15:27:04 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">14/06/2024 15:32:11 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(44, 'A08', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'Rescisão - Inativar E-mail', 'O colaborador Rafael Fiorentin, que usava o e-mail <a href=\"mailto:assistencia08@launer.com.br\">assistencia08@launer.com.br</a> não faz mais parte do nosso quadro de funcionários.', 'O colaborador Rafael Fiorentin, que usava o e-mail <a href=\"mailto:assistencia08@launer.com.br\">assistencia08@launer.com.br</a> não faz mais parte do nosso quadro de funcionários.', '2024-06-13 19:24:17', '2024-06-13 19:39:11', '2024-06-13 19:39:11', '2024-06-13 19:39:11', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:59', '1', 1, '0', '0', '', '', '<li class=\"smaller\">13/06/2024 16:24:17 | enviado por Cliente</li><li class=\"smaller\">13/06/2024 16:24:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">13/06/2024 16:39:11 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(43, 'A07', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Internet - liberação de página bloqueada', '<a href=\"http://info.nsf.org/usda/listings.asp\">http://info.nsf.org/usda/listings.asp</a><br />\r\nOs itens da lista que estão bloqueados, favor desbloquear.', '<a href=\"http://info.nsf.org/usda/listings.asp\">http://info.nsf.org/usda/listings.asp</a><br />\r\nOs itens da lista que estão bloqueados, favor desbloquear.', '2024-06-12 18:42:40', '2024-06-13 17:45:36', '2024-06-13 10:43:37', '2024-06-13 17:45:36', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:50', '1', 1, '0', '0', '', '', '<li class=\"smaller\">12/06/2024 15:42:40 | enviado por Cliente</li><li class=\"smaller\">12/06/2024 15:42:40 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">13/06/2024 14:45:36 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(42, 'A06', 'Patrícia Eick Martins', 'nutricaoanimal@launer.com.br', 2, '3', 'Configurar Impressora', 'Configurar impressora para que as impressões saiam no laboratório.', 'Configurar impressora para que as impressões saiam no laboratório.', '2024-06-11 11:19:17', '2024-06-11 11:38:11', '2024-06-11 11:38:11', '2024-06-11 11:38:11', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:14:14', '1', 1, '0', '0', '', '', '<li class=\"smaller\">11/06/2024 08:19:17 | enviado por Cliente</li><li class=\"smaller\">11/06/2024 08:19:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">11/06/2024 08:38:11 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(41, 'A05', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'Criação de E-mail', 'Criar e-mail para a colaboradora nova Patricia:<br />\r\n<br />\r\n<a href=\"mailto:nutricaoanimal@launer.com.br\">nutricaoanimal@launer.com.br</a>', 'Criar e-mail para a colaboradora nova Patricia:<br />\r\n<br />\r\n<a href=\"mailto:nutricaoanimal@launer.com.br\">nutricaoanimal@launer.com.br</a>', '2024-06-10 13:39:16', '2024-06-10 13:47:00', '2024-06-10 13:47:00', '2024-06-10 13:47:00', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:04:36', '1', 1, '0', '0', '', '', '<li class=\"smaller\">10/06/2024 10:39:16 | enviado por Cliente</li><li class=\"smaller\">10/06/2024 10:39:16 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">10/06/2024 10:47:00 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(80, 'A44', 'Patricia Eick Martins', 'peickmartins@gmail.com', 3, '1', 'Acesso REDE e pasta da QUALIDADE', 'liberar acesso a pasta QUALIDADE ( acesso a entrada de materias primas e laudos', 'liberar acesso a pasta QUALIDADE ( acesso a entrada de materias primas e laudos', '2024-08-15 17:19:30', '2024-08-19 10:34:15', NULL, '2024-08-19 10:34:15', NULL, '192.168.0.168', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">15/08/2024 14:19:30 | enviado por Cliente</li><li class=\"smaller\">15/08/2024 14:19:30 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">19/08/2024 07:34:15 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(79, 'A43', 'Wanderson', 'wandersonfrancisco@launer.com.br', 3, '1', 'Ativar o Windows', 'Cfe anexo...', 'Cfe anexo...', '2024-08-07 10:46:03', '2024-08-07 10:50:52', '2024-08-07 10:50:52', '2024-08-07 10:50:52', NULL, '192.168.0.106', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:03:45', '1', 1, '0', '0', '6#Alerta-Ativacao-Windows.docx,', '', '<li class=\"smaller\">07/08/2024 07:46:03 | enviado por Cliente</li><li class=\"smaller\">07/08/2024 07:46:03 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">07/08/2024 07:50:52 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(78, 'A42', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'Criação de E-mail', 'Boa tarde,<br />\r\n<br />\r\nFavor criar e-mail para o colega novo, Anderson Rodrigo Richter. <br />\r\nSugestão: <a href=\"mailto:pedagro@launer.com.br\">pedagro@launer.com.br</a>', 'Boa tarde,<br />\r\n<br />\r\nFavor criar e-mail para o colega novo, Anderson Rodrigo Richter. <br />\r\nSugestão: <a href=\"mailto:pedagro@launer.com.br\">pedagro@launer.com.br</a>', '2024-08-06 19:07:35', '2024-08-07 10:37:51', NULL, '2024-08-07 10:37:51', NULL, '192.168.0.145', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:05:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">06/08/2024 16:07:35 | enviado por Cliente</li><li class=\"smaller\">06/08/2024 16:07:35 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">07/08/2024 07:37:43 | tempo dedicado atualizado para 00:05:00 por TI (Administrador)</li><li class=\"smaller\">07/08/2024 07:37:47 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(77, 'A41', 'jacson wegner', 'manutencao@launer.com.br', 2, '3', 'impressora', 'configurar impressora do almoxarifado de peças, no computador da manutenção.', 'configurar impressora do almoxarifado de peças, no computador da manutenção.', '2024-08-06 11:51:33', '2024-09-16 16:23:42', '2024-08-07 10:40:26', '2024-09-16 16:23:42', NULL, '192.168.0.171', NULL, 3, 0, 1, 1, 2, 1, 1, -1, '00:00:00', '0', 1, '0', '0', '', '', '<li class=\"smaller\">06/08/2024 08:51:33 | enviado por Cliente</li><li class=\"smaller\">06/08/2024 08:51:33 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">07/08/2024 07:40:26 | status alterado para Em espera por TI (Administrador)</li><li class=\"smaller\">16/09/2024 13:23:25 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(76, 'A40', 'Tainara', 'comercial@launer.com.br', 2, '3', 'impressora trancando', 'impressora trancando', 'impressora trancando', '2024-08-05 11:38:11', '2024-08-05 12:14:04', NULL, '2024-08-05 12:14:04', NULL, '192.168.0.122', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">05/08/2024 08:38:11 | enviado por Cliente</li><li class=\"smaller\">05/08/2024 08:38:11 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">05/08/2024 09:14:04 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(75, 'A39', 'Júlia', 'artes@launer.com.br', 3, '1', 'Corel - Problemas em salvar PDF', 'Não consigo salvar PDF de arquivos maiores do Corel, PDF fica em branco ou não abre.', 'Não consigo salvar PDF de arquivos maiores do Corel, PDF fica em branco ou não abre.', '2024-08-01 13:06:17', '2024-08-23 10:56:19', '2024-08-23 10:56:19', '2024-08-23 10:56:19', NULL, '192.168.0.166', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:15', '1', 1, '0', '0', '', '', '<li class=\"smaller\">01/08/2024 10:06:17 | enviado por Cliente</li><li class=\"smaller\">01/08/2024 10:06:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">01/08/2024 11:45:54 | status alterado para Em espera por TI (Administrador)</li><li class=\"smaller\">23/08/2024 07:56:19 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(74, 'A38', 'Wanderson', 'wandersonfrancisco@launer.com.br', 3, '1', 'Gateway Offline no Power BI', 'Verificar para ativar novamente o Gateway.', 'Verificar para ativar novamente o Gateway.', '2024-07-30 16:18:05', '2024-07-30 16:34:16', '2024-07-30 16:34:16', '2024-07-30 16:34:16', NULL, '192.168.0.106', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:13:53', '1', 1, '0', '0', '5#01d688f8-1447-4bbf-b5e4-289d58d6c515.jpg,', '', '<li class=\"smaller\">30/07/2024 13:18:05 | enviado por Cliente</li><li class=\"smaller\">30/07/2024 13:18:05 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">30/07/2024 13:34:16 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(73, 'A37', 'DIOSE', 'faturamento@launer.com.br', 2, '3', 'nao imprimi', 'ja faz duas semanas que estou na função de reinicir ou desligar e começar tudo denovo para conseguir as impressoes', 'ja faz duas semanas que estou na função de reinicir ou desligar e começar tudo denovo para conseguir as impressoes', '2024-07-26 11:45:36', '2024-07-26 14:31:58', NULL, '2024-07-26 14:31:58', NULL, '192.168.0.140', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">26/07/2024 08:45:36 | enviado por Cliente</li><li class=\"smaller\">26/07/2024 08:45:36 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/07/2024 11:31:53 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(72, 'A36', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Internet - liberação de página bloqueada', '<a href=\"https://www.infinitypharma.com.br/wp-content/uploads/2023/06/Dioxido-de-Titanio-T.pdf\">https://www.infinitypharma.com.br/wp-content/uploads/2023/06/Dioxido-de-Titanio-T.pdf</a>', '<a href=\"https://www.infinitypharma.com.br/wp-content/uploads/2023/06/Dioxido-de-Titanio-T.pdf\">https://www.infinitypharma.com.br/wp-content/uploads/2023/06/Dioxido-de-Titanio-T.pdf</a>', '2024-07-16 14:45:50', '2024-07-16 16:32:30', '2024-07-16 16:32:30', '2024-07-16 16:32:30', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:00', '1', 1, '0', '0', '', '', '<li class=\"smaller\">16/07/2024 11:45:50 | enviado por Cliente</li><li class=\"smaller\">16/07/2024 11:45:50 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/07/2024 13:32:30 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(71, 'A35', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 3, '1', 'Computador Lento', 'Computador lento de forma geral. Sistema do ponto tranca e não consigo finalizar os lançamentos. Preciso fechar o sistema, abrir e fazer o lançamento novamente. Lentidão persiste mesmo reiniciando.', 'Computador lento de forma geral. Sistema do ponto tranca e não consigo finalizar os lançamentos. Preciso fechar o sistema, abrir e fazer o lançamento novamente. Lentidão persiste mesmo reiniciando.', '2024-07-16 12:46:26', '2024-09-16 16:23:46', '2024-07-16 16:33:41', '2024-09-16 16:23:46', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:59', '1', 1, '0', '0', '', '', '<li class=\"smaller\">16/07/2024 09:46:26 | enviado por Cliente</li><li class=\"smaller\">16/07/2024 09:46:26 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/07/2024 13:33:41 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">16/09/2024 13:23:25 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(69, 'A33', 'Patricia Eick Martins', 'nutricaoanimal@launer.com.br', 4, '3', 'expirou licença', 'Sem acesso world, excel, etc...', 'Sem acesso world, excel, etc...', '2024-07-11 20:25:13', '2024-07-15 11:20:25', '2024-07-15 11:20:25', '2024-07-15 11:20:25', NULL, '192.168.0.168', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:17', '1', 1, '0', '0', '', '', '<li class=\"smaller\">11/07/2024 17:25:13 | enviado por Cliente</li><li class=\"smaller\">11/07/2024 17:25:13 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">15/07/2024 08:20:25 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(70, 'A34', 'Patricia Eick Martins', 'peickmartins@gmail.com', 2, '3', 'Instalação impressora note', 'Instalar impressora note particular', 'Instalar impressora note particular', '2024-07-12 17:23:45', '2024-07-15 11:21:57', '2024-07-15 11:21:57', '2024-07-15 11:21:57', NULL, '192.168.0.168', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:02', '1', 1, '0', '0', '', '', '<li class=\"smaller\">12/07/2024 14:23:45 | enviado por Cliente</li><li class=\"smaller\">12/07/2024 14:23:45 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">15/07/2024 08:21:57 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(68, 'A32', 'Diego Krilow', 'vendas@launer.com.br', 3, '1', 'PC lento', 'PC demorando muito para ligar diariamente. Lento para baixar pedidos recebidos em pdf. No geral bem lento, como abrir planilhas em excel ou demais arquivos.', 'PC demorando muito para ligar diariamente. Lento para baixar pedidos recebidos em pdf. No geral bem lento, como abrir planilhas em excel ou demais arquivos.', '2024-07-08 10:51:50', '2024-09-16 16:23:25', NULL, '2024-09-16 16:23:25', NULL, '192.168.0.128', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">08/07/2024 07:51:50 | enviado por Cliente</li><li class=\"smaller\">08/07/2024 07:51:50 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/09/2024 13:23:25 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(67, 'A31', 'Vivian', 'laboratorio@launer.com.br', 3, '1', 'Computador não liga', 'O computador não está ligando.', 'O computador não está ligando.', '2024-07-03 10:48:59', '2024-07-03 11:27:13', NULL, '2024-07-03 11:27:13', NULL, '192.168.0.158', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">03/07/2024 07:48:59 | enviado por Cliente</li><li class=\"smaller\">03/07/2024 07:48:59 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/07/2024 08:27:13 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(66, 'A30', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'E-mail no SPAM', 'Olá, <br />\r\n<br />\r\nVeja se tenho ingressos para o evento Vibee da Unimed no SPAM do e-mail por favor.', 'Olá, <br />\r\n<br />\r\nVeja se tenho ingressos para o evento Vibee da Unimed no SPAM do e-mail por favor.', '2024-07-02 19:11:21', '2024-07-03 12:30:32', NULL, '2024-07-03 12:30:32', NULL, '192.168.0.145', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">02/07/2024 16:11:21 | enviado por Cliente</li><li class=\"smaller\">02/07/2024 16:11:21 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/07/2024 09:30:32 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(65, 'A29', 'Tainara', 'comercial@launer.com.br', 3, '1', 'nao ta imprimindo', 'nao ta imprimindo', 'nao ta imprimindo', '2024-07-02 14:46:39', '2024-07-03 10:39:02', NULL, '2024-07-03 10:39:02', NULL, '192.168.0.122', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">02/07/2024 11:46:39 | enviado por Cliente</li><li class=\"smaller\">02/07/2024 11:46:39 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/07/2024 07:38:56 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(64, 'A28', 'PRISCILA', 'launer@launer.com.br', 3, '1', 'Impressora.', 'Impressora não imprime. Precisa desligar ela para imprimir mais vezes.', 'Impressora não imprime. Precisa desligar ela para imprimir mais vezes.', '2024-07-01 16:32:35', '2024-07-03 12:30:12', NULL, '2024-07-03 12:30:12', NULL, '192.168.0.130', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '4#erro-impressora0107.png,', '', '<li class=\"smaller\">01/07/2024 13:32:35 | enviado por Cliente</li><li class=\"smaller\">01/07/2024 13:32:35 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/07/2024 09:30:12 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(63, 'A27', 'Jeferson', 'almoxarifado@launer.com.br', 4, '3', 'Ativação Microsoft.', 'Não estou conseguindo acessar a planilha.', 'Não estou conseguindo acessar a planilha.', '2024-07-01 11:11:36', '2024-07-03 10:39:43', NULL, '2024-07-03 10:39:43', NULL, '192.168.0.136', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '3#Captura-de-tela-2024-07-01-080839.png,', '', '<li class=\"smaller\">01/07/2024 08:11:36 | enviado por Cliente</li><li class=\"smaller\">01/07/2024 08:11:36 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/07/2024 07:39:39 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(62, 'A26', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Internet - liberação de página bloqueada', '<a href=\"https://www.emfal.com.br/wp-content/uploads/2022/07/ficha-tecnica-129-silicone-dc-245-rev-05.pdf\">https://www.emfal.com.br/wp-content/uploads/2022/07/ficha-tecnica-129-silicone-dc-245-rev-05.pdf</a>', '<a href=\"https://www.emfal.com.br/wp-content/uploads/2022/07/ficha-tecnica-129-silicone-dc-245-rev-05.pdf\">https://www.emfal.com.br/wp-content/uploads/2022/07/ficha-tecnica-129-silicone-dc-245-rev-05.pdf</a>', '2024-06-27 13:58:05', '2024-06-27 16:10:21', '2024-06-27 14:45:30', '2024-06-27 16:10:21', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:56', '1', 1, '0', '0', '', '', '<li class=\"smaller\">27/06/2024 10:58:05 | enviado por Cliente</li><li class=\"smaller\">27/06/2024 10:58:05 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">27/06/2024 13:10:21 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(61, 'A25', 'Adrieli', 'laboratorio01@launer.com.br', 5, '2', 'Liberação de site', 'Liberar acesso ao site <a href=\"https://www.chiva.com.br/\">https://www.chiva.com.br/</a>', 'Liberar acesso ao site <a href=\"https://www.chiva.com.br/\">https://www.chiva.com.br/</a>', '2024-06-24 11:09:19', '2024-06-24 12:17:10', '2024-06-24 12:06:11', '2024-06-24 12:17:10', NULL, '192.168.0.158', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:12', '1', 1, '0', '0', '', '', '<li class=\"smaller\">24/06/2024 08:09:19 | enviado por Cliente</li><li class=\"smaller\">24/06/2024 08:09:19 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">24/06/2024 09:17:10 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(58, 'A22', 'Alexandre', 'compras@launer.com.br', 5, '2', 'qualquer coisa', 'qualquer coisa', 'qualquer coisa', '2024-06-20 17:49:06', '2024-06-20 18:12:12', NULL, '2024-06-20 18:12:12', NULL, '192.168.0.117', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 14:49:06 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 14:49:06 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 15:12:12 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(59, 'A23', 'Patricia', 'nutricaoanimal@launer.com.br', 3, '1', 'Acesso pasta Publico', 'Sem acesso pasta', 'Sem acesso pasta', '2024-06-20 18:00:21', '2024-06-20 18:11:46', '2024-06-20 18:11:46', '2024-06-20 18:11:46', NULL, '192.168.0.168', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:04:46', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 15:00:21 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 15:00:21 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 15:11:46 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(60, 'A24', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Internet - liberação de página bloqueada', '<a href=\"https://emkt.abralimp.org.br/emkt/tracer/?2,8615990,98651013,bef3,2\">https://emkt.abralimp.org.br/emkt/tracer/?2,8615990,98651013,bef3,2</a>', '<a href=\"https://emkt.abralimp.org.br/emkt/tracer/?2,8615990,98651013,bef3,2\">https://emkt.abralimp.org.br/emkt/tracer/?2,8615990,98651013,bef3,2</a>', '2024-06-21 10:59:17', '2024-06-21 11:32:09', '2024-06-21 11:32:09', '2024-06-21 11:32:09', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:42', '1', 1, '0', '0', '', '', '<li class=\"smaller\">21/06/2024 07:59:17 | enviado por Cliente</li><li class=\"smaller\">21/06/2024 07:59:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">21/06/2024 08:32:09 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(57, 'A21', 'Júlia', 'artes@launer.com.br', 3, '1', 'Programa Corel', 'Corel está travando e fechando sozinho.', 'Corel está travando e fechando sozinho.', '2024-06-20 16:14:57', '2024-06-20 16:23:46', '2024-06-20 16:23:46', '2024-06-20 16:23:46', NULL, '192.168.0.166', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:07:34', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 13:14:57 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 13:14:57 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 13:23:46 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(56, 'A20', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 6, '3', 'Celular para colaborador novo', 'Preciso de um celular para o colaborador novo Christian Martinelli Becher. <br />\r\nEle estará na empresa amanhã, 21/06.', 'Preciso de um celular para o colaborador novo Christian Martinelli Becher. <br />\r\nEle estará na empresa amanhã, 21/06.', '2024-06-20 14:57:47', '2024-06-21 14:22:05', NULL, '2024-06-21 14:22:05', NULL, '192.168.0.145', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:10:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 11:57:47 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 11:57:47 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">21/06/2024 11:21:54 | tempo dedicado atualizado para 00:10:00 por TI (Administrador)</li><li class=\"smaller\">21/06/2024 11:22:00 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(55, 'A19', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'Criação de E-mail', 'Favor criar e-mail <a href=\"mailto:assistencia12@launer.com.br\">assistencia12@launer.com.br</a> para o colaborador novo, Christian Martinelli Becher.', 'Favor criar e-mail <a href=\"mailto:assistencia12@launer.com.br\">assistencia12@launer.com.br</a> para o colaborador novo, Christian Martinelli Becher.', '2024-06-20 14:56:32', '2024-06-20 16:11:48', '2024-06-20 16:11:48', '2024-06-20 16:11:48', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:13', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 11:56:32 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 11:56:32 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 13:11:48 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(54, 'A18', 'Marcelo Worm', 'producao@launer.com.br', 3, '1', 'Televisão', 'A televisão da linha de envase não está ligando.', 'A televisão da linha de envase não está ligando.', '2024-06-20 11:02:27', '2024-06-20 11:14:06', '2024-06-20 11:14:06', '2024-06-20 11:14:06', NULL, '192.168.0.78', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:06:25', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 08:02:27 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 08:02:27 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 08:14:06 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(52, 'A16', 'jacson wegner', 'manutencao@launer.com.br', 3, '1', 'teclado', 'Teclado do computador da manutenção, está com problemas, não digita.', 'Teclado do computador da manutenção, está com problemas, não digita.', '2024-06-19 20:23:37', '2024-06-20 11:06:54', '2024-06-20 11:06:54', '2024-06-20 11:06:54', NULL, '192.168.0.171', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:17', '1', 1, '0', '0', '', '', '<li class=\"smaller\">19/06/2024 17:23:37 | enviado por Cliente</li><li class=\"smaller\">19/06/2024 17:23:37 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 08:06:33 | tempo dedicado atualizado para 00:02:00 por TI (Administrador)</li><li class=\"smaller\">20/06/2024 08:06:54 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(53, 'A17', 'Patricia', 'nutricaoanimal@launer.com.br', 3, '1', 'Alerta de virus', 'Não consigo digitar....preciso reiniciar o  pc umas 3 vezes,,, muitos alertas de virus...', 'Não consigo digitar....preciso reiniciar o  pc umas 3 vezes,,, muitos alertas de virus...', '2024-06-20 10:18:32', '2024-06-20 11:06:15', '2024-06-20 11:06:15', '2024-06-20 11:06:15', NULL, '192.168.0.168', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:03', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/06/2024 07:18:32 | enviado por Cliente</li><li class=\"smaller\">20/06/2024 07:18:32 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/06/2024 08:06:15 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(37, 'A37', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Internet - liberação de página bloqueada', '<a href=\"https://capuani.com.br/linha-produtos/surfactantes/especialidades-quimicas\">https://capuani.com.br/linha-produtos/surfactantes/especialidades-quimicas</a>', '<a href=\"https://capuani.com.br/linha-produtos/surfactantes/especialidades-quimicas\">https://capuani.com.br/linha-produtos/surfactantes/especialidades-quimicas</a>', '2024-06-06 18:17:57', '2024-07-26 14:31:58', '2024-06-07 10:49:35', '2024-07-26 14:31:58', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:54', '1', 1, '0', '0', '', '', '<li class=\"smaller\">06/06/2024 15:17:57 | enviado por Cliente</li><li class=\"smaller\">06/06/2024 15:17:57 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">07/06/2024 11:39:50 | fechado por TI (Administrador)</li><li class=\"smaller\">26/07/2024 11:31:53 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(38, 'A02', 'Admin', 'ti@launer.com.br', 1, '1', 'Teste', 'Teste', 'Teste', '2024-06-07 12:03:58', '2024-06-07 12:06:51', NULL, '2024-06-07 12:06:51', NULL, '192.168.0.155', NULL, 3, 1, NULL, 1, 0, 0, 1, 1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">07/06/2024 09:03:58 | chamado criado por TI (Administrador)</li><li class=\"smaller\">07/06/2024 09:03:58 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">07/06/2024 09:06:51 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(39, 'A03', 'Tainara', 'comercial@launer.com.br', 3, '1', 'Computador se desligando', 'computador novamente se desligando', 'computador novamente se desligando', '2024-06-10 10:56:38', '2024-06-10 11:15:08', NULL, '2024-06-10 11:15:08', NULL, '192.168.0.122', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">10/06/2024 07:56:38 | enviado por Cliente</li><li class=\"smaller\">10/06/2024 07:56:38 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">10/06/2024 08:14:53 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(40, 'A04', 'Vivian', 'laboratorio@launer.com.br', 3, '1', 'Computador não liga', 'O computador está na tela inicial de bloqueio e não há como colocar a senha, não funciona nem mouse, nem teclado.', 'O computador está na tela inicial de bloqueio e não há como colocar a senha, não funciona nem mouse, nem teclado.', '2024-06-10 10:57:29', '2024-06-10 12:34:35', '2024-06-10 11:43:35', '2024-06-10 12:34:35', NULL, '192.168.0.129', NULL, 3, 0, 1, 1, 3, 2, 1, -1, '00:31:52', '1', 1, '0', '0', '', '', '<li class=\"smaller\">10/06/2024 07:57:29 | enviado por Cliente</li><li class=\"smaller\">10/06/2024 07:57:29 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">10/06/2024 08:43:35 | status alterado para Resolvido por TI (Administrador)</li><li class=\"smaller\">10/06/2024 09:16:26 | status alterado para Aguardando resposta por TI (Administrador)</li><li class=\"smaller\">10/06/2024 09:34:35 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(51, 'A15', 'Patricia', 'nutricaoanimal@launer.com.br', 3, '1', 'Alerta de virus', 'Mensagens insistentes de virus', 'Mensagens insistentes de virus', '2024-06-19 13:20:39', '2024-06-19 14:02:15', '2024-06-19 14:02:15', '2024-06-19 14:02:15', NULL, '192.168.0.168', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:10:13', '1', 1, '0', '0', '', '', '<li class=\"smaller\">19/06/2024 10:20:39 | enviado por Cliente</li><li class=\"smaller\">19/06/2024 10:20:39 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">19/06/2024 11:02:15 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(81, 'A45', 'DIEGO', 'vendas@launer.com.br', 3, '1', 'Skype sem acesso', 'Skype solicitando senha, sem acesso', 'Skype solicitando senha, sem acesso', '2024-08-20 11:10:20', '2024-08-20 11:23:25', NULL, '2024-08-20 11:23:25', NULL, '192.168.0.128', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">20/08/2024 08:10:20 | enviado por Cliente</li><li class=\"smaller\">20/08/2024 08:10:20 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/08/2024 08:23:21 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(82, 'A46', 'Marcelo Worm', 'producao@launer.com.br', 3, '1', 'Quadro - televisão', 'Quadro com programação do dia não está atualizando.', 'Quadro com programação do dia não está atualizando.', '2024-08-22 10:21:42', '2024-08-23 13:40:48', NULL, '2024-08-23 13:40:48', NULL, '192.168.0.78', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">22/08/2024 07:21:42 | enviado por Cliente</li><li class=\"smaller\">22/08/2024 07:21:42 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">23/08/2024 10:40:48 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(83, 'A47', 'David', 'assistencia@nupran.com.br', 3, '1', 'Incluir impressora', 'Boa tarde! <br />\r\n<br />\r\nGostaria de incluir a impressora &quot;em vendas&quot; para realizar impressões', 'Boa tarde! <br />\r\n<br />\r\nGostaria de incluir a impressora &quot;em vendas&quot; para realizar impressões', '2024-08-22 16:56:40', '2024-09-16 16:23:29', NULL, '2024-09-16 16:23:29', NULL, '172.16.0.206', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">22/08/2024 13:56:40 | enviado por Cliente</li><li class=\"smaller\">22/08/2024 13:56:40 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/09/2024 13:23:25 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(84, 'A48', 'Adriéli', 'laboratorio01@launer.com.br', 1, '1', 'Erro de sistema', 'O item 006292 - POLIETILENO DE ALTA DENSIDADE GF 4950 não está entrando para o estoque do PCP, consta como pendente no 98, porém também não está nos módulos da qualidade aguardando liberação. No cadastro do produto, está em SigaQuality, mas em rastro consta como não utiliza, ou seja, não controla lote. Precisamos saber para onde foi e como liberar, o PCP está precisando da MP.', 'O item 006292 - POLIETILENO DE ALTA DENSIDADE GF 4950 não está entrando para o estoque do PCP, consta como pendente no 98, porém também não está nos módulos da qualidade aguardando liberação. No cadastro do produto, está em SigaQuality, mas em rastro consta como não utiliza, ou seja, não controla lote. Precisamos saber para onde foi e como liberar, o PCP está precisando da MP.', '2024-08-22 18:32:20', '2024-08-26 11:08:36', NULL, '2024-08-26 11:08:36', NULL, '192.168.0.158', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">22/08/2024 15:32:20 | enviado por Cliente</li><li class=\"smaller\">22/08/2024 15:32:20 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/08/2024 08:08:36 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(85, 'A49', 'Adriéli', 'laboratorio01@launer.com.br', 1, '1', 'Geração de laudos', 'O sistema não está gerando os laudos da qualidade ao emitir nota fiscal, inclusive de produtos que gerava normalmente.', 'O sistema não está gerando os laudos da qualidade ao emitir nota fiscal, inclusive de produtos que gerava normalmente.', '2024-08-26 10:37:31', '2024-08-26 12:03:35', NULL, '2024-08-26 12:03:35', NULL, '192.168.0.158', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">26/08/2024 07:37:31 | enviado por Cliente</li><li class=\"smaller\">26/08/2024 07:37:31 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/08/2024 09:03:35 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(86, 'A50', 'DIEGO', 'vendas@launer.com.br', 3, '1', 'SEM ACESSO NOTAS FISCAIS GUARDIAO', 'SEM ACESSO NOTAS FISCAIS GUARDIAO', 'SEM ACESSO NOTAS FISCAIS GUARDIAO', '2024-08-27 11:36:22', '2024-08-28 10:44:48', NULL, '2024-08-28 10:44:48', NULL, '192.168.0.128', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">27/08/2024 08:36:22 | enviado por Cliente</li><li class=\"smaller\">27/08/2024 08:36:22 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">28/08/2024 07:44:44 | fechado por TI (Administrador)</li><li class=\"smaller\">28/08/2024 07:44:48 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(87, 'A51', 'Cassio', 'producao@launer.com.br', 3, '1', 'Quadro - televisão', 'NÃO ESTÁ ATUALIZANDO!', 'NÃO ESTÁ ATUALIZANDO!', '2024-09-10 16:29:34', '2024-09-16 16:23:33', NULL, '2024-09-16 16:23:33', NULL, '192.168.0.78', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">10/09/2024 13:29:34 | enviado por Cliente</li><li class=\"smaller\">10/09/2024 13:29:34 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/09/2024 13:23:25 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL);
INSERT INTO `hesk_tickets` (`id`, `trackid`, `name`, `email`, `category`, `priority`, `subject`, `message`, `message_html`, `dt`, `lastchange`, `firstreply`, `closedat`, `articles`, `ip`, `language`, `status`, `openedby`, `firstreplyby`, `closedby`, `replies`, `staffreplies`, `owner`, `assignedby`, `time_worked`, `lastreplier`, `replierid`, `archive`, `locked`, `attachments`, `merged`, `history`, `custom1`, `custom2`, `custom3`, `custom4`, `custom5`, `custom6`, `custom7`, `custom8`, `custom9`, `custom10`, `custom11`, `custom12`, `custom13`, `custom14`, `custom15`, `custom16`, `custom17`, `custom18`, `custom19`, `custom20`, `custom21`, `custom22`, `custom23`, `custom24`, `custom25`, `custom26`, `custom27`, `custom28`, `custom29`, `custom30`, `custom31`, `custom32`, `custom33`, `custom34`, `custom35`, `custom36`, `custom37`, `custom38`, `custom39`, `custom40`, `custom41`, `custom42`, `custom43`, `custom44`, `custom45`, `custom46`, `custom47`, `custom48`, `custom49`, `custom50`, `due_date`, `overdue_email_sent`, `satisfaction_email_sent`, `satisfaction_email_dt`) VALUES
(88, 'A52', 'Maiquel', 'pcp2@launer.com.br', 3, '1', 'desligando durante o dia', 'Computador da expedição está se desligando', 'Computador da expedição está se desligando', '2024-09-12 16:46:17', '2024-09-16 16:23:37', NULL, '2024-09-16 16:23:37', NULL, '192.168.0.119', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">12/09/2024 13:46:17 | enviado por Cliente</li><li class=\"smaller\">12/09/2024 13:46:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/09/2024 13:23:25 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(89, 'A53', 'Cláudia Schlabitz', 'ped02@launer.com.br', 3, '1', 'Corel Draw', 'Olá. É possível instalar o Corel Draw na minha máquina? Facilitaria quando preciso solicitar etiquetas ao Gregory. Tendo o software eu já poderia enviar as etiquetas prontas. Grata.', 'Olá. É possível instalar o Corel Draw na minha máquina? Facilitaria quando preciso solicitar etiquetas ao Gregory. Tendo o software eu já poderia enviar as etiquetas prontas. Grata.', '2024-09-16 11:44:38', '2024-09-16 13:29:25', '2024-09-16 13:29:25', '2024-09-16 13:29:25', NULL, '192.168.0.127', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:06', '1', 1, '0', '0', '', '', '<li class=\"smaller\">16/09/2024 08:44:38 | enviado por Cliente</li><li class=\"smaller\">16/09/2024 08:44:38 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/09/2024 10:29:25 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(90, 'A54', 'Maiquel', 'pcp2@launer.com.br', 1, '1', 'SISTEMA LENTO', 'Sistema travando muito', 'Sistema travando muito', '2024-09-16 18:19:30', '2024-09-18 10:38:54', NULL, '2024-09-18 10:38:54', NULL, '192.168.0.119', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">16/09/2024 15:19:30 | enviado por Cliente</li><li class=\"smaller\">16/09/2024 15:19:30 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:38:41 | fechado por TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:38:54 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(91, 'A55', 'Maiquel', 'pcp2@launer.com.br', 1, '1', 'SISTEMA LENTO', 'Sistema muito lento, no PCP e na expedição', 'Sistema muito lento, no PCP e na expedição', '2024-09-17 16:20:41', '2024-09-18 10:38:59', NULL, '2024-09-18 10:38:59', NULL, '192.168.0.119', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/09/2024 13:20:41 | enviado por Cliente</li><li class=\"smaller\">17/09/2024 13:20:41 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:38:41 | fechado por TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:38:54 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(92, 'A56', 'Maiquel', 'pcp2@launer.com.br', 3, '1', 'impressora ZM600', 'Não funciona mais', 'Não funciona mais', '2024-09-17 16:22:42', '2024-10-01 10:39:28', NULL, '2024-10-01 10:39:28', NULL, '192.168.0.119', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/09/2024 13:22:42 | enviado por Cliente</li><li class=\"smaller\">17/09/2024 13:22:42 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">01/10/2024 07:39:28 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(93, 'A57', 'jacson wegner', 'manutencao@launer.com.br', 2, '3', 'IMPRESSORA NÃO CONFIGURADA', 'Não é possível enviar impressões do computador da manutenção, para a impressora do almoxarifado de peças, segundo Alexandre é necessário formatar o computador do almoxarifado de peças,', 'Não é possível enviar impressões do computador da manutenção, para a impressora do almoxarifado de peças, segundo Alexandre é necessário formatar o computador do almoxarifado de peças,', '2024-09-17 16:40:32', '2025-02-25 12:42:09', NULL, '2025-02-25 12:42:09', NULL, '192.168.0.171', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/09/2024 13:40:32 | enviado por Cliente</li><li class=\"smaller\">17/09/2024 13:40:32 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">25/02/2025 09:42:04 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(94, 'A58', 'jacson wegner', 'manutencao@launer.com.br', 2, '3', 'IMPRESSORA NÃO CONFIGURADA', 'Não é possível enviar impressões do computador da manutenção, para a impressora do almoxarifado de peças, segundo Alexandre é necessário formatar o computador do almoxarifado de peças,', 'Não é possível enviar impressões do computador da manutenção, para a impressora do almoxarifado de peças, segundo Alexandre é necessário formatar o computador do almoxarifado de peças,', '2024-09-17 16:47:10', '2024-09-18 10:39:03', NULL, '2024-09-18 10:39:03', NULL, '192.168.0.171', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/09/2024 13:47:10 | enviado por Cliente</li><li class=\"smaller\">17/09/2024 13:47:10 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:38:41 | fechado por TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:38:54 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(95, 'A59', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 3, '1', 'Liberações e Acessos - Sabrina Sehn - Prazo 24/09', 'Boa tarde,<br />\r\n<br />\r\nNa semana que vem irá iniciar conosco a funcionária Sabrina Sehn. <br />\r\nEla terá as mesmas atividades que a Carla Zinn.<br />\r\n<br />\r\nFavor configurar:<br />\r\n<br />\r\n-Usuário e Senha no sistema Protheus (Mesmas liberações Carla)<br />\r\n- E-mail - <a href=\"mailto:fiscal@launer.com.br\">fiscal@launer.com.br</a><br />\r\n- Liberar acesso as pastas do servidor (Mesmas liberações Carla)<br />\r\n<br />\r\nA Sabrina inicia conosco na próxima terça, 24/09, e o ideal é que esteja tudo pronto nessa data.', 'Boa tarde,<br />\r\n<br />\r\nNa semana que vem irá iniciar conosco a funcionária Sabrina Sehn. <br />\r\nEla terá as mesmas atividades que a Carla Zinn.<br />\r\n<br />\r\nFavor configurar:<br />\r\n<br />\r\n-Usuário e Senha no sistema Protheus (Mesmas liberações Carla)<br />\r\n- E-mail - <a href=\"mailto:fiscal@launer.com.br\">fiscal@launer.com.br</a><br />\r\n- Liberar acesso as pastas do servidor (Mesmas liberações Carla)<br />\r\n<br />\r\nA Sabrina inicia conosco na próxima terça, 24/09, e o ideal é que esteja tudo pronto nessa data.', '2024-09-17 19:57:43', '2024-09-18 10:53:08', '2024-09-18 10:53:08', '2024-09-18 10:53:08', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:47', '1', 1, '0', '0', '', '', '<li class=\"smaller\">17/09/2024 16:57:43 | enviado por Cliente</li><li class=\"smaller\">17/09/2024 16:57:43 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">18/09/2024 07:53:08 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(96, 'A60', 'Adriéli', 'laboratorio01@launer.com.br', 3, '1', 'No break', 'Conectar meu computador ao no break da Vivi.', 'Conectar meu computador ao no break da Vivi.', '2024-09-19 18:46:01', '2024-09-23 10:56:08', '2024-09-23 10:56:08', '2024-09-23 10:56:08', NULL, '192.168.0.158', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:41', '1', 1, '0', '0', '', '', '<li class=\"smaller\">19/09/2024 15:46:01 | enviado por Cliente</li><li class=\"smaller\">19/09/2024 15:46:01 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">23/09/2024 07:56:08 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(97, 'A61', 'Cassiano', 'assistencia02@launer.com.br', 3, '1', 'Instalar aplicativo &quot;chamado&quot; e &quot;marketing&quot; no computador', 'Instalar aplicativo &quot;chamado&quot; e &quot;marketing&quot; no computador', 'Instalar aplicativo &quot;chamado&quot; e &quot;marketing&quot; no computador', '2024-09-23 19:09:56', '2024-10-04 11:29:57', NULL, '2024-10-04 11:29:57', NULL, '192.168.0.162', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">23/09/2024 16:09:56 | enviado por Cliente</li><li class=\"smaller\">23/09/2024 16:09:56 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">04/10/2024 08:29:57 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(98, 'A62', 'Cláudia Schlabitz', 'ped02@launer.com.br', 3, '1', 'Tela de aviso sobre credenciais', 'Olá. Está aparecendo uma tela dizendo que é necessário fornecer as credenciais. Acredito que tem relação com o OneDrive, pq tb apareceu um aviso dizendo que não estava salvando.', 'Olá. Está aparecendo uma tela dizendo que é necessário fornecer as credenciais. Acredito que tem relação com o OneDrive, pq tb apareceu um aviso dizendo que não estava salvando.', '2024-09-24 10:04:10', '2024-10-04 10:38:50', '2024-10-02 17:21:42', '2024-10-04 10:38:50', NULL, '192.168.0.127', NULL, 3, 0, 1, 1, 2, 1, 1, -1, '00:05:35', '1', 1, '0', '0', '7#Captura-de-tela-2024-09-24-070245.png,', '', '<li class=\"smaller\">24/09/2024 07:04:10 | enviado por Cliente</li><li class=\"smaller\">24/09/2024 07:04:10 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">01/10/2024 07:39:56 | fechado por TI (Administrador)</li><li class=\"smaller\">02/10/2024 07:19:17 | aberto por Cliente</li><li class=\"smaller\">04/10/2024 07:38:43 | tempo dedicado atualizado para 00:05:35 por TI (Administrador)</li><li class=\"smaller\">04/10/2024 07:38:46 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(99, 'A63', 'Maiquel', 'pcp2@launer.com.br', 3, '1', 'excel', 'PC da expedição não tem acesso', 'PC da expedição não tem acesso', '2024-09-30 20:30:59', '2024-10-01 11:19:44', '2024-10-01 11:19:44', '2024-10-01 11:19:44', NULL, '192.168.0.119', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:10:08', '1', 1, '0', '0', '', '', '<li class=\"smaller\">30/09/2024 17:30:59 | enviado por Cliente</li><li class=\"smaller\">30/09/2024 17:30:59 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">01/10/2024 08:19:13 | tempo dedicado atualizado para 00:10:00 por TI (Administrador)</li><li class=\"smaller\">01/10/2024 08:19:44 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(100, 'A64', 'Marcelo Worm', 'producao@launer.com.br', 3, '1', 'Excel', 'Não é possivel acessar as planilhas do excel.', 'Não é possivel acessar as planilhas do excel.', '2024-10-01 10:22:56', '2024-10-01 11:04:54', '2024-10-01 11:04:54', '2024-10-01 11:04:54', NULL, '192.168.0.114', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:20:07', '1', 1, '0', '0', '', '', '<li class=\"smaller\">01/10/2024 07:22:56 | enviado por Cliente</li><li class=\"smaller\">01/10/2024 07:22:56 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">01/10/2024 08:04:45 | tempo dedicado atualizado para 00:20:00 por TI (Administrador)</li><li class=\"smaller\">01/10/2024 08:04:54 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(101, 'A65', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'Criação de E-mail Daniel Del Compare', 'Olá,<br />\r\n<br />\r\nFavor criar e-mail para o colega novo:<br />\r\n<br />\r\nDaniel Lucas Oliveira Del Compare<br />\r\n<a href=\"mailto:assistenciaagro02@launer.com.br\">assistenciaagro02@launer.com.br</a>', 'Olá,<br />\r\n<br />\r\nFavor criar e-mail para o colega novo:<br />\r\n<br />\r\nDaniel Lucas Oliveira Del Compare<br />\r\n<a href=\"mailto:assistenciaagro02@launer.com.br\">assistenciaagro02@launer.com.br</a>', '2024-10-02 14:06:08', '2024-10-02 16:21:14', '2024-10-02 16:21:14', '2024-10-02 16:21:14', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:30:36', '1', 1, '0', '0', '', '', '<li class=\"smaller\">02/10/2024 11:06:08 | enviado por Cliente</li><li class=\"smaller\">02/10/2024 11:06:08 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">02/10/2024 13:20:36 | tempo dedicado atualizado para 00:30:00 por TI (Administrador)</li><li class=\"smaller\">02/10/2024 13:21:14 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(102, 'A66', 'Maiquel', 'pcp2@launer.com.br', 2, '3', 'Impressora expedição', 'não está funcionando a impressora da expedição', 'não está funcionando a impressora da expedição', '2024-10-10 16:16:31', '2024-11-01 14:09:40', '2024-10-10 16:50:06', '2024-11-01 14:09:40', NULL, '192.168.0.119', NULL, 3, 0, 1, 1, 3, 2, 1, -1, '00:05:04', '1', 1, '0', '0', '', '', '<li class=\"smaller\">10/10/2024 13:16:31 | enviado por Cliente</li><li class=\"smaller\">10/10/2024 13:16:31 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">10/10/2024 13:50:06 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">30/10/2024 07:33:35 | status alterado para Aguardando resposta por TI (Administrador)</li><li class=\"smaller\">01/11/2024 11:09:36 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(103, 'A67', 'Maiquel', 'pcp2@launer.com.br', 3, '1', 'PC Grégory não funciona', 'Pc do Grégory está travando e a impressora ZT 420 não imprime', 'Pc do Grégory está travando e a impressora ZT 420 não imprime', '2024-10-14 17:11:57', '2024-10-15 10:39:32', NULL, '2024-10-15 10:39:32', NULL, '192.168.0.119', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:05:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">14/10/2024 14:11:57 | enviado por Cliente</li><li class=\"smaller\">14/10/2024 14:11:57 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">15/10/2024 07:38:27 | tempo dedicado atualizado para 00:05:00 por TI (Administrador)</li><li class=\"smaller\">15/10/2024 07:39:28 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(106, 'A70', 'DANIEL HORST', 'custos@launer.com.br', 3, '1', 'Instalar as Caixinhas de Som.', 'Após longa espera, gostaria então de pedir que fossem instaladas as caixinhas de som no meu computador.', 'Após longa espera, gostaria então de pedir que fossem instaladas as caixinhas de som no meu computador.', '2024-10-16 10:45:18', '2024-11-08 10:30:15', NULL, '2024-11-08 10:30:15', NULL, '192.168.0.143', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">16/10/2024 07:45:18 | enviado por Cliente</li><li class=\"smaller\">16/10/2024 07:45:18 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">08/11/2024 07:30:15 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(109, 'A73', 'Wanderson', 'wandersonfrancisco@launer.com.br', 6, '3', 'Instalar Whats web para o Daniel e a Sabrina', 'Conforme conversamos, verificar a melhor forma de deixar disponível o uso compartilhado do WhatsApp Web para o Daniel e a Sabrina e assim eles poderem agilizar os processos internos e facilitar comunicação da Launer com e Escritório Contábil.', 'Conforme conversamos, verificar a melhor forma de deixar disponível o uso compartilhado do WhatsApp Web para o Daniel e a Sabrina e assim eles poderem agilizar os processos internos e facilitar comunicação da Launer com e Escritório Contábil.', '2024-10-31 10:30:21', '2024-11-05 10:53:13', '2024-11-05 10:53:13', NULL, NULL, '192.168.0.106', NULL, 4, 0, 1, NULL, 1, 1, 1, -1, '00:10:00', '1', 1, '0', '0', '', '', '<li class=\"smaller\">31/10/2024 07:30:21 | enviado por Cliente</li><li class=\"smaller\">31/10/2024 07:30:21 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">05/11/2024 07:53:13 | status alterado para Em progresso por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(108, 'A72', 'Marcelo Worm', 'producao@launer.com.br', 3, '1', 'Instalar computador na veterinária', 'Instalar o computador que está na sala do coordenador de produção no setor na veterinária.<br />\r\nPassar email do compudator para o notebook.', 'Instalar o computador que está na sala do coordenador de produção no setor na veterinária.<br />\r\nPassar email do compudator para o notebook.', '2024-10-30 10:16:43', '2024-11-04 12:30:19', '2024-11-04 12:30:19', '2024-11-04 12:30:19', NULL, '192.168.0.114', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '08:00:04', '1', 1, '0', '0', '', '', '<li class=\"smaller\">30/10/2024 07:16:43 | enviado por Cliente</li><li class=\"smaller\">30/10/2024 07:16:43 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">04/11/2024 09:30:14 | tempo dedicado atualizado para 08:00:00 por TI (Administrador)</li><li class=\"smaller\">04/11/2024 09:30:19 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(110, 'A74', 'Wanderson', 'wandersonfrancisco@launer.com.br', 4, '3', 'Criar e-mail e assinatura para a Fernanda Mallmann', 'Favor dar sequência com os cadastros necessários e alinhar a assinatura e foto do e-mail com o Marketing <br />\r\n<br />\r\nFunção: Analista de Desenvolvimento de Negócios <br />\r\nCelular: 51 99556-4104', 'Favor dar sequência com os cadastros necessários e alinhar a assinatura e foto do e-mail com o Marketing <br />\r\n<br />\r\nFunção: Analista de Desenvolvimento de Negócios <br />\r\nCelular: 51 99556-4104', '2024-10-31 16:17:16', '2024-12-04 11:07:51', '2024-11-05 10:40:27', '2024-12-04 11:07:51', NULL, '192.168.0.106', NULL, 3, 0, 1, 1, 2, 1, 1, -1, '00:01:17', '1', 1, '0', '0', '', '', '<li class=\"smaller\">31/10/2024 13:17:16 | enviado por Cliente</li><li class=\"smaller\">31/10/2024 13:17:16 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">05/11/2024 07:40:27 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">04/12/2024 08:07:51 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(111, 'A75', 'Wanderson', 'wandersonfrancisco@launer.com.br', 4, '3', 'Lentidão Power BI', 'Verificar alternativa para que eu possa trabalhar com o Power BI e não travar, pois no cenário atual está exigindo muito da máquina e eu não estou conseguindo trabalhar no desenvolvimento.', 'Verificar alternativa para que eu possa trabalhar com o Power BI e não travar, pois no cenário atual está exigindo muito da máquina e eu não estou conseguindo trabalhar no desenvolvimento.', '2024-10-31 17:58:43', '2024-11-05 10:42:23', '2024-11-05 10:42:23', '2024-11-05 10:42:23', NULL, '192.168.0.106', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:30:07', '1', 1, '0', '0', '', '', '<li class=\"smaller\">31/10/2024 14:58:43 | enviado por Cliente</li><li class=\"smaller\">31/10/2024 14:58:43 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">05/11/2024 07:42:15 | tempo dedicado atualizado para 00:30:00 por TI (Administrador)</li><li class=\"smaller\">05/11/2024 07:42:23 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(112, 'A76', 'Maiquel', 'pcp2@launer.com.br', 2, '3', 'Impressora expedição', 'não está funcionando', 'não está funcionando', '2024-11-04 10:38:56', '2024-11-04 13:47:01', NULL, '2024-11-04 13:47:01', NULL, '192.168.0.119', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">04/11/2024 07:38:56 | enviado por Cliente</li><li class=\"smaller\">04/11/2024 07:38:56 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">04/11/2024 10:46:57 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(113, 'A77', 'Cássia Taís da Costa Caliari', 'rh2@launer.com.br', 4, '3', 'E-mail para colaborador novo', 'Bom dia,<br />\r\n<br />\r\nFavor criar e-mail para o colaborador que irá iniciar em 18/11:<br />\r\n<br />\r\nMatheus Henrique Lopes de Barros<br />\r\nseguindo a ordem, fica: <a href=\"mailto:assistencia13@launer.com.br\">assistencia13@launer.com.br</a>', 'Bom dia,<br />\r\n<br />\r\nFavor criar e-mail para o colaborador que irá iniciar em 18/11:<br />\r\n<br />\r\nMatheus Henrique Lopes de Barros<br />\r\nseguindo a ordem, fica: <a href=\"mailto:assistencia13@launer.com.br\">assistencia13@launer.com.br</a>', '2024-11-12 12:30:42', '2024-11-12 13:10:24', '2024-11-12 13:10:24', '2024-11-12 13:10:24', NULL, '192.168.0.145', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:54', '1', 1, '0', '0', '', '', '<li class=\"smaller\">12/11/2024 09:30:42 | enviado por Cliente</li><li class=\"smaller\">12/11/2024 09:30:42 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">12/11/2024 10:10:24 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(114, 'A78', 'Marcelo Worm', 'producao@launer.com.br', 2, '3', 'impressora', 'Sincronizar o computador com a impressora.', 'Sincronizar o computador com a impressora.', '2024-11-12 17:27:08', '2024-11-13 10:46:02', NULL, '2024-11-13 10:46:02', NULL, '192.168.0.114', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">12/11/2024 14:27:08 | enviado por Cliente</li><li class=\"smaller\">12/11/2024 14:27:08 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">13/11/2024 07:45:58 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(115, 'A79', 'Marcelo Worm', 'producao@launer.com.br', 2, '3', 'impressora', 'Adicionar impressora.', 'Adicionar impressora.', '2024-11-19 13:47:43', '2024-11-19 13:51:30', '2024-11-19 13:51:30', '2024-11-19 13:51:30', NULL, '192.168.0.114', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:19', '1', 1, '0', '0', '', '', '<li class=\"smaller\">19/11/2024 10:47:43 | enviado por Cliente</li><li class=\"smaller\">19/11/2024 10:47:43 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">19/11/2024 10:51:30 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(116, 'A80', 'jacson wegner', 'manutencao@launer.com.br', 3, '1', 'ORDENS DE SERVIÇO', 'NÃO ESTA GERANDO O ARQUIVO EM EXCEL PARA VISUALIZAR O RELATÓRIO. QUANDO POSSIVEL VENHA ATÉ A MANUTENÇÃO', 'NÃO ESTA GERANDO O ARQUIVO EM EXCEL PARA VISUALIZAR O RELATÓRIO. QUANDO POSSIVEL VENHA ATÉ A MANUTENÇÃO', '2024-11-19 17:37:32', '2025-02-25 12:44:15', '2024-11-21 11:19:28', '2025-02-25 12:44:15', NULL, '192.168.0.171', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:02:24', '1', 1, '0', '0', '', '', '<li class=\"smaller\">19/11/2024 14:37:32 | enviado por Cliente</li><li class=\"smaller\">19/11/2024 14:37:32 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">25/02/2025 09:43:59 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(117, 'A81', 'Adriéli', 'laboratorio01@launer.com.br', 3, '1', 'Formatar computador', 'Necessidade de formatação do computador.', 'Necessidade de formatação do computador.', '2024-11-19 19:39:38', '2024-11-26 12:27:42', '2024-11-21 17:06:30', '2024-11-26 12:27:42', NULL, '192.168.0.158', NULL, 3, 0, 1, 1, 2, 1, 1, -1, '02:00:51', '0', 1, '0', '0', '', '', '<li class=\"smaller\">19/11/2024 16:39:38 | enviado por Cliente</li><li class=\"smaller\">19/11/2024 16:39:38 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/11/2024 09:27:29 | tempo dedicado atualizado para 02:00:51 por TI (Administrador)</li><li class=\"smaller\">26/11/2024 09:27:37 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(118, 'A82', 'Patricia', 'nutricaoanimal@launer.com.br', 2, '3', 'Adicionar impressora', 'Adicionar impressora para note da nutrição', 'Adicionar impressora para note da nutrição', '2024-11-25 13:52:02', '2024-11-26 12:27:10', NULL, '2024-11-26 12:27:10', NULL, '192.168.0.168', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">25/11/2024 10:52:02 | enviado por Cliente</li><li class=\"smaller\">25/11/2024 10:52:02 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/11/2024 09:27:05 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(119, 'A83', 'Marcelo Worm', 'producao@launer.com.br', 4, '3', 'email', 'Instalar assinatura do email.', 'Instalar assinatura do email.', '2024-11-27 17:50:35', '2024-12-16 11:00:38', NULL, '2024-12-16 11:00:38', NULL, '192.168.0.114', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">27/11/2024 14:50:35 | enviado por Cliente</li><li class=\"smaller\">27/11/2024 14:50:35 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/12/2024 08:00:34 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(120, 'A84', 'Diego', 'vendas@launer.com.br', 2, '3', 'impressora sem imprimir', 'impressora sem imprimir', 'impressora sem imprimir', '2024-11-28 11:54:17', '2024-11-28 12:09:09', NULL, '2024-11-28 12:09:09', NULL, '192.168.0.128', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:05:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">28/11/2024 08:54:17 | enviado por Cliente</li><li class=\"smaller\">28/11/2024 08:54:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">28/11/2024 09:09:03 | tempo dedicado atualizado para 00:05:00 por TI (Administrador)</li><li class=\"smaller\">28/11/2024 09:09:05 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(121, 'A85', 'Eduardo Bortoli', 'producao02@launer.com.br', 2, '3', 'Impressora Laboratório', 'Foi trocado a impressora do laboratório, assim não consigo imprimir.', 'Foi trocado a impressora do laboratório, assim não consigo imprimir.', '2024-12-04 11:00:37', '2024-12-17 10:36:31', NULL, '2024-12-17 10:36:31', NULL, '192.168.0.117', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">04/12/2024 08:00:37 | enviado por Cliente</li><li class=\"smaller\">04/12/2024 08:00:37 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/12/2024 07:36:26 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(122, 'A86', 'Marcelo Worm', 'producao@launer.com.br', 3, '1', 'Computador', 'Computador não esta ligando.', 'Computador não esta ligando.', '2024-12-05 17:27:01', '2024-12-16 11:00:22', NULL, '2024-12-16 11:00:22', NULL, '192.168.0.159', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">05/12/2024 14:27:01 | enviado por Cliente</li><li class=\"smaller\">05/12/2024 14:27:01 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">16/12/2024 08:00:17 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(123, 'A87', 'JACSON RODRIGO WEGNER', 'manutencao@launer.com.br', 3, '1', 'Computador', 'Computador acusou erro grave, e desligou! Led LiG/desl piscando. Aparentemente parece ser fonte.', 'Computador acusou erro grave, e desligou! Led LiG/desl piscando. Aparentemente parece ser fonte.', '2024-12-12 11:03:48', '2025-02-03 11:36:48', NULL, '2025-02-03 11:36:48', NULL, '172.16.1.219', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">12/12/2024 08:03:48 | enviado por Cliente</li><li class=\"smaller\">12/12/2024 08:03:48 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/12/2024 07:36:06 | status alterado para Em espera por TI (Administrador)</li><li class=\"smaller\">03/02/2025 08:36:44 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(124, 'A88', 'Vivian', 'laboratorio@launer.com.br', 5, '2', 'Criar link', 'Oi Diogo!!<br />\r\n<br />\r\nPrecisamos que você elabore um questionário de satisfação pós atendimento de SAC que será enviado aos clientes via whatsapp ou e-mail. Favor ver com as meninas do marketing sugestões de frases e formato.<br />\r\nSegue em anexo as perguntas.', 'Oi Diogo!!<br />\r\n<br />\r\nPrecisamos que você elabore um questionário de satisfação pós atendimento de SAC que será enviado aos clientes via whatsapp ou e-mail. Favor ver com as meninas do marketing sugestões de frases e formato.<br />\r\nSegue em anexo as perguntas.', '2024-12-24 12:03:43', '2025-04-23 18:42:24', '2025-03-06 20:13:10', '2025-04-23 18:42:24', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:01', '1', 1, '0', '0', '8#Questionario-de-Acompanhamento-Pos-RNC.docx,', '', '<li class=\"smaller\">24/12/2024 09:03:43 | enviado por Cliente</li><li class=\"smaller\">24/12/2024 09:03:43 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">28/01/2025 10:31:32 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">23/04/2025 15:42:20 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(125, 'A89', 'Manueli', 'comercial@launer.com.br', 3, '1', 'Fios com mal contato', 'Arrumar fios que estão com mau contato na recepção', 'Arrumar fios que estão com mau contato na recepção', '2025-01-09 19:34:25', '2025-02-03 10:52:26', NULL, '2025-02-03 10:52:26', NULL, '192.168.0.122', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">09/01/2025 16:34:25 | enviado por Cliente</li><li class=\"smaller\">09/01/2025 16:34:25 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/02/2025 07:52:21 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(126, 'A90', 'Eduardo Bortoli', 'producao02@launer.com.br', 2, '3', 'Impressora', 'Bom dia, tudo bem?<br />\r\nNão estou conseguindo ainda imprimir nossos trabalhos na impressora do laboratório, não sabemos tb se seria devido a distância do roteador.<br />\r\n<br />\r\nSeria viável caso tiver uma impressora sobrando, colocar aqui para nós na sala da linha agrícola, devido a demandas de impressão para testes e identificação de produtos?]<br />\r\n<br />\r\nObrigado..', 'Bom dia, tudo bem?<br />\r\nNão estou conseguindo ainda imprimir nossos trabalhos na impressora do laboratório, não sabemos tb se seria devido a distância do roteador.<br />\r\n<br />\r\nSeria viável caso tiver uma impressora sobrando, colocar aqui para nós na sala da linha agrícola, devido a demandas de impressão para testes e identificação de produtos?]<br />\r\n<br />\r\nObrigado..', '2025-01-10 10:51:51', '2025-03-06 20:11:43', NULL, '2025-03-06 20:11:43', NULL, '172.16.0.99', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">10/01/2025 07:51:51 | enviado por Cliente</li><li class=\"smaller\">10/01/2025 07:51:51 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">06/03/2025 17:11:38 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(127, 'A91', 'Wanderson', 'wandersonfrancisco@launer.com.br', 2, '3', 'Adicionar Impressora', 'Adicionar a impressora da contabilidade | Custos', 'Adicionar a impressora da contabilidade | Custos', '2025-01-17 17:01:28', '2025-02-03 10:53:20', NULL, '2025-02-03 10:53:20', NULL, '192.168.0.106', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">17/01/2025 14:01:28 | enviado por Cliente</li><li class=\"smaller\">17/01/2025 14:01:28 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/02/2025 07:53:16 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(128, 'A92', 'Manueli', 'comercial@launer.com.br', 2, '3', 'Impressora travando', 'Impressora travando diversasssss vezes', 'Impressora travando diversasssss vezes', '2025-01-20 12:49:20', '2025-02-03 11:02:14', NULL, '2025-02-03 11:02:14', NULL, '192.168.0.122', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">20/01/2025 09:49:20 | enviado por Cliente</li><li class=\"smaller\">20/01/2025 09:49:20 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">03/02/2025 08:02:10 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(129, 'A93', 'Wanderson', 'wandersonfrancisco@launer.com.br', 1, '1', 'E-mails automáticos', 'Não estamos mais recebendo os e-mails automático dos títulos INCLUSÃO DE PRODUTOS e ALTERAÇÃO DE ESTRUTURA ...  O último foi no dia 02/01 as 10:23. Consegues verificar?  aproveita para inserir o e-mail da Sabrina no de INCLUSÂO DE PRODUTOS.', 'Não estamos mais recebendo os e-mails automático dos títulos INCLUSÃO DE PRODUTOS e ALTERAÇÃO DE ESTRUTURA ...  O último foi no dia 02/01 as 10:23. Consegues verificar?  aproveita para inserir o e-mail da Sabrina no de INCLUSÂO DE PRODUTOS.', '2025-01-20 19:13:28', '2025-02-03 11:32:27', '2025-02-03 11:24:01', NULL, NULL, '192.168.0.106', NULL, 1, 0, 1, NULL, 2, 1, 1, -1, '00:00:00', '0', 1, '0', '0', '', '', '<li class=\"smaller\">20/01/2025 16:13:28 | enviado por Cliente</li><li class=\"smaller\">20/01/2025 16:13:28 | atribuído automaticamente a TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(130, 'A94', 'Marcelo Worm', 'producao@launer.com.br', 4, '3', 'Atualização de planilhas', 'Não estou conseguindo atualizar as planilhas do publico.', 'Não estou conseguindo atualizar as planilhas do publico.', '2025-02-13 14:40:50', '2025-02-17 14:58:25', '2025-02-13 16:41:29', '2025-02-17 14:58:25', NULL, '192.168.0.115', NULL, 3, 0, 1, 1, 2, 2, 1, -1, '00:01:25', '1', 1, '0', '0', '', '', '<li class=\"smaller\">13/02/2025 11:40:50 | enviado por Cliente</li><li class=\"smaller\">13/02/2025 11:40:50 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/02/2025 11:58:25 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(131, 'A95', 'jacson', 'manutencao@launer.com.br', 2, '3', 'imppressão', 'Quando vai imprimir, está acusando acesso negado a impressora.', 'Quando vai imprimir, está acusando acesso negado a impressora.', '2025-02-25 12:30:06', '2025-02-26 19:59:06', '2025-02-25 12:41:18', '2025-02-26 19:59:06', NULL, '192.168.0.171', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:07', '1', 1, '0', '0', '', '', '<li class=\"smaller\">25/02/2025 09:30:06 | enviado por Cliente</li><li class=\"smaller\">25/02/2025 09:30:06 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/02/2025 16:59:06 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(132, 'A96', 'Marcelo Worm', 'producao@launer.com.br', 3, '1', 'Chamado - ordens de serviço', 'Instalar o Chamado para ordens de serviço no computador do envase do saneantes.', 'Instalar o Chamado para ordens de serviço no computador do envase do saneantes.', '2025-02-26 16:39:44', '2025-02-26 19:57:55', '2025-02-26 19:57:55', '2025-02-26 19:57:55', NULL, '192.168.0.126', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:05:15', '1', 1, '0', '0', '', '', '<li class=\"smaller\">26/02/2025 13:39:44 | enviado por Cliente</li><li class=\"smaller\">26/02/2025 13:39:44 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/02/2025 16:57:39 | tempo dedicado atualizado para 00:05:00 por TI (Administrador)</li><li class=\"smaller\">26/02/2025 16:57:55 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(133, 'A97', 'Diogo Wermann', 'ti@launer.com.br', 3, '3', 'Instalar No-Break | PC-ENVASE', 'Instalar novo No-Break no PC da ENVASE na produção.<br />\r\nAtualmente tem um Filtro de Linha no lugar.', 'Instalar novo No-Break no PC da ENVASE na produção.<br />\r\nAtualmente tem um Filtro de Linha no lugar.', '2025-02-26 19:45:27', '2025-02-26 19:57:11', '2025-02-26 19:57:11', '2025-02-26 19:57:11', NULL, '192.168.0.123', NULL, 3, 1, 1, 1, 1, 1, 1, -1, '00:11:04', '1', 1, '0', '0', '', '', '<li class=\"smaller\">26/02/2025 16:45:27 | chamado criado por TI (Administrador)</li><li class=\"smaller\">26/02/2025 16:45:27 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">26/02/2025 16:45:27 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">26/02/2025 16:57:11 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(134, 'A98', 'Diogo Wermann', 'ti@launer.com.br', 5, '2', 'Liberar uso de IA para Daniel | CUSTOS/CONTABILIDADE', 'Daniel têm algumas dúvidas e seria melhor para suas pesquisas o auxílio de uma Inteligência Artificial.<br />\r\nConfigurar o email e deixar o acesso no computador CUSTOS.', 'Daniel têm algumas dúvidas e seria melhor para suas pesquisas o auxílio de uma Inteligência Artificial.<br />\r\nConfigurar o email e deixar o acesso no computador CUSTOS.', '2025-02-27 11:26:59', '2025-02-27 12:09:39', '2025-02-27 12:09:39', '2025-02-27 12:09:39', NULL, '192.168.0.123', NULL, 3, 1, 1, 1, 1, 1, 1, -1, '00:20:58', '1', 1, '0', '0', '', '', '<li class=\"smaller\">27/02/2025 08:26:59 | chamado criado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 08:26:59 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">27/02/2025 09:08:40 | tempo dedicado atualizado para 00:20:00 por TI (Administrador)</li><li class=\"smaller\">27/02/2025 09:09:39 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(135, 'A99', 'Diogo Wermann', 'ti@launer.com.br', 4, '1', 'Andressa - Assessoria | Instalar e Ativar o Pacote OFFICE', 'Está com problemas para utilizar produtos da Microsoft365.<br />\r\nInstalar o pacote do Office e logar na conta \'assessoria@launerquim.onmicrosoft.com\'.', 'Está com problemas para utilizar produtos da Microsoft365.<br />\r\nInstalar o pacote do Office e logar na conta \'assessoria@launerquim.onmicrosoft.com\'.', '2025-02-27 18:34:39', '2025-02-27 18:35:24', '2025-02-27 18:35:24', '2025-02-27 18:35:24', NULL, '192.168.0.123', NULL, 3, 1, 1, 1, 1, 1, 1, -1, '00:00:45', '1', 1, '0', '0', '', '', '<li class=\"smaller\">27/02/2025 15:34:39 | chamado criado por TI (Administrador)</li><li class=\"smaller\">27/02/2025 15:34:39 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">27/02/2025 15:35:24 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(136, 'B01', 'Adriéli', 'laboratorio01@launer.com.br', 3, '1', 'Computador não liga', 'O computador não está ligando.', 'O computador não está ligando.', '2025-03-06 19:44:07', '2025-03-06 20:09:30', '2025-03-06 20:09:30', '2025-03-06 20:09:30', NULL, '192.168.0.158', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:10:52', '1', 1, '0', '0', '', '', '<li class=\"smaller\">06/03/2025 16:44:07 | enviado por Cliente</li><li class=\"smaller\">06/03/2025 16:44:07 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">06/03/2025 17:09:25 | tempo dedicado atualizado para 00:10:48 por TI (Administrador)</li><li class=\"smaller\">06/03/2025 17:09:30 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(137, 'B02', 'Tanize', 'laboratorio04@launer.com.br', 3, '1', 'Skype', 'Bom dia, <br />\r\n <br />\r\nMeu Skype esta solicitando para fazer Download, teria como verificar para mim.<br />\r\n<br />\r\nObrigado.', 'Bom dia, <br />\r\n <br />\r\nMeu Skype esta solicitando para fazer Download, teria como verificar para mim.<br />\r\n<br />\r\nObrigado.', '2025-03-11 11:19:01', '2025-03-11 16:42:36', NULL, '2025-03-11 16:42:36', '4', '192.168.0.116', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">11/03/2025 08:19:01 | enviado por Cliente</li><li class=\"smaller\">11/03/2025 08:19:01 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">11/03/2025 13:42:31 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL);
INSERT INTO `hesk_tickets` (`id`, `trackid`, `name`, `email`, `category`, `priority`, `subject`, `message`, `message_html`, `dt`, `lastchange`, `firstreply`, `closedat`, `articles`, `ip`, `language`, `status`, `openedby`, `firstreplyby`, `closedby`, `replies`, `staffreplies`, `owner`, `assignedby`, `time_worked`, `lastreplier`, `replierid`, `archive`, `locked`, `attachments`, `merged`, `history`, `custom1`, `custom2`, `custom3`, `custom4`, `custom5`, `custom6`, `custom7`, `custom8`, `custom9`, `custom10`, `custom11`, `custom12`, `custom13`, `custom14`, `custom15`, `custom16`, `custom17`, `custom18`, `custom19`, `custom20`, `custom21`, `custom22`, `custom23`, `custom24`, `custom25`, `custom26`, `custom27`, `custom28`, `custom29`, `custom30`, `custom31`, `custom32`, `custom33`, `custom34`, `custom35`, `custom36`, `custom37`, `custom38`, `custom39`, `custom40`, `custom41`, `custom42`, `custom43`, `custom44`, `custom45`, `custom46`, `custom47`, `custom48`, `custom49`, `custom50`, `due_date`, `overdue_email_sent`, `satisfaction_email_sent`, `satisfaction_email_dt`) VALUES
(138, 'B03', 'Jeferson', 'almoxarifado@launer.com.br', 5, '3', 'Colocar Rede Cabeada', 'Conectar cabo ethernet no computador e no switch para Almoxarifado.<br />\r\nAtualmente está utilizando um adaptador Wi-fi.', 'Conectar cabo ethernet no computador e no switch para Almoxarifado.<br />\r\nAtualmente está utilizando um adaptador Wi-fi.', '2025-03-11 17:25:35', '2025-03-11 17:53:31', '2025-03-11 17:53:31', '2025-03-11 17:53:31', NULL, '192.168.0.117', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '00:10:06', '1', 1, '0', '0', '', '', '<li class=\"smaller\">11/03/2025 14:25:35 | chamado criado por TI (Administrador)</li><li class=\"smaller\">11/03/2025 14:25:35 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">11/03/2025 14:53:23 | tempo dedicado atualizado para 00:10:00 por TI (Administrador)</li><li class=\"smaller\">11/03/2025 14:53:31 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(139, 'B04', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 6, '3', 'teste', 'oi', 'oi', '2025-03-12 11:10:57', '2025-03-13 12:43:56', NULL, '2025-03-13 12:43:56', '4', '192.168.0.113', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">12/03/2025 08:10:57 | enviado por Cliente</li><li class=\"smaller\">12/03/2025 08:10:57 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">13/03/2025 09:43:56 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(140, 'B05', 'Cláudia Schlabitz', 'ped02@launer.com.br', 4, '3', 'Atualização/Configuração do Skype', 'Meu skype não está funcionando. Dizia que precisava atualizar, cliquei, mas nãonsigo ir adiante.', 'Meu skype não está funcionando. Dizia que precisava atualizar, cliquei, mas nãonsigo ir adiante.', '2025-03-12 11:51:46', '2025-03-13 12:43:42', NULL, '2025-03-13 12:43:42', '4', '192.168.0.174', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:05:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">12/03/2025 08:51:46 | enviado por Cliente</li><li class=\"smaller\">12/03/2025 08:51:46 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">13/03/2025 09:43:35 | tempo dedicado atualizado para 00:05:00 por TI (Administrador)</li><li class=\"smaller\">13/03/2025 09:43:37 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(141, 'B06', 'Vivian Versteg', 'laboratorio@launer.com.br', 3, '2', 'Monitor Não Funcionando | Laboratorio02', 'Tela piscando e dando estática. Computador desligando e ligando sozinho.', 'Tela piscando e dando estática. Computador desligando e ligando sozinho.', '2025-03-14 14:34:16', '2025-03-14 15:00:22', '2025-03-14 14:49:37', '2025-03-14 14:49:45', NULL, '192.168.0.117', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '00:15:19', '1', 1, '0', '0', '9#Imagem-do-WhatsApp-de-2025-03-14-as-10.54.17_b91394e1.jpg,', '', '<li class=\"smaller\">14/03/2025 11:34:16 | chamado criado por TI (Administrador)</li><li class=\"smaller\">14/03/2025 11:34:16 | fechado por TI (Administrador)</li><li class=\"smaller\">14/03/2025 11:34:16 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">14/03/2025 11:45:14 | tempo dedicado atualizado para 00:15:00 por TI (Administrador)</li><li class=\"smaller\">14/03/2025 11:49:09 | tempo dedicado atualizado para 00:08:00 por TI (Administrador)</li><li class=\"smaller\">14/03/2025 11:49:17 | tempo dedicado atualizado para 00:15:00 por TI (Administrador)</li><li class=\"smaller\">14/03/2025 11:49:41 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(142, 'B07', 'Eduardo Bortoli', 'producao02@launer.com.br', 4, '3', 'Pacote office', 'Bom dia.. <br />\r\nNot começou a dar aviso do pacote oficce..', 'Bom dia.. <br />\r\nNot começou a dar aviso do pacote oficce..', '2025-03-17 10:51:20', '2025-05-20 17:48:25', '2025-03-17 11:04:34', '2025-05-20 17:48:25', NULL, '192.168.0.104', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:03:03', '1', 1, '0', '0', '', '', '<li class=\"smaller\">17/03/2025 07:51:20 | enviado por Cliente</li><li class=\"smaller\">17/03/2025 07:51:20 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">17/03/2025 08:04:30 | tempo dedicado atualizado para 00:03:00 por TI (Administrador)</li><li class=\"smaller\">17/03/2025 08:04:34 | status alterado para Em Análise por TI (Administrador)</li><li class=\"smaller\">20/05/2025 14:48:21 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(143, 'B08', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 4, '3', 'E-mail para Gestão Comercial Agro', 'E-mail para Renan Parmejiani -  Gestão Comercial Agro:<br />\r\n<a href=\"mailto:renanparmejiani@launer.com.br\">renanparmejiani@launer.com.br</a>', 'E-mail para Renan Parmejiani -  Gestão Comercial Agro:<br />\r\n<a href=\"mailto:renanparmejiani@launer.com.br\">renanparmejiani@launer.com.br</a>', '2025-03-18 12:56:21', '2025-03-18 18:50:13', '2025-03-18 18:50:13', '2025-03-18 18:50:13', NULL, '192.168.0.107', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:03:27', '1', 1, '0', '0', '', '', '<li class=\"smaller\">18/03/2025 09:56:21 | enviado por Cliente</li><li class=\"smaller\">18/03/2025 09:56:21 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">18/03/2025 15:50:13 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(144, 'B09', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 6, '3', 'Celular: Aparelho e chip', 'Celular: Aparelho e chip para Renan Parmejiani', 'Celular: Aparelho e chip para Renan Parmejiani', '2025-03-18 12:57:25', '2025-04-03 10:41:09', NULL, '2025-04-03 10:41:09', NULL, '192.168.0.107', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">18/03/2025 09:57:25 | enviado por Cliente</li><li class=\"smaller\">18/03/2025 09:57:25 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">18/03/2025 15:51:28 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">03/04/2025 07:41:04 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(145, 'B10', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 4, '3', 'E-mail para P&amp;D Biotecnologia', 'E-mail para Rovian que fará Consultoria Técnica na biotecnologia:<br />\r\n<a href=\"mailto:roviangirelli@launer.com.br\">roviangirelli@launer.com.br</a>', 'E-mail para Rovian que fará Consultoria Técnica na biotecnologia:<br />\r\n<a href=\"mailto:roviangirelli@launer.com.br\">roviangirelli@launer.com.br</a>', '2025-03-20 13:04:14', '2025-03-20 13:48:42', '2025-03-20 13:48:42', '2025-03-20 13:48:42', NULL, '192.168.0.107', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:01:18', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/03/2025 10:04:14 | enviado por Cliente</li><li class=\"smaller\">20/03/2025 10:04:14 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/03/2025 10:48:42 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(146, 'B11', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 3, '1', 'Notebook para Rovian', 'Notebook para Rovian que fará Consultoria Técnica na Biotecnologia para uso interno', 'Notebook para Rovian que fará Consultoria Técnica na Biotecnologia para uso interno', '2025-03-20 13:05:38', '2025-03-21 10:58:43', '2025-03-21 10:58:43', '2025-03-21 10:58:43', NULL, '192.168.0.107', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '04:10:00', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/03/2025 10:05:38 | enviado por Cliente</li><li class=\"smaller\">20/03/2025 10:05:38 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/03/2025 14:18:39 | tempo dedicado atualizado para 03:00:00 por TI (Administrador)</li><li class=\"smaller\">20/03/2025 14:18:50 | status alterado para Em progresso por TI (Administrador)</li><li class=\"smaller\">20/03/2025 16:23:02 | tempo dedicado atualizado para 03:10:00 por TI (Administrador)</li><li class=\"smaller\">20/03/2025 17:22:21 | tempo dedicado atualizado para 03:10:00 por TI (Administrador)</li><li class=\"smaller\">20/03/2025 17:22:31 | tempo dedicado atualizado para 04:10:00 por TI (Administrador)</li><li class=\"smaller\">21/03/2025 07:58:43 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(147, 'B12', 'Wanderson', 'wandersonfrancisco@launer.com.br', 2, '3', 'Trocar o toner da impressora', 'Trocar toner da impressora...', 'Trocar toner da impressora...', '2025-03-24 15:56:20', '2025-04-02 10:41:18', NULL, '2025-04-02 10:41:18', NULL, '192.168.0.142', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">24/03/2025 12:56:20 | enviado por Cliente</li><li class=\"smaller\">24/03/2025 12:56:20 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">02/04/2025 07:41:13 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(148, 'B13', 'Cássia Caliari', 'rh2@launer.com.br', 4, '3', 'Configurar Computador, E-mail e WhatsApp', 'Bom dia,<br />\r\n<br />\r\nNa próxima terça-feira (01/04) iniciará a Deise no comercial interno. Ela vai precisar de computador, E-mail e WhatsApp. Ela vai utilizar E-mail e WhatsApp que eram da Tainara:<br />\r\n<br />\r\n<a href=\"mailto:comercial02@launer.com.br\">comercial02@launer.com.br</a>  / 51 99857-8095', 'Bom dia,<br />\r\n<br />\r\nNa próxima terça-feira (01/04) iniciará a Deise no comercial interno. Ela vai precisar de computador, E-mail e WhatsApp. Ela vai utilizar E-mail e WhatsApp que eram da Tainara:<br />\r\n<br />\r\n<a href=\"mailto:comercial02@launer.com.br\">comercial02@launer.com.br</a>  / 51 99857-8095', '2025-03-28 12:58:17', '2025-03-28 14:49:02', '2025-03-28 14:49:02', '2025-03-28 14:49:02', NULL, '192.168.0.165', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '01:18:58', '1', 1, '0', '0', '', '', '<li class=\"smaller\">28/03/2025 09:58:17 | enviado por Cliente</li><li class=\"smaller\">28/03/2025 09:58:17 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">28/03/2025 11:49:02 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(149, 'B14', 'Tanize', 'laboratorio04@launer.com.br', 3, '1', 'Mouse e Nobreak', 'BOA TARDE, <br />\r\n<br />\r\nGOSTARIA DE SOLICITAR UM MOUSE NOVO PARA O MEU PC, POIS O MESMO ENCONTRA-SE FALHANDO.<br />\r\n<br />\r\nGOSTARIA TAMBÉM DE UM NOBREAK PARA O PC DO LABORATÓRIO.<br />\r\n<br />\r\nOBRIGADO.', 'BOA TARDE, <br />\r\n<br />\r\nGOSTARIA DE SOLICITAR UM MOUSE NOVO PARA O MEU PC, POIS O MESMO ENCONTRA-SE FALHANDO.<br />\r\n<br />\r\nGOSTARIA TAMBÉM DE UM NOBREAK PARA O PC DO LABORATÓRIO.<br />\r\n<br />\r\nOBRIGADO.', '2025-03-31 18:07:22', '2025-04-02 10:40:43', '2025-04-02 10:40:43', '2025-04-02 10:40:43', '4,3', '192.168.0.116', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:15:41', '1', 1, '0', '0', '', '', '<li class=\"smaller\">31/03/2025 15:07:22 | enviado por Cliente</li><li class=\"smaller\">31/03/2025 15:07:22 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">02/04/2025 07:34:30 | tempo dedicado atualizado para 00:15:00 por TI (Administrador)</li><li class=\"smaller\">02/04/2025 07:40:43 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(150, 'B15', 'jacson', 'manutencao@launer.com.br', 5, '2', 'Ordens de serviço', 'Algumas pessoas vieram a relatar problemas no envio de ordem de serviço.', 'Algumas pessoas vieram a relatar problemas no envio de ordem de serviço.', '2025-04-01 14:21:44', '2025-04-08 19:38:42', '2025-04-08 19:38:42', '2025-04-08 19:38:42', NULL, '192.168.0.171', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:00', '1', 1, '0', '0', '10#Sem-titulo.png,', '', '<li class=\"smaller\">01/04/2025 11:21:44 | enviado por Cliente</li><li class=\"smaller\">01/04/2025 11:21:44 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">08/04/2025 16:38:42 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(160, 'B25', 'Diego Krilow', 'vendas@launer.com.br', 2, '3', 'Impressora não imprimindo', 'Ao enviar arquivo para impressão, a impressora acusa \'\'estado de erro\'\'. Para imprimir é necessário reiniciar uma ou mais vezes a impressora.', 'Ao enviar arquivo para impressão, a impressora acusa \'\'estado de erro\'\'. Para imprimir é necessário reiniciar uma ou mais vezes a impressora.', '2025-05-08 11:07:22', '2025-05-08 16:34:47', '2025-05-08 16:34:47', '2025-05-08 16:34:47', '4', '192.168.0.133', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:47', '1', 1, '0', '0', '', '', '<li class=\"smaller\">08/05/2025 08:07:22 | enviado por Cliente</li><li class=\"smaller\">08/05/2025 08:07:22 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">08/05/2025 13:34:47 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(158, 'B23', 'Deise', 'comercial02@launer.com.br', 3, '1', 'guardião', 'Bom dia, não tenho acesso ao guardiao.', 'Bom dia, não tenho acesso ao guardiao.', '2025-04-29 12:50:12', '2025-04-29 17:57:38', '2025-04-29 17:57:38', '2025-04-29 17:57:38', NULL, '192.168.0.164', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:11:29', '1', 1, '0', '0', '', '', '<li class=\"smaller\">29/04/2025 09:50:12 | enviado por Cliente</li><li class=\"smaller\">29/04/2025 09:50:12 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">29/04/2025 14:57:38 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(154, 'B19', 'Wanderson', 'wandersonfrancisco@launer.com.br', 4, '3', 'Gateway Offline no Power BI', 'Favor verificar o Gateway, pois o mesmo se encontra offline e acabou não atualizando os BI na Web...', 'Favor verificar o Gateway, pois o mesmo se encontra offline e acabou não atualizando os BI na Web...', '2025-04-23 10:08:50', '2025-04-23 10:49:01', '2025-04-23 10:49:01', '2025-04-23 10:49:01', '4', '192.168.0.115', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:06:17', '1', 1, '0', '0', '11#Erro-Gateway.docx,', '', '<li class=\"smaller\">23/04/2025 07:08:49 | enviado por Cliente</li><li class=\"smaller\">23/04/2025 07:08:50 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">23/04/2025 07:49:01 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(155, 'B20', 'M180 MARKETING', 'marketing@launer.com.br', 2, '3', 'Não consigo imprimir meu documento', 'Documentos enviados à impressora não estão sendo imprimidos e somente ficam na fila.', 'Documentos enviados à impressora não estão sendo imprimidos e somente ficam na fila.', '2025-04-28 11:25:36', '2025-04-28 11:30:59', '2025-04-28 11:27:09', '2025-04-28 11:30:59', NULL, '192.168.0.120', NULL, 3, 1, 1, 1, 5, 3, 1, 1, '00:04:00', '1', 1, '0', '0', '', '', '<li class=\"smaller\">28/04/2025 08:25:36 | chamado criado por TI (Administrador)</li><li class=\"smaller\">28/04/2025 08:25:36 | fechado por TI (Administrador)</li><li class=\"smaller\">28/04/2025 08:25:36 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">28/04/2025 08:28:28 | status alterado para Aguardando resposta por TI (Administrador)</li><li class=\"smaller\">28/04/2025 08:29:18 | status alterado para Resolvido por TI (Administrador)</li><li class=\"smaller\">28/04/2025 08:30:04 | status alterado para Aguardando resposta por TI (Administrador)</li><li class=\"smaller\">28/04/2025 08:30:59 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(153, 'B18', 'Wanderson', 'wandersonfrancisco@launer.com.br', 4, '3', 'Atualização Gateway | Power BI Web', 'Boa tarde!<br />\r\n<br />\r\nOs BI da Launer não estão atualizando desde o dia 01/04 de manhã e acredito que seja pela conexão do gateway. <br />\r\n<br />\r\nAbaixo um dos erros:<br />\r\n<br />\r\nErro de fonte de dados:	{&quot;error&quot;:{&quot;code&quot;:&quot;DM_GWPipeline_Gateway_SpooledOperationMissing&quot;,&quot;pbi.error&quot;:{&quot;code&quot;:&quot;DM_GWPipeline_Gateway_SpooledOperationMissing&quot;,&quot;parameters&quot;:{},&quot;details&quot;:[],&quot;exceptionCulprit&quot;:1}}} Table: dVendedores.', 'Boa tarde!<br />\r\n<br />\r\nOs BI da Launer não estão atualizando desde o dia 01/04 de manhã e acredito que seja pela conexão do gateway. <br />\r\n<br />\r\nAbaixo um dos erros:<br />\r\n<br />\r\nErro de fonte de dados:	{&quot;error&quot;:{&quot;code&quot;:&quot;DM_GWPipeline_Gateway_SpooledOperationMissing&quot;,&quot;pbi.error&quot;:{&quot;code&quot;:&quot;DM_GWPipeline_Gateway_SpooledOperationMissing&quot;,&quot;parameters&quot;:{},&quot;details&quot;:[],&quot;exceptionCulprit&quot;:1}}} Table: dVendedores.', '2025-04-07 19:37:23', '2025-04-10 10:35:56', '2025-04-10 10:35:56', '2025-04-10 10:35:56', '2,4', '192.168.0.142', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '01:00:36', '1', 1, '0', '0', '', '', '<li class=\"smaller\">07/04/2025 16:37:23 | enviado por Cliente</li><li class=\"smaller\">07/04/2025 16:37:23 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">10/04/2025 07:35:20 | tempo dedicado atualizado para 01:00:00 por TI (Administrador)</li><li class=\"smaller\">10/04/2025 07:35:56 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(159, 'B24', 'Eduardo Bortoli', 'producao02@launer.com.br', 4, '3', 'Pacote office', 'Atualização', 'Atualização', '2025-04-29 18:24:22', '2025-05-20 17:48:49', '2025-04-29 19:06:11', '2025-05-20 17:48:49', '4', '192.168.0.102', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:00:58', '1', 1, '0', '0', '', '', '<li class=\"smaller\">29/04/2025 15:24:22 | enviado por Cliente</li><li class=\"smaller\">29/04/2025 15:24:22 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">20/05/2025 14:48:44 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(161, 'B26', 'Priscila', 'launer@launer.com.br', 4, '3', 'Teams', 'Meu Teams não funciona.', 'Meu Teams não funciona.', '2025-05-14 10:38:07', '2025-05-20 17:53:12', NULL, '2025-05-20 17:53:12', NULL, '192.168.0.163', NULL, 3, 0, NULL, 1, 0, 0, 1, -1, '00:10:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">14/05/2025 07:38:07 | enviado por Cliente</li><li class=\"smaller\">14/05/2025 07:38:07 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">14/05/2025 08:10:11 | tempo dedicado atualizado para 00:10:00 por TI (Administrador)</li><li class=\"smaller\">20/05/2025 14:53:07 | fechado por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(162, 'B27', 'Cláudia Schlabitz', 'ped02@launer.com.br', 3, '1', 'Suporte para notebook e teclado para funcionária Deise', 'Verificado em vistoria da CIPA que a o notebook da funcionária Deise está muito baixo para que ela se sente ergonomicamente. Solicitamos que seja fornecido um suporte e um teclado para ela.', 'Verificado em vistoria da CIPA que a o notebook da funcionária Deise está muito baixo para que ela se sente ergonomicamente. Solicitamos que seja fornecido um suporte e um teclado para ela.', '2025-05-16 16:06:26', '2025-05-26 19:24:40', '2025-05-26 19:24:40', '2025-05-26 19:24:40', '4', '192.168.0.130', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '00:05:03', '1', 1, '0', '0', '', '', '<li class=\"smaller\">16/05/2025 13:06:26 | enviado por Cliente</li><li class=\"smaller\">16/05/2025 13:06:26 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">22/05/2025 13:37:31 | status alterado para Em progresso por TI (administrador)</li><li class=\"smaller\">26/05/2025 16:24:37 | tempo dedicado atualizado para 00:05:00 por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 16:24:40 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(163, 'B28', 'Cláudia Schlabitz', 'ped02@launer.com.br', 3, '1', 'Suporte para notebook e teclado para Andressa', 'Verificado em vistoria da CIPA que a o notebook da funcionária Andressa está muito baixo para que ela se sente ergonomicamente. Solicitamos que seja fornecido um suporte e um teclado para ela.', 'Verificado em vistoria da CIPA que a o notebook da funcionária Andressa está muito baixo para que ela se sente ergonomicamente. Solicitamos que seja fornecido um suporte e um teclado para ela.', '2025-05-16 16:07:21', '2025-05-22 16:38:08', NULL, NULL, '4', '192.168.0.130', NULL, 4, 0, NULL, NULL, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">16/05/2025 13:07:21 | enviado por Cliente</li><li class=\"smaller\">16/05/2025 13:07:21 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">22/05/2025 13:38:08 | status alterado para Em progresso por TI (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(164, 'B29', 'Cláudia Schlabitz', 'ped02@launer.com.br', 3, '1', 'Ajustes do monitor da funcionária Diose', 'Verificado em vistoria da CIPA que a o monitor da funcionária Diose não está em altura e posição adequada. Solicitamos que sejam feitos ajustes nos cabos para possibilitar que ela sente em posição ergonômica.', 'Verificado em vistoria da CIPA que a o monitor da funcionária Diose não está em altura e posição adequada. Solicitamos que sejam feitos ajustes nos cabos para possibilitar que ela sente em posição ergonômica.', '2025-05-16 16:08:57', '2025-05-22 16:38:01', NULL, NULL, '4', '192.168.0.130', NULL, 6, 0, NULL, NULL, 0, 0, 1, -1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">16/05/2025 13:08:57 | enviado por Cliente</li><li class=\"smaller\">16/05/2025 13:08:57 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">22/05/2025 13:38:01 | status alterado para Em Análise por TI (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(165, 'B30', 'Jeferson Tag', 'producao@launer.com.br', 3, '3', 'Computador entrando na BIOS sozinho.', 'O computador da Veterinária está entrando na bios &quot;sozinho&quot;', 'O computador da Veterinária está entrando na bios &quot;sozinho&quot;', '2025-05-20 13:15:25', '2025-05-20 13:37:07', '2025-05-20 13:37:07', '2025-05-20 13:37:07', NULL, '172.16.0.33', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '00:15:52', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/05/2025 10:15:25 | chamado criado por TI (Administrador)</li><li class=\"smaller\">20/05/2025 10:15:25 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">20/05/2025 10:29:59 | tempo dedicado atualizado para 00:14:00 por TI (Administrador)</li><li class=\"smaller\">20/05/2025 10:37:07 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(166, 'B31', 'Grégory Dornelles', 'rotulagem@launer.com.br', 3, '1', 'Corel', 'Corel não tá abrindo.', 'Corel não tá abrindo.', '2025-05-20 18:26:34', '2025-05-21 11:25:46', '2025-05-21 11:25:46', '2025-05-21 11:25:46', NULL, '192.168.0.121', NULL, 3, 0, 1, 1, 1, 1, 1, -1, '01:02:09', '1', 1, '0', '0', '', '', '<li class=\"smaller\">20/05/2025 15:26:34 | enviado por Cliente</li><li class=\"smaller\">20/05/2025 15:26:34 | atribuído automaticamente a TI (Administrador)</li><li class=\"smaller\">21/05/2025 08:19:07 | tempo dedicado atualizado para 01:00:00 por TI (Administrador)</li><li class=\"smaller\">21/05/2025 08:25:46 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(167, 'B32', 'Marisa', 'financeiro@launer.com.br', 3, '2', 'Computador com lentidão', 'O computador se encontra demasiadamente lento e não está imprimindo documentos mesmo após atualizações, desligar e religar impressora e reinicialização.', 'O computador se encontra demasiadamente lento e não está imprimindo documentos mesmo após atualizações, desligar e religar impressora e reinicialização.', '2025-05-21 18:54:39', '2025-05-21 19:09:35', '2025-05-21 19:09:35', '2025-05-21 19:09:35', NULL, '192.168.0.120', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '00:12:59', '1', 1, '0', '0', '', '', '<li class=\"smaller\">21/05/2025 15:54:39 | chamado criado por TI (Administrador)</li><li class=\"smaller\">21/05/2025 15:54:39 | atribuído a TI (Administrador) por TI (Administrador)</li><li class=\"smaller\">21/05/2025 16:09:35 | status alterado para Resolvido por TI (Administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(169, 'B34', 'Cláudia Schlabitz', 'ped02@launer.com.br', 3, '1', 'reativar Microsoft Office', 'Favor reativar o M. Office. Não consigo mais editar arquivos', 'Favor reativar o M. Office. Não consigo mais editar arquivos', '2025-05-23 17:41:31', '2025-05-26 11:40:54', '2025-05-26 11:40:54', '2025-05-26 11:40:54', NULL, '192.168.0.130', NULL, 3, 0, 1, 1, 1, 1, 1, 1, '00:05:40', '1', 1, '0', '0', '', '', '<li class=\"smaller\">23/05/2025 14:41:31 | enviado por Cliente</li><li class=\"smaller\">26/05/2025 08:35:13 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 08:40:54 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(170, 'B35', 'Diogo Wermann', 'ti@launer.com.br', 5, '3', 'Instalar Agente nos Endpoints', 'Necessário instalar o Agente | Bitdefender nos seguintes endpoints:<br />\r\nTI; <br />\r\nComercial02; <br />\r\nGerente; <br />\r\nCoordenador; <br />\r\nVendas; <br />\r\nP&amp;D; <br />\r\nRH; <br />\r\nAssessoria; <br />\r\nManutenção; <br />\r\nRecepção; <br />\r\nCustos; <br />\r\nAgrícola; <br />\r\nFaturamento; <br />\r\nSupervisor;<br />\r\n<br />\r\nEm seguida, organizar a atribuição de políticas e grupos dentro do gereciamento do Bitdefender.', 'Necessário instalar o Agente | Bitdefender nos seguintes endpoints:<br />\r\nTI; <br />\r\nComercial02; <br />\r\nGerente; <br />\r\nCoordenador; <br />\r\nVendas; <br />\r\nP&amp;D; <br />\r\nRH; <br />\r\nAssessoria; <br />\r\nManutenção; <br />\r\nRecepção; <br />\r\nCustos; <br />\r\nAgrícola; <br />\r\nFaturamento; <br />\r\nSupervisor;<br />\r\n<br />\r\nEm seguida, organizar a atribuição de políticas e grupos dentro do gereciamento do Bitdefender.', '2025-05-26 11:00:39', '2025-05-26 11:18:39', '2025-05-26 11:18:39', '2025-05-26 11:18:39', NULL, '192.168.0.118', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '00:30:12', '1', 1, '0', '0', '', '', '<li class=\"smaller\">26/05/2025 08:00:39 | chamado criado por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 08:18:18 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 08:18:26 | tempo dedicado atualizado para 00:30:00 por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 08:18:39 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(171, 'B36', 'Jacson', 'manutencao@launer.com.br', 3, '3', 'Formatar computador da Manutenção', 'O computador se encontra bem lento e travando em algumas ocasiões, ele também está a muito tempo sem uma formatação adequada.', 'O computador se encontra bem lento e travando em algumas ocasiões, ele também está a muito tempo sem uma formatação adequada.', '2025-05-26 12:05:05', '2025-05-26 19:17:39', '2025-05-26 19:17:39', '2025-05-26 19:17:39', NULL, '192.168.0.118', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '03:38:19', '1', 1, '0', '0', '', '', '<li class=\"smaller\">26/05/2025 09:05:05 | chamado criado por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 09:05:05 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 11:31:33 | tempo dedicado atualizado para 00:35:00 por Diogo (administrador)</li><li class=\"smaller\">26/05/2025 16:17:39 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(172, 'B37', 'Franciele', 'marketing@launer.com.br', 2, '2', 'Relatar Problemas Contínuos com a Impressora 180', 'A impressora colorida do setor de Marketing está apresentando muitos problemas seguidos, use este chamado para relatar os problemas em que são necessários a ajuda da TI.', 'A impressora colorida do setor de Marketing está apresentando muitos problemas seguidos, use este chamado para relatar os problemas em que são necessários a ajuda da TI.', '2025-05-27 10:53:56', '2025-05-27 10:53:56', NULL, NULL, NULL, '192.168.0.118', NULL, 4, 1, NULL, NULL, 0, 0, 1, 1, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">27/05/2025 07:53:56 | chamado criado por Diogo (administrador)</li><li class=\"smaller\">27/05/2025 07:53:56 | status alterado para Em progresso por Diogo (administrador)</li><li class=\"smaller\">27/05/2025 07:53:56 | atribuído a Diogo (administrador) por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(173, 'B38', 'DANIEL HORST', 'custos@launer.com.br', 5, '2', 'PIA-PRODUTO 2024 (IBGE)', 'PRECISO QUE SEJA BAIXADO O PROGRAMA DO IBGE (PIA-PRODUTO 2024), NO MEU COMPUTADOR, PARA QUE POSSAMOS ATENDER A OBRIGATORIEDADE DO PREENCHIMENTO DO QUESTIONÁRIO ANUAL, NO QUAL INFORMAMOS DADOS INERENTES À ITENS MANUFATURADOS DA EMPRESA LAUNER QUÍMICA LTDA.', 'PRECISO QUE SEJA BAIXADO O PROGRAMA DO IBGE (PIA-PRODUTO 2024), NO MEU COMPUTADOR, PARA QUE POSSAMOS ATENDER A OBRIGATORIEDADE DO PREENCHIMENTO DO QUESTIONÁRIO ANUAL, NO QUAL INFORMAMOS DADOS INERENTES À ITENS MANUFATURADOS DA EMPRESA LAUNER QUÍMICA LTDA.', '2025-05-27 19:49:00', '2025-05-27 20:16:30', NULL, '2025-05-27 20:16:30', NULL, '192.168.0.118', NULL, 3, 0, NULL, 1, 0, 0, 1, 1, '00:10:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">27/05/2025 16:49:00 | enviado por Cliente</li><li class=\"smaller\">27/05/2025 17:16:15 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">27/05/2025 17:16:22 | tempo dedicado atualizado para 00:10:00 por Diogo (administrador)</li><li class=\"smaller\">27/05/2025 17:16:23 | fechado por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(174, 'B39', 'Diego Krilow', 'vendas@launer.com.br', 3, '3', 'Demora para baixar arquivos', 'Arquivos no formato pdf estão levando um tempo acima do normal para baixar', 'Arquivos no formato pdf estão levando um tempo acima do normal para baixar', '2025-05-28 16:27:21', '2025-05-30 10:55:21', '2025-05-29 18:10:02', '2025-05-30 10:55:21', NULL, '192.168.0.133', NULL, 3, 0, 1, 1, 2, 2, 1, NULL, '00:02:48', '1', 1, '0', '0', '', '', '<li class=\"smaller\">28/05/2025 13:27:21 | enviado por Cliente</li><li class=\"smaller\">29/05/2025 15:10:02 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">29/05/2025 15:10:02 | prioridade alterada para Baixa por Diogo (administrador)</li><li class=\"smaller\">30/05/2025 07:55:21 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(175, 'B40', 'Marisa', 'financeiro@launer.com.br', 3, '3', 'Formatar computador do Financeiro', 'O computador do Financeiro continua com problemas e se desligando sozinho, formatar ele seria uma forma de melhora-lo eficientemente.', 'O computador do Financeiro continua com problemas e se desligando sozinho, formatar ele seria uma forma de melhora-lo eficientemente.', '2025-05-28 16:43:19', '2025-06-03 19:58:11', '2025-06-03 19:58:11', '2025-06-03 19:58:11', NULL, '192.168.0.118', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '02:24:36', '1', 1, '0', '0', '', '', '<li class=\"smaller\">28/05/2025 13:43:19 | chamado criado por Diogo (administrador)</li><li class=\"smaller\">28/05/2025 13:43:19 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">28/05/2025 13:48:59 | tempo dedicado atualizado para 00:20:00 por Diogo (administrador)</li><li class=\"smaller\">28/05/2025 16:13:34 | tempo dedicado atualizado para 02:20:00 por Diogo (administrador)</li><li class=\"smaller\">30/05/2025 07:55:45 | status alterado para Em progresso por Diogo (administrador)</li><li class=\"smaller\">03/06/2025 16:58:11 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(176, 'B41', 'deise', 'comercial02@launer.com.br', 1, '3', 'problema no sistema', 'Olá, preciso que verifiquem um problema na hora da impressão de um documento após a atualização pv feita no sistema de pedidos.', 'Olá, preciso que verifiquem um problema na hora da impressão de um documento após a atualização pv feita no sistema de pedidos.', '2025-05-29 14:11:11', '2025-06-09 11:34:53', '2025-05-30 10:39:53', '2025-06-09 11:34:53', NULL, '192.168.0.118', NULL, 3, 0, 1, 1, 3, 2, 1, NULL, '00:04:09', '1', 1, '0', '0', '', '', '<li class=\"smaller\">29/05/2025 11:11:11 | enviado por Cliente</li><li class=\"smaller\">30/05/2025 07:39:53 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">30/05/2025 07:39:53 | prioridade alterada para Baixa por Diogo (administrador)</li><li class=\"smaller\">03/06/2025 16:57:11 | data de vencimento atualizada para 2025-06-06 em Diogo (administrador)</li><li class=\"smaller\">09/06/2025 08:34:53 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2025-06-06 03:00:00', 0, 0, NULL),
(177, 'B42', 'Franciele', 'marketing@launer.com.br', 4, '3', 'Mover Arquivos do Marketing de Dentro do Servidor Para o OneDrive', 'O OneDrive tem mais espaço e consegue armazenar muito mais do que o tanto disponível dentro do servidor.', 'O OneDrive tem mais espaço e consegue armazenar muito mais do que o tanto disponível dentro do servidor.', '2025-05-30 10:45:02', '2025-05-30 10:49:00', '2025-05-30 10:49:00', '2025-05-30 10:49:00', NULL, '192.168.0.118', NULL, 3, 1, 1, 1, 1, 1, 1, 1, '08:01:05', '1', 1, '0', '0', '', '', '<li class=\"smaller\">30/05/2025 07:45:02 | chamado criado por Diogo (administrador)</li><li class=\"smaller\">30/05/2025 07:45:02 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">30/05/2025 07:48:45 | tempo dedicado atualizado para 08:00:50 por Diogo (administrador)</li><li class=\"smaller\">30/05/2025 07:49:00 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(178, 'B43', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 5, '2', 'Liberar acesso', 'Este site está bloqueado :https://www.acilajeado.org.br/', 'Este site está bloqueado :https://www.acilajeado.org.br/', '2025-06-02 14:52:39', '2025-06-02 14:58:53', '2025-06-02 14:58:53', '2025-06-02 14:58:53', NULL, '192.168.0.114', NULL, 3, 0, 1, 1, 1, 1, 1, NULL, '00:01:37', '1', 1, '0', '0', '', '', '<li class=\"smaller\">02/06/2025 11:52:39 | enviado por Cliente</li><li class=\"smaller\">02/06/2025 11:58:53 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">02/06/2025 11:58:53 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(180, 'B45', 'Tanize', 'laboratorio04@launer.com.br', 2, '3', 'Impressora', 'Bom dia,<br />\r\n<br />\r\nTeria como verificar a impressora, não estou conseguindo imprimir.<br />\r\nObrigado', 'Bom dia,<br />\r\n<br />\r\nTeria como verificar a impressora, não estou conseguindo imprimir.<br />\r\nObrigado', '2025-06-03 10:59:14', '2025-06-03 16:20:44', '2025-06-03 16:20:44', '2025-06-03 16:20:44', NULL, '192.168.0.138', NULL, 3, 0, 1, 1, 1, 1, 1, NULL, '05:18:44', '1', 1, '0', '0', '', '', '<li class=\"smaller\">03/06/2025 07:59:14 | enviado por Cliente</li><li class=\"smaller\">03/06/2025 13:20:44 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">03/06/2025 13:20:44 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(181, 'B46', 'ADRIANA DE SIQUEIRA', 'rh@launer.com.br', 3, '1', 'Notebook', 'O notebook está bem lento, trancando, sendo necessário reiniciar algumas vezes. Lento não só na internet, mas também  nos documentos.', 'O notebook está bem lento, trancando, sendo necessário reiniciar algumas vezes. Lento não só na internet, mas também  nos documentos.', '2025-06-03 18:43:10', '2025-06-09 11:33:31', '2025-06-03 19:53:39', '2025-06-09 11:33:31', NULL, '192.168.0.114', NULL, 3, 0, 1, 1, 2, 2, 1, NULL, '02:03:26', '1', 1, '0', '0', '', '', '<li class=\"smaller\">03/06/2025 15:43:10 | enviado por Cliente</li><li class=\"smaller\">03/06/2025 16:53:39 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">09/06/2025 08:32:39 | tempo dedicado atualizado para 02:02:35 por Diogo (administrador)</li><li class=\"smaller\">09/06/2025 08:33:31 | status alterado para Resolvido por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(184, 'B49', 'Guilherme Rocha', 'coordenador.vendas@launer.com.br', 2, '3', 'NÃO CONSIGO IMPRIMIR', 'NÃO CONSIGO IMPRIMIR', 'NÃO CONSIGO IMPRIMIR', '2025-06-13 12:57:51', '2025-06-13 13:02:01', '2025-06-13 13:01:45', '2025-06-13 13:02:01', NULL, '192.168.0.187', NULL, 3, 0, 1, 1, 1, 1, 1, NULL, '00:02:23', '1', 1, '0', '0', '', '', '<li class=\"smaller\">13/06/2025 09:57:51 | enviado por Cliente</li><li class=\"smaller\">13/06/2025 10:01:45 | atribuído a Diogo (administrador) por Diogo (administrador)</li><li class=\"smaller\">13/06/2025 10:02:01 | fechado por Diogo (administrador)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(183, 'B48', 'Diego Krilow', 'vendas@launer.com.br', 6, '3', 'Mensagem automática', 'Quando chamo um cliente que faz tempo que não tive contato, o whatsapp está enviando minha mensagem automática, como se o cliente tivesse me contatado.', 'Quando chamo um cliente que faz tempo que não tive contato, o whatsapp está enviando minha mensagem automática, como se o cliente tivesse me contatado.', '2025-06-11 13:09:06', '2025-06-11 13:09:06', NULL, NULL, NULL, '192.168.0.133', NULL, 0, 0, NULL, NULL, 0, 0, 0, NULL, '00:00:00', '0', NULL, '0', '0', '', '', '<li class=\"smaller\">11/06/2025 10:09:06 | enviado por Cliente</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL),
(185, 'B50', 'Tanize', 'laboratorio04@launer.com.br', 2, '3', 'Impressora', 'Bom dia,<br />\r\n<br />\r\nNão estou conseguindo imprimir.<br />\r\n<br />\r\nEnviei uma imagem para o Zang.', 'Bom dia,<br />\r\n<br />\r\nNão estou conseguindo imprimir.<br />\r\n<br />\r\nEnviei uma imagem para o Zang.', '2025-06-16 11:39:59', '2025-06-16 20:15:30', '2025-06-16 20:15:30', NULL, NULL, '192.168.0.138', NULL, 2, 0, 2, NULL, 1, 1, 2, NULL, '00:00:00', '1', 2, '0', '0', '', '', '<li class=\"smaller\">16/06/2025 08:39:59 | enviado por Cliente</li><li class=\"smaller\">16/06/2025 17:15:30 | atribuído a Alexandre (alexandre) por Alexandre (alexandre)</li>', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_ticket_counter`
--

CREATE TABLE `hesk_ticket_counter` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `hesk_ticket_counter`
--

INSERT INTO `hesk_ticket_counter` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50),
(51),
(52),
(53),
(54),
(55),
(56),
(57),
(58),
(59),
(60),
(61),
(62),
(63),
(64),
(65),
(66),
(67),
(68),
(69),
(70),
(71),
(72),
(73),
(74),
(75),
(76),
(77),
(78),
(79),
(80),
(81),
(82),
(83),
(84),
(85),
(86),
(87),
(88),
(89),
(90),
(91),
(92),
(93),
(94),
(95),
(96),
(97),
(98),
(99),
(100),
(101),
(102),
(103),
(104),
(105),
(106),
(107),
(108),
(109),
(110),
(111),
(112),
(113),
(114),
(115),
(116),
(117),
(118),
(119),
(120),
(121),
(122),
(123),
(124),
(125),
(126),
(127),
(128),
(129),
(130),
(131),
(132),
(133),
(134),
(135),
(136),
(137),
(138),
(139),
(140),
(141),
(142),
(143),
(144),
(145),
(146),
(147),
(148),
(149);

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_ticket_templates`
--

CREATE TABLE `hesk_ticket_templates` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `message` mediumtext NOT NULL,
  `message_html` mediumtext DEFAULT NULL,
  `tpl_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `hesk_users`
--

CREATE TABLE `hesk_users` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `user` varchar(255) NOT NULL DEFAULT '',
  `pass` varchar(255) NOT NULL DEFAULT '',
  `isadmin` enum('0','1') NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `signature` varchar(1000) NOT NULL DEFAULT '',
  `language` varchar(50) DEFAULT NULL,
  `categories` varchar(500) NOT NULL DEFAULT '',
  `afterreply` enum('0','1','2') NOT NULL DEFAULT '0',
  `autostart` enum('0','1') NOT NULL DEFAULT '1',
  `autoreload` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `notify_customer_new` enum('0','1') NOT NULL DEFAULT '1',
  `notify_customer_reply` enum('0','1') NOT NULL DEFAULT '1',
  `show_suggested` enum('0','1') NOT NULL DEFAULT '1',
  `notify_new_unassigned` enum('0','1') NOT NULL DEFAULT '1',
  `notify_new_my` enum('0','1') NOT NULL DEFAULT '1',
  `notify_reply_unassigned` enum('0','1') NOT NULL DEFAULT '1',
  `notify_reply_my` enum('0','1') NOT NULL DEFAULT '1',
  `notify_assigned` enum('0','1') NOT NULL DEFAULT '1',
  `notify_pm` enum('0','1') NOT NULL DEFAULT '1',
  `notify_note` enum('0','1') NOT NULL DEFAULT '1',
  `notify_overdue_unassigned` enum('0','1') NOT NULL DEFAULT '1',
  `notify_overdue_my` enum('0','1') NOT NULL DEFAULT '1',
  `default_list` varchar(255) NOT NULL DEFAULT '',
  `autoassign` enum('0','1') NOT NULL DEFAULT '1',
  `heskprivileges` varchar(1000) DEFAULT NULL,
  `ratingneg` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `ratingpos` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `rating` float NOT NULL DEFAULT 0,
  `replies` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `mfa_enrollment` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `mfa_secret` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `hesk_users`
--

INSERT INTO `hesk_users` (`id`, `user`, `pass`, `isadmin`, `name`, `email`, `signature`, `language`, `categories`, `afterreply`, `autostart`, `autoreload`, `notify_customer_new`, `notify_customer_reply`, `show_suggested`, `notify_new_unassigned`, `notify_new_my`, `notify_reply_unassigned`, `notify_reply_my`, `notify_assigned`, `notify_pm`, `notify_note`, `notify_overdue_unassigned`, `notify_overdue_my`, `default_list`, `autoassign`, `heskprivileges`, `ratingneg`, `ratingpos`, `rating`, `replies`, `mfa_enrollment`, `mfa_secret`) VALUES
(1, 'administrador', '$2y$10$x2lykKv0AQPJ8WQEvB78We8Z/EEdU1cS54k3x7CMuNFPqf.xAGS5m', '1', 'Diogo', 'ti@launer.com.br', 'Diogo', NULL, '', '1', '1', 30, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '0', '', 0, 2, 5, 117, 0, NULL),
(2, 'alexandre', '$2y$10$mBaif3T.Ds/IAELkXaiTQel4Xk951WeuN35yLrY8MhzAJ2jG.kVT.', '1', 'Alexandre', 'compras@launer.com.br', 'Alexandre Zang', NULL, '', '1', '1', 30, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '0', '', 0, 0, 0, 1, 0, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `hesk_attachments`
--
ALTER TABLE `hesk_attachments`
  ADD PRIMARY KEY (`att_id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Índices de tabela `hesk_auth_tokens`
--
ALTER TABLE `hesk_auth_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_banned_emails`
--
ALTER TABLE `hesk_banned_emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Índices de tabela `hesk_banned_ips`
--
ALTER TABLE `hesk_banned_ips`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_categories`
--
ALTER TABLE `hesk_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Índices de tabela `hesk_custom_fields`
--
ALTER TABLE `hesk_custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `useType` (`use`,`type`);

--
-- Índices de tabela `hesk_custom_statuses`
--
ALTER TABLE `hesk_custom_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_kb_articles`
--
ALTER TABLE `hesk_kb_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `catid` (`catid`),
  ADD KEY `sticky` (`sticky`),
  ADD KEY `type` (`type`);
ALTER TABLE `hesk_kb_articles` ADD FULLTEXT KEY `subject` (`subject`,`content`,`keywords`);

--
-- Índices de tabela `hesk_kb_attachments`
--
ALTER TABLE `hesk_kb_attachments`
  ADD PRIMARY KEY (`att_id`);

--
-- Índices de tabela `hesk_kb_categories`
--
ALTER TABLE `hesk_kb_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `parent` (`parent`);

--
-- Índices de tabela `hesk_logins`
--
ALTER TABLE `hesk_logins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Índices de tabela `hesk_log_overdue`
--
ALTER TABLE `hesk_log_overdue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket` (`ticket`),
  ADD KEY `category` (`category`),
  ADD KEY `priority` (`priority`),
  ADD KEY `status` (`status`),
  ADD KEY `owner` (`owner`);

--
-- Índices de tabela `hesk_mail`
--
ALTER TABLE `hesk_mail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from` (`from`),
  ADD KEY `to` (`to`,`read`,`deletedby`);

--
-- Índices de tabela `hesk_mfa_backup_codes`
--
ALTER TABLE `hesk_mfa_backup_codes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_mfa_verification_tokens`
--
ALTER TABLE `hesk_mfa_verification_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `verification_token` (`verification_token`);

--
-- Índices de tabela `hesk_notes`
--
ALTER TABLE `hesk_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticketid` (`ticket`);

--
-- Índices de tabela `hesk_oauth_providers`
--
ALTER TABLE `hesk_oauth_providers`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_oauth_tokens`
--
ALTER TABLE `hesk_oauth_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_online`
--
ALTER TABLE `hesk_online`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `dt` (`dt`);

--
-- Índices de tabela `hesk_pipe_loops`
--
ALTER TABLE `hesk_pipe_loops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`,`hits`);

--
-- Índices de tabela `hesk_replies`
--
ALTER TABLE `hesk_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `replyto` (`replyto`),
  ADD KEY `dt` (`dt`),
  ADD KEY `staffid` (`staffid`);

--
-- Índices de tabela `hesk_reply_drafts`
--
ALTER TABLE `hesk_reply_drafts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `ticket` (`ticket`);

--
-- Índices de tabela `hesk_reset_password`
--
ALTER TABLE `hesk_reset_password`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`);

--
-- Índices de tabela `hesk_service_messages`
--
ALTER TABLE `hesk_service_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Índices de tabela `hesk_std_replies`
--
ALTER TABLE `hesk_std_replies`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_temp_attachments`
--
ALTER TABLE `hesk_temp_attachments`
  ADD PRIMARY KEY (`att_id`);

--
-- Índices de tabela `hesk_temp_attachments_limits`
--
ALTER TABLE `hesk_temp_attachments_limits`
  ADD PRIMARY KEY (`ip`);

--
-- Índices de tabela `hesk_tickets`
--
ALTER TABLE `hesk_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trackid` (`trackid`),
  ADD KEY `archive` (`archive`),
  ADD KEY `categories` (`category`),
  ADD KEY `statuses` (`status`),
  ADD KEY `owner` (`owner`),
  ADD KEY `openedby` (`openedby`,`firstreplyby`,`closedby`),
  ADD KEY `dt` (`dt`);

--
-- Índices de tabela `hesk_ticket_counter`
--
ALTER TABLE `hesk_ticket_counter`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_ticket_templates`
--
ALTER TABLE `hesk_ticket_templates`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `hesk_users`
--
ALTER TABLE `hesk_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autoassign` (`autoassign`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `hesk_attachments`
--
ALTER TABLE `hesk_attachments`
  MODIFY `att_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `hesk_auth_tokens`
--
ALTER TABLE `hesk_auth_tokens`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `hesk_banned_emails`
--
ALTER TABLE `hesk_banned_emails`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_banned_ips`
--
ALTER TABLE `hesk_banned_ips`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_categories`
--
ALTER TABLE `hesk_categories`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `hesk_kb_articles`
--
ALTER TABLE `hesk_kb_articles`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `hesk_kb_attachments`
--
ALTER TABLE `hesk_kb_attachments`
  MODIFY `att_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `hesk_kb_categories`
--
ALTER TABLE `hesk_kb_categories`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `hesk_logins`
--
ALTER TABLE `hesk_logins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

--
-- AUTO_INCREMENT de tabela `hesk_log_overdue`
--
ALTER TABLE `hesk_log_overdue`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_mail`
--
ALTER TABLE `hesk_mail`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `hesk_mfa_backup_codes`
--
ALTER TABLE `hesk_mfa_backup_codes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_mfa_verification_tokens`
--
ALTER TABLE `hesk_mfa_verification_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_notes`
--
ALTER TABLE `hesk_notes`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `hesk_oauth_providers`
--
ALTER TABLE `hesk_oauth_providers`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_oauth_tokens`
--
ALTER TABLE `hesk_oauth_tokens`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_online`
--
ALTER TABLE `hesk_online`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_pipe_loops`
--
ALTER TABLE `hesk_pipe_loops`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_replies`
--
ALTER TABLE `hesk_replies`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT de tabela `hesk_reply_drafts`
--
ALTER TABLE `hesk_reply_drafts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de tabela `hesk_reset_password`
--
ALTER TABLE `hesk_reset_password`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `hesk_service_messages`
--
ALTER TABLE `hesk_service_messages`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `hesk_std_replies`
--
ALTER TABLE `hesk_std_replies`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_temp_attachments`
--
ALTER TABLE `hesk_temp_attachments`
  MODIFY `att_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `hesk_tickets`
--
ALTER TABLE `hesk_tickets`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT de tabela `hesk_ticket_counter`
--
ALTER TABLE `hesk_ticket_counter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT de tabela `hesk_ticket_templates`
--
ALTER TABLE `hesk_ticket_templates`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `hesk_users`
--
ALTER TABLE `hesk_users`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
