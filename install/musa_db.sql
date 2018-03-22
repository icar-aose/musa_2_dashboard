-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: serverino:3306
-- Generato il: Mar 22, 2018 alle 11:55
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
) ENGINE=InnoDB  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=14 ;

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
(7, 3, 'sadsa', 1, 'sadsa', 'sadsa', 'unactive', 'sadsa', 'test.Classe', 0x504b03041400080808007391754c000000000000000000000000140004004d4554412d494e462f4d414e49464553542e4d46feca0000f34dcccb4c4b2d2ed10d4b2d2acecccfb35230d433e0e5e2e50200504b0708b27f02ee1b00000019000000504b03041400080808004877754c000000000000000000000000430000006f72672f696361722f6d7573612f636f72652f72756e74696d655f656e746974792f436f6e63726574654361706162696c697479496e746572666163652e636c6173737d8e3d4e033110859f03c9427e24b8012534b8a1a58a84040d05119468d67a095ebc369a78035c8d8203702884575a41c714f3699e3433dfd7f7c727800b2c2a8c0c2e936eac77a2b6edb6625d525aed62f62d1f5990dfed3245a7cc5cca8bd43e94e83a66ea5a1c2bec1b1c35b2131b246eec6dddd0658359937c5c3d7145690df64ecfee0de681b2e36fb8d866d1fc90f4791dd2abc17139d9fa28997fd9946f745de64daacb70973a75bcf2810627ff489df73e1383f2187d8d8be31813f4aed5c083818703a73dcbc6acf411e63f504b07089b717ba3d000000025010000504b03041400080808007b7d754c00000000000000000000000011000000746573742f436c617373652e636c6173736d924b6fd34010c7ffdba6711e2e69d286164aa16979a4e5e10b12870097082450784889ca116ddc69bac1f656eb75a11f0b0e2071e003f0a110e362a5a9d883777667fef39b9d59fffef3f31780c778e86141a06e29b5413f92694a1e4a022b53792a83482693e0dd784aa1f5501678a6cd2450a134419ca53208b5a1c0648955317d2436f62ce8eb243464a92f4fe45845ec7a95583247322481f2539528fb5c60b1bb772050eaeb43aa6111751f1e2a028d814ae86d168fc98ce438e28cd64087323a9046e5e7c259b2c72a15581eccddbac74d4cb54a46c734221957d1c29a87d54b9d0ccf524bb18f36aef215746605da83f3b0d2c17ba3123bb486937b156c70e93764f5a1de9ea3d6701d373c6c0aac3ad27c6ce1a6807792bba284e1ddc15c71cbee492fefdb8f489e52c1aca0c3b8a2d67c801b4cad34f683369f8e22fdb982db026b85f05244a0c9238e55222d5da8ef096c14eaffa20235fa426166e9b51e57b0cf8442fa62e666cd506726a4972a1f7afddf9c1fe51da1031e207f4bfc0f95d9f2ebf15ae553c056b05ddaff81da57de2cc02f44ecc432af7eb1bf82065b7ea159f21356e7b1ea37345bebdf71ed025063cb0196d6e720d519e4961bb2ed803458da744276dc905d07a4cdd27527e48e1b72d701d964e99613d27543f61c900e4b779c90fbe7ca077f01504b0708dc89b295f0010000ec030000504b030414000008080056bf754cca74a5d59d000000180100000c0024006d616e69666573742e786d6c0a002000000000000100180000d48a2968c1d30100d48a2968c1d30100d48a2968c1d3014d8fd10e82300c457f85ec5da6f1411fca8821f10bf403cad690c5d111ba88febd4808eceddc73d3a685fad387e24da3f8c8953a95475510dbe83c77957a3eee87ab2a24213b0c91a9521c556da0c1015b1f7cface1cd98e94c880771b5f4067696e6eada4116d32e77fb32560ecc9083a41d00b830d28422691a4b25918f4eac00f531c5f32a0dd867205d390ef5b1360479cf26217a0f72375f6d50f504b010214001400080808007391754cb27f02ee1b000000190000001400240000000000000000000000000000004d4554412d494e462f4d414e49464553542e4d460a002000000000000100180000012fac37c1d301f0583ed5deb19d01f0583ed5deb19d01504b010214001400080808004877754c9b717ba3d0000000250100004300240000000000000000000000610000006f72672f696361722f6d7573612f636f72652f72756e74696d655f656e746974792f436f6e63726574654361706162696c697479496e746572666163652e636c6173730a0020000000000001001800004cdaa81cc1d301f0583ed5deb19d01f0583ed5deb19d01504b010214001400080808007b7d754cdc89b295f0010000ec0300001100240000000000000000000000a2010000746573742f436c617373652e636c6173730a002000000000000100180000f1d30823c1d301f0583ed5deb19d01f0583ed5deb19d01504b0102140014000008080056bf754cca74a5d59d000000180100000c00240000000000000000000000d10300006d616e69666573742e786d6c0a002000000000000100180000d48a2968c1d30100d48a2968c1d30100d48a2968c1d301504b05060000000004000400bc010000bc0400000000, 'undeployed', 'sadsa');

-- --------------------------------------------------------

