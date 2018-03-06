-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mar 06, 2018 alle 16:18
-- Versione del server: 10.1.28-MariaDB
-- Versione PHP: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `musa_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `abstract_capability`
--

CREATE TABLE `abstract_capability` (
  `idAbstrat_Capability` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `input` longtext,
  `output` longtext,
  `params` longtext,
  `body` varchar(1000) DEFAULT NULL,
  `assumption` longtext,
  `description` longtext,
  `idDomain` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `abstract_capability`
--

INSERT INTO `abstract_capability` (`idAbstrat_Capability`, `name`, `input`, `output`, `params`, `body`, `assumption`, `description`, `idDomain`) VALUES
(3, 'check_user', '<empty>', '<empty>', 'an_order, a_user, the_user_data', 'capability check_user {\r\npre: available(X) and order(X) and  not logged(Y) and user(Y)\r\npost: true\r\nscenario RegisteredUserWithCloud ( add registered(a_user), add has_cloud_space(a_user) )\r\nscenario RegisteredUserWithoutCloud ( add registered(a_user), remove user_data(the_user_data), add logged(a_user) )\r\nscenario KnownUser (add complete(the_user_data), add unregistered(a_user), add logged(a_user))\r\nscenario UnknownUser (add(uncomplete(the_user_data)), add(unregistered(a_user)), add(logged(a_user)))\r\n}', 'order(an_order), user(a_user), user_data(the_user_data)', '', 28),
(4, 'add_user', '<empty>', '<empty>', 'a_user, the_user_data', 'capability add_user {\r\npre: true\r\npost: true\r\nscenario evolution ( add available(an_order) )\r\n}', 'user(a_user), user_data(the_user_data)', '', 28),
(5, 'send_reg_form', '<empty>', '<empty>', 'a_user, the_user_data, the_registation_form', 'capability send_reg_form {\r\npre: uncomplete(X) and user_data(X) and unregistered(Y) and user(Y)\r\npost: true\r\nscenario evolution (add(uncomplete(the_registation_form)))\r\n}', 'user(a_user), user_data(the_user_data), registation_form(the_registation_form)', '', 28),
(6, 'wait_user_data', '<empty>', '<empty>', 'the_user_data, the_registation_form', 'capability wait_user_data {\r\npre: uncomplete(X) and registation_form(X)\r\npost: true\r\nscenario CompleteForm (add(complete(the_user_data)), remove(uncomplete(the_registration_form)), remove(uncomplete(the_user_data)))\r\nscenario UncompleteForm (remove(uncomplete(the_registration_form)))\r\n}', 'user_data(the_user_data), registation_form(the_registation_form)', '', 28),
(7, 'check_storehouse', '<empty>', '<empty>', 'an_order, a_user', 'capability check_storehouse {\r\npre: available(X) and order(X) and registered(X) and user(X)\r\npost: true\r\nscenario AcceptableOrder (add(accepted(an_order)), remove(available(an_order)))\r\nscenario UnacceptableOrder (add(refused(an_order)), remove(available(an_order)))\r\n}', 'order(an_order), user(a_user)', '', 28),
(8, 'notify_stock_failure', '<empty>', '<empty>', 'an_order, a_user', 'capability notify_stock_failure {\r\npre: refused(X) and order(X) and registered(Y) and user(Y) and not failure_order(Z)\r\npost: true\r\nscenario evolution (add(sent(failure_order, a_user)), add(failure_order(failure_order)))\r\n}', 'order(an_order), user(a_user)', '', 28),
(9, 'generate_invoice', '<empty>', '<empty>', 'an_order, a_user, the_invoice', 'capability generate_invoice {\r\npre: accepted(X) and order(X) and registered(Y) and user(Y) and not available(Z)\r\npost: true\r\nscenario evolution (add(available(the_invoice)))\r\n}', 'order(an_order), user(a_user), invoice(the_invoice)', '', 28),
(10, 'upload_on_user_cloud_storage', '<empty>', '<empty>', 'the_invoice, a_user', 'capability upload_on_user_cloud_storage {\r\npre: available(X) and invoice(X) and has_cloud_space(Y) and user(Y) and not uploaded_on_cloud(X)\r\npost: true\r\nscenario evolution (add(uploaded_on_cloud(the_invoice)))\r\n}', 'invoice(the_invoice), user(a_user)', '', 28),
(11, 'upload_on_private_cloud_storage', '<empty>', '<empty>', 'the_invoice, a_user', 'capability upload_on_private_cloud_storage {\r\npre: available(X) and invoice(X) and NOT has_cloud_space(Y) and user(Y) and not uploaded_on_cloud(X)\r\npost: true\r\nscenario evolution (add(uploaded_on_cloud(the_invoice)))\r\n}', 'invoice(the_invoice), user(a_user)', '', 28),
(12, 'share_file_link', '<empty>', '<empty>', 'the_invoice, a_user', 'capability share_file_link {\r\npre: uploaded_on_cloud(X) and invoice(X) and NOT has_cloud_space(Y) and user(Y) and not mailed_perm_link(X, Y)\r\npost: true\r\nscenario evolution (add(mailed_perm_link(the_invoice, a_user)))\r\n}', 'invoice(the_invoice), user(a_user)', '', 28),
(13, 'notify_storehouse_manager', '<empty>', '<empty>', 'the_invoice, a_user, the_delivery_order, a_storehouse_manager', 'capability notify_storehouse_manager {\r\npre: notified(X, Y) and invoice(X) and user(Y) and not sent(X, Y)\r\npost: true\r\nscenario evolution (add(sent(the_delivery_order,a_storehouse_manager)))\r\n}', 'invoice(the_invoice), user(a_user), delivery_order(the_delivery_order), storehouse_manager(a_storehouse_manager)', '', 28),
(14, 'wait_message', '<empty>', '<empty>', 'an_order', 'capability wait_message {\r\npre: true\r\npost: true\r\nscenario evolution ( add available(an_order) )\r\n}', 'order(an_order)', '', 28);

-- --------------------------------------------------------

--
-- Struttura della tabella `abstract_capability_proposal`
--

CREATE TABLE `abstract_capability_proposal` (
  `idProposal` int(11) NOT NULL,
  `name` varchar(45) COLLATE ascii_bin DEFAULT NULL,
  `input` longtext COLLATE ascii_bin,
  `output` longtext COLLATE ascii_bin,
  `params` longtext COLLATE ascii_bin,
  `body` varchar(1000) COLLATE ascii_bin DEFAULT NULL,
  `description` longtext COLLATE ascii_bin,
  `idDomain` int(11) NOT NULL,
  `idAbstractCapability` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `state` enum('approved','refused','waiting','') COLLATE ascii_bin NOT NULL,
  `motivation` varchar(250) COLLATE ascii_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin;

-- --------------------------------------------------------

--
-- Struttura della tabella `capability_instance`
--

CREATE TABLE `capability_instance` (
  `idCapability_Instance` int(11) NOT NULL,
  `state` varchar(45) DEFAULT NULL,
  `idCapability` int(11) DEFAULT NULL,
  `idCase` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `capability_log`
--

CREATE TABLE `capability_log` (
  `idCapability_Operation` int(11) NOT NULL,
  `timeOperation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(45) DEFAULT NULL,
  `idInstance` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `case_execution`
