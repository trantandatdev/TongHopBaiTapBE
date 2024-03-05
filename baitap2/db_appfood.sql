/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `desciption` varchar(255) DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `food_type` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `food_type`;
CREATE TABLE `food_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `like_res`;
CREATE TABLE `like_res` (
  `like_res_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `res_id` int DEFAULT NULL,
  `date_like` datetime DEFAULT NULL,
  `dis_like` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`like_res_id`),
  KEY `user_id` (`user_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `like_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `like_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orders_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `arr_sub_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `user_id` (`user_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `rate_res`;
CREATE TABLE `rate_res` (
  `rate_res_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `res_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `date_rate` datetime DEFAULT NULL,
  PRIMARY KEY (`rate_res_id`),
  KEY `user_id` (`user_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `rate_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `rate_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `restaurant`;
CREATE TABLE `restaurant` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `desciption` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sub_food`;
CREATE TABLE `sub_food` (
  `sub_id` int NOT NULL AUTO_INCREMENT,
  `sub_name` varchar(50) DEFAULT NULL,
  `sub_price` float DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  PRIMARY KEY (`sub_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `sub_food_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `desciption`, `type_id`) VALUES
(1, 'Bubo virginianus', 'http://dummyimage.com/136x100.png/ff4444/ffffff', 100, 'Uhzveeduplzgdjqpzryypjlvcfturqvtmjubemihpqnoyso', 9);
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `desciption`, `type_id`) VALUES
(2, 'Madoqua kirkii', 'http://dummyimage.com/242x100.png/5fa2dd/ffffff', 80, 'Tbjwngnduwkqucetaqtrjgimluiboeqketmpwluemwzjqqw', 8);
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `desciption`, `type_id`) VALUES
(3, 'Lamprotornis nitens', 'http://dummyimage.com/171x100.png/dddddd/000000', 31, 'Qizrhagojuegjzdxrsilhjnolnjxonnfrusoislypgloxqw', 4);
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `desciption`, `type_id`) VALUES
(4, 'Plegadis falcinellus', 'http://dummyimage.com/201x100.png/5fa2dd/ffffff', 4, 'Gamhnwvcanphzwgfjuynpzfjmwziqaaqzjwpreirnpxlkhn', 9),
(5, 'Panthera leo persica', 'http://dummyimage.com/230x100.png/dddddd/000000', 90, 'Jplekderdgfoglhicmtowdrdhqqbhodbelwvgdfwkfbggry', 1),
(6, 'Meles meles', 'http://dummyimage.com/211x100.png/cc0000/ffffff', 88, 'Ieffxecwwpxhcaexaaasdvvknwhgkkdjygjcreqvanhyqke', 5),
(7, 'Bison bison', 'http://dummyimage.com/208x100.png/cc0000/ffffff', 92, 'Ziegykvqampdkiitlixhkbtcqzaqxrpunaxbvrtanrdusgz', 7),
(8, 'Sceloporus magister', 'http://dummyimage.com/157x100.png/5fa2dd/ffffff', 86, 'Disowabhnsznyucnjjdjutnhvoqihjodvueflztdxohbadu', 3),
(9, 'Cynictis penicillata', 'http://dummyimage.com/227x100.png/cc0000/ffffff', 65, 'Ufwbelwpwnntztjykfpkbifyzvfkscqpkebxdciniohhcrj', 7),
(10, 'Macropus fuliginosus', 'http://dummyimage.com/239x100.png/5fa2dd/ffffff', 20, 'Rofggmbyuglbhwmberyxphkewvfwudnfpgnyenctsebmyzf', 10),
(11, 'Callorhinus ursinus', 'http://dummyimage.com/204x100.png/ff4444/ffffff', 31, 'Krjwaftfbeswtaqjsjbkzedvhoedhaghlbzezrjykbxlthd', 5),
(12, 'Haliaeetus leucocephalus', 'http://dummyimage.com/194x100.png/dddddd/000000', 93, 'Bruyhakstywchjagxjxwniylhuzbbvrebmvizpgdchqbpam', 9),
(13, 'Sciurus vulgaris', 'http://dummyimage.com/171x100.png/ff4444/ffffff', 88, 'Zaakqiwmwyyskwmhhrhwhtlqknnedcqrhlxbxcqktjabkor', 9),
(14, 'Spilogale gracilis', 'http://dummyimage.com/103x100.png/ff4444/ffffff', 96, 'Tyrhmsvvrjjhuyheniybzpbcwpyuaafegfclndhxkicnshz', 9),
(15, 'Eudyptula minor', 'http://dummyimage.com/233x100.png/ff4444/ffffff', 24, 'Bidkooyrjaocpnjpvixoqkcmqzssgrkqnqvyyzvtlewaawz', 1),
(16, 'Geochelone radiata', 'http://dummyimage.com/189x100.png/5fa2dd/ffffff', 44, 'Helrlieqsnomblokjdanlfmdpfatdigzzbathqptpwzxnxj', 1),
(17, 'Bucephala clangula', 'http://dummyimage.com/147x100.png/dddddd/000000', 50, 'Dzahxfgbbomcnypepvintzghqxcswhuxpppanaaxcyngknj', 8),
(18, 'Macropus eugenii', 'http://dummyimage.com/216x100.png/5fa2dd/ffffff', 89, 'Gvoifzvywacpajwvrsiyfgpnhuuqtsoogstgwbwyqtwowto', 5),
(19, 'Sula dactylatra', 'http://dummyimage.com/237x100.png/5fa2dd/ffffff', 51, 'Rbgvtxsbzyohnmsceykfoxrtepbvotrqkilwvxgylvqcyuo', 9),
(20, 'Crotalus triseriatus', 'http://dummyimage.com/122x100.png/dddddd/000000', 10, 'Jfmooietlgwtquywupdqvkzftrfcexwzyigdsujemnfshju', 3),
(21, 'Aonyx capensis', 'http://dummyimage.com/227x100.png/cc0000/ffffff', 66, 'Bvgupxfzqgdobswqtxdiodgbzizlrplliuufjwlcikofuoz', 6),
(22, 'Myrmecophaga tridactyla', 'http://dummyimage.com/112x100.png/cc0000/ffffff', 14, 'Zjsgxzdhjtbngwdlhvslhhjlpgcpwgvvblziaizccgmsnvf', 6),
(23, 'Varanus salvator', 'http://dummyimage.com/111x100.png/cc0000/ffffff', 43, 'Wgwxtxmmmqrmbzlukuownqpckifigsyjfjijugcmxxdsgcm', 9),
(24, 'Cathartes aura', 'http://dummyimage.com/116x100.png/dddddd/000000', 56, 'Ayhuzhwypddrtohkwtqjvzgghprerfyawywvgmksebxjdfy', 9),
(25, 'Fregata magnificans', 'http://dummyimage.com/160x100.png/cc0000/ffffff', 51, 'Xhrarncqlutvpfjweahhbdrlrrjxcrinbvvjgmjtbmcgbtu', 8),
(26, 'Cacatua galerita', 'http://dummyimage.com/232x100.png/dddddd/000000', 88, 'Ggxtwgaaiiyswfhklbxxrrntlpcthltzkbalibhzsskaxsj', 9),
(27, 'Odocoileus hemionus', 'http://dummyimage.com/224x100.png/cc0000/ffffff', 49, 'Oeeqvpocbfahilnwwgbnlczczbylyelqzzfxkczbuktgwti', 8),
(28, 'Larus novaehollandiae', 'http://dummyimage.com/247x100.png/dddddd/000000', 87, 'Lodevmpcuzygakedojgowhdfteexucdtzznpisszamnxyjn', 9),
(29, 'Castor fiber', 'http://dummyimage.com/209x100.png/cc0000/ffffff', 36, 'Oebfpbxkcybogcbmxvyyqgzehqzafeumnwfetftkhlghogu', 10),
(30, 'Parus atricapillus', 'http://dummyimage.com/190x100.png/dddddd/000000', 14, 'Rmlgdlqzicrgwuenhjxuperofnovbcmwqnqsilirmkmolrh', 8),
(31, 'Geochelone elephantopus', 'http://dummyimage.com/142x100.png/cc0000/ffffff', 56, 'Axddurqjhjgpkoezlcwztxjamwhucghbvpgymjcwtywuiwd', 3),
(32, 'Manouria emys', 'http://dummyimage.com/177x100.png/dddddd/000000', 80, 'Evyfxsiwlkpearkmudoxloucrhegzjlejrzmfewuayifrvd', 6),
(33, 'Neophron percnopterus', 'http://dummyimage.com/162x100.png/5fa2dd/ffffff', 35, 'Rxegqonyqkoxvpktlycrervbbopsqyfhhlzuvuwvwwqxxbh', 10),
(34, 'Sula dactylatra', 'http://dummyimage.com/240x100.png/5fa2dd/ffffff', 44, 'Akxmuirlsfjcdlnybaqwcxxhssfyqhnqsiwwjyazrhwewbh', 5),
(35, 'Redunca redunca', 'http://dummyimage.com/203x100.png/dddddd/000000', 68, 'Fcxhuitqwyjsobglfhribfrrvwwcnugzeyuasfhzfntaezi', 10),
(36, 'Phoca vitulina', 'http://dummyimage.com/105x100.png/dddddd/000000', 27, 'Fcdymzasbrzliwlvbcqvvyacpfgiylzufjogmqxiizhgavk', 1),
(37, 'Ctenophorus ornatus', 'http://dummyimage.com/205x100.png/5fa2dd/ffffff', 38, 'Kbbfawdabcoyvrvhwrdbtekwcolsfvxdgpbfsyoebrmtycr', 7),
(38, 'Acrobates pygmaeus', 'http://dummyimage.com/160x100.png/cc0000/ffffff', 43, 'Tlwpnqirslgcwpglkxxfutmiliqxorzpyqqbnygfkvfbyoq', 4),
(39, 'Raphicerus campestris', 'http://dummyimage.com/100x100.png/5fa2dd/ffffff', 18, 'Icllfziuvrwfnyfstnfhozpirmodudydovtkfmxvwkwgplr', 9),
(40, 'Alopex lagopus', 'http://dummyimage.com/130x100.png/5fa2dd/ffffff', 44, 'Dfjmdmtfonwbkmzpazaipfvoerlzpujhcmwwpbvzsklmwep', 8),
(41, 'Alces alces', 'http://dummyimage.com/136x100.png/5fa2dd/ffffff', 87, 'Lzzkfwbchieybzptcayrnkpulaeeockrorwlyjbtwnrzafp', 2),
(42, 'Milvus migrans', 'http://dummyimage.com/165x100.png/5fa2dd/ffffff', 65, 'Jaassqtzmuaekpnhvjmoaoulpiygsjpwuvnlhemkabvhkfy', 5),
(43, 'Cygnus atratus', 'http://dummyimage.com/205x100.png/dddddd/000000', 49, 'Ltlpmccpdalnuorlzsksizjuhvngpmnuqrbnocggkwoawfj', 2),
(44, 'Neotoma sp.', 'http://dummyimage.com/130x100.png/ff4444/ffffff', 17, 'Mzxjinjrivdjoizovmarqghzdnmezduhjhkuplbodezywhx', 8),
(45, 'Pelecans onocratalus', 'http://dummyimage.com/127x100.png/dddddd/000000', 49, 'Cibssbmnpevpawskjmudsspsjhgmjqovmgewbnyupgzjvos', 5),
(46, 'Eudromia elegans', 'http://dummyimage.com/120x100.png/cc0000/ffffff', 49, 'Kdxxxtsekhsqzuigqqlqsgkrfzhevjrskeiyyghcsvfopdd', 6),
(47, 'Libellula quadrimaculata', 'http://dummyimage.com/113x100.png/cc0000/ffffff', 36, 'Gktbohfiprqdyruqmrekaszrrgbvlfyoeqfnbbdevghcyel', 2),
(48, 'Sterna paradisaea', 'http://dummyimage.com/213x100.png/cc0000/ffffff', 89, 'Ouipcylstagilchaaejcixwdoiaigiimhbdjoapcvekyzpd', 1),
(49, 'Uraeginthus granatina', 'http://dummyimage.com/165x100.png/cc0000/ffffff', 72, 'Ovygcchvcgubnsatjhodyyksfvpzntmtzamqlhaeyxqqomf', 1),
(50, 'Cracticus nigroagularis', 'http://dummyimage.com/116x100.png/5fa2dd/ffffff', 1, 'Rfjjiucknyuqtgqiglzimrvsmvifugdszxlbouotrebjtps', 2),
(51, 'Fregata magnificans', 'http://dummyimage.com/186x100.png/ff4444/ffffff', 13, 'Iwkleueadnwxuqkcuyvzadeuvezamrykhivoixutowlzuhs', 8),
(52, 'Carphophis sp.', 'http://dummyimage.com/245x100.png/ff4444/ffffff', 78, 'Izuuycfaebmcrlenaawdznfkphgvcvyfgzyozlalpitahsv', 1),
(53, 'Haliaeetus leucocephalus', 'http://dummyimage.com/152x100.png/cc0000/ffffff', 16, 'Gethxoqfimdnmzpsyapvtjkxroybcimveheoojlfpgyydnm', 4),
(54, 'Ara ararauna', 'http://dummyimage.com/236x100.png/cc0000/ffffff', 20, 'Uyweappzzmbcsctwsmpmgakmejseuyoqqowiqhgylfyyunf', 7),
(55, 'Ratufa indica', 'http://dummyimage.com/200x100.png/cc0000/ffffff', 51, 'Pnwanbgnbbrnlaoorkkjfbxfsjdykyeypntkjlipntqlvnx', 6),
(56, 'Laniarius ferrugineus', 'http://dummyimage.com/222x100.png/dddddd/000000', 26, 'Gbvysfkedwkylsfugqylxkkdusqtdpfylfknmvtgmnnsebs', 4),
(57, 'Alcelaphus buselaphus cokii', 'http://dummyimage.com/121x100.png/ff4444/ffffff', 32, 'Rbaerlceflblkgeijbptkqrvnaaaclplovsdjbkuomqnhsh', 10),
(58, 'Microcebus murinus', 'http://dummyimage.com/228x100.png/cc0000/ffffff', 15, 'Hombybbyfgdsxmftfilaupdgfqlheqwzdorpyvqziughkig', 5),
(59, 'Macropus rufogriseus', 'http://dummyimage.com/128x100.png/dddddd/000000', 43, 'Gqnfatuxzvbymkopzjbnthxkbrwelxkizfrssnsdniriufs', 8),
(60, 'Tamandua tetradactyla', 'http://dummyimage.com/200x100.png/dddddd/000000', 65, 'Arokxqhuzgjawzdreiytnebghbekqentdquibvxueejjeya', 5),
(61, 'Gymnorhina tibicen', 'http://dummyimage.com/118x100.png/ff4444/ffffff', 18, 'Zbkhxhvxtzfadtqvuhxtmdhpybrhtwxljgyiievuwlofuke', 7),
(62, 'Cereopsis novaehollandiae', 'http://dummyimage.com/180x100.png/5fa2dd/ffffff', 90, 'Fcfljlohidwhzgrfcwfjxyxswbmmbijtpdumbzwtaywdzag', 10),
(63, 'Plectopterus gambensis', 'http://dummyimage.com/121x100.png/5fa2dd/ffffff', 48, 'Qrdjdeibznftgucedzlnggtwnlubrrhjxgmlrxaedntqmob', 5),
(64, 'Anas bahamensis', 'http://dummyimage.com/217x100.png/dddddd/000000', 90, 'Bpzztdevngtxmasqknsavwhoetkgzkomgilwlluqoztudxy', 5),
(65, 'Paraxerus cepapi', 'http://dummyimage.com/193x100.png/5fa2dd/ffffff', 62, 'Lnkjorqohltbicvsfbltkluzvrxdvqoeaonmerofezhwjvb', 6),
(66, 'Bassariscus astutus', 'http://dummyimage.com/189x100.png/ff4444/ffffff', 10, 'Lewuywsnrrvlzgngjqvsrjgfaoiqmjjuniqafxydtsmnlvi', 10),
(67, 'Otaria flavescens', 'http://dummyimage.com/220x100.png/5fa2dd/ffffff', 52, 'Goyvgwptmqmdxixfxzasrgigxpmreryvporabdhbhfyrhnb', 4),
(68, 'Ardea golieth', 'http://dummyimage.com/192x100.png/ff4444/ffffff', 37, 'Axfjyjfqssgepetlnpaqvcdiarmkqtzavnzzcupxrbgxmhs', 7),
(69, 'Lamprotornis superbus', 'http://dummyimage.com/123x100.png/dddddd/000000', 47, 'Xdfyxcpgxnbhqvrfsuwalmvwjzkfbbaspsugfbvwjhufkks', 6),
(70, 'unavailable', 'http://dummyimage.com/182x100.png/5fa2dd/ffffff', 55, 'Tzsnczvgvjomnqajaodufhstlspzfgutpykfurioyqnliif', 7),
(71, 'Castor fiber', 'http://dummyimage.com/227x100.png/cc0000/ffffff', 29, 'Jjhpngovcuszzntbvuagdkqwijfhctujekajbmxfmunbqbj', 2),
(72, 'Zalophus californicus', 'http://dummyimage.com/130x100.png/dddddd/000000', 4, 'Izhmiuuxfwxcmykkfcfuyyuiksutqyzglsgfmieshvjbjbn', 7),
(73, 'Chamaelo sp.', 'http://dummyimage.com/172x100.png/cc0000/ffffff', 17, 'Olzhelwfhrogrqaexhhrjnilzfxbhvabuslecqeqvtcubzu', 3),
(74, 'Uraeginthus angolensis', 'http://dummyimage.com/173x100.png/dddddd/000000', 25, 'Iluyamxbfgkkbsedckcdzyxcxrsmctoozhqfhmxqlpbopdk', 2),
(75, 'Chelodina longicollis', 'http://dummyimage.com/233x100.png/ff4444/ffffff', 42, 'Zprrnklswblaszwkmdlbwskcuidqkvhhdcjbagzoomznukr', 8),
(76, 'Caiman crocodilus', 'http://dummyimage.com/208x100.png/dddddd/000000', 59, 'Fqrediyijsydpleichmqucldwraqptiwjgrnpqpvrrtnmck', 1),
(77, 'Gabianus pacificus', 'http://dummyimage.com/201x100.png/5fa2dd/ffffff', 41, 'Lhcztqssjldzhpzknkrzwngwxijfekjwiwsjcslcouvhzav', 9),
(78, 'Aonyx capensis', 'http://dummyimage.com/155x100.png/ff4444/ffffff', 100, 'Nmmluryjbrrnldljmwjjtxegdeilmzvvxdkvkbizvjdhwyb', 2),
(79, 'Graspus graspus', 'http://dummyimage.com/228x100.png/ff4444/ffffff', 87, 'Iouytogipifhgudfbcdiibrvwxcqjoqzymrkkrnaeiydcdd', 9),
(80, 'Scolopax minor', 'http://dummyimage.com/183x100.png/dddddd/000000', 12, 'Gowgsvocsgitfvmzjuapewnixyvovfdbbsmtckvoacdrhwx', 7),
(81, 'Coracias caudata', 'http://dummyimage.com/162x100.png/5fa2dd/ffffff', 35, 'Lvaemfmxnhbmppcxoxcvyiuwdkqoprrhlvjloexhmrratzu', 5),
(82, 'Varanus komodensis', 'http://dummyimage.com/177x100.png/5fa2dd/ffffff', 21, 'Tupclsywvkqhxfuznprksfnsbrfplrktjgxsfactjgcecvd', 3),
(83, 'Zosterops pallidus', 'http://dummyimage.com/161x100.png/ff4444/ffffff', 83, 'Gpiwxzssoptybtnjzfntcvliiewkpzpsyzbvyvalnppltkh', 3),
(84, 'Varanus sp.', 'http://dummyimage.com/227x100.png/5fa2dd/ffffff', 59, 'Vxavthwrcncuqkqomagieohqozweswkumnyluldrjdczwlg', 8),
(85, 'Bos taurus', 'http://dummyimage.com/116x100.png/ff4444/ffffff', 12, 'Sthbbrejysvzmxbfmuvodudajjewoxrrrakzrtzgcqjxnvm', 9),
(86, 'Rhea americana', 'http://dummyimage.com/131x100.png/dddddd/000000', 3, 'Vamntsufehajgmbhlhxbwangjsgkcodscgpobztuscydubi', 1),
(87, 'Cathartes aura', 'http://dummyimage.com/139x100.png/5fa2dd/ffffff', 3, 'Bvfmulhyxsvdwlaklohklumphvzztxgrvpmsfnkodhrawje', 6),
(88, 'Corvus albus', 'http://dummyimage.com/166x100.png/dddddd/000000', 77, 'Nhcitfpspqxehzybwvkfltcthtqymmuylfyhqhjapnpoofg', 8),
(89, 'Francolinus coqui', 'http://dummyimage.com/138x100.png/5fa2dd/ffffff', 47, 'Soztposjeykdyrzksthecmhxertbebmwjfcspcamqsanrha', 7),
(90, 'Haematopus ater', 'http://dummyimage.com/134x100.png/ff4444/ffffff', 47, 'Cfgotlssukoycuhbovltehdiqzobiepojwiqfdbleozxhwd', 5),
(91, 'Dasyurus maculatus', 'http://dummyimage.com/239x100.png/5fa2dd/ffffff', 37, 'Psnpyekucmzcmbqjynvniuyzwbaftcofhcirqqbfgcjxmhz', 8),
(92, 'Dicrurus adsimilis', 'http://dummyimage.com/114x100.png/dddddd/000000', 73, 'Whkaqcafhxyjkdejjeiszogifdmjkgnstgakktssrwtnncx', 9),
(93, 'Platalea leucordia', 'http://dummyimage.com/232x100.png/ff4444/ffffff', 73, 'Elmuwtzhcnyhnonxawzezwvgdxwdjoickbmhwfcybkvrdkd', 9),
(94, 'Varanus komodensis', 'http://dummyimage.com/177x100.png/cc0000/ffffff', 52, 'Pzbuomfnfphtnyunkzbcyxhvdqmjxyjezxpfkiawbsumfkv', 5),
(95, 'Psophia viridis', 'http://dummyimage.com/230x100.png/cc0000/ffffff', 37, 'Gdallyuhvxdgqxsnsmygbhhuvmynvjfppknmwdkviypzsni', 2),
(96, 'Ploceus intermedius', 'http://dummyimage.com/199x100.png/dddddd/000000', 48, 'Bmdpvdxoqfocynkdricjqdikhjbxjiulsfsdakbvgazfrpp', 5),
(97, 'Uraeginthus angolensis', 'http://dummyimage.com/133x100.png/ff4444/ffffff', 50, 'Kvhaluqrduykwvqkkhwxshsskyczmvnfgaistlkausjvddf', 5),
(98, 'Cebus apella', 'http://dummyimage.com/166x100.png/dddddd/000000', 59, 'Uyzrpnyzqurpjcmaduvtbleabvxafgsjcgfaxbdwmaxbkdj', 8),
(99, 'Lemur fulvus', 'http://dummyimage.com/101x100.png/ff4444/ffffff', 9, 'Lnklvfrtxbqtjnmsdlelnoyvqrlwwtqsguyfawwvfhjrqgq', 1),
(100, 'Macropus eugenii', 'http://dummyimage.com/206x100.png/5fa2dd/ffffff', 99, 'Tcjfjymsbnuvqqjdvfbxnasueniwkquvfmwwmvplaxrlrao', 9);

INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(1, 'sit');
INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(2, 'dolorem');
INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(3, 'libero');
INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(4, 'minus'),
(5, 'ipsam'),
(6, 'omnis'),
(7, 'repellat'),
(8, 'sit'),
(9, 'et'),
(10, 'explicabo');

INSERT INTO `like_res` (`like_res_id`, `user_id`, `res_id`, `date_like`, `dis_like`) VALUES
(1, 1, 2, '2023-01-10 12:38:41', 0);
INSERT INTO `like_res` (`like_res_id`, `user_id`, `res_id`, `date_like`, `dis_like`) VALUES
(2, 3, 2, '2023-01-10 12:38:41', 0);
INSERT INTO `like_res` (`like_res_id`, `user_id`, `res_id`, `date_like`, `dis_like`) VALUES
(3, 4, 2, '2023-01-10 12:38:41', 0);
INSERT INTO `like_res` (`like_res_id`, `user_id`, `res_id`, `date_like`, `dis_like`) VALUES
(4, 5, 2, '2023-01-10 12:38:41', 0),
(5, 6, 2, '2023-01-10 12:38:41', 0),
(6, 7, 2, '2023-01-10 12:38:41', 0),
(7, 8, 2, '2023-01-10 12:38:41', 0),
(8, 1, 1, '2023-01-10 12:38:41', 0),
(9, 1, 3, '2023-01-10 12:38:41', 0),
(10, 1, 4, '2023-01-10 12:38:41', 0),
(11, 1, 5, '2023-01-10 12:38:41', 0);

INSERT INTO `orders` (`orders_id`, `user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(1, 1, 1, 99, 'VLBL', 'arr_sub_id');
INSERT INTO `orders` (`orders_id`, `user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(2, 1, 2, 99, 'VLBL', 'arr_sub_id');
INSERT INTO `orders` (`orders_id`, `user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(3, 1, 3, 99, 'VLBL', 'arr_sub_id');
INSERT INTO `orders` (`orders_id`, `user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(4, 1, 4, 99, 'VLBL', 'arr_sub_id'),
(5, 1, 5, 99, 'VLBL', 'arr_sub_id'),
(6, 1, 6, 99, 'VLBL', 'arr_sub_id');

INSERT INTO `rate_res` (`rate_res_id`, `user_id`, `res_id`, `amount`, `date_rate`) VALUES
(1, 1, 1, 11, '2023-01-10 12:38:41');
INSERT INTO `rate_res` (`rate_res_id`, `user_id`, `res_id`, `amount`, `date_rate`) VALUES
(2, 3, 1, 11, '2023-01-10 12:38:41');
INSERT INTO `rate_res` (`rate_res_id`, `user_id`, `res_id`, `amount`, `date_rate`) VALUES
(3, 4, 1, 11, '2023-01-10 12:38:41');
INSERT INTO `rate_res` (`rate_res_id`, `user_id`, `res_id`, `amount`, `date_rate`) VALUES
(4, 1, 1, 11, '2023-01-10 12:38:41'),
(5, 1, 2, 11, '2023-01-10 12:38:41'),
(6, 1, 3, 99, '2023-01-10 12:38:41'),
(7, 1, 4, 99, '2023-01-10 12:38:41'),
(8, 1, 5, 99, '2023-01-10 12:38:41'),
(9, 1, 5, 99, '2023-01-10 12:38:41'),
(10, 1, 6, 99, '2023-01-10 12:38:41');

INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `desciption`) VALUES
(1, 'laudantium', 'tmp//5576ed1c9626480808732ad47f5e9cd1.jpg', 'Facilis voluptate quia quas unde. Facere omnis ut quo ex odit praesentium laborum.');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `desciption`) VALUES
(2, 'a', 'tmp//96e7b8175b5660ae0292450434ac1038.jpg', 'Accusamus et culpa dolorem est dolorem. Quidem et laboriosam velit aut nihil.');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `desciption`) VALUES
(3, 'occaecati', 'tmp//a95b6509bc852741f09582474efdfed4.jpg', 'Ex quia quia quasi vero ut voluptas. Porro ullam quam perferendis laboriosam. Nesciunt officiis maiores inventore aliquam. Maxime non odio saepe maxime.');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `desciption`) VALUES
(4, 'maiores', 'tmp//2a49adfbd0618a76dc582484ec095e36.jpg', 'Assumenda ut minus molestiae dolores eum. Non minima iste amet ea nemo. Ipsam quae debitis qui sint.'),
(5, 'repellendus', 'tmp//369f50b93b2b90c1782a28142196d6a1.jpg', 'Dolorem animi ut est possimus rerum ipsum. Et perferendis voluptatem cumque voluptatem. Facere harum iusto et quas. Ipsam exercitationem nisi commodi sit est est temporibus vel.'),
(6, 'sint', 'tmp//0b8f5328f5055cbbf1f2a22bdfcdf012.jpg', 'Deserunt quia quo cumque saepe sequi praesentium nemo. Harum ex aut labore debitis est quis pariatur. Aut similique est molestiae dolorem quibusdam expedita et. Veniam tempore est impedit dolorum.'),
(7, 'voluptatem', 'tmp//22ace1d076413baf86c2f9baa9a63d93.jpg', 'Fugiat quisquam dolorem sapiente placeat nemo ea magni. Vel occaecati et eos voluptas suscipit expedita. Fugit quo nihil facilis debitis beatae quod laborum architecto. Odit qui impedit a voluptatum.'),
(8, 'exercitationem', 'tmp//42ee59b80d3e588cc6647c091aa9758c.jpg', 'Laborum quibusdam deleniti non voluptatem. Et architecto a non est et cumque deleniti. Similique nemo aut quo accusamus non quam.'),
(9, 'sunt', 'tmp//ddd9c70808dccbf646bd923b0329536e.jpg', 'Possimus non expedita voluptas autem temporibus voluptate praesentium. Esse est sit qui quia. Excepturi omnis eligendi et voluptatem distinctio alias. Tempore est ea consequatur sapiente.'),
(10, 'nesciunt', 'tmp//bad5269d346190aa06f31b010d2d22fd.jpg', 'Vitae ipsa placeat atque et magni. Voluptas dolore necessitatibus atque quibusdam sapiente. Modi rerum totam quisquam aliquam.'),
(11, 'voluptatem', 'tmp//5d7151f4b81edd57dda8aeb936a6d13a.jpg', 'Nihil ullam vel recusandae accusantium expedita porro illum. Ducimus provident inventore id placeat nisi. Debitis reiciendis exercitationem minima neque quo aut et animi.'),
(12, 'asperiores', 'tmp//b27ccc60428ed04f6507d29908078849.jpg', 'Et consectetur ut sed et. Fugiat esse ut eveniet. Iste possimus et corporis rem perferendis enim. Excepturi eum ea nostrum corporis occaecati quas ratione.'),
(13, 'aliquid', 'tmp//774edff181beb5af5c859bc861cd9e81.jpg', 'Perspiciatis commodi ratione suscipit ut dolore provident. Veritatis eos asperiores repudiandae exercitationem velit et. Necessitatibus nostrum rem quia.'),
(14, 'eius', 'tmp//0b04b74e212b7f74eea53b709b04b4f7.jpg', 'Illum possimus quo ex incidunt ea numquam iure. Nam voluptate tenetur eaque ut ut atque. Earum eaque quia enim et omnis. Ut consequatur magni quasi et tempore est temporibus.'),
(15, 'est', 'tmp//9799f953c0441ce37c3fc8247261015e.jpg', 'Quisquam rerum est ipsum pariatur assumenda sit et. Doloremque accusantium officiis nobis sapiente harum natus ut dolor. Libero vitae porro doloribus dicta natus enim.'),
(16, 'doloribus', 'tmp//5be12197d870dea35b545f3e11b6de5f.jpg', 'In saepe iure occaecati dolore. Accusantium ipsam blanditiis culpa repellendus doloremque reiciendis.'),
(17, 'provident', 'tmp//429e7c8f7c2a683d51a81139cae6c2d8.jpg', 'Blanditiis quos velit dolorem doloribus. Esse consequatur dolore autem. Soluta fuga ex quo amet quia eaque. Ut soluta sit cum dolores.'),
(18, 'quaerat', 'tmp//22fea412beebde2174058d0bf4460227.jpg', 'Aut et dolorem quia voluptate quibusdam consequatur dicta. Ut occaecati quaerat neque quae. Ducimus nesciunt sed sit rerum et nihil at. Vero corporis rerum consequatur sed.'),
(19, 'praesentium', 'tmp//6e43b3632e000d211075bdae87b3e872.jpg', 'Provident quos voluptate delectus at omnis ullam. Sed est ipsa laudantium in optio et. Aut eum laboriosam numquam eius expedita.'),
(20, 'unde', 'tmp//19042640307cd4f9fd4a3ee2542d781f.jpg', 'Sunt quia sit et doloremque ea. Nobis at ex qui vero quia. Quo suscipit qui facere. Placeat voluptatem incidunt fuga laudantium nobis. Iste autem repudiandae earum doloremque nostrum.'),
(21, 'illo', 'tmp//6d1523dba09df145726c5ee8aacb6382.jpg', 'Deleniti inventore maxime cumque quaerat. Ut doloremque doloremque blanditiis est voluptates corrupti. Ut minus aut cumque voluptate vel quae dolorem amet.'),
(22, 'possimus', 'tmp//37037e7461aba7e79d8e8e17aa3daaa9.jpg', 'Et est illo in iure dolor. Qui sed consequatur necessitatibus voluptatem vitae mollitia amet consectetur. Ut excepturi neque ducimus quae sunt.'),
(23, 'repellendus', 'tmp//7ba0636a72fd79890c02b3dfdd08ad86.jpg', 'Minima deserunt sed ut molestiae vero velit quo enim. Reiciendis quam ut est quibusdam repellendus. Rerum ipsa voluptatem qui ullam mollitia vero ea.'),
(24, 'ut', 'tmp//00392f750801c39c1cddbf06c201ad55.jpg', 'Facilis harum veniam sequi fuga in. Repudiandae animi necessitatibus quidem a saepe molestiae voluptatem. Id laborum sapiente ut id qui.'),
(25, 'nihil', 'tmp//f45ceae377324f4980d569f9bdceaf4c.jpg', 'Molestiae accusantium fugit nam quam sed totam. Et earum vel sed nisi hic et. Laborum molestiae totam labore provident dolor voluptatem qui. Quia aut dolorem aspernatur dolorum.'),
(26, 'ipsam', 'tmp//818546e49ef7f2ab21423afc0de1f209.jpg', 'Consequatur ipsa nobis est voluptas fuga neque. Assumenda corrupti quam voluptatem accusamus est sint. Molestiae sapiente voluptatem omnis est velit corporis.'),
(27, 'id', 'tmp//ad598e67b568dc30ef7ce5392eee2a2d.jpg', 'Aut aliquam laudantium eos asperiores ipsa dolor. Voluptatem sed nemo aut quasi nihil ut sint veniam.'),
(28, 'id', 'tmp//58236b2186605f1fedf2171b8ab411df.jpg', 'Qui in fuga qui molestiae. Quod assumenda nostrum sequi officia quasi. Dolore commodi veritatis earum facilis praesentium. Iure ipsa voluptas est cupiditate.'),
(29, 'deserunt', 'tmp//77cf4a117e2ac3112b34340242397675.jpg', 'Ea et minus accusamus possimus qui voluptas. Repellendus et magnam omnis dignissimos dolores reprehenderit magnam. Et assumenda a inventore voluptatem similique ut aliquam sapiente.'),
(30, 'eius', 'tmp//4c55f7dcc3d340e295a4e93d6189e5ff.jpg', 'Maxime corrupti iste pariatur vel consectetur asperiores. Omnis eos deserunt aperiam autem. Neque illo ut sit aut repudiandae inventore. At ut accusamus vero vel ducimus quia tempore hic.'),
(31, 'laboriosam', 'tmp//6e149f56a45f74ab1cec2c48c50fbdd0.jpg', 'Id consequatur aut dicta. Quo eum tempore quas facere voluptatem. Est mollitia est vel.\nNam aut consectetur odit. Inventore vero autem dolor. Dolor sint in ut sunt magnam.'),
(32, 'et', 'tmp//ab383510ac9be8c09da2055605367ce2.jpg', 'Voluptatem quis possimus quis deserunt pariatur qui iusto unde. Eius sequi et cumque molestias laudantium. Dolores nobis quod possimus sunt impedit.'),
(33, 'eius', 'tmp//9e0b2f37e51950fd3fd4622b4ef93daa.jpg', 'Porro nihil sequi recusandae assumenda minima consequatur. In est nulla eos quos omnis quam aut.'),
(34, 'et', 'tmp//43ff5ba59b3839ac33eebffb855654be.jpg', 'Tempore sit et ab tempora quia quo. Expedita id molestias molestiae aut illo est. Aut odio odit nesciunt est optio ut. Et similique eaque placeat est voluptatem ut magnam.'),
(35, 'eligendi', 'tmp//224aa90a3a80ab056673af2b4e5f1065.jpg', 'Odio et est id dolorem sed. Deleniti corporis voluptatibus esse incidunt aliquam. Quae sed quo ex possimus rerum. Id et ipsum ullam reiciendis. Qui voluptatibus itaque doloribus.'),
(36, 'libero', 'tmp//19c3ddab7598c27dd3ac7b2216171c77.jpg', 'Magni temporibus minus corporis eos. Magni voluptas laborum saepe placeat. Soluta sed eos doloribus rerum odio. Molestiae explicabo fugiat adipisci repellat quidem.'),
(37, 'voluptate', 'tmp//e32432fcaa05d5318f5b241676552d23.jpg', 'Eum corrupti velit cupiditate illum. Quaerat earum sequi suscipit ducimus velit a. Optio in quaerat eaque sunt. Aspernatur qui optio saepe.'),
(38, 'quo', 'tmp//3cdf23ef9f1e17af0ac667e2b0b6488a.jpg', 'Quo modi asperiores modi maiores. Quia ullam dolorem vel autem. Libero qui molestias consectetur voluptas quia. Magni qui amet libero.'),
(39, 'libero', 'tmp//ee0f391b48257480b6d5c4f3e56c3ab9.jpg', 'Facilis at omnis sed laudantium ab. Maxime nisi rerum et eaque. Dolor quo quam asperiores ab fuga ducimus nulla soluta. Vero voluptates excepturi dolores dolorem tempora atque.'),
(40, 'cupiditate', 'tmp//c0a51891e77d8a9443832d108bf4a527.jpg', 'Dolorem alias aut voluptatem amet deleniti nesciunt. Iusto sint consequuntur dolorum ad in sint. Et eum iusto cupiditate ad saepe.'),
(41, 'nisi', 'tmp//786fa332db0ad9b2546c5dc7f1de5099.jpg', 'Et omnis nihil at. Et mollitia eos earum optio eligendi iure consequatur. Asperiores dolores corporis sequi suscipit. Voluptatem pariatur voluptas eius magni.'),
(42, 'qui', 'tmp//bdfe125b5a021cb3e56815bab35efd58.jpg', 'Optio consequatur aspernatur impedit quis vero dignissimos. Quibusdam accusantium id impedit commodi sunt neque. Explicabo laudantium unde ut.'),
(43, 'alias', 'tmp//7fd6b86afda336bfdfea78ffc8bb84c5.jpg', 'Praesentium ut quam deserunt omnis dolorem minima beatae fugiat. Dolore vel consequatur eius incidunt. Quis iure illum laboriosam aut nemo qui. Consequatur provident facilis distinctio expedita.'),
(44, 'est', 'tmp//c29128135cca2e7f749a880a31eef543.jpg', 'Ad illo ut deleniti vel sed repellat quas. Nulla reprehenderit natus ipsa quas. Saepe dolor qui accusamus minima natus quibusdam labore.'),
(45, 'est', 'tmp//4149b0c376c6c138b7f622791f9fa2a7.jpg', 'Aliquid fugiat magni possimus eum nobis minima. Id odio unde aperiam. Eaque distinctio nihil explicabo in voluptatem saepe ratione.'),
(46, 'consequatur', 'tmp//8d9b5be912f19ed76aa6f7172c46f1cd.jpg', 'Vero dolorem animi qui dolorum. Fugit sit et voluptatem unde incidunt cumque.'),
(47, 'facere', 'tmp//1892236552eda64ca849c1b69309c108.jpg', 'Alias eum harum nesciunt ut voluptatem enim. Repellendus necessitatibus adipisci modi facere. Architecto distinctio officiis qui blanditiis repellendus tenetur praesentium.'),
(48, 'aliquid', 'tmp//03c3d65777e3acd4282c2c2d092ca5e8.jpg', 'Deserunt laboriosam similique quo sit eum ut commodi. Maxime quaerat tenetur quis praesentium alias velit ut magni. Aspernatur atque itaque qui ut mollitia quasi et.'),
(49, 'neque', 'tmp//670afe06726d07c5c8db2ce7e2665c10.jpg', 'Rerum omnis dolore sed accusamus recusandae. Minima voluptas dolorem voluptatem molestias hic. Nesciunt excepturi excepturi exercitationem. Sed modi et at quo blanditiis et est.'),
(50, 'nulla', 'tmp//ee6f2e8925902be52ca32c805716493c.jpg', 'Rerum similique ipsam est ea consequatur ipsa voluptatum. Et blanditiis omnis et et quia commodi officiis. Saepe at et velit. Nemo unde nemo omnis voluptatum ut sit optio modi.');

INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(1, 'Damaliscus lunatus', 75, 39);
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(2, 'Geochelone elegans', 5, 99);
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(3, 'Coluber constrictor', 50, 21);
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(4, 'Callorhinus ursinus', 3, 37),
(5, 'Bassariscus astutus', 29, 12),
(6, 'Bettongia penicillata', 80, 89),
(7, 'Papilio canadensis', 28, 61),
(8, 'Alectura lathami', 83, 10),
(9, 'Phalaropus fulicarius', 50, 55),
(10, 'Trichoglossus haematodus moluccanus', 56, 15),
(11, 'Tenrec ecaudatus', 99, 76),
(12, 'Nycticorax nycticorax', 78, 52),
(13, 'Graspus graspus', 80, 66),
(14, 'Dasypus novemcinctus', 3, 74),
(15, 'Halcyon smyrnesis', 76, 62),
(16, 'Bison bison', 53, 88),
(17, 'Corvus albicollis', 95, 9),
(18, 'unavailable', 78, 95),
(19, 'Grus rubicundus', 85, 92),
(20, 'Corvus albus', 45, 6),
(21, 'Tockus flavirostris', 52, 70),
(22, 'Papio ursinus', 12, 10),
(23, 'Pelecanus occidentalis', 56, 36),
(24, 'Agelaius phoeniceus', 13, 61),
(25, 'Haliaetus leucogaster', 47, 66),
(26, 'Cacatua tenuirostris', 1, 90),
(27, 'Anastomus oscitans', 56, 30),
(28, 'unavailable', 32, 96),
(29, 'Sciurus vulgaris', 38, 67),
(30, 'Cervus elaphus', 23, 40),
(31, 'Cebus nigrivittatus', 48, 48),
(32, 'Aonyx capensis', 45, 93),
(33, 'Cracticus nigroagularis', 63, 79),
(34, 'Felis wiedi or Leopardus weidi', 36, 89),
(35, 'Vanessa indica', 87, 7),
(36, 'Bos frontalis', 23, 2),
(37, 'Porphyrio porphyrio', 53, 98),
(38, 'Pseudocheirus peregrinus', 1, 29),
(39, 'Genetta genetta', 41, 41),
(40, 'Damaliscus lunatus', 11, 98),
(41, 'Equus hemionus', 15, 50),
(42, 'Smithopsis crassicaudata', 4, 15),
(43, 'Felis serval', 68, 19),
(44, 'Bubalus arnee', 36, 4),
(45, 'Vulpes vulpes', 77, 17),
(46, 'Marmota flaviventris', 41, 77),
(47, 'Connochaetus taurinus', 65, 22),
(48, 'Callipepla gambelii', 75, 2),
(49, 'Spermophilus parryii', 79, 54),
(50, 'Alopex lagopus', 98, 65),
(51, 'Genetta genetta', 36, 30),
(52, 'Bubalornis niger', 96, 81),
(53, 'Cervus canadensis', 49, 80),
(54, 'Odocoileus hemionus', 11, 11),
(55, 'Ctenophorus ornatus', 72, 5),
(56, 'unavailable', 44, 86),
(57, 'Trichosurus vulpecula', 16, 53),
(58, 'Crotaphytus collaris', 63, 77),
(59, 'Psophia viridis', 39, 87),
(60, 'Dasypus septemcincus', 53, 92),
(61, 'Nyctea scandiaca', 92, 24),
(62, 'Choloepus hoffmani', 12, 35),
(63, 'Ursus arctos', 16, 42),
(64, 'Cebus apella', 49, 46),
(65, 'Calyptorhynchus magnificus', 75, 53),
(66, 'Odocoilenaus virginianus', 26, 1),
(67, 'Redunca redunca', 48, 64),
(68, 'Speotyte cuniculata', 45, 3),
(69, 'Gyps bengalensis', 55, 18),
(70, 'Neophoca cinerea', 25, 74),
(71, 'Iguana iguana', 26, 18),
(72, 'Physignathus cocincinus', 14, 38),
(73, 'Dendrohyrax brucel', 3, 76),
(74, 'Ammospermophilus nelsoni', 33, 43),
(75, 'Equus hemionus', 93, 9),
(76, 'Macropus eugenii', 44, 34),
(77, 'Cercatetus concinnus', 76, 36),
(78, 'Mazama gouazoubira', 46, 14),
(79, 'Colobus guerza', 31, 38),
(80, 'Upupa epops', 91, 74),
(81, 'Ctenophorus ornatus', 11, 31),
(82, 'Zalophus californicus', 60, 62),
(83, 'Capreolus capreolus', 86, 67),
(84, 'Macaca radiata', 84, 63),
(85, 'Lamprotornis nitens', 76, 28),
(86, 'Chamaelo sp.', 2, 79),
(87, 'Chauna torquata', 7, 15),
(88, 'Phascogale calura', 1, 13),
(89, 'Alopex lagopus', 73, 96),
(90, 'Ciconia episcopus', 81, 35),
(91, 'Lasiodora parahybana', 26, 31),
(92, 'Panthera leo persica', 7, 47),
(93, 'Litrocranius walleri', 31, 88),
(94, 'Echimys chrysurus', 26, 28),
(95, 'Helogale undulata', 29, 18),
(96, 'Ciconia episcopus', 48, 17),
(97, 'Aegypius tracheliotus', 36, 95),
(98, 'Galago crassicaudataus', 7, 77),
(99, 'Lepilemur rufescens', 57, 7),
(100, 'Hippotragus niger', 39, 19),
(101, 'Cacatua tenuirostris', 57, 80),
(102, 'Perameles nasuta', 91, 48),
(103, 'Semnopithecus entellus', 14, 61),
(104, 'Funambulus pennati', 87, 29),
(105, 'Pytilia melba', 91, 73),
(106, 'Gorilla gorilla', 56, 57),
(107, 'Alopex lagopus', 43, 20),
(108, 'Butorides striatus', 55, 19),
(109, 'Varanus sp.', 64, 20),
(110, 'Castor fiber', 26, 100),
(111, 'Tachybaptus ruficollis', 24, 95),
(112, 'Taxidea taxus', 2, 1),
(113, 'Streptopelia senegalensis', 96, 91),
(114, 'Ara chloroptera', 43, 13),
(115, 'Cynictis penicillata', 27, 91),
(116, 'Taxidea taxus', 26, 91),
(117, 'Milvago chimachima', 60, 94),
(118, 'Aegypius tracheliotus', 57, 43),
(119, 'Macropus agilis', 2, 87),
(120, 'Phalaropus fulicarius', 49, 68),
(121, 'Tragelaphus scriptus', 34, 65),
(122, 'Thalasseus maximus', 72, 14),
(123, 'Trichoglossus chlorolepidotus', 61, 93),
(124, 'Bassariscus astutus', 96, 90),
(125, 'Vanellus chilensis', 71, 55),
(126, 'Numida meleagris', 90, 5),
(127, 'Cynictis penicillata', 3, 73),
(128, 'Leptoptilos crumeniferus', 82, 32),
(129, 'Felis concolor', 9, 36),
(130, 'Macaca mulatta', 86, 79),
(131, 'Phalacrocorax niger', 10, 64),
(132, 'Ratufa indica', 36, 66),
(133, 'Coendou prehensilis', 79, 75),
(134, 'Varanus sp.', 12, 55),
(135, 'Plocepasser mahali', 72, 70),
(136, 'Suricata suricatta', 67, 21),
(137, 'Elephas maximus bengalensis', 53, 47),
(138, 'Cygnus atratus', 41, 34),
(139, 'Thamnolaea cinnmomeiventris', 98, 39),
(140, 'Passer domesticus', 3, 96),
(141, 'unavailable', 57, 94),
(142, 'Manouria emys', 78, 64),
(143, 'Acanthaster planci', 1, 64),
(144, 'Ctenophorus ornatus', 16, 3),
(145, 'Phalaropus fulicarius', 43, 78),
(146, 'Grus antigone', 10, 21),
(147, 'Phalaropus fulicarius', 7, 81),
(148, 'Felis concolor', 72, 100),
(149, 'Castor fiber', 93, 53),
(150, 'Larus dominicanus', 47, 85),
(151, 'Didelphis virginiana', 99, 18),
(152, 'Macropus eugenii', 96, 10),
(153, 'Oryx gazella', 75, 87),
(154, 'Ninox superciliaris', 82, 4),
(155, 'Felis silvestris lybica', 30, 51),
(156, 'Centrocercus urophasianus', 39, 10),
(157, 'Acrantophis madagascariensis', 71, 44),
(158, 'Sarcophilus harrisii', 11, 91),
(159, 'Eumetopias jubatus', 86, 49),
(160, 'Cordylus giganteus', 11, 98),
(161, 'Otaria flavescens', 42, 95),
(162, 'Eubalaena australis', 11, 83),
(163, 'Ctenophorus ornatus', 73, 30),
(164, 'Mirounga angustirostris', 59, 61),
(165, 'Boa caninus', 17, 6),
(166, 'Naja haje', 6, 97),
(167, 'Bison bison', 31, 50),
(168, 'Morelia spilotes variegata', 35, 76),
(169, 'Agkistrodon piscivorus', 47, 51),
(170, 'Sylvicapra grimma', 36, 98),
(171, 'Ursus americanus', 61, 3),
(172, 'Paraxerus cepapi', 24, 22),
(173, 'Ploceus rubiginosus', 75, 21),
(174, 'Sagittarius serpentarius', 54, 18),
(175, 'Sciurus vulgaris', 6, 45),
(176, 'Macropus giganteus', 70, 85),
(177, 'Boa constrictor mexicana', 57, 33),
(178, 'Choloepus hoffmani', 52, 8),
(179, 'Vombatus ursinus', 82, 14),
(180, 'Sceloporus magister', 76, 40),
(181, 'Lemur catta', 26, 65),
(182, 'Uraeginthus granatina', 24, 50),
(183, 'Raphicerus campestris', 15, 76),
(184, 'Phalacrocorax niger', 57, 35),
(185, 'Cervus canadensis', 15, 48),
(186, 'Actophilornis africanus', 37, 57),
(187, 'Prionace glauca', 71, 84),
(188, 'Fregata magnificans', 19, 35),
(189, 'Potamochoerus porcus', 30, 73),
(190, 'Amphibolurus barbatus', 70, 20),
(191, 'Fregata magnificans', 66, 69),
(192, 'Callipepla gambelii', 27, 19),
(193, 'Terathopius ecaudatus', 19, 34),
(194, 'Felis concolor', 28, 93),
(195, 'Ctenophorus ornatus', 81, 65),
(196, 'Tamiasciurus hudsonicus', 20, 80),
(197, 'Lorythaixoides concolor', 49, 72),
(198, 'Melursus ursinus', 34, 53),
(199, 'Pitangus sulphuratus', 14, 57),
(200, 'Creagrus furcatus', 99, 65);

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`) VALUES
(1, 'vulebaolong', 'vulebaolong@gmail.com', '$2b$10$YgasEyfrUmTJw7qQ6LZ0a.2fEIVLy74R0PVph1084OqA0rzq2S2jW');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`) VALUES
(3, 'vulebaolong1', 'vulebaolong1@gmail.com', '$2b$10$3tcOSbLEqnimAWrOQ6UtaeNmlHOErtftuqfaRjAcE29e5n9rDFJYC');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`) VALUES
(4, 'vulebaolong2', 'vulebaolong2@gmail.com', '$2b$10$6945LO0FLt9hVK9Ph1UGH.rSSkdsFX6eF04l8ieAeG1VtJeRY/k5i');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`) VALUES
(5, 'vulebaolong3', 'vulebaolong3@gmail.com', '$2b$10$S/dmwhR5CWjta76.HiGp/OOP4we1X0OJ53omXTyDavsPKkx3P26RG'),
(6, 'vulebaolong4', 'vulebaolong4@gmail.com', '$2b$10$nkDo.tw8aNUKu9z/gZE0kOC6OQzYD12ReiAOLn5y0obuVWBKSvAgC'),
(7, 'vulebaolong4', 'vulebaolong5@gmail.com', '$2b$10$SSCMsjCplukDYokjBHH5GOZwFRU1X0ZCyJffCd2UepQuZ2oLvbt4i'),
(8, 'vulebaolong6', 'vulebaolong6@gmail.com', '$2b$10$xRGLIahoFpFwvxwcRHQYQeO.W7B14ev1BXXIEVjfdGJj9vOajEKXK'),
(9, 'vulebaolong7', 'vulebaolong7@gmail.com', '$2b$10$2B9ebxFuQKjfteNLXsJG2ehiu/DaY0C6mt1gSXlwnvH3B/48rIN9y');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;