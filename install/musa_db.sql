-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: serverino:3306
-- Generato il: Lug 03, 2018 alle 23:12
-- Versione del server: 5.5.59-0ubuntu0.14.04.1
-- Versione PHP: 5.5.9-1ubuntu4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `musa_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `abstract_capability`
--

CREATE TABLE IF NOT EXISTS `abstract_capability` (
  `idAbstrat_Capability` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `input` longtext,
  `output` longtext,
  `params` longtext,
  `body` longtext,
  `assumption` longtext,
  `description` longtext,
  `idDomain` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAbstrat_Capability`),
  KEY `FAC_idx` (`idDomain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=56 ;

--
-- Dump dei dati per la tabella `abstract_capability`
--

INSERT INTO `abstract_capability` (`idAbstrat_Capability`, `name`, `input`, `output`, `params`, `body`, `assumption`, `description`, `idDomain`) VALUES
(3, 'check_user', '<empty>', '<empty>', 'an_order, a_user, the_user_data', 'capability check_user {\r\npre: available(X) and order(X) and  not logged(Y) and user(Y)\r\npost: true\r\nscenario RegisteredUserWithCloud ( add registered(a_user), add has_cloud_space(a_user) )\r\nscenario RegisteredUserWithoutCloud ( add registered(a_user), remove user_data(the_user_data), add logged(a_user) )\r\nscenario KnownUser (add complete(the_user_data), add unregistered(a_user), add logged(a_user))\r\nscenario UnknownUser (add(uncomplete(the_user_data)), add(unregistered(a_user)), add(logged(a_user)))\r\n}', 'order(an_order), user(a_user), user_data(the_user_data)', '', 28),
(5, 'send_reg_form', '<empty>', '<empty>', 'a_user, the_user_data, the_registation_form', 'capability send_reg_form {\r\npre: uncomplete(X) and user_data(X) and unregistered(Y) and user(Y)\r\npost: true\r\nscenario evolution (add(uncomplete(the_registation_form)))\r\n}', 'user(a_user), user_data(the_user_data), registation_form(the_registation_form)', '', 28),
(6, 'wait_user_data', '<empty>', '<empty>', 'the_user_data, the_registation_form', 'capability wait_user_data {\r\npre: uncomplete(X) and registation_form(X)\r\npost: true\r\nscenario CompleteForm (add(complete(the_user_data)), remove(uncomplete(the_registration_form)), remove(uncomplete(the_user_data)))\r\nscenario UncompleteForm (remove(uncomplete(the_registration_form)))\r\n}', 'user_data(the_user_data), registation_form(the_registation_form)', '', 28),
(7, 'check_storehouse', '<empty>', '<empty>', 'an_order, a_user', 'capability check_storehouse {\r\npre: available(X) and order(X) and registered(X) and user(X)\r\npost: true\r\nscenario AcceptableOrder (add(accepted(an_order)), remove(available(an_order)))\r\nscenario UnacceptableOrder (add(refused(an_order)), remove(available(an_order)))\r\n}', 'order(an_order), user(a_user)', '', 28),
(8, 'notify_stock_failure', '<empty>', '<empty>', 'an_order, a_user', 'capability notify_stock_failure {\r\npre: refused(X) and order(X) and registered(Y) and user(Y) and not failure_order(Z)\r\npost: true\r\nscenario evolution (add(sent(failure_order, a_user)), add(failure_order(failure_order)))\r\n}', 'order(an_order), user(a_user)', '', 28),
(9, 'generate_invoice', '<empty>', '<empty>', 'an_order, a_user, the_invoice', 'capability generate_invoice {\r\npre: accepted(X) and order(X) and registered(Y) and user(Y) and not available(Z)\r\npost: true\r\nscenario evolution (add(available(the_invoice)))\r\n}', 'order(an_order), user(a_user), invoice(the_invoice)', '', 28),
(10, 'upload_on_user_cloud_storage', '<empty>', '<empty>', 'the_invoice, a_user', 'capability upload_on_user_cloud_storage {\r\npre: available(X) and invoice(X) and has_cloud_space(Y) and user(Y) and not uploaded_on_cloud(X)\r\npost: true\r\nscenario evolution (add(uploaded_on_cloud(the_invoice)))\r\n}', 'invoice(the_invoice), user(a_user)', '', 28),
(11, 'upload_on_private_cloud_storage', '<empty>', '<empty>', 'the_invoice, a_user', 'capability upload_on_private_cloud_storage {\r\npre: available(X) and invoice(X) and NOT has_cloud_space(Y) and user(Y) and not uploaded_on_cloud(X)\r\npost: true\r\nscenario evolution (add(uploaded_on_cloud(the_invoice)))\r\n}', 'invoice(the_invoice), user(a_user)', '', 28),
(12, 'share_file_link', '<empty>', '<empty>', 'the_invoice, a_user', 'capability share_file_link {\r\npre: uploaded_on_cloud(X) and invoice(X) and NOT has_cloud_space(Y) and user(Y) and not mailed_perm_link(X, Y)\r\npost: true\r\nscenario evolution (add(mailed_perm_link(the_invoice, a_user)))\r\n}', 'invoice(the_invoice), user(a_user)', '', 28),
(13, 'notify_storehouse_manager', '<empty>', '<empty>', 'the_invoice, a_user, the_delivery_order, a_storehouse_manager', 'capability notify_storehouse_manager {\r\npre: notified(X, Y) and invoice(X) and user(Y) and not sent(X, Y)\r\npost: true\r\nscenario evolution (add(sent(the_delivery_order,a_storehouse_manager)))\r\n}', 'invoice(the_invoice), user(a_user), delivery_order(the_delivery_order), storehouse_manager(a_storehouse_manager)', '', 28),
(14, 'wait_message', '<empty>', '<empty>', 'an_order', 'capability wait_message {\r\npre: true\r\npost: true\r\nscenario evolution ( add available(an_order) )\r\n}', 'order(an_order)', '', 28),
(55, 'gffd', NULL, NULL, NULL, 'dsf', NULL, 'sdfd', 28);

-- --------------------------------------------------------

--
-- Struttura della tabella `abstract_capability_proposal`
--

CREATE TABLE IF NOT EXISTS `abstract_capability_proposal` (
  `idProposal` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE ascii_bin,
  `input` longtext COLLATE ascii_bin,
  `output` longtext COLLATE ascii_bin,
  `params` longtext COLLATE ascii_bin,
  `body` longtext COLLATE ascii_bin,
  `description` longtext COLLATE ascii_bin,
  `idDomain` int(11) NOT NULL,
  `idAbstractCapability` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `state` enum('approved','refused','waiting','') COLLATE ascii_bin NOT NULL,
  `motivation` longtext COLLATE ascii_bin,
  PRIMARY KEY (`idProposal`),
  KEY `idDomain` (`idDomain`),
  KEY `idAbstractCapability` (`idAbstractCapability`),
  KEY `provider` (`provider`)
) ENGINE=InnoDB  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=12 ;

--
-- Dump dei dati per la tabella `abstract_capability_proposal`
--

INSERT INTO `abstract_capability_proposal` (`idProposal`, `name`, `input`, `output`, `params`, `body`, `description`, `idDomain`, `idAbstractCapability`, `provider`, `state`, `motivation`) VALUES
(11, 'gffd', 'sdf', 'fs', 'sdfds', 'dsf', 'sdfd', 28, 55, 1, 'approved', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `capability_instance`
--

CREATE TABLE IF NOT EXISTS `capability_instance` (
  `idCapability_Instance` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(45) DEFAULT NULL,
  `idCapability` int(11) DEFAULT NULL,
  `idCase` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCapability_Instance`),
  KEY `FKCINC_idx` (`idCase`),
  KEY `FKCC_idx` (`idCapability`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `capability_log`
--

CREATE TABLE IF NOT EXISTS `capability_log` (
  `idCapability_Operation` int(11) NOT NULL AUTO_INCREMENT,
  `timeOperation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(45) DEFAULT NULL,
  `idInstance` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCapability_Operation`),
  KEY `idInstance_idx` (`idInstance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `case_execution`
--

CREATE TABLE IF NOT EXISTS `case_execution` (
  `idCase` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `startedTime` datetime DEFAULT NULL,
  `terminatedTime` datetime DEFAULT NULL,
  `idSpecification` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCase`),
  KEY `FKCS_idx` (`idSpecification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `concrete_capability`
--

CREATE TABLE IF NOT EXISTS `concrete_capability` (
  `idConcrete_Capability` int(11) NOT NULL AUTO_INCREMENT,
  `idAbstract_Capability` int(11) DEFAULT NULL,
  `name` longtext,
  `provider` int(45) DEFAULT NULL,
  `ipWorkspace` longtext NOT NULL,
  `wpname` longtext NOT NULL,
  `state` set('active','unactive') NOT NULL DEFAULT 'unactive',
  `description` longtext,
  `classname` longtext,
  `jarfile` longblob,
  `deploystate` set('deployed','undeployed') NOT NULL DEFAULT 'undeployed',
  `agent` longtext,
  PRIMARY KEY (`idConcrete_Capability`),
  KEY `idABSTRACT_idx` (`idAbstract_Capability`),
  KEY `provider` (`provider`),
  KEY `provider_2` (`provider`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dump dei dati per la tabella `concrete_capability`
--

INSERT INTO `concrete_capability` (`idConcrete_Capability`, `idAbstract_Capability`, `name`, `provider`, `ipWorkspace`, `wpname`, `state`, `description`, `classname`, `jarfile`, `deploystate`, `agent`) VALUES
(7, 3, 'sadsa', 1, 'sadsa', 'sadsa', 'unactive', 'sadsa', 'test.Classe', 0x504b03041400080808007391754c000000000000000000000000140004004d4554412d494e462f4d414e49464553542e4d46feca0000f34dcccb4c4b2d2ed10d4b2d2acecccfb35230d433e0e5e2e50200504b0708b27f02ee1b00000019000000504b03041400080808004877754c000000000000000000000000430000006f72672f696361722f6d7573612f636f72652f72756e74696d655f656e746974792f436f6e63726574654361706162696c697479496e746572666163652e636c6173737d8e3d4e033110859f03c9427e24b8012534b8a1a58a84040d05119468d67a095ebc369a78035c8d8203702884575a41c714f3699e3433dfd7f7c727800b2c2a8c0c2e936eac77a2b6edb6625d525aed62f62d1f5990dfed3245a7cc5cca8bd43e94e83a66ea5a1c2bec1b1c35b2131b246eec6dddd0658359937c5c3d7145690df64ecfee0de681b2e36fb8d866d1fc90f4791dd2abc17139d9fa28997fd9946f745de64daacb70973a75bcf2810627ff489df73e1383f2187d8d8be31813f4aed5c083818703a73dcbc6acf411e63f504b07089b717ba3d000000025010000504b03041400080808007b7d754c00000000000000000000000011000000746573742f436c617373652e636c6173736d924b6fd34010c7ffdba6711e2e69d286164aa16979a4e5e10b12870097082450784889ca116ddc69bac1f656eb75a11f0b0e2071e003f0a110e362a5a9d883777667fef39b9d59fffef3f31780c778e86141a06e29b5413f92694a1e4a022b53792a83482693e0dd784aa1f5501678a6cd2450a134419ca53208b5a1c0648955317d2436f62ce8eb243464a92f4fe45845ec7a95583247322481f2539528fb5c60b1bb772050eaeb43aa6111751f1e2a028d814ae86d168fc98ce438e28cd64087323a9046e5e7c259b2c72a15581eccddbac74d4cb54a46c734221957d1c29a87d54b9d0ccf524bb18f36aef215746605da83f3b0d2c17ba3123bb486937b156c70e93764f5a1de9ea3d6701d373c6c0aac3ad27c6ce1a6807792bba284e1ddc15c71cbee492fefdb8f489e52c1aca0c3b8a2d67c801b4cad34f683369f8e22fdb982db026b85f05244a0c9238e55222d5da8ef096c14eaffa20235fa426166e9b51e57b0cf8442fa62e666cd506726a4972a1f7afddf9c1fe51da1031e207f4bfc0f95d9f2ebf15ae553c056b05ddaff81da57de2cc02f44ecc432af7eb1bf82065b7ea159f21356e7b1ea37345bebdf71ed025063cb0196d6e720d519e4961bb2ed803458da744276dc905d07a4cdd27527e48e1b72d701d964e99613d27543f61c900e4b779c90fbe7ca077f01504b0708dc89b295f0010000ec030000504b030414000008080056bf754cca74a5d59d000000180100000c0024006d616e69666573742e786d6c0a002000000000000100180000d48a2968c1d30100d48a2968c1d30100d48a2968c1d3014d8fd10e82300c457f85ec5da6f1411fca8821f10bf403cad690c5d111ba88febd4808eceddc73d3a685fad387e24da3f8c8953a95475510dbe83c77957a3eee87ab2a24213b0c91a9521c556da0c1015b1f7cface1cd98e94c880771b5f4067696e6eada4116d32e77fb32560ecc9083a41d00b830d28422691a4b25918f4eac00f531c5f32a0dd867205d390ef5b1360479cf26217a0f72375f6d50f504b010214001400080808007391754cb27f02ee1b000000190000001400240000000000000000000000000000004d4554412d494e462f4d414e49464553542e4d460a002000000000000100180000012fac37c1d301f0583ed5deb19d01f0583ed5deb19d01504b010214001400080808004877754c9b717ba3d0000000250100004300240000000000000000000000610000006f72672f696361722f6d7573612f636f72652f72756e74696d655f656e746974792f436f6e63726574654361706162696c697479496e746572666163652e636c6173730a0020000000000001001800004cdaa81cc1d301f0583ed5deb19d01f0583ed5deb19d01504b010214001400080808007b7d754cdc89b295f0010000ec0300001100240000000000000000000000a2010000746573742f436c617373652e636c6173730a002000000000000100180000f1d30823c1d301f0583ed5deb19d01f0583ed5deb19d01504b0102140014000008080056bf754cca74a5d59d000000180100000c00240000000000000000000000d10300006d616e69666573742e786d6c0a002000000000000100180000d48a2968c1d30100d48a2968c1d30100d48a2968c1d301504b05060000000004000400bc010000bc0400000000, 'deployed', 'sadsa');

-- --------------------------------------------------------

--
-- Struttura della tabella `domain`
--

CREATE TABLE IF NOT EXISTS `domain` (
  `idDomain` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `description` longtext,
  PRIMARY KEY (`idDomain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=50 ;

--
-- Dump dei dati per la tabella `domain`
--

INSERT INTO `domain` (`idDomain`, `name`, `description`) VALUES
(28, 'Cloud Application Mashup', ''),
(49, 'Media Shop', '');

--
-- Trigger `domain`
--
DROP TRIGGER IF EXISTS `triggerDomainCreate`;
DELIMITER //
CREATE TRIGGER `triggerDomainCreate` AFTER INSERT ON `domain`
 FOR EACH ROW BEGIN
INSERT INTO domain_configuration (idDomain,name,value,description,id_dom_conf_def)
SELECT NEW.idDomain,name,default_value,description,id_dom_conf_def FROM domain_conf_default;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `domain_assumption`
--

CREATE TABLE IF NOT EXISTS `domain_assumption` (
  `idAssumption` int(11) NOT NULL AUTO_INCREMENT,
  `idDomain` int(11) DEFAULT NULL,
  `name` longtext,
  `assumption` longtext,
  `description` longtext,
  PRIMARY KEY (`idAssumption`),
  KEY `FD1_idx` (`idDomain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Dump dei dati per la tabella `domain_assumption`
--

INSERT INTO `domain_assumption` (`idAssumption`, `idDomain`, `name`, `assumption`, `description`) VALUES
(14, 28, 'entities', 'role, document, url, failure_order,\r\nuser [is-a role],\r\nstorehouse_manager [is-a role],\r\norder [is-a document],\r\ninvoice [is-a document],\r\nuser_data [is-a document],\r\nregistration_form [is-a-document],\r\ndelivery_order [is-a order],\r\nrxfile [is-a URL]', ''),
(15, 28, 'unary user''s properties', 'registered,\r\nunregistered,\r\nhas_cloud_space', ''),
(16, 28, 'unary document''s properties', 'available, uploaded_on_cloud', ''),
(17, 28, 'unary order''s properties', 'accepted, refused, processed', ''),
(18, 28, 'unary user_data''s properties', 'complete, uncomplete', ''),
(19, 28, 'unary registration_form''s properties', 'complete, uncomplete', ''),
(20, 28, 'binary properties', 'notified(document,user),\r\nmailed_perm_link(document,user) [is-a notified]', ''),
(21, 28, 'Rules about the document', 'role(X) :- user(X) \r\nrole(X) :- storehouse_manager(X) \r\ndocument(X) :- order(X)\r\ndocument(X) :- invoice(X)\r\ndocument(X) :- user_data(X)\r\ndocument(X) :- registration_form(X)\r\norder(X) :- delivery_order(X)', ''),
(22, 28, 'Rules about the process', 'processed(X) :- accepted(X) & order(X) & sent(Y,Z) & delivery_order(Y) & storehouse_manager(Z)\r\nprocessed(X) :- refused(X) & order(X) & sent(failure_order,Y) & user(Y)', ''),
(23, 28, 'Rules about the notification', 'notified(X,Y) :- uploaded_on_cloud(X) & document(X) & has_cloud_space(Y) & user(Y)\r\nnotified(X,Y) :- mailed_perm_link(X,Y) & document(X) & user(Y)', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `domain_configuration`
--

CREATE TABLE IF NOT EXISTS `domain_configuration` (
  `idDomain_Configuration` int(11) NOT NULL AUTO_INCREMENT,
  `idDomain` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `value` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `id_dom_conf_def` int(11) NOT NULL,
  PRIMARY KEY (`idDomain_Configuration`),
  KEY `FDC_idx` (`idDomain`),
  KEY `id_dom_conf_def` (`id_dom_conf_def`,`name`,`description`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dump dei dati per la tabella `domain_configuration`
--

INSERT INTO `domain_configuration` (`idDomain_Configuration`, `idDomain`, `name`, `value`, `description`, `id_dom_conf_def`) VALUES
(1, 28, 'session', 'single', 'This parameter specifies if the applications, under this domain, are single sessions or a new session is created for each user request.', 1),
(22, 49, 'session', 'single', 'This parameter specifies if the applications, under this domain, are single sessions or a new session is created for each user request.', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `domain_conf_default`
--

CREATE TABLE IF NOT EXISTS `domain_conf_default` (
  `id_dom_conf_def` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `default_value` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_dom_conf_def`) USING BTREE,
  UNIQUE KEY `id_dom_conf_def` (`id_dom_conf_def`,`name`,`description`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dump dei dati per la tabella `domain_conf_default`
--

INSERT INTO `domain_conf_default` (`id_dom_conf_def`, `name`, `default_value`, `description`) VALUES
(1, 'session', 'single', 'This parameter specifies if the applications, under this domain, are single sessions or a new session is created for each user request.');

--
-- Trigger `domain_conf_default`
--
DROP TRIGGER IF EXISTS `triggerConfCreate`;
DELIMITER //
CREATE TRIGGER `triggerConfCreate` AFTER INSERT ON `domain_conf_default`
 FOR EACH ROW BEGIN
INSERT INTO domain_configuration (idDomain,name,value,description,id_dom_conf_def)
SELECT idDomain,NEW.name,NEW.default_value,NEW.description,NEW.id_dom_conf_def FROM domain;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `functional_req`
--

CREATE TABLE IF NOT EXISTS `functional_req` (
  `idFunctional_Req` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `type` longtext,
  `description` longtext,
  `priority` tinytext,
  `current_state` set('activated','deactivated','waiting') DEFAULT 'waiting',
  `body` longtext,
  `actors` longtext,
  `idWF` int(11) DEFAULT NULL,
  `idSpecification` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFunctional_Req`),
  KEY `idSpec_idx` (`idSpecification`),
  KEY `idWf_idx` (`idWF`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=383 ;

--
-- Dump dei dati per la tabella `functional_req`
--

INSERT INTO `functional_req` (`idFunctional_Req`, `name`, `type`, `description`, `priority`, `current_state`, `body`, `actors`, `idWF`, `idSpecification`) VALUES
(230, 'to_handle_order', 'manual', '', '0', 'deactivated', '( WHEN MESSAGE Doc RECEIVED FROM THE Client ROLE AND order(Doc) AND user(Client) ) -> F (processed(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(231, 'to_wait_order', 'manual', '', '0', 'waiting', '( WHEN MESSAGE Doc RECEIVED FROM THE Client ROLE AND order(Doc) AND user(Client) ) -> F (available(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(232, 'to_process_order', 'manual', '', '0', 'waiting', '( WHEN available(Doc) AND order(Doc) AND registered(Client) AND user(Client) ) -> F (processed(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(233, 'to_process_accepted_order', 'manual', '', '0', 'waiting', '( WHEN accepted(X) AND order(X) ) -> F (MESSAGE U SENT TO THE Z ROLE AND delivery_order(U) AND storehouse_manager(Z))', 'THE SYSTEM', NULL, 21),
(234, 'to_notify_invoice', 'manual', '', '0', 'waiting', '( WHEN accepted(X) AND order(X) AND registered(Y) AND user(Y) ) -> F (MESSAGE invoice SENT TO THE Client ROLE AND user(Client))', 'THE SYSTEM', NULL, 21),
(235, 'to_deliver_order', 'manual', '', '0', 'waiting', '( WHEN MESSAGE Doc SENT TO THE Client ROLE AND invoice(Doc) AND user(Client) ) -> F (MESSAGE Deliv SENT TO THE SM ROLE AND delivery_order(Deliv) AND storehouse_manager(SM))', 'THE SYSTEM', NULL, 21),
(236, 'to_notify_failure', 'manual', '', '0', 'activated', '( WHEN refused(X) AND order(X) AND registered(Y) AND user(Y) ) -> F (MESSAGE failure_order SENT TO THE Client ROLE AND user(Client))', 'THE SYSTEM', NULL, 21),
(353, 'Manage\nInternet Shop', 'generated', 'Manage Internet Shop', '1', 'activated', 'Manage Internet Shop', 'Manage Internet Shop', NULL, 25),
(354, 'Update\nCatalogue', 'generated', 'Update Catalogue', '1', 'activated', 'Update Catalogue', 'Update Catalogue', NULL, 25),
(355, 'Adaption', 'generated', 'Adaption', '1', 'activated', 'Adaption', 'Adaption', NULL, 25),
(356, 'Manage\nItem Searching', 'generated', 'Manage Item Searching', '0', 'activated', 'Manage Item Searching', 'Manage Item Searching', NULL, 25),
(357, 'Manage\nInternet Orders', 'generated', 'Manage Internet Orders', '1', 'activated', 'Manage Internet Orders', 'Manage Internet Orders', NULL, 25),
(358, 'Produce\nStatistics', 'generated', 'Produce Statistics', '1', 'activated', 'Produce Statistics', 'Produce Statistics', NULL, 25),
(359, 'Update\nGUI', 'generated', 'Update GUI', '1', 'activated', 'Update GUI', 'Update GUI', NULL, 25),
(360, 'System\nEvolution', 'generated', 'System Evolution', '1', 'activated', 'System Evolution', 'System Evolution', NULL, 25),
(361, 'DB\nQuering', 'generated', 'DB Quering', '1', 'activated', 'DB Quering', 'DB Quering', NULL, 25),
(362, 'Catalogue\nConsulting', 'generated', 'Catalogue Consulting', '1', 'activated', 'Catalogue Consulting', 'Catalogue Consulting', NULL, 25),
(363, 'Monitoring\nSystem', 'generated', 'Monitoring System', '1', 'activated', 'Monitoring System', 'Monitoring System', NULL, 25),
(364, 'Add Item', 'generated', 'Add Item', '1', 'activated', 'Add Item', 'Add Item', NULL, 25),
(365, 'Get Identification\nDetails', 'generated', 'Get Identification Details', '1', 'activated', 'Get Identification Details', 'Get Identification Details', NULL, 25),
(370, 'Shopping\nCart', 'generated', 'Shopping Cart', '1', 'activated', 'Shopping Cart', 'Shopping Cart', NULL, 25),
(371, 'Select Items', 'generated', 'Select Items', '1', 'activated', 'Select Items', 'Select Items', NULL, 25),
(372, 'Check Out', 'generated', 'Check Out', '1', 'activated', 'Check Out', 'Check Out', NULL, 25),
(373, 'Classic Communication\nHandled', 'generated', 'Get Identification Details', '1', 'activated', 'Get Identification Details', 'Get Identification Details', NULL, 25),
(374, 'Pre-Order\nnon avaiable Item', 'generated', 'Pre-Order non avaiable Item', '1', 'activated', 'Pre-Order non avaiable Item', 'Pre-Order non avaiable Item', NULL, 25),
(375, 'Internet\nManaged', 'generated', 'Internet Managed', '1', 'activated', 'Internet Managed', 'Internet Managed', NULL, 25),
(376, 'Pick Avaiable\nitem', 'generated', 'Pick Avaiable item', '1', 'activated', 'Pick Avaiable item', 'Pick Avaiable item', NULL, 25),
(377, 'Standard\nForm Order', 'generated', 'Standard From Order', '1', 'activated', 'Standard From Order', 'Standard From Order', NULL, 25),
(378, 'Perform\nPrivacy Control', 'generated', 'Perform Privacy Control', '1', 'activated', 'Perform Privacy Control', 'Perform Privacy Control', NULL, 25),
(379, 'Secure\nForm Order', 'generated', 'Secure From Order', '1', 'activated', 'Secure From Order', 'Secure From Order', NULL, 25),
(380, 'Check\nAccess Control', 'generated', 'Check Access Control', '1', 'activated', 'Check Access Control', 'Check Access Control', NULL, 25),
(381, 'Check\nInformation Flow', 'generated', 'Check Information Flow', '1', 'activated', 'Check Information Flow', 'Check Information Flow', NULL, 25),
(382, 'Check\nAuthentication', 'generated', 'Check Authentication', '1', 'activated', 'Check Authentication', 'Check Authentication', NULL, 25);

-- --------------------------------------------------------

--
-- Struttura della tabella `functional_req_relations`
--

CREATE TABLE IF NOT EXISTS `functional_req_relations` (
  `idFunc_Req_rel` int(11) NOT NULL AUTO_INCREMENT,
  `id_start` int(11) DEFAULT NULL,
  `id_end` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `id_spec` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `id_start_quality` int(11) DEFAULT NULL,
  `id_end_quality` int(11) DEFAULT NULL,
  `id_show_start` text,
  `id_show_end` text,
  `mangen` enum('manual','generated','','') NOT NULL,
  `type_objects` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFunc_Req_rel`),
  KEY `start` (`id_start`),
  KEY `end` (`id_end`),
  KEY `spec` (`id_spec`),
  KEY `type` (`type`),
  KEY `id_start_quality` (`id_start_quality`),
  KEY `id_end_quality` (`id_end_quality`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=481 ;

--
-- Dump dei dati per la tabella `functional_req_relations`
--

INSERT INTO `functional_req_relations` (`idFunc_Req_rel`, `id_start`, `id_end`, `type`, `id_spec`, `name`, `id_start_quality`, `id_end_quality`, `id_show_start`, `id_show_end`, `mangen`, `type_objects`) VALUES
(4, 230, 232, 3, 21, 'aaa', NULL, NULL, '0', '0', 'generated', 0),
(442, 370, 357, 3, 25, NULL, NULL, NULL, 'Shopping\nCart (Goal)', 'Manage\nInternet Orders (Goal)', 'generated', NULL),
(443, 377, NULL, 4, 25, NULL, NULL, 6, 'Standard\nForm Order (Goal)', 'Privacy (Quality)', 'generated', NULL),
(444, 379, NULL, 3, 25, NULL, NULL, 6, 'Secure\nForm Order (Goal)', 'Privacy (Quality)', 'generated', NULL),
(445, NULL, NULL, 3, 25, NULL, 6, 7, 'Privacy (Quality)', 'Security (Quality)', 'generated', NULL),
(446, 378, NULL, 3, 25, NULL, NULL, 6, 'Perform\nPrivacy Control (Goal)', 'Privacy (Quality)', 'generated', NULL),
(447, 382, 378, 3, 25, NULL, NULL, NULL, 'Check\nAuthentication (Goal)', 'Perform\nPrivacy Control (Goal)', 'generated', NULL),
(448, 381, 378, 3, 25, NULL, NULL, NULL, 'Check\nInformation Flow (Goal)', 'Perform\nPrivacy Control (Goal)', 'generated', NULL),
(449, 380, 378, 3, 25, NULL, NULL, NULL, 'Check\nAccess Control (Goal)', 'Perform\nPrivacy Control (Goal)', 'generated', NULL),
(450, NULL, NULL, 3, 25, NULL, 7, 11, 'Security (Quality)', 'Usability (Quality)', 'generated', NULL),
(451, NULL, NULL, 3, 25, NULL, 10, 11, 'Easy to Use (Quality)', 'Usability (Quality)', 'generated', NULL),
(452, NULL, NULL, 3, 25, NULL, 8, 7, 'Integrity (Quality)', 'Security (Quality)', 'generated', NULL),
(453, NULL, NULL, 3, 25, NULL, 12, 7, 'Availability (Quality)', 'Security (Quality)', 'generated', NULL),
(454, NULL, NULL, 3, 25, NULL, 9, 11, 'Adaptability (Quality)', 'Usability (Quality)', 'generated', NULL),
(455, 361, NULL, 4, 25, NULL, NULL, 10, 'DB\nQuering (Goal)', 'Easy to Use (Quality)', 'generated', NULL),
(456, 362, NULL, 3, 25, NULL, NULL, 10, 'Catalogue\nConsulting (Goal)', 'Easy to Use (Quality)', 'generated', NULL),
(457, 361, NULL, 4, 25, NULL, NULL, 8, 'DB\nQuering (Goal)', 'Integrity (Quality)', 'generated', NULL),
(458, 363, NULL, 4, 25, NULL, NULL, 8, 'Monitoring\nSystem (Goal)', 'Integrity (Quality)', 'generated', NULL),
(459, 359, NULL, 3, 25, NULL, NULL, 12, 'Update\nGUI (Goal)', 'Availability (Quality)', 'generated', NULL),
(460, 355, NULL, 3, 25, NULL, NULL, 9, 'Adaption (Goal)', 'Adaptability (Quality)', 'generated', NULL),
(461, 353, 357, 1, 25, NULL, NULL, NULL, 'Manage\nInternet Shop (Goal)', 'Manage\nInternet Orders (Goal)', 'generated', NULL),
(462, 353, 356, 1, 25, NULL, NULL, NULL, 'Manage\nInternet Shop (Goal)', 'Manage\nItem Searching (Goal)', 'generated', NULL),
(463, 353, 358, 1, 25, NULL, NULL, NULL, 'Manage\nInternet Shop (Goal)', 'Produce\nStatistics (Goal)', 'generated', NULL),
(464, 353, 355, 1, 25, NULL, NULL, NULL, 'Manage\nInternet Shop (Goal)', 'Adaption (Goal)', 'generated', NULL),
(465, 356, 362, 2, 25, NULL, NULL, NULL, 'Manage\nItem Searching (Goal)', 'Catalogue\nConsulting (Goal)', 'generated', NULL),
(466, 356, 361, 2, 25, NULL, NULL, NULL, 'Manage\nItem Searching (Goal)', 'DB\nQuering (Goal)', 'generated', NULL),
(467, 355, 360, 1, 25, NULL, NULL, NULL, 'Adaption (Goal)', 'System\nEvolution (Goal)', 'generated', NULL),
(468, 355, 354, 1, 25, NULL, NULL, NULL, 'Adaption (Goal)', 'Update\nCatalogue (Goal)', 'generated', NULL),
(469, 355, 363, 1, 25, NULL, NULL, NULL, 'Adaption (Goal)', 'Monitoring\nSystem (Goal)', 'generated', NULL),
(470, 355, 359, 1, 25, NULL, NULL, NULL, 'Adaption (Goal)', 'Update\nGUI (Goal)', 'generated', NULL),
(471, 370, 364, 1, 25, NULL, NULL, NULL, 'Shopping\nCart (Goal)', 'Add Item (Goal)', 'generated', NULL),
(472, 370, 371, 1, 25, NULL, NULL, NULL, 'Shopping\nCart (Goal)', 'Select Items (Goal)', 'generated', NULL),
(473, 370, 365, 1, 25, NULL, NULL, NULL, 'Shopping\nCart (Goal)', 'Get Identification\nDetails (Goal)', 'generated', NULL),
(474, 370, 372, 1, 25, NULL, NULL, NULL, 'Shopping\nCart (Goal)', 'Check Out (Goal)', 'generated', NULL),
(475, 365, 373, 2, 25, NULL, NULL, NULL, 'Get Identification\nDetails (Goal)', 'Classic Communication\nHandled (Goal)', 'generated', NULL),
(476, 365, 375, 2, 25, NULL, NULL, NULL, 'Get Identification\nDetails (Goal)', 'Internet\nManaged (Goal)', 'generated', NULL),
(477, 375, 379, 2, 25, NULL, NULL, NULL, 'Internet\nManaged (Goal)', 'Secure\nForm Order (Goal)', 'generated', NULL),
(478, 375, 377, 2, 25, NULL, NULL, NULL, 'Internet\nManaged (Goal)', 'Standard\nForm Order (Goal)', 'generated', NULL),
(479, 371, 376, 2, 25, NULL, NULL, NULL, 'Select Items (Goal)', 'Pick Avaiable\nitem (Goal)', 'generated', NULL),
(480, 371, 374, 2, 25, NULL, NULL, NULL, 'Select Items (Goal)', 'Pre-Order\nnon avaiable Item (Goal)', 'generated', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `general_configuration`
--

CREATE TABLE IF NOT EXISTS `general_configuration` (
  `idGeneral_Configuration` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `value` longtext,
  `description` longtext,
  PRIMARY KEY (`idGeneral_Configuration`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dump dei dati per la tabella `general_configuration`
--

INSERT INTO `general_configuration` (`idGeneral_Configuration`, `name`, `value`, `description`) VALUES
(7, 'IP_WORKFLOW_EDITOR', 'aose.pa.icar.cnr.it', 'Ip Address of the server where the Workflow Editor is installed.'),
(20, 'PORT_WORKFLOW_EDITOR', '8080', 'Port of Workflow Editor'),
(23, 'APACHEMQ IP ADDRESS', 'localhost', 'Address of the server where ApacheMQ is installed - MUSA GUI and MUSA communicate asynchronously by using Apache MQ'),
(24, 'APACHEMQ SOCKET PORT', '61616', 'Port of ApacheMQ server');

-- --------------------------------------------------------

--
-- Struttura della tabella `goalModel`
--

CREATE TABLE IF NOT EXISTS `goalModel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json` longblob NOT NULL,
  `name` longtext NOT NULL,
  `idSpec` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idSpec` (`idSpec`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `goalModel`
--

INSERT INTO `goalModel` (`id`, `json`, `name`, `idSpec`) VALUES
(2, 0x7b2263656c6c73223a5b7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3131382e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a3339362e302c2279223a352e333239303730353138323030373531452d31337d2c22616e676c65223a302e302c226964223a2237336533366536612d363363332d343462372d383764372d386562653639376239323339222c227a223a312e302c226174747273223a7b2274657874223a7b2274657874223a224d616e6167655c6e496e7465726e65742053686f70227d2c222e626f6479223a7b2274657874223a224d616e61676520496e7465726e65742053686f70227d2c222e6465736372697074696f6e223a7b2274657874223a224d616e61676520496e7465726e65742053686f70227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a224d616e61676520496e7465726e65742053686f70227d2c222e69644442223a7b2274657874223a22333533227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3130342e302c22686569676874223a36332e37357d2c22706f736974696f6e223a7b2278223a3938312e302c2279223a3333302e3632357d2c22616e676c65223a302e302c226964223a2266643464323463382d366232302d343266642d623231302d636330316536633634373665222c227a223a322e302c226174747273223a7b2274657874223a7b2274657874223a225570646174655c6e436174616c6f677565227d2c222e626f6479223a7b2274657874223a2255706461746520436174616c6f677565227d2c222e6465736372697074696f6e223a7b2274657874223a2255706461746520436174616c6f677565227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2255706461746520436174616c6f677565227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333534227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39312e302c22686569676874223a34332e3939393939393939393939383436357d2c22706f736974696f6e223a7b2278223a3731372e302c2279223a3234342e35303030303030303030303132327d2c22616e676c65223a302e302c226964223a2265613632393065652d636537652d346334302d386562322d306634643139343132373939222c227a223a332e302c226174747273223a7b2274657874223a7b2274657874223a224164617074696f6e227d2c222e626f6479223a7b2274657874223a224164617074696f6e227d2c222e6465736372697074696f6e223a7b2274657874223a224164617074696f6e227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a224164617074696f6e227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333535227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3131352e302c22686569676874223a36342e39393939393939393939393937327d2c22706f736974696f6e223a7b2278223a3336372e302c2279223a3230382e307d2c22616e676c65223a302e302c226964223a2237633763656230622d353764392d343336322d386661352d373164393531396638326432222c227a223a342e302c226174747273223a7b2274657874223a7b2274657874223a224d616e6167655c6e4974656d20536561726368696e67227d2c222e626f6479223a7b2274657874223a224d616e616765204974656d20536561726368696e67227d2c222e6465736372697074696f6e223a7b2274657874223a224d616e616765204974656d20536561726368696e67227d2c222e6163746f7273223a7b2274657874223a224d616e616765204974656d20536561726368696e67227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333536227d2c222e7072696f72697479223a7b7d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3131372e302c22686569676874223a35342e34393939393939393939393837357d2c22706f736974696f6e223a7b2278223a3236302e302c2279223a3135332e35303030303030303030303132357d2c22616e676c65223a302e302c226964223a2235366462373962382d323161642d343533312d393730392d383262616565306530643131222c227a223a352e302c226174747273223a7b2274657874223a7b2274657874223a224d616e6167655c6e496e7465726e6574204f7264657273227d2c222e626f6479223a7b2274657874223a224d616e61676520496e7465726e6574204f7264657273227d2c222e6465736372697074696f6e223a7b2274657874223a224d616e61676520496e7465726e6574204f7264657273227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a224d616e61676520496e7465726e6574204f7264657273227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333537227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39362e302c22686569676874223a35372e35303030303030303030303032337d2c22706f736974696f6e223a7b2278223a3531302e302c2279223a3231352e34393939393939393939393937377d2c22616e676c65223a302e302c226964223a2236636334383964662d613863342d343732662d383130392d353831636664326432353231222c227a223a362e302c226174747273223a7b2274657874223a7b2274657874223a2250726f647563655c6e53746174697374696373227d2c222e626f6479223a7b2274657874223a2250726f647563652053746174697374696373227d2c222e6465736372697074696f6e223a7b2274657874223a2250726f647563652053746174697374696373227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2250726f647563652053746174697374696373227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333538227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39312e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a313035392e302c2279223a3633372e313739323435323833303138397d2c22616e676c65223a302e302c226964223a2239623861656461332d623332642d346430332d393132332d303363653232326636623939222c227a223a372e302c226174747273223a7b2274657874223a7b2274657874223a225570646174655c6e475549227d2c222e626f6479223a7b2274657874223a2255706461746520475549227d2c222e6465736372697074696f6e223a7b2274657874223a2255706461746520475549227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2255706461746520475549227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333539227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39312e302c22686569676874223a36342e39393939393939393939393937327d2c22706f736974696f6e223a7b2278223a3933362e302c2279223a3233342e303030303030303030303030367d2c22616e676c65223a302e302c226964223a2234656262653537652d383431352d343736302d626664312d653932633763616433643930222c227a223a382e302c226174747273223a7b2274657874223a7b2274657874223a2253797374656d5c6e45766f6c7574696f6e227d2c222e626f6479223a7b2274657874223a2253797374656d2045766f6c7574696f6e227d2c222e6465736372697074696f6e223a7b2274657874223a2253797374656d2045766f6c7574696f6e227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2253797374656d2045766f6c7574696f6e227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333630227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a38322e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a3338332e352c2279223a3435352e307d2c22616e676c65223a302e302c226964223a2238663934383832632d353365322d346437612d613463382d653134666564383330343339222c227a223a392e302c226174747273223a7b2274657874223a7b2274657874223a2244425c6e51756572696e67227d2c222e626f6479223a7b2274657874223a2244422051756572696e67227d2c222e6465736372697074696f6e223a7b2274657874223a2244422051756572696e67227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2244422051756572696e67227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333631227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3131312e302c22686569676874223a37322e357d2c22706f736974696f6e223a7b2278223a3630362e302c2279223a3332312e3837357d2c22616e676c65223a302e302c226964223a2232393839616535302d613733362d343930382d613438352d363136383936386330303133222c227a223a31302e302c226174747273223a7b2274657874223a7b2274657874223a22436174616c6f6775655c6e436f6e73756c74696e67227d2c222e626f6479223a7b2274657874223a22436174616c6f67756520436f6e73756c74696e67227d2c222e6465736372697074696f6e223a7b2274657874223a22436174616c6f67756520436f6e73756c74696e67227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22436174616c6f67756520436f6e73756c74696e67227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333632227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39302e302c22686569676874223a36312e38333936323236343135303935357d2c22706f736974696f6e223a7b2278223a3935302e302c2279223a3438342e31363033373733353834393034357d2c22616e676c65223a302e302c226964223a2234343031663339372d373532312d343733332d396535662d643563323336303831386466222c227a223a31312e302c226174747273223a7b2274657874223a7b2274657874223a224d6f6e69746f72696e675c6e53797374656d227d2c222e626f6479223a7b2274657874223a224d6f6e69746f72696e672053797374656d227d2c222e6465736372697074696f6e223a7b2274657874223a224d6f6e69746f72696e672053797374656d227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a224d6f6e69746f72696e672053797374656d227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333633227d7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a3431352e302c2279223a39372e307d2c22616e676c65223a302e302c226964223a2261643762666663392d396561382d343266342d383333632d666465333631616635613139222c227a223a31322e302c226174747273223a7b2274657874223a7b2274657874223a22414e44227d2c22696e4c696e6b73223a7b2230223a2237336533366536612d363363332d343462372d383764372d386562653639376239323339227d2c226f75744c696e6b73223a7b2230223a2235366462373962382d323161642d343533312d393730392d383262616565306530643131222c2231223a2237633763656230622d353764392d343336322d386661352d373164393531396638326432222c2232223a2236636334383964662d613863342d343732662d383130392d353831636664326432353231222c2233223a2265613632393065652d636537652d346334302d386562322d306634643139343132373939227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2237336533366536612d363363332d343462372d383764372d386562653639376239323339227d2c22746172676574223a7b226964223a2261643762666663392d396561382d343266342d383333632d666465333631616635613139227d2c226964223a2264346136346234632d343062622d343837662d626431662d393137643931323132323763222c227a223a31332e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261643762666663392d396561382d343266342d383333632d666465333631616635613139227d2c22746172676574223a7b226964223a2235366462373962382d323161642d343533312d393730392d383262616565306530643131227d2c226964223a2263336233333264352d373531352d343861332d386638622d393262643363663132383339222c227a223a31342e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261643762666663392d396561382d343266342d383333632d666465333631616635613139227d2c22746172676574223a7b226964223a2237633763656230622d353764392d343336322d386661352d373164393531396638326432227d2c226964223a2236383064376462612d363362312d343332332d386164312d646563333966313561323363222c227a223a31352e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261643762666663392d396561382d343266342d383333632d666465333631616635613139227d2c22746172676574223a7b226964223a2236636334383964662d613863342d343732662d383130392d353831636664326432353231227d2c226964223a2236633963353662652d326136342d343362322d393535662d343364393466626662373832222c227a223a31362e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261643762666663392d396561382d343266342d383333632d666465333631616635613139227d2c22746172676574223a7b226964223a2265613632393065652d636537652d346334302d386562322d306634643139343132373939227d2c226964223a2233363263313637392d373164362d346565362d623165382d656133643537353262636432222c227a223a31372e302c226174747273223a7b7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a3338342e352c2279223a3331342e3337357d2c22616e676c65223a302e302c226964223a2264386232663635622d666165622d343530342d386137632d666366313130633161626265222c227a223a31382e302c226174747273223a7b2274657874223a7b2274657874223a224f52227d2c22696e4c696e6b73223a7b2230223a2237633763656230622d353764392d343336322d386661352d373164393531396638326432227d2c226f75744c696e6b73223a7b2230223a2232393839616535302d613733362d343930382d613438352d363136383936386330303133222c2231223a2238663934383832632d353365322d346437612d613463382d653134666564383330343339227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2237633763656230622d353764392d343336322d386661352d373164393531396638326432227d2c22746172676574223a7b226964223a2264386232663635622d666165622d343530342d386137632d666366313130633161626265227d2c226964223a2235643239653766372d623066332d343433642d613865352d386661306339343139306236222c227a223a31392e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2264386232663635622d666165622d343530342d386137632d666366313130633161626265227d2c22746172676574223a7b226964223a2232393839616535302d613733362d343930382d613438352d363136383936386330303133227d2c226964223a2239616332353530302d393866312d343965352d383538632d373131343562396561316330222c227a223a32302e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2264386232663635622d666165622d343530342d386137632d666366313130633161626265227d2c22746172676574223a7b226964223a2238663934383832632d353365322d346437612d613463382d653134666564383330343339227d2c226964223a2237653039363437642d313533372d346362382d386566342d343134343137623739326430222c227a223a32312e302c226174747273223a7b7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a3834352e302c2279223a3332302e307d2c22616e676c65223a302e302c226964223a2261656364383237352d636131372d343330392d623362342d343061323733623365316238222c227a223a32322e302c226174747273223a7b2274657874223a7b2274657874223a22414e44227d2c22696e4c696e6b73223a7b2230223a2265613632393065652d636537652d346334302d386562322d306634643139343132373939227d2c226f75744c696e6b73223a7b2230223a2234656262653537652d383431352d343736302d626664312d653932633763616433643930222c2231223a2266643464323463382d366232302d343266642d623231302d636330316536633634373665222c2232223a2234343031663339372d373532312d343733332d396535662d643563323336303831386466222c2233223a2239623861656461332d623332642d346430332d393132332d303363653232326636623939227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265613632393065652d636537652d346334302d386562322d306634643139343132373939227d2c22746172676574223a7b226964223a2261656364383237352d636131372d343330392d623362342d343061323733623365316238227d2c226964223a2264343531316437642d343163612d343231312d386538352d336437306337363562363763222c227a223a32332e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261656364383237352d636131372d343330392d623362342d343061323733623365316238227d2c22746172676574223a7b226964223a2234656262653537652d383431352d343736302d626664312d653932633763616433643930227d2c226964223a2262393037306165372d366336342d346638342d623466632d626362303135316566363539222c227a223a32342e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261656364383237352d636131372d343330392d623362342d343061323733623365316238227d2c22746172676574223a7b226964223a2266643464323463382d366232302d343266642d623231302d636330316536633634373665227d2c226964223a2237376339353362652d323763612d343237322d613963362d653964313861636361313930222c227a223a32352e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261656364383237352d636131372d343330392d623362342d343061323733623365316238227d2c22746172676574223a7b226964223a2234343031663339372d373532312d343733332d396535662d643563323336303831386466227d2c226964223a2234323561663963312d616436392d346135662d616531352d326534306337373734653462222c227a223a32362e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2261656364383237352d636131372d343330392d623362342d343061323733623365316238227d2c22746172676574223a7b226964223a2239623861656461332d623332642d346430332d393132332d303363653232326636623939227d2c226964223a2236373935303863352d646166622d346661362d386237612d666566363539343931633562222c227a223a32372e302c227665727469636573223a5b7b2278223a313130352e302c2279223a3438312e307d5d2c226174747273223a7b7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3130342e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a2d35372e302c2279223a3338322e307d2c22616e676c65223a302e302c226964223a2234363235343038352d653636632d343666302d393033322d663131666631623465346134222c227a223a32382e302c226174747273223a7b2274657874223a7b2274657874223a22416464204974656d227d2c222e626f6479223a7b2274657874223a22416464204974656d227d2c222e6465736372697074696f6e223a7b2274657874223a22416464204974656d227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22416464204974656d227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333634227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3131382e30303030303030303030303030372c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a36382e39393939393939393939393939372c2279223a3530372e307d2c22616e676c65223a302e302c226964223a2233393036346531632d646233322d343231342d383865362d636235313835646635373066222c227a223a32392e302c226174747273223a7b2274657874223a7b2274657874223a22476574204964656e74696669636174696f6e5c6e44657461696c73227d2c222e626f6479223a7b2274657874223a22476574204964656e74696669636174696f6e2044657461696c73227d2c222e6465736372697074696f6e223a7b2274657874223a22476574204964656e74696669636174696f6e2044657461696c73227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22476574204964656e74696669636174696f6e2044657461696c73227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333635227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a37382e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a38392e302c2279223a3235352e307d2c22616e676c65223a302e302c226964223a2266353639333761352d626162372d343834312d613039662d323533613634656664663564222c227a223a33342e302c226174747273223a7b2274657874223a7b2274657874223a2253686f7070696e675c6e43617274227d2c222e626f6479223a7b2274657874223a2253686f7070696e672043617274227d2c222e6465736372697074696f6e223a7b2274657874223a2253686f7070696e672043617274227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2253686f7070696e672043617274227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333730227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3130342e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a2d37322e302c2279223a3532302e307d2c22616e676c65223a302e302c226964223a2263343434626436312d393161362d343131662d396166342d313735306330613861646132222c227a223a33352e302c226174747273223a7b2274657874223a7b2274657874223a2253656c656374204974656d73227d2c222e626f6479223a7b2274657874223a2253656c656374204974656d73227d2c222e6465736372697074696f6e223a7b2274657874223a2253656c656374204974656d73227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a2253656c656374204974656d73227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333731227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a38322e30303030303030303030303030362c22686569676874223a35322e307d2c22706f736974696f6e223a7b2278223a3233332e39393939393939393939393939372c2279223a3338382e357d2c22616e676c65223a302e302c226964223a2266323164633263362d626333312d343861612d393762362d323732333061633231373364222c227a223a33362e302c226174747273223a7b2274657874223a7b2274657874223a22436865636b204f7574227d2c222e626f6479223a7b2274657874223a22436865636b204f7574227d2c222e6465736372697074696f6e223a7b2274657874223a22436865636b204f7574227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22436865636b204f7574227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333732227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2266353639333761352d626162372d343834312d613039662d323533613634656664663564227d2c22746172676574223a7b226964223a2235366462373962382d323161642d343533312d393730392d383262616565306530643131227d2c226964223a2238616538386561382d646338662d346466632d623731372d633165393336373032633838222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a33382e302c226174747273223a7b7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a38382e302c2279223a3337342e357d2c22616e676c65223a302e302c226964223a2265623635356639302d393161652d343864642d613932362d633063333433376362626239222c227a223a33392e302c226174747273223a7b2274657874223a7b2274657874223a22414e44227d2c22696e4c696e6b73223a7b2230223a2266353639333761352d626162372d343834312d613039662d323533613634656664663564227d2c226f75744c696e6b73223a7b2230223a2234363235343038352d653636632d343666302d393033322d663131666631623465346134222c2231223a2263343434626436312d393161362d343131662d396166342d313735306330613861646132222c2232223a2233393036346531632d646233322d343231342d383865362d636235313835646635373066222c2233223a2266323164633263362d626333312d343861612d393762362d323732333061633231373364227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2266353639333761352d626162372d343834312d613039662d323533613634656664663564227d2c22746172676574223a7b226964223a2265623635356639302d393161652d343864642d613932362d633063333433376362626239227d2c226964223a2237623635613264392d626536632d346531382d613066642d353535323264653033643235222c227a223a34302e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265623635356639302d393161652d343864642d613932362d633063333433376362626239227d2c22746172676574223a7b226964223a2234363235343038352d653636632d343666302d393033322d663131666631623465346134227d2c226964223a2262323361653433612d366339312d346666622d616666322d663832353762636562616333222c227a223a34312e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265623635356639302d393161652d343864642d613932362d633063333433376362626239227d2c22746172676574223a7b226964223a2263343434626436312d393161362d343131662d396166342d313735306330613861646132227d2c226964223a2236306563623130632d333964382d343366622d383534612d303039333765636364643933222c227a223a34322e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265623635356639302d393161652d343864642d613932362d633063333433376362626239227d2c22746172676574223a7b226964223a2233393036346531632d646233322d343231342d383865362d636235313835646635373066227d2c226964223a2233396564383232642d613230312d343233332d393239622d396366643465393438326466222c227a223a34332e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265623635356639302d393161652d343864642d613932362d633063333433376362626239227d2c22746172676574223a7b226964223a2266323164633263362d626333312d343861612d393762362d323732333061633231373364227d2c226964223a2237663334306230622d366563302d346533342d623130392d646339343462346232306165222c227a223a34342e302c226174747273223a7b7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3136392e302c22686569676874223a37382e307d2c22706f736974696f6e223a7b2278223a2d35322e302c2279223a3732312e357d2c22616e676c65223a302e302c226964223a2266643734646435632d356134312d343762342d626562362d376134383962626332613632222c227a223a34352e302c226174747273223a7b2274657874223a7b2274657874223a22436c617373696320436f6d6d756e69636174696f6e5c6e48616e646c6564227d2c222e626f6479223a7b2274657874223a22476574204964656e74696669636174696f6e2044657461696c73227d2c222e6465736372697074696f6e223a7b2274657874223a22476574204964656e74696669636174696f6e2044657461696c73227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22476574204964656e74696669636174696f6e2044657461696c73227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333733227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3133302e302c22686569676874223a38342e357d2c22706f736974696f6e223a7b2278223a2d38332e302c2279223a3630372e307d2c22616e676c65223a302e302c226964223a2234653834646463312d316232302d343934382d383130342d366461356133336164363565222c227a223a34362e302c226174747273223a7b2274657874223a7b2274657874223a225072652d4f726465725c6e6e6f6e206176616961626c65204974656d227d2c222e626f6479223a7b2274657874223a225072652d4f72646572206e6f6e206176616961626c65204974656d227d2c222e6465736372697074696f6e223a7b2274657874223a225072652d4f72646572206e6f6e206176616961626c65204974656d227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a225072652d4f72646572206e6f6e206176616961626c65204974656d227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333734227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39332e30303030303030303030303031372c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a3136362e39393939393939393939393938332c2279223a3732382e307d2c22616e676c65223a302e302c226964223a2231356563636265612d306634632d343561392d623335632d626535363465396361353438222c227a223a34372e302c226174747273223a7b2274657874223a7b2274657874223a22496e7465726e65745c6e4d616e61676564227d2c222e626f6479223a7b2274657874223a22496e7465726e6574204d616e61676564227d2c222e6465736372697074696f6e223a7b2274657874223a22496e7465726e6574204d616e61676564227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22496e7465726e6574204d616e61676564227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333735227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3130342e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a2d3231322e302c2279223a3635362e357d2c22616e676c65223a302e302c226964223a2239333336656432632d613836332d346361362d613330382d313762393764333436336537222c227a223a34382e302c226174747273223a7b2274657874223a7b2274657874223a225069636b204176616961626c655c6e6974656d227d2c222e626f6479223a7b2274657874223a225069636b204176616961626c65206974656d227d2c222e6465736372697074696f6e223a7b2274657874223a225069636b204176616961626c65206974656d227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a225069636b204176616961626c65206974656d227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333736227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39362e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a3430372e302c2279223a3836302e357d2c22616e676c65223a302e302c226964223a2265666335323932652d646462612d343862342d613365342d343832363236356664646132222c227a223a34392e302c226174747273223a7b2274657874223a7b2274657874223a225374616e646172645c6e466f726d204f72646572227d2c222e626f6479223a7b2274657874223a225374616e646172642046726f6d204f72646572227d2c222e6465736372697074696f6e223a7b2274657874223a225374616e646172642046726f6d204f72646572227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a225374616e646172642046726f6d204f72646572227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333737227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3131382e302c22686569676874223a36352e307d2c22706f736974696f6e223a7b2278223a3339362e302c2279223a313132362e307d2c22616e676c65223a302e302c226964223a2263656538353737612d323535312d346130322d383138322d343739663366663838376233222c227a223a35302e302c226174747273223a7b2274657874223a7b2274657874223a22506572666f726d5c6e5072697661637920436f6e74726f6c227d2c222e626f6479223a7b2274657874223a22506572666f726d205072697661637920436f6e74726f6c227d2c222e6465736372697074696f6e223a7b2274657874223a22506572666f726d205072697661637920436f6e74726f6c227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22506572666f726d205072697661637920436f6e74726f6c227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333738227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3130342e302c22686569676874223a37312e33323037353437313639383131337d2c22706f736974696f6e223a7b2278223a3136372e302c2279223a3938342e307d2c22616e676c65223a302e302c226964223a2266353336373033352d663231302d343365302d393966372d336464363537343464303431222c227a223a35312e302c226174747273223a7b2274657874223a7b2274657874223a225365637572655c6e466f726d204f72646572227d2c222e626f6479223a7b2274657874223a225365637572652046726f6d204f72646572227d2c222e6465736372697074696f6e223a7b2274657874223a225365637572652046726f6d204f72646572227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a225365637572652046726f6d204f72646572227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333739227d7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a38382e302c2279223a3631312e357d2c22616e676c65223a302e302c226964223a2263356535376265342d626630632d343965652d386165622d313439313365336261356433222c227a223a35322e302c226174747273223a7b2274657874223a7b2274657874223a224f52227d2c22696e4c696e6b73223a7b2230223a2233393036346531632d646233322d343231342d383865362d636235313835646635373066227d2c226f75744c696e6b73223a7b2230223a2266643734646435632d356134312d343762342d626562362d376134383962626332613632222c2231223a2231356563636265612d306634632d343561392d623335632d626535363465396361353438227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2233393036346531632d646233322d343231342d383865362d636235313835646635373066227d2c22746172676574223a7b226964223a2263356535376265342d626630632d343965652d386165622d313439313365336261356433227d2c226964223a2232383465303538352d383163392d343533332d616437382d623933666165616562336165222c227a223a35332e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2263356535376265342d626630632d343965652d386165622d313439313365336261356433227d2c22746172676574223a7b226964223a2266643734646435632d356134312d343762342d626562362d376134383962626332613632227d2c226964223a2263346535643165392d333435322d346165662d386238312d646461363835393234613833222c227a223a35342e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2263356535376265342d626630632d343965652d386165622d313439313365336261356433227d2c22746172676574223a7b226964223a2231356563636265612d306634632d343561392d623335632d626535363465396361353438227d2c226964223a2237346466366466642d616565382d343138352d613764342d626231363337326361323739222c227a223a35352e302c226174747273223a7b7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a3138302e302c2279223a3835332e307d2c22616e676c65223a302e302c226964223a2230663733333863382d633161342d343933302d613135372d336464306637643361323864222c227a223a35362e302c226174747273223a7b2274657874223a7b2274657874223a224f52227d2c22696e4c696e6b73223a7b2230223a2231356563636265612d306634632d343561392d623335632d626535363465396361353438227d2c226f75744c696e6b73223a7b2230223a2266353336373033352d663231302d343365302d393966372d336464363537343464303431222c2231223a2265666335323932652d646462612d343862342d613365342d343832363236356664646132227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2231356563636265612d306634632d343561392d623335632d626535363465396361353438227d2c22746172676574223a7b226964223a2230663733333863382d633161342d343933302d613135372d336464306637643361323864227d2c226964223a2235653939383931322d663663332d346362372d613761372d313334393762646632366561222c227a223a35372e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2230663733333863382d633161342d343933302d613135372d336464306637643361323864227d2c22746172676574223a7b226964223a2266353336373033352d663231302d343365302d393966372d336464363537343464303431227d2c226964223a2265353230653332302d633866322d346138352d613964342d613330623136663837323933222c227a223a35382e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2230663733333863382d633161342d343933302d613135372d336464306637643361323864227d2c22746172676574223a7b226964223a2265666335323932652d646462612d343862342d613365342d343832363236356664646132227d2c226964223a2232393432306366342d346234342d343266662d393934332d383361316132663638333531222c227a223a35392e302c226174747273223a7b7d7d2c7b2274797065223a226572642e52656c6174696f6e73686970222c2273697a65223a7b227769647468223a38302e302c22686569676874223a38302e307d2c22706f736974696f6e223a7b2278223a2d3230302e302c2279223a3531322e357d2c22616e676c65223a302e302c226964223a2239633237633938662d646361662d343037332d626463312d633331303066303237656665222c227a223a36302e302c226174747273223a7b2274657874223a7b2274657874223a224f52227d2c22696e4c696e6b73223a7b2230223a2263343434626436312d393161362d343131662d396166342d313735306330613861646132227d2c226f75744c696e6b73223a7b2230223a2239333336656432632d613836332d346361362d613330382d313762393764333436336537222c2231223a2234653834646463312d316232302d343934382d383130342d366461356133336164363565227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2263343434626436312d393161362d343131662d396166342d313735306330613861646132227d2c22746172676574223a7b226964223a2239633237633938662d646361662d343037332d626463312d633331303066303237656665227d2c226964223a2231303339313539342d626239362d343234642d623061372d636139643132386465626437222c227a223a36312e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2239633237633938662d646361662d343037332d626463312d633331303066303237656665227d2c22746172676574223a7b226964223a2239333336656432632d613836332d346361362d613330382d313762393764333436336537227d2c226964223a2238356632623666362d623965612d343561632d393261652d623263653937373562313065222c227a223a36322e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2239633237633938662d646361662d343037332d626463312d633331303066303237656665227d2c22746172676574223a7b226964223a2234653834646463312d316232302d343934382d383130342d366461356133336164363565227d2c226964223a2265366632623330362d306532662d343863382d613365312d343633303931653438643831222c227a223a36332e302c226174747273223a7b7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3431302e302c2279223a3938342e307d2c2273697a65223a7b227769647468223a39302e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2264323436366532312d383438332d343638362d386133342d613934343566623461356131222c227a223a36342e302c226174747273223a7b2274657874223a7b2274657874223a2250726976616379227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a2250726976616379227d2c222e6465736372697074696f6e223a7b2274657874223a2250726976616379227d2c222e69644442223a7b2274657874223a2236227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265666335323932652d646462612d343862342d613365342d343832363236356664646132227d2c22746172676574223a7b226964223a2264323436366532312d383438332d343638362d386133342d613934343566623461356131227d2c226964223a2238313139613032652d326136392d346665352d396638632d313630343164343337623131222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22434f4e464c494354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a36352e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2266353336373033352d663231302d343365302d393966372d336464363537343464303431227d2c22746172676574223a7b226964223a2264323436366532312d383438332d343638362d386133342d613934343566623461356131227d2c226964223a2236373937343563392d626663332d343537652d623035392d303637386134316339653533222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a36362e302c227665727469636573223a5b5d2c226174747273223a7b7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3632372e302c2279223a3931322e363739323435323833303138397d2c2273697a65223a7b227769647468223a39302e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2266306234623336342d326138352d346232392d616632612d656539663337356330343666222c227a223a36372e302c226174747273223a7b2274657874223a7b2274657874223a225365637572697479227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a225365637572697479227d2c222e6465736372697074696f6e223a7b2274657874223a225365637572697479227d2c222e69644442223a7b2274657874223a2237227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2264323436366532312d383438332d343638362d386133342d613934343566623461356131227d2c22746172676574223a7b226964223a2266306234623336342d326138352d346232392d616632612d656539663337356330343666227d2c226964223a2231313164343162392d346635392d343263332d396435362d346262396266353738386664222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a36382e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2263656538353737612d323535312d346130322d383138322d343739663366663838376233227d2c22746172676574223a7b226964223a2264323436366532312d383438332d343638362d386133342d613934343566623461356131227d2c226964223a2232386263653431622d376335332d346331382d393037382d323861363766653135333239222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a36392e302c226174747273223a7b7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3132312e302c22686569676874223a37382e307d2c22706f736974696f6e223a7b2278223a3631312e352c2279223a313032322e307d2c22616e676c65223a302e302c226964223a2265356438633038632d643533392d346134612d383732332d383230646330363033336263222c227a223a37302e302c226174747273223a7b2274657874223a7b2274657874223a22436865636b5c6e41636365737320436f6e74726f6c227d2c222e626f6479223a7b2274657874223a22436865636b2041636365737320436f6e74726f6c227d2c222e6465736372697074696f6e223a7b2274657874223a22436865636b2041636365737320436f6e74726f6c227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22436865636b2041636365737320436f6e74726f6c227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333830227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3132312e302c22686569676874223a37382e307d2c22706f736974696f6e223a7b2278223a3632372e302c2279223a313131392e357d2c22616e676c65223a302e302c226964223a2264373261323937342d303065372d343931312d383566642d666336393732363037386164222c227a223a37312e302c226174747273223a7b2274657874223a7b2274657874223a22436865636b5c6e496e666f726d6174696f6e20466c6f77227d2c222e626f6479223a7b2274657874223a22436865636b20496e666f726d6174696f6e20466c6f77227d2c222e6465736372697074696f6e223a7b2274657874223a22436865636b20496e666f726d6174696f6e20466c6f77227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22436865636b20496e666f726d6174696f6e20466c6f77227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333831227d7d7d2c7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a39392e30303030303030303030303030332c22686569676874223a37382e307d2c22706f736974696f6e223a7b2278223a3136312e302c2279223a313131392e357d2c22616e676c65223a302e302c226964223a2235386235336363322d383237332d343265362d616661332d663366363035643563653532222c227a223a37322e302c226174747273223a7b2274657874223a7b2274657874223a22436865636b5c6e41757468656e7469636174696f6e227d2c222e626f6479223a7b2274657874223a22436865636b2041757468656e7469636174696f6e227d2c222e6465736372697074696f6e223a7b2274657874223a22436865636b2041757468656e7469636174696f6e227d2c222e7072696f72697479223a7b2274657874223a312e307d2c222e6163746f7273223a7b2274657874223a22436865636b2041757468656e7469636174696f6e227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e69644442223a7b2274657874223a22333832227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2235386235336363322d383237332d343265362d616661332d663366363035643563653532227d2c22746172676574223a7b226964223a2263656538353737612d323535312d346130322d383138322d343739663366663838376233227d2c226964223a2237356164326533322d303436332d346531662d626265332d626166323665653330646636222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a37332e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2264373261323937342d303065372d343931312d383566642d666336393732363037386164227d2c22746172676574223a7b226964223a2263656538353737612d323535312d346130322d383138322d343739663366663838376233227d2c226964223a2230313932623133642d336630362d346466322d613864352d663261666266376233363465222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a37342e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265356438633038632d643533392d346134612d383732332d383230646330363033336263227d2c22746172676574223a7b226964223a2263656538353737612d323535312d346130322d383138322d343739663366663838376233227d2c226964223a2236313061656134662d666638322d346364372d393139342d623034396162356136613762222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a37352e302c226174747273223a7b7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3337392e352c2279223a3633342e303138383637393234353238337d2c2273697a65223a7b227769647468223a39302e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2233386364343838612d396439352d343534612d616366392d393736616334336237666361222c227a223a37362e302c226174747273223a7b2274657874223a7b2274657874223a22496e74656772697479227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a22496e74656772697479227d2c222e6465736372697074696f6e223a7b2274657874223a22496e74656772697479227d2c222e69644442223a7b2274657874223a2238227d7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3935302e302c2279223a3638352e313739323435323833303138397d2c2273697a65223a7b227769647468223a39302e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2237363761643063352d393534352d343830312d383537302d323066643661366330313537222c227a223a37372e302c226174747273223a7b2274657874223a7b2274657874223a2241646170746162696c697479227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a2241646170746162696c697479227d2c222e6465736372697074696f6e223a7b2274657874223a2241646170746162696c697479227d2c222e69644442223a7b2274657874223a2239227d7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3631342e302c2279223a3435342e357d2c2273697a65223a7b227769647468223a3130332e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2236333938383637372d386138662d346131332d623433392d393666336535313933343332222c227a223a37382e302c226174747273223a7b2274657874223a7b2274657874223a224561737920746f20557365227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a224561737920746f20557365227d2c222e6465736372697074696f6e223a7b2274657874223a224561737920746f20557365227d2c222e69644442223a7b2274657874223a223130227d7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3830382e302c2279223a3831352e307d2c2273697a65223a7b227769647468223a39302e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2235643663356538312d383236332d343965662d623632322d373937623565313964346231222c227a223a38302e302c226174747273223a7b2274657874223a7b2274657874223a2255736162696c697479227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a2255736162696c697479227d2c222e6465736372697074696f6e223a7b2274657874223a2255736162696c697479227d2c222e69644442223a7b2274657874223a223131227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2266306234623336342d326138352d346232392d616632612d656539663337356330343666227d2c22746172676574223a7b226964223a2235643663356538312d383236332d343965662d623632322d373937623565313964346231227d2c226964223a2237376230376537372d303235662d343430642d393866392d346139343633353732393438222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38312e302c226174747273223a7b7d7d2c7b2274797065223a2262617369632e5175616c697479222c22706f736974696f6e223a7b2278223a3932352e302c2279223a3932352e357d2c2273697a65223a7b227769647468223a39302e302c22686569676874223a37312e33323037353437313639383131337d2c22616e676c65223a302e302c226964223a2265393736326234342d666633372d343731322d396463332d303335643961643434613262222c227a223a38322e302c226174747273223a7b2274657874223a7b2274657874223a22417661696c6162696c697479227d2c222e223a7b22646174612d746f6f6c7469702d706f736974696f6e223a226c656674222c22646174612d746f6f6c7469702d706f736974696f6e2d73656c6563746f72223a222e6a6f696e742d7374656e63696c227d2c222e626f6479223a7b2274657874223a22417661696c6162696c697479227d2c222e6465736372697074696f6e223a7b2274657874223a22417661696c6162696c697479227d2c222e69644442223a7b2274657874223a223132227d7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2236333938383637372d386138662d346131332d623433392d393666336535313933343332227d2c22746172676574223a7b226964223a2235643663356538312d383236332d343965662d623632322d373937623565313964346231227d2c226964223a2261663335343834642d323837332d346564372d393430302d663031633933666265653764222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38332e302c227665727469636573223a5b7b2278223a3833322e302c2279223a3633372e307d5d2c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2233386364343838612d396439352d343534612d616366392d393736616334336237666361227d2c22746172676574223a7b226964223a2266306234623336342d326138352d346232392d616632612d656539663337356330343666227d2c226964223a2235623434336635382d383162642d343038392d393264352d326139396334323965616637222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38342e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265393736326234342d666633372d343731322d396463332d303335643961643434613262227d2c22746172676574223a7b226964223a2266306234623336342d326138352d346232392d616632612d656539663337356330343666227d2c226964223a2233666565376266642d623830632d346337632d386136322d313166386565646562333962222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38352e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2237363761643063352d393534352d343830312d383537302d323066643661366330313537227d2c22746172676574223a7b226964223a2235643663356538312d383236332d343965662d623632322d373937623565313964346231227d2c226964223a2232326237636330302d613166362d343265352d623738662d366236383466323631386330222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38362e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2238663934383832632d353365322d346437612d613463382d653134666564383330343339227d2c22746172676574223a7b226964223a2236333938383637372d386138662d346131332d623433392d393666336535313933343332227d2c226964223a2231376138303132332d643031362d346563642d386463322d313662393333353732376638222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22434f4e464c494354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38372e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2232393839616535302d613733362d343930382d613438352d363136383936386330303133227d2c22746172676574223a7b226964223a2236333938383637372d386138662d346131332d623433392d393666336535313933343332227d2c226964223a2232383061386262342d613136612d346634322d623433362d396233643534653930396135222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38382e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2238663934383832632d353365322d346437612d613463382d653134666564383330343339227d2c22746172676574223a7b226964223a2233386364343838612d396439352d343534612d616366392d393736616334336237666361227d2c226964223a2233626261643765652d663038342d343763612d393033302d343138346561363563303564222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22434f4e464c494354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a38392e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2234343031663339372d373532312d343733332d396535662d643563323336303831386466227d2c22746172676574223a7b226964223a2233386364343838612d396439352d343534612d616366392d393736616334336237666361227d2c226964223a2262323061386565372d666538652d343739392d386162622d666530333535303063383166222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22434f4e464c494354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a39302e302c227665727469636573223a5b5d2c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2239623861656461332d623332642d346430332d393132332d303363653232326636623939227d2c22746172676574223a7b226964223a2265393736326234342d666633372d343731322d396463332d303335643961643434613262227d2c226964223a2233346635306235652d326462642d343961382d623463312d396261393366626430393238222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a39312e302c226174747273223a7b7d7d2c7b2274797065223a226170702e4c696e6b222c22726f75746572223a7b226e616d65223a226e6f726d616c227d2c22636f6e6e6563746f72223a7b226e616d65223a226e6f726d616c227d2c22736f75726365223a7b226964223a2265613632393065652d636537652d346334302d386562322d306634643139343132373939227d2c22746172676574223a7b226964223a2237363761643063352d393534352d343830312d383537302d323066643661366330313537227d2c226964223a2230636138353036342d323934642d343331622d393362392d363332653765363865323061222c226c6162656c73223a5b7b22706f736974696f6e223a302e352c226174747273223a7b2274657874223a7b2274657874223a22494d50414354222c2266696c6c223a2223464646464646227d2c2272656374223a7b227374726f6b65223a2223303030303030222c227374726f6b652d7769647468223a31362e302c227278223a352e302c227279223a352e307d7d7d5d2c222e72656c6174223a7b2274657874223a2274727565227d2c227a223a39322e302c226174747273223a7b7d7d5d7d, '', 25);
INSERT INTO `goalModel` (`id`, `json`, `name`, `idSpec`) VALUES
(3, 0x7b2263656c6c73223a5b7b2274797065223a226572642e476f616c222c2273697a65223a7b227769647468223a3132302c22686569676874223a34387d2c22706f736974696f6e223a7b2278223a3331322c2279223a3434327d2c22616e676c65223a302c226964223a2263346633356166612d353465362d343130382d383635302d363863343431333261663030222c227a223a312c226174747273223a7b2274657874223a7b2274657874223a22746f5f68616e646c655f6f72646572227d2c222e6163746f7273223a7b2274657874223a225448452053595354454d227d2c222e7072696f72697479223a7b2274657874223a2230227d2c222e6465736372697074696f6e223a7b2274657874223a22227d2c222e626f6479223a7b2274657874223a2228205748454e204d45535341474520446f632052454345495645442046524f4d2054484520436c69656e7420524f4c4520414e44206f7264657228446f632920414e44207573657228436c69656e74292029202d3e2046202870726f63657373656428446f632920414e44206f7264657228446f632929227d2c222e69644442223a7b2274657874223a3233307d7d7d5d7d, '', 21);

-- --------------------------------------------------------

--
-- Struttura della tabella `goal_relation_type`
--

CREATE TABLE IF NOT EXISTS `goal_relation_type` (
  `idGrt` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(200) NOT NULL,
  PRIMARY KEY (`idGrt`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

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

CREATE TABLE IF NOT EXISTS `non_functional_req` (
  `idNonFunctional_Req` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `value` longtext,
  `description` longtext,
  `idSpecification` int(11) DEFAULT NULL,
  `current_state` set('active','deactivate','waiting') DEFAULT 'waiting',
  `type` longtext NOT NULL,
  PRIMARY KEY (`idNonFunctional_Req`),
  KEY `FNFS_idx` (`idSpecification`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dump dei dati per la tabella `non_functional_req`
--

INSERT INTO `non_functional_req` (`idNonFunctional_Req`, `name`, `value`, `description`, `idSpecification`, `current_state`, `type`) VALUES
(2, 'TEMPO DI RISPOSTA', 'T<30', 'Test', 21, 'waiting', 'manual'),
(3, 'u', 'u', 'u', 21, 'waiting', 'manual'),
(6, 'Privacy', 'Privacy', 'Privacy', 25, 'active', 'generated'),
(7, 'Security', 'Security', 'Security', 25, 'active', 'generated'),
(8, 'Integrity', 'Integrity', 'Integrity', 25, 'active', 'generated'),
(9, 'Adaptability', 'Adaptability', 'Adaptability', 25, 'active', 'generated'),
(10, 'Easy to Use', 'Easy to Use', 'Easy to Use', 25, 'active', 'generated'),
(11, 'Usability', 'Usability', 'Usability', 25, 'active', 'generated'),
(12, 'Availability', 'Availability', 'Availability', 25, 'active', 'generated');

-- --------------------------------------------------------

--
-- Struttura della tabella `page_description`
--

CREATE TABLE IF NOT EXISTS `page_description` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `link` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dump dei dati per la tabella `page_description`
--

INSERT INTO `page_description` (`id`, `name`, `description`, `link`) VALUES
(1, 'home_admin', 'The "admin" role is responsible for setting the general configurations and creating new domains. A domain is featured by: domain assumptions and abstract capabilities.', ''),
(2, 'home_dev', 'The "developer" role is responsible for deploying concrete capabilities, i.e. real services can be used to generate a workflow.', ''),
(3, 'home_cust', 'The "customer" is the stakeholder of a MUSA application. First, select the domain of interest for which you desire to create a new MUSA application. Then you will be asked to add new functional/non-functional requirements.', ''),
(4, 'home_super', 'The "super-admin" role is dev-mode user who can see and modify everything', ''),
(5, 'genconf_admin', 'The page allows specifying general settings for MUSA functioning', ''),
(6, 'domman_admin', 'This page allows creating a new Domain. A domain is a logical container of MUSA applications characterized by a common ontology and a common set of abstract capabilities.', ''),
(7, 'domconf_admin', 'This page allows defining domain-specific settings', ''),
(8, 'domass_admin', 'A Domain Assumption is a rule [consequence <- premise] describing invariant behavior of the system.', ''),
(9, 'abscap_admin', 'An Abstract Capability is the symbolic description of a Service the system will use to generate solutions.', '//www.google.com'),
(10, 'concap_admin', 'Page Description Concrete Capabilities', ''),
(11, 'spec_cust', 'A Specification is a collection of functional/non-functional requirements that defines a MUSA application. A specification may be "injected" into MUSA in order to launch a new application.', ''),
(12, 'func_cust', 'MUSA adopts a goal-oriented language to specify its functional requirements, and in particular a linear temporal logic dialect. ', ''),
(13, 'qual_cust', 'Currently, this feature is disabled.', ''),
(14, 'case_cust', 'Page Description Case Details', ''),
(15, 'newconc_dev', 'The page provides a list of all the Abstract Services. Creating a new concrete capabilities means to provide one or more real operation to realize the specified behavior. ', ''),
(16, 'manconc_dev', 'This page provides the list of Concrete Capabilities you have uploaded. Note: other developers may provide other concrete capabilities.', ''),
(17, 'prop_dev', 'A developer may propose to add a new Abstract Capability. It is responsibility of the Admin to decide if to accept or refuse it.', ''),
(19, 'logcase_dev', 'Page Description Log Case', ''),
(20, 'logall_dev', 'Page Description Log All', ''),
(21, 'depconc_dev', 'Here, the developer may upload a new concrete capability for an abstract one. The corresponding service is encapsulated into a jar file. ', ''),
(22, 'rel_cust', 'Page Description Goal Relations', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `predicate`
--

CREATE TABLE IF NOT EXISTS `predicate` (
  `idPredicate` int(11) NOT NULL,
  `name` longblob,
  `description` longblob,
  `idCase` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPredicate`),
  KEY `FKPC_idx` (`idCase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `process`
--

CREATE TABLE IF NOT EXISTS `process` (
  `idWorkflow` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `description` longtext,
  `fileWF` blob,
  `idSpecification` int(11) DEFAULT NULL,
  PRIMARY KEY (`idWorkflow`),
  KEY `idSpecification` (`idSpecification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `specification`
--

CREATE TABLE IF NOT EXISTS `specification` (
  `idSpecification` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `description` longtext,
  `state` set('activate','deactivate','waiting') DEFAULT 'waiting',
  `user` int(11) DEFAULT NULL,
  `idDomain` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSpecification`),
  KEY `FKSDOM_idx` (`idDomain`),
  KEY `user` (`user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dump dei dati per la tabella `specification`
--

INSERT INTO `specification` (`idSpecification`, `name`, `description`, `state`, `user`, `idDomain`) VALUES
(21, 'Cloud Application for Fashion Firm', '', 'deactivate', 3, 28),
(25, 'Medi@', '', 'waiting', 3, 49);

-- --------------------------------------------------------

--
-- Struttura della tabella `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `role` set('customer','dev','admin','super') NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

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

CREATE TABLE IF NOT EXISTS `variable` (
  `idVariable` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  `idCase` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVariable`),
  KEY `idCase_idx` (`idCase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `abstract_capability`
--
ALTER TABLE `abstract_capability`
  ADD CONSTRAINT `FAC` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `FKCS` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `FD1` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `domain_configuration`
--
ALTER TABLE `domain_configuration`
  ADD CONSTRAINT `domain_configuration_ibfk_1` FOREIGN KEY (`id_dom_conf_def`, `name`, `description`) REFERENCES `domain_conf_default` (`id_dom_conf_def`, `name`, `description`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FDC` FOREIGN KEY (`idDomain`) REFERENCES `domain` (`idDomain`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `functional_req`
--
ALTER TABLE `functional_req`
  ADD CONSTRAINT `idSpec` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idWf` FOREIGN KEY (`idWF`) REFERENCES `process` (`idWorkflow`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `functional_req_relations`
--
ALTER TABLE `functional_req_relations`
  ADD CONSTRAINT `end` FOREIGN KEY (`id_end`) REFERENCES `functional_req` (`idFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `end_qual` FOREIGN KEY (`id_end_quality`) REFERENCES `non_functional_req` (`idNonFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `spec` FOREIGN KEY (`id_spec`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `start` FOREIGN KEY (`id_start`) REFERENCES `functional_req` (`idFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `start_qual` FOREIGN KEY (`id_start_quality`) REFERENCES `non_functional_req` (`idNonFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `type` FOREIGN KEY (`type`) REFERENCES `goal_relation_type` (`idGrt`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `goalModel`
--
ALTER TABLE `goalModel`
  ADD CONSTRAINT `goalModel_ibfk_1` FOREIGN KEY (`idSpec`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `non_functional_req`
--
ALTER TABLE `non_functional_req`
  ADD CONSTRAINT `FNFS` FOREIGN KEY (`idSpecification`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `predicate`
--
ALTER TABLE `predicate`
  ADD CONSTRAINT `FKPC` FOREIGN KEY (`idCase`) REFERENCES `case_execution` (`idCase`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `idCase` FOREIGN KEY (`idCase`) REFERENCES `case_execution` (`idCase`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