--

CREATE TABLE `case_execution` (
  `idCase` int(11) NOT NULL,
  `name` longtext,
  `startedTime` datetime DEFAULT NULL,
  `terminatedTime` datetime DEFAULT NULL,
  `idSpecification` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `concrete_capability`
--

CREATE TABLE `concrete_capability` (
  `idConcrete_Capability` int(11) NOT NULL,
  `idAbstract_Capability` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `provider` int(45) DEFAULT NULL,
  `ipWorkspace` varchar(255) NOT NULL,
  `wpname` varchar(255) NOT NULL,
  `state` set('active','unactive') NOT NULL DEFAULT 'unactive',
  `description` longtext,
  `classname` varchar(255) DEFAULT NULL,
  `jarfile` longblob,
  `deploystate` set('deployed','undeployed') NOT NULL DEFAULT 'undeployed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `domain`
--

CREATE TABLE `domain` (
  `idDomain` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `domain`
--

INSERT INTO `domain` (`idDomain`, `name`, `description`) VALUES
(28, 'Cloud Application Mashup', '');

--
-- Trigger `domain`
--
DELIMITER $$
CREATE TRIGGER `triggerDomainCreate` AFTER INSERT ON `domain` FOR EACH ROW BEGIN
INSERT INTO domain_configuration (idDomain,name,value,description,id_dom_conf_def)
SELECT NEW.idDomain,name,default_value,description,id_dom_conf_def FROM domain_conf_default;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `domain_assumption`
--

CREATE TABLE `domain_assumption` (
  `idAssumption` int(11) NOT NULL,
  `idDomain` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `assumption` longtext,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `domain_assumption`
--

INSERT INTO `domain_assumption` (`idAssumption`, `idDomain`, `name`, `assumption`, `description`) VALUES
(14, 28, 'entities', 'role, document, url, failure_order     user [is-a role],      storehouse_manager [is-a role],      order [is-a document],      invoice [is-a document],     user_data [is-a document],     registration_form [is-a-document],     delivery_order [is-a order],     rxfile [is-a URL]', ''),
(15, 28, 'unary user\'s properties', 'registered,      unregistered,      has_cloud_space', ''),
(16, 28, 'unary document\'s properties', 'available, uploaded_on_cloud', ''),
(17, 28, 'unary order\'s properties', 'accepted, refused, processed', ''),
(18, 28, 'unary user_data\'s properties', 'complete, uncomplete', ''),
(19, 28, 'unary registration_form\'s properties', 'complete, uncomplete', ''),
(20, 28, 'binary properties', 'notified(document,user),       mailed_perm_link(document,user) [is-a notified]', ''),
(21, 28, 'Rules about the document', 'role(X) :- user(X)  role(X) :- storehouse_manager(X)  document(X) :- order(X)  document(X) :- invoice(X)  document(X) :- user_data(X)  document(X) :- registration_form(X)  order(X) :- delivery_order(X)', ''),
(22, 28, 'Rules about the process', 'processed(X) :- accepted(X) & order(X) & sent(Y,Z) & delivery_order(Y) & storehouse_manager(Z)  processed(X) :- refused(X) & order(X) & sent(failure_order,Y) & user(Y)', ''),
(23, 28, 'Rules about the notification', 'notified(X,Y) :- uploaded_on_cloud(X) & document(X) & has_cloud_space(Y) & user(Y)  notified(X,Y) :- mailed_perm_link(X,Y) & document(X) & user(Y)', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `domain_configuration`
--

CREATE TABLE `domain_configuration` (
  `idDomain_Configuration` int(11) NOT NULL,
  `idDomain` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `id_dom_conf_def` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `domain_conf_default`
--

CREATE TABLE `domain_conf_default` (
  `id_dom_conf_def` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `default_value` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Trigger `domain_conf_default`
--
DELIMITER $$
CREATE TRIGGER `triggerConfCreate` AFTER INSERT ON `domain_conf_default` FOR EACH ROW BEGIN
INSERT INTO domain_configuration (idDomain,name,value,description,id_dom_conf_def)
SELECT idDomain,NEW.name,NEW.default_value,NEW.description,NEW.id_dom_conf_def FROM domain;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `functional_req`
--

CREATE TABLE `functional_req` (
  `idFunctional_Req` int(11) NOT NULL,
  `name` longtext,
  `type` longtext,
  `description` longtext,
  `priority` int(10) DEFAULT NULL,
  `current_state` set('activated','deactivated','waiting') DEFAULT 'waiting',
  `body` longtext,
  `actors` longtext,
  `idWF` int(11) DEFAULT NULL,
  `idSpecification` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `functional_req`
--

INSERT INTO `functional_req` (`idFunctional_Req`, `name`, `type`, `description`, `priority`, `current_state`, `body`, `actors`, `idWF`, `idSpecification`) VALUES
(230, 'to_handle_order', 'manual', '', 0, 'waiting', '( WHEN MESSAGE Doc RECEIVED FROM THE Client ROLE AND order(Doc) AND user(Client) ) -> F (processed(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(231, 'to_wait_order', 'manual', '', 0, 'waiting', '( WHEN MESSAGE Doc RECEIVED FROM THE Client ROLE AND order(Doc) AND user(Client) ) -> F (available(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(232, 'to_process_order', 'manual', '', 0, 'waiting', '( WHEN available(Doc) AND order(Doc) AND registered(Client) AND user(Client) ) -> F (processed(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(233, 'to_process_accepted_order', 'manual', '', 0, 'waiting', '( WHEN accepted(X) AND order(X) ) -> F (MESSAGE U SENT TO THE Z ROLE AND delivery_order(U) AND storehouse_manager(Z))', 'THE SYSTEM', NULL, 21),
(234, 'to_notify_invoice', 'manual', '', 0, 'waiting', '( WHEN accepted(X) AND order(X) AND registered(Y) AND user(Y) ) -> F (MESSAGE invoice SENT TO THE Client ROLE AND user(Client))', 'THE SYSTEM', NULL, 21),
(235, 'to_deliver_order', 'manual', '', 0, 'waiting', '( WHEN MESSAGE Doc SENT TO THE Client ROLE AND invoice(Doc) AND user(Client) ) -> F (MESSAGE Deliv SENT TO THE SM ROLE AND delivery_order(Deliv) AND storehouse_manager(SM))', 'THE SYSTEM', NULL, 21),
(236, 'to_notify_failure', 'manual', '', 0, 'waiting', '( WHEN refused(X) AND order(X) AND registered(Y) AND user(Y) ) -> F (MESSAGE failure_order SENT TO THE Client ROLE AND user(Client))', 'THE SYSTEM', NULL, 21);

-- --------------------------------------------------------

--
-- Struttura della tabella `functional_req_relations`
--

CREATE TABLE `functional_req_relations` (
  `idFunc_Req_rel` int(11) NOT NULL,
  `id_start` int(11) NOT NULL,
  `id_end` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `id_spec` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `general_configuration`
--

CREATE TABLE `general_configuration` (
  `idGeneral_Configuration` int(11) NOT NULL,
  `name` longtext,
  `value` longtext,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `general_configuration`
--

INSERT INTO `general_configuration` (`idGeneral_Configuration`, `name`, `value`, `description`) VALUES
(7, 'IP_WORKFLOW_EDITOR', 'aose.pa.icar.cnr.it', 'Ip Address of Workflow Editor'),
(20, 'PORT_WORKFLOW_EDITOR', '8080', 'Port of Workflow Editor'),
(21, 'IP_BPMN2GOALSPEC_SERVICE', 'aose.pa.icar.cnr.it', 'Ip address of BPMN2GOALSPEC Service'),
(22, 'PORT_BPMN2GOALSPEC_SERVICE', '8080', 'Port of BPMN2GOALSPEC Service'),
(23, 'APACHEMQ_IP', 'localhost', 'Ip Address of ApacheMQ server'),
(24, 'APACHEMQ_PORT', '61616', 'Port of ApacheMQ server');

-- --------------------------------------------------------

--
-- Struttura della tabella `goal_relation_type`
--

CREATE TABLE `goal_relation_type` (
  `idGrt` int(11) NOT NULL,
  `typeName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `goal_relation_type`
--

INSERT INTO `goal_relation_type` (`idGrt`, `typeName`) VALUES
(1, 'and decomposition'),
(2, 'or decomposition'),
(3, 'impact (++)'),
(4, 'conflict (--)');

-- --------------------------------------------------------

--
-- Struttura della tabella `non_functional_req`
--

CREATE TABLE `non_functional_req` (
  `idNonFunctional_Req` int(11) NOT NULL,
  `name` longtext,
  `value` longtext,
  `description` varchar(45) DEFAULT NULL,
  `idSpecification` int(11) DEFAULT NULL,
  `current_state` set('active','deactivate','waiting') DEFAULT 'waiting'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `predicate`
--

CREATE TABLE `predicate` (
  `idPredicate` int(11) NOT NULL,
  `name` longblob,
  `description` longblob,
  `idCase` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `process`
--

CREATE TABLE `process` (
  `idWorkflow` int(11) NOT NULL,
  `name` longtext,
  `description` longtext,
  `fileWF` blob,
  `idSpecification` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `specification`
--

CREATE TABLE `specification` (
  `idSpecification` int(11) NOT NULL,
  `name` longtext,
  `description` longtext,
  `state` set('activate','deactivate','waiting') DEFAULT 'waiting',
  `user` int(11) DEFAULT NULL,
  `idDomain` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `specification`
--

INSERT INTO `specification` (`idSpecification`, `name`, `description`, `state`, `user`, `idDomain`) VALUES
(21, 'Cloud Application for Fashion Firm', '', 'activate', 3, 28);

-- --------------------------------------------------------

--
-- Struttura della tabella `user`
--

CREATE TABLE `user` (
  `idUser` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` set('customer','dev','admin','super') NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `user`
--

INSERT INTO `user` (`idUser`, `name`, `role`, `password`) VALUES
(1, 'dev1', 'dev', 'admin'),
(2, 'dev2', 'dev', 'admin'),
(3, 'cust1', 'customer', 'admin'),
(4, 'cust2', 'customer', 'admin'),
(5, 'admin1', 'admin', 'admin'),
(6, 'super', 'super', 'admin');

-- --------------------------------------------------------

--
-- Struttura della tabella `variable`
--

CREATE TABLE `variable` (
  `idVariable` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  `idCase` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `abstract_capability`
--
ALTER TABLE `abstract_capability`
  ADD PRIMARY KEY (`idAbstrat_Capability`),
  ADD KEY `FAC_idx` (`idDomain`);

--
-- Indici per le tabelle `abstract_capability_proposal`
--
ALTER TABLE `abstract_capability_proposal`
  ADD PRIMARY KEY (`idProposal`),
  ADD KEY `idDomain` (`idDomain`),
  ADD KEY `idAbstractCapability` (`idAbstractCapability`),
  ADD KEY `provider` (`provider`);

--
-- Indici per le tabelle `capability_instance`
--
ALTER TABLE `capability_instance`
  ADD PRIMARY KEY (`idCapability_Instance`),
  ADD KEY `FKCINC_idx` (`idCase`),
  ADD KEY `FKCC_idx` (`idCapability`);

--
-- Indici per le tabelle `capability_log`
--
ALTER TABLE `capability_log`
  ADD PRIMARY KEY (`idCapability_Operation`),
  ADD KEY `idInstance_idx` (`idInstance`);

--
-- Indici per le tabelle `case_execution`
--
ALTER TABLE `case_execution`
  ADD PRIMARY KEY (`idCase`),
  ADD KEY `FKCS_idx` (`idSpecification`);

--
-- Indici per le tabelle `concrete_capability`
--
ALTER TABLE `concrete_capability`
  ADD PRIMARY KEY (`idConcrete_Capability`),
  ADD KEY `idABSTRACT_idx` (`idAbstract_Capability`),
  ADD KEY `provider` (`provider`),
  ADD KEY `provider_2` (`provider`);

--
-- Indici per le tabelle `domain`
--
ALTER TABLE `domain`
  ADD PRIMARY KEY (`idDomain`);

--
-- Indici per le tabelle `domain_assumption`
--
ALTER TABLE `domain_assumption`
  ADD PRIMARY KEY (`idAssumption`),
  ADD KEY `FD1_idx` (`idDomain`);

--
-- Indici per le tabelle `domain_configuration`
--
ALTER TABLE `domain_configuration`
  ADD PRIMARY KEY (`idDomain_Configuration`),
  ADD KEY `FDC_idx` (`idDomain`),
  ADD KEY `id_dom_conf_def` (`id_dom_conf_def`,`name`,`description`);

--
-- Indici per le tabelle `domain_conf_default`
--
ALTER TABLE `domain_conf_default`
  ADD PRIMARY KEY (`id_dom_conf_def`) USING BTREE,
  ADD UNIQUE KEY `id_dom_conf_def` (`id_dom_conf_def`,`name`,`description`);

--
-- Indici per le tabelle `functional_req`
--
ALTER TABLE `functional_req`
  ADD PRIMARY KEY (`idFunctional_Req`),
  ADD KEY `idSpec_idx` (`idSpecification`),
  ADD KEY `idWf_idx` (`idWF`);

--
-- Indici per le tabelle `functional_req_relations`
--
ALTER TABLE `functional_req_relations`
  ADD PRIMARY KEY (`idFunc_Req_rel`),
  ADD KEY `start` (`id_start`),
  ADD KEY `end` (`id_end`),
  ADD KEY `spec` (`id_spec`),
  ADD KEY `type` (`type`);

--
-- Indici per le tabelle `general_configuration`
--
ALTER TABLE `general_configuration`
  ADD PRIMARY KEY (`idGeneral_Configuration`);

--
-- Indici per le tabelle `goal_relation_type`
--
ALTER TABLE `goal_relation_type`
  ADD PRIMARY KEY (`idGrt`);

--
-- Indici per le tabelle `non_functional_req`
--
ALTER TABLE `non_functional_req`
  ADD PRIMARY KEY (`idNonFunctional_Req`),
  ADD KEY `FNFS_idx` (`idSpecification`);

--
-- Indici per le tabelle `predicate`
--
ALTER TABLE `predicate`
  ADD PRIMARY KEY (`idPredicate`),
  ADD KEY `FKPC_idx` (`idCase`);

--
-- Indici per le tabelle `process`
--
ALTER TABLE `process`
  ADD PRIMARY KEY (`idWorkflow`),
  ADD KEY `idSpecification` (`idSpecification`);

--
-- Indici per le tabelle `specification`
--
ALTER TABLE `specification`
  ADD PRIMARY KEY (`idSpecification`),
  ADD KEY `FKSDOM_idx` (`idDomain`),
  ADD KEY `user` (`user`);

--
-- Indici per le tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`);

--
-- Indici per le tabelle `variable`
--
ALTER TABLE `variable`
  ADD PRIMARY KEY (`idVariable`),
  ADD KEY `idCase_idx` (`idCase`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `abstract_capability`
--
ALTER TABLE `abstract_capability`
  MODIFY `idAbstrat_Capability` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT per la tabella `abstract_capability_proposal`
--
ALTER TABLE `abstract_capability_proposal`
  MODIFY `idProposal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `capability_instance`
--
ALTER TABLE `capability_instance`
  MODIFY `idCapability_Instance` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `capability_log`
--
ALTER TABLE `capability_log`
  MODIFY `idCapability_Operation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `case_execution`
--
ALTER TABLE `case_execution`
  MODIFY `idCase` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `concrete_capability`
--
ALTER TABLE `concrete_capability`
  MODIFY `idConcrete_Capability` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `domain`
--
ALTER TABLE `domain`
  MODIFY `idDomain` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT per la tabella `domain_assumption`
--
ALTER TABLE `domain_assumption`
  MODIFY `idAssumption` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT per la tabella `domain_configuration`
--
ALTER TABLE `domain_configuration`
  MODIFY `idDomain_Configuration` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `domain_conf_default`
--
ALTER TABLE `domain_conf_default`
  MODIFY `id_dom_conf_def` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `functional_req`
--
ALTER TABLE `functional_req`
  MODIFY `idFunctional_Req` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT per la tabella `functional_req_relations`
--
ALTER TABLE `functional_req_relations`
  MODIFY `idFunc_Req_rel` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `general_configuration`
--
ALTER TABLE `general_configuration`
  MODIFY `idGeneral_Configuration` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT per la tabella `goal_relation_type`
--
ALTER TABLE `goal_relation_type`
  MODIFY `idGrt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `non_functional_req`
--
ALTER TABLE `non_functional_req`
  MODIFY `idNonFunctional_Req` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `process`
--
ALTER TABLE `process`
  MODIFY `idWorkflow` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `specification`
--
ALTER TABLE `specification`
  MODIFY `idSpecification` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT per la tabella `user`
--
ALTER TABLE `user`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `variable`
--
ALTER TABLE `variable`
  MODIFY `idVariable` int(11) NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `abstract_capability`
--
ALTER TABLE `abstract_capability`
  ADD CONSTRAINT `FAC` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `abstract_capability_proposal`
--
ALTER TABLE `abstract_capability_proposal`
  ADD CONSTRAINT `abstract_capability_proposal_ibfk_1` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`),
  ADD CONSTRAINT `abstract_capability_proposal_ibfk_2` FOREIGN KEY (`idAbstractCapability`) REFERENCES `abstract_capability` (`idAbstrat_Capability`),
  ADD CONSTRAINT `provider_user` FOREIGN KEY (`provider`) REFERENCES `user` (`idUser`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Limiti per la tabella `capability_instance`
--
ALTER TABLE `capability_instance`
  ADD CONSTRAINT `FKCC` FOREIGN KEY (`idCapability`) REFERENCES `concrete_capability` (`idConcrete_Capability`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKCINC` FOREIGN KEY (`idCase`) REFERENCES `case_execution` (`idCase`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `capability_log`
--
ALTER TABLE `capability_log`
  ADD CONSTRAINT `idInstance` FOREIGN KEY (`idInstance`) REFERENCES `capability_instance` (`idCapability_Instance`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `case_execution`
--
ALTER TABLE `case_execution`
  ADD CONSTRAINT `FKCS` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `concrete_capability`
--
ALTER TABLE `concrete_capability`
  ADD CONSTRAINT `dProvider` FOREIGN KEY (`provider`) REFERENCES `user` (`idUser`),
  ADD CONSTRAINT `idABSTRACT` FOREIGN KEY (`idAbstract_Capability`) REFERENCES `abstract_capability` (`idAbstrat_Capability`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limiti per la tabella `domain_assumption`
--
ALTER TABLE `domain_assumption`
  ADD CONSTRAINT `FD1` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `domain_configuration`
--
ALTER TABLE `domain_configuration`
  ADD CONSTRAINT `FDC` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `domain_configuration_ibfk_1` FOREIGN KEY (`id_dom_conf_def`,`name`,`description`) REFERENCES `domain_conf_default` (`id_dom_conf_def`, `name`, `description`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `functional_req`
--
ALTER TABLE `functional_req`
  ADD CONSTRAINT `idSpec` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idWf` FOREIGN KEY (`idWF`) REFERENCES `process` (`idWorkflow`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `functional_req_relations`
--
ALTER TABLE `functional_req_relations`
  ADD CONSTRAINT `end` FOREIGN KEY (`id_end`) REFERENCES `functional_req` (`idFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `spec` FOREIGN KEY (`id_spec`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `start` FOREIGN KEY (`id_start`) REFERENCES `functional_req` (`idFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `type` FOREIGN KEY (`type`) REFERENCES `goal_relation_type` (`idGrt`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `non_functional_req`
--
ALTER TABLE `non_functional_req`
  ADD CONSTRAINT `FNFS` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `predicate`
--
ALTER TABLE `predicate`
  ADD CONSTRAINT `FKPC` FOREIGN KEY (`idCase`) REFERENCES `case_execution` (`idCase`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `process`
--
ALTER TABLE `process`
  ADD CONSTRAINT `process_ibfk_1` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`);

--
-- Limiti per la tabella `specification`
--
ALTER TABLE `specification`
  ADD CONSTRAINT `FKSDOM` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `iduser` FOREIGN KEY (`user`) REFERENCES `user` (`idUser`);

--
-- Limiti per la tabella `variable`
--
ALTER TABLE `variable`
  ADD CONSTRAINT `idCase` FOREIGN KEY (`idCase`) REFERENCES `case_execution` (`idCase`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