--
-- Struttura della tabella `domain`
--

CREATE TABLE IF NOT EXISTS `domain` (
  `idDomain` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `description` longtext,
  PRIMARY KEY (`idDomain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

--
-- Dump dei dati per la tabella `domain`
--

INSERT INTO `domain` (`idDomain`, `name`, `description`) VALUES
(28, 'Cloud Application Mashup', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dump dei dati per la tabella `domain_configuration`
--

INSERT INTO `domain_configuration` (`idDomain_Configuration`, `idDomain`, `name`, `value`, `description`, `id_dom_conf_def`) VALUES
(1, 28, 'session', 'single', 'This parameter specifies if the applications, under this domain, are single sessions or a new session is created for each user request.', 1);

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
  `priority` int(10) DEFAULT NULL,
  `current_state` set('activated','deactivated','waiting') DEFAULT 'waiting',
  `body` longtext,
  `actors` longtext,
  `idWF` int(11) DEFAULT NULL,
  `idSpecification` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFunctional_Req`),
  KEY `idSpec_idx` (`idSpecification`),
  KEY `idWf_idx` (`idWF`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=237 ;

--
-- Dump dei dati per la tabella `functional_req`
--

INSERT INTO `functional_req` (`idFunctional_Req`, `name`, `type`, `description`, `priority`, `current_state`, `body`, `actors`, `idWF`, `idSpecification`) VALUES
(230, 'to_handle_order', 'manual', '', 0, 'deactivated', '( WHEN MESSAGE Doc RECEIVED FROM THE Client ROLE AND order(Doc) AND user(Client) ) -> F (processed(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(231, 'to_wait_order', 'manual', '', 0, 'waiting', '( WHEN MESSAGE Doc RECEIVED FROM THE Client ROLE AND order(Doc) AND user(Client) ) -> F (available(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(232, 'to_process_order', 'manual', '', 0, 'waiting', '( WHEN available(Doc) AND order(Doc) AND registered(Client) AND user(Client) ) -> F (processed(Doc) AND order(Doc))', 'THE SYSTEM', NULL, 21),
(233, 'to_process_accepted_order', 'manual', '', 0, 'waiting', '( WHEN accepted(X) AND order(X) ) -> F (MESSAGE U SENT TO THE Z ROLE AND delivery_order(U) AND storehouse_manager(Z))', 'THE SYSTEM', NULL, 21),
(234, 'to_notify_invoice', 'manual', '', 0, 'waiting', '( WHEN accepted(X) AND order(X) AND registered(Y) AND user(Y) ) -> F (MESSAGE invoice SENT TO THE Client ROLE AND user(Client))', 'THE SYSTEM', NULL, 21),
(235, 'to_deliver_order', 'manual', '', 0, 'waiting', '( WHEN MESSAGE Doc SENT TO THE Client ROLE AND invoice(Doc) AND user(Client) ) -> F (MESSAGE Deliv SENT TO THE SM ROLE AND delivery_order(Deliv) AND storehouse_manager(SM))', 'THE SYSTEM', NULL, 21),
(236, 'to_notify_failure', 'manual', '', 0, 'activated', '( WHEN refused(X) AND order(X) AND registered(Y) AND user(Y) ) -> F (MESSAGE failure_order SENT TO THE Client ROLE AND user(Client))', 'THE SYSTEM', NULL, 21);

-- --------------------------------------------------------

--
-- Struttura della tabella `functional_req_relations`
--

CREATE TABLE IF NOT EXISTS `functional_req_relations` (
  `idFunc_Req_rel` int(11) NOT NULL AUTO_INCREMENT,
  `id_start` int(11) NOT NULL,
  `id_end` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `id_spec` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idFunc_Req_rel`),
  KEY `start` (`id_start`),
  KEY `end` (`id_end`),
  KEY `spec` (`id_spec`),
  KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dump dei dati per la tabella `functional_req_relations`
--

INSERT INTO `functional_req_relations` (`idFunc_Req_rel`, `id_start`, `id_end`, `type`, `id_spec`, `name`) VALUES
(4, 230, 232, 3, 21, 'aaa');

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
  PRIMARY KEY (`idNonFunctional_Req`),
  KEY `FNFS_idx` (`idSpecification`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `non_functional_req`
--

INSERT INTO `non_functional_req` (`idNonFunctional_Req`, `name`, `value`, `description`, `idSpecification`, `current_state`) VALUES
(2, 'TEMPO DI RISPOSTA', 'T<30', '', 21, 'waiting');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dump dei dati per la tabella `specification`
--

INSERT INTO `specification` (`idSpecification`, `name`, `description`, `state`, `user`, `idDomain`) VALUES
(21, 'Cloud Application for Fashion Firm', '', 'activate', 3, 28);

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
  ADD CONSTRAINT `spec` FOREIGN KEY (`id_spec`) REFERENCES `specification` (`idSpecification`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `start` FOREIGN KEY (`id_start`) REFERENCES `functional_req` (`idFunctional_Req`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `type` FOREIGN KEY (`type`) REFERENCES `goal_relation_type` (`idGrt`) ON DELETE CASCADE ON UPDATE CASCADE;

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
