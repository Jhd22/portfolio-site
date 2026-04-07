-- =============================================================================
-- Personal AI System — Seed Data
-- Generated: 2026-03-28
-- Source: Læseplan_Dashboard.jsx
-- =============================================================================

-- =============================================================================
-- READINGS — 119 texts across IR2, Økonomi, Metode (weeks 6-21)
-- =============================================================================

-- Note on 'course' field: JSX uses 'fag' with values 'IR2', 'Økonomi', 'Metode'
-- These map directly to the schema's 'course' column

INSERT INTO readings (id, course, week, lecture, title, author, pages, status, priority, type, mode, depth, notes) VALUES

-- === IR2 ===

-- Week 6 - Lecture 1: Introduction
(1,  'IR2', 6, 'Forelæsning 1: Introduction', 'Introduction: Diversity and disciplinarity in IR Theory, 1-12', 'Smith (2024)', 12, 'ikke_startet', 'mellem', 'catch_up', 'noter', 'unread', NULL),

-- Week 6 - Lecture 2: Neorealism
(2,  'IR2', 6, 'Forelæsning 2: Neorealism', 'Introduktion til Studiet af International Politik, 124-132', 'Wæver (1992)', 9, 'ikke_startet', 'mellem', 'catch_up', 'noter', 'unread', NULL),
(3,  'IR2', 6, 'Forelæsning 2: Neorealism', 'Theory of International Politics, 88-101, 116-161', 'Waltz (1979)', 45, 'i_gang', 'høj', 'catch_up', 'fuld', 'unread', 'Nået til s. 96'),
(4,  'IR2', 6, 'Forelæsning 2: Neorealism', 'Structural Realism after the Cold War, 5-41', 'Waltz (2000)', 37, 'ikke_startet', 'mellem', 'catch_up', 'noter', 'unread', NULL),
(5,  'IR2', 6, 'Forelæsning 2: Neorealism', 'Structural Realism, 72-86', 'Mearsheimer (2024)', 15, 'ikke_startet', 'mellem', 'catch_up', 'fuld', 'unread', NULL),

-- Week 7 - Lecture 3: Neoclassical Realism
(6,  'IR2', 7, 'Forelæsning 3: Neoclassical Realism', 'Neoclassical Realist Theory of International Politics, 16-79', 'Ripsman, Taliaferro & Lobell (2016)', 63, 'i_gang', 'høj', 'catch_up', 'fuld', 'unread', 'Nået til s. 62'),
(7,  'IR2', 7, 'Forelæsning 3: Neoclassical Realism', 'Neoclassical Realism, Global IR, and the unheard echoes, 369-386', 'Cerioli (2025)', 17, 'ikke_startet', 'lav', 'catch_up', 'noter', 'unread', NULL),

-- Week 7 - Lecture 4: Liberalism
(8,  'IR2', 7, 'Forelæsning 4: Liberalism', 'Liberalism, 68-88', 'Jørgensen (2024)', 21, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),
(9,  'IR2', 7, 'Forelæsning 4: Liberalism', 'Diplomacy and domestic politics: the logic of two-level games, 427-460', 'Putnam (1988)', 34, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),
(10, 'IR2', 7, 'Forelæsning 4: Liberalism', 'Taking Preferences Seriously: A Liberal Theory of International Politics, 513-553', 'Moravcsik (1997)', 41, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),

-- Week 8 - Lecture 5: Neoliberal Institutionalism
(11, 'IR2', 8, 'Forelæsning 5: Neoliberal Institutionalism', 'Neoliberalism, 110-126', 'Sterling-Folker (2024)', 17, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(12, 'IR2', 8, 'Forelæsning 5: Neoliberal Institutionalism', 'Neoliberal Institutionalism: A perspective on World Politics, 1-19', 'Keohane (1989/2018)', 20, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(13, 'IR2', 8, 'Forelæsning 5: Neoliberal Institutionalism', 'Contested Global Governance, 138-145', 'Zürn (2018)', 7, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(14, 'IR2', 8, 'Forelæsning 5: Neoliberal Institutionalism', 'Cooperation and discord in global climate policy, 570-575', 'Keohane & Victor (2016)', 6, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(15, 'IR2', 8, 'Forelæsning 5: Neoliberal Institutionalism', 'Against the clock to address plastic pollution, 1-12', 'Gonçalves et al. (2024)', 13, 'ikke_startet', 'lav', 'pensum', 'fuld', 'unread', NULL),

-- Week 8 - Lecture 6: Constructivism
(16, 'IR2', 8, 'Forelæsning 6: Constructivism', 'Constructivisms in IR: Wendt, Onuf and Kratochwil, 54-75', 'Zehfuss (2001)', 22, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(17, 'IR2', 8, 'Forelæsning 6: Constructivism', 'Anarchy is what States make of it: The Social Construction of Power Politics, 391-425', 'Wendt (1992)', 35, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(18, 'IR2', 8, 'Forelæsning 6: Constructivism', 'The Nuclear Taboo: The US and the Normative Basis of Nuclear Non-Use, 433-468', 'Tannenwald (1999)', 36, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 9 - Lecture 7: Practice Turn
(19, 'IR2', 9, 'Forelæsning 7: Practice Turn', 'Situating Practice in Social Theory and IR, 13-33', 'Bueger & Gadinger (2018)', 20, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(20, 'IR2', 9, 'Forelæsning 7: Practice Turn', 'Communities of Practice in World Politics', 'Adler, Bremberg & Sondarjee (2024)', 10, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(21, 'IR2', 9, 'Forelæsning 7: Practice Turn', 'Change in international practices, 687-711', 'Hopf (2017)', 24, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 9 - Lecture 8: Feminist and Queer IR
(22, 'IR2', 9, 'Forelæsning 8: Feminist and Queer IR', 'Feminism, 209-221', 'Sjoberg & Tickner (2024)', 13, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(23, 'IR2', 9, 'Forelæsning 8: Feminist and Queer IR', 'Gender, Nation, Rape: Bosnia and the Construction of Security, 55-75', 'Hansen (2001)', 21, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(24, 'IR2', 9, 'Forelæsning 8: Feminist and Queer IR', 'Mother Russia in Queer Peril, 105-121', 'Wilkinson (2018)', 17, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(25, 'IR2', 9, 'Forelæsning 8: Feminist and Queer IR', 'Making Sense of International LGBTI Rights Promotion, 175-187', 'Edenborg (2025)', 10, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(26, 'IR2', 9, 'Forelæsning 8: Feminist and Queer IR', 'Politicized Homophobia: Sexual Moralism, National Identity, and Foreign Policy, 188-200', 'Cooper-Cunningham (2025)', 10, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 10 - Lecture 9: Postcolonialism
(27, 'IR2', 10, 'Forelæsning 9: Postcolonialism', 'Postcolonialism, 247-261', 'Biswas (2024)', 15, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(28, 'IR2', 10, 'Forelæsning 9: Postcolonialism', 'Postcolonial Theory and the Critique of International Relations, 167-183', 'Seth (2011)', 17, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(29, 'IR2', 10, 'Forelæsning 9: Postcolonialism', 'Colonialism, genocide and IR: the Namibian-German case, 91-115', 'Weber & Weber (2020)', 25, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 10 - Lecture 10: Poststructuralism
(30, 'IR2', 10, 'Forelæsning 10: Poststructuralism', 'Poststructuralism, 164-187', 'Devetak (2022)', 24, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(31, 'IR2', 10, 'Forelæsning 10: Poststructuralism', 'Forget September 11, 513-528', 'Zehfuss (2003)', 16, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(32, 'IR2', 10, 'Forelæsning 10: Poststructuralism', 'Exceptionalism and the Politics of Counter-Terrorism, Chapter 6', 'Neal (2010)', 18, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(33, 'IR2', 10, 'Forelæsning 10: Poststructuralism', 'Writing Security: US Foreign Policy and the Politics of Identity, Introduction', 'Campbell (1998)', 14, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 11 - Lecture 11: Marxism
(34, 'IR2', 11, 'Forelæsning 11: Marxism', 'Imperialism as a special stage of capitalism, 66-74', 'Lenin (1916)', 9, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(35, 'IR2', 11, 'Forelæsning 11: Marxism', 'Social Forces, States and World Orders: Beyond IR Theory, 126-155', 'Cox (1981)', 30, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(36, 'IR2', 11, 'Forelæsning 11: Marxism', 'Marx and the critique of Actor-Network Theory, 294-313', 'Sayes (2017)', 19, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(37, 'IR2', 11, 'Forelæsning 11: Marxism', 'Uneven and combined development, 17-30', 'Rosenberg (2016)', 13, 'ikke_startet', 'lav', 'pensum', 'fuld', 'unread', NULL),

-- Week 11 - Lecture 12: New Materialism
(38, 'IR2', 11, 'Forelæsning 12: New Materialism', 'Actor-Network Theory and methodology, 134-149', 'Sayes (2014)', 16, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(39, 'IR2', 11, 'Forelæsning 12: New Materialism', 'We have never been civilized: Torture and the materiality of world political binaries, 49-73', 'Austin (2017)', 25, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(40, 'IR2', 11, 'Forelæsning 12: New Materialism', 'The Materiality of State Failure, 553-574', 'Schouten (2013)', 22, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 12 - Lecture 13: Green IR
(41, 'IR2', 12, 'Forelæsning 13: Green IR', 'International Relations, the Environment, and Green Theory, 292-310', 'Eckersley & Corry (2024)', 19, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(42, 'IR2', 12, 'Forelæsning 13: Green IR', 'The Anthropocene and the geo-political imagination', 'Lövbrand, Mobjörk & Söder (2020)', 8, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(43, 'IR2', 12, 'Forelæsning 13: Green IR', 'What if we don''t take nature for granted, 97-120', 'Fishel (2025)', 24, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(44, 'IR2', 12, 'Forelæsning 13: Green IR', 'Many worlds, many nature(s), one planet, 1-19', 'Inoue & Moreira (2016)', 19, 'ikke_startet', 'lav', 'pensum', 'fuld', 'unread', NULL),

-- Week 12 - Lecture 14: The End of IR
(45, 'IR2', 12, 'Forelæsning 14: The End of IR', 'Still a Discipline After All These Debates?, 333-353', 'Wæver (2024)', 21, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(46, 'IR2', 12, 'Forelæsning 14: The End of IR', 'IR at the End: A Sociological Autopsy, figure 1', 'Kristensen (2018)', 1, 'ikke_startet', 'lav', 'pensum', 'skim', 'unread', NULL),

-- === ØKONOMI 2 ===

-- Week 6
(50, 'Økonomi', 6, 'Introduktion og makroøkonomiske begreber', 'BAG kap 1+2', 'Blanchard et al.', 0, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),
(51, 'Økonomi', 6, 'Introduktion og makroøkonomiske begreber', 'PT kap 1 + 2.1, 2.2, 2.4, 2.9, 7.1', 'Trier (2025)', 0, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),
(52, 'Økonomi', 6, 'Varemarkedet og det keynesianske kryds', 'BAG kap 3', 'Blanchard et al.', 0, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),
(53, 'Økonomi', 6, 'Varemarkedet og det keynesianske kryds', 'PT kap 2.7', 'Trier (2025)', 0, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),

-- Week 8
(54, 'Økonomi', 8, 'Penge, finansielle markeder, IS-LM', 'BAG kap 4+5', 'Blanchard et al.', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(55, 'Økonomi', 8, 'Penge, finansielle markeder, IS-LM', 'PT 2.8 + 6.1, 6.2, 6.3 (til s. 111)', 'Trier (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),

-- Week 9
(56, 'Økonomi', 9, 'IS-LM-modellen', 'BAG kap 5+6', 'Blanchard et al.', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(57, 'Økonomi', 9, 'IS-LM-modellen', 'PT 6.4', 'Trier (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),

-- Week 10
(58, 'Økonomi', 10, 'Arbejdsmarked og inflation', 'BAG kap 7+8', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(59, 'Økonomi', 10, 'Arbejdsmarked og inflation', 'PT 2.5', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 11
(60, 'Økonomi', 11, 'IS-LM-PC og COVID-krisen', 'BAG kap 9+10', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(61, 'Økonomi', 11, 'IS-LM-PC og COVID-krisen', 'PT 2.6, 4.1', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 12
(62, 'Økonomi', 12, 'Stylized facts og Solow-modellen', 'BAG kap 11+12', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(63, 'Økonomi', 12, 'Stylized facts og Solow-modellen', 'PT 7.2, 7.3', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 13
(64, 'Økonomi', 13, 'Teknologiske fremskridt og grænser for vækst', 'BAG kap 13+14', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(65, 'Økonomi', 13, 'Teknologiske fremskridt og grænser for vækst', 'PT 7.4, 7.5 + kap 8', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 15
(66, 'Økonomi', 15, 'Forventninger og makroøkonomisk politik', 'BAG kap 16+17', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 16
(67, 'Økonomi', 16, 'Den åbne økonomi I', 'BAG kap 18+19', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(68, 'Økonomi', 16, 'Den åbne økonomi I', 'PT 2.3', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 17
(69, 'Økonomi', 17, 'Den åbne økonomi II', 'BAG kap 20+21', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(70, 'Økonomi', 17, 'Den åbne økonomi II', 'PT 6.3 (fra s. 111), 6.6, 6.7, 6.9', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 18
(71, 'Økonomi', 18, 'Finanspolitik og finanspolitiske regler', 'BAG kap 22+23', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(72, 'Økonomi', 18, 'Finanspolitik og finanspolitiske regler', 'PT 4.2, 4.3 + kap 5 + 6.8', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 19
(73, 'Økonomi', 19, 'Pengepolitik og finansiel regulering', 'BAG kap 24', 'Blanchard et al.', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(74, 'Økonomi', 19, 'Pengepolitik og finansiel regulering', 'PT 6.5', 'Trier (2025)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 20
(75, 'Økonomi', 20, 'Perspektiver: Makroøkonomiens historie', 'BAG kap 25', 'Blanchard et al.', 0, 'ikke_startet', 'lav', 'pensum', 'fuld', 'unread', NULL),
(76, 'Økonomi', 20, 'Perspektiver: Makroøkonomiens historie', 'DR kap 5+6', 'Rodrik', 0, 'ikke_startet', 'lav', 'pensum', 'fuld', 'unread', NULL),

-- === METODE 3 ===

-- Week 6 - F1
(80,  'Metode', 6, 'F1: Kvalitative metoder og forskningsspørgsmål', 'A framework for empirical political science research', 'Hansen, Andersen & Cecchini (2026)', 20, 'ikke_startet', 'høj', 'catch_up', 'fuld', 'unread', NULL),
(81,  'Metode', 6, 'F1: Kvalitative metoder og forskningsspørgsmål', 'Traveling to the Heart, in Strangers in Their Own Land, 3-25', 'Hochschild (2016)', 22, 'ikke_startet', 'mellem', 'catch_up', 'fuld', 'unread', NULL),
(82,  'Metode', 6, 'F1: Kvalitative metoder og forskningsspørgsmål', 'Sidewalk, Introduction, 53-61', 'Duneier (1999)', 8, 'ikke_startet', 'mellem', 'catch_up', 'fuld', 'unread', NULL),
(83,  'Metode', 6, 'F1: Kvalitative metoder og forskningsspørgsmål', 'Peaceland: Introduction, 1-19', 'Autesserre (2014)', 19, 'ikke_startet', 'mellem', 'catch_up', 'fuld', 'unread', NULL),

-- Week 8 - F2
(84,  'Metode', 8, 'F2: Forskningsdesign og kriterier', 'MIS kap 4', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(85,  'Metode', 8, 'F2: Forskningsdesign og kriterier', 'Designing for Trustworthiness, kap 6, 91-114', 'Schwartz-Shea & Yanow (2012)', 24, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(86,  'Metode', 8, 'F2: Forskningsdesign og kriterier', 'Now I see it, now I don''t: researcher''s position and reflexivity, 219-234', 'Berger (2013)', 15, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(87,  'Metode', 8, 'F2: Forskningsdesign og kriterier', 'Eight Big-Tent Criteria for Excellent Qualitative Research, 837-851', 'Tracy (2010)', 24, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 9 - F3
(88,  'Metode', 9, 'F3: Single casestudier og process tracing', 'What Is a Case Study and What Is It Good for?, 341-354', 'Gerring (2004)', 14, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(89,  'Metode', 9, 'F3: Single casestudier og process tracing', 'Five misunderstandings about case-study research, 219-245', 'Flyvbjerg (2006)', 26, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(90,  'Metode', 9, 'F3: Single casestudier og process tracing', 'MIS kap 15', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(91,  'Metode', 9, 'F3: Single casestudier og process tracing', 'Case Selection Techniques in Case Study Research, 294-308', 'Seawright & Gerring (2008)', 15, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 10 - F4
(92,  'Metode', 10, 'F4: Komparative casestudier', 'MIS kap 14', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(93,  'Metode', 10, 'F4: Komparative casestudier', 'Case Studies and Theory Development, kap 3-6', 'George & Bennett (2005)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(94,  'Metode', 10, 'F4: Komparative casestudier', 'Small N''s and big conclusions, 307-320', 'Lieberson (1991)', 14, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 11 - F5
(95,  'Metode', 11, 'F5: Feltarbejde og deltagerobservation', 'MIS kap 17', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(96,  'Metode', 11, 'F5: Feltarbejde og deltagerobservation', 'Political Ethnography, Introduction', 'Schatz (2009)', 20, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(97,  'Metode', 11, 'F5: Feltarbejde og deltagerobservation', 'Reflections on Ethnographic Work in Political Science, 255-272', 'Wedeen (2010)', 17, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 12 - F6
(98,  'Metode', 12, 'F6: Det etnografiske interview', 'Ethnographic Interviewing, 369-380', 'Heyl (2002)', 21, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(99,  'Metode', 12, 'F6: Det etnografiske interview', 'Articulating practice through the interview to the double, 195-212', 'Nicolini (2009)', 17, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(100, 'Metode', 12, 'F6: Det etnografiske interview', 'The Politics of Resentment, kap 1-2', 'Cramer (2016)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 13 - F7
(101, 'Metode', 13, 'F7: Interviews', 'MIS kap 16', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(102, 'Metode', 13, 'F7: Interviews', 'Interviewing as qualitative research, 81-95', 'Seidman (2012)', 15, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(103, 'Metode', 13, 'F7: Interviews', 'The Epistemology of Qualitative Research', 'Becker (1996)', 15, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 15 - F8
(104, 'Metode', 15, 'F8: Fokusgrupper', 'Measuring party identification: an exploratory study with focus groups, 217-237', 'Bartle (2003)', 20, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(105, 'Metode', 15, 'F8: Fokusgrupper', 'Fokusgrupper i teori og praksis', 'Dahler-Larsen & Dahler-Larsen (1999)', 0, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 16 - F9
(106, 'Metode', 16, 'F9: Diskursanalyse I', 'Security as practice, kap 2', 'Hansen (2006)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(107, 'Metode', 16, 'F9: Diskursanalyse I', 'Forests, discourses, institutions, 340-347', 'Arts & Buizer (2009)', 8, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 17 - F10
(108, 'Metode', 17, 'F10: Diskursanalyse II', 'Security as practice, kap 3', 'Hansen (2006)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),

-- Week 18 - F11
(109, 'Metode', 18, 'F11: Kvalitativ indholdskodning + Displays', 'MIS kap 18 + 19', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(110, 'Metode', 18, 'F11: Kvalitativ indholdskodning + Displays', 'Guide til NVivo, kap 2-5', 'Binderkrantz & Andersen (2016)', 67, 'ikke_startet', 'lav', 'pensum', 'fuld', 'unread', NULL),

-- Week 19 - F12
(111, 'Metode', 19, 'F12: Fra data til analyse', 'MIS kap 20 (genlæs)', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(112, 'Metode', 19, 'F12: Fra data til analyse', 'I Swear I Saw This, 11-20', 'Taussig (2011)', 10, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(113, 'Metode', 19, 'F12: Fra data til analyse', 'After the Interview: What is left at the end, 269-277', 'Faircloth (2012)', 9, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(114, 'Metode', 19, 'F12: Fra data til analyse', 'Should ChatGPT help with my research?, 1062-1083', 'Friedman, Owen & VanPuymbrouck (2024)', 21, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),

-- Week 20 - F13
(115, 'Metode', 20, 'F13: Forskningsetik', 'MIS kap 11 (kun etik-delen, genlæs)', 'Hansen, Andersen & Cecchini (2025)', 0, 'ikke_startet', 'høj', 'pensum', 'fuld', 'unread', NULL),
(116, 'Metode', 20, 'F13: Forskningsetik', 'Research ethics 101: Dilemmas and responsibilities, 717-723', 'Fujii (2012)', 6, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(117, 'Metode', 20, 'F13: Forskningsetik', 'Spies like us, 411-430', 'Driscoll & Schuster (2018)', 19, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(118, 'Metode', 20, 'F13: Forskningsetik', 'Implementing continuous consent in qualitative research, 795-810', 'Klykken (2021)', 15, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL),
(119, 'Metode', 20, 'F13: Forskningsetik', 'Anonymising interview data: challenges and compromise, 616-632', 'Saunders, Kitzinger & Kitzinger (2014)', 16, 'ikke_startet', 'mellem', 'pensum', 'fuld', 'unread', NULL);


-- =============================================================================
-- EVENTS — deadlines, exams, holidays
-- =============================================================================
INSERT INTO events (week, date, label, type, course) VALUES
(7,  NULL,         'Læse- og forberedelsesuge (ingen undervisning)',  'info',     NULL),
(11, '2026-03-11', 'IR2 Synopsis deadline',                          'deadline', 'IR2'),
(12, NULL,         'IR2 mundtlig eksamen (fra uge 12)',               'exam',     'IR2'),
(14, NULL,         'Påskeferie – ingen undervisning',                 'holiday',  NULL),
(15, '2026-04-08', 'Økonomi skriveøvelse udleveres kl. 12',          'deadline', 'Økonomi'),
(16, '2026-04-22', 'Økonomi skriveøvelse afleveres kl. 12',          'deadline', 'Økonomi'),
(19, '2026-05-11', 'Økonomi skriveøvelse genafleveres kl. 12',       'deadline', 'Økonomi'),
(21, '2026-05-26', 'Metode 3 fri opgave afleveres kl. 12',           'deadline', 'Metode'),
(24, '2026-06-09', 'Økonomi 2 eksamen kl. 9-13',                    'exam',     'Økonomi');


-- =============================================================================
-- KU SCHEDULE — default weekly timetable + overrides
-- =============================================================================

-- Default schedule (week = NULL means "applies to all normal weeks")
INSERT INTO ku_schedule (week, day_of_week, time_slot, course, session_type, room) VALUES
(NULL, 'Tirsdag',  '08-10', 'IR2',     'Forelæsning', 'Chr. Hansen Aud.'),
(NULL, 'Tirsdag',  '13-15', 'Metode',  'Forelæsning', 'Chr. Hansen Aud.'),
(NULL, 'Torsdag',  '08-10', 'Økonomi', 'Forelæsning', 'Chr. Hansen Aud.'),
(NULL, 'Torsdag',  '10-12', 'Metode',  'Hold',        'CSS 2-1-12'),
(NULL, 'Torsdag',  '13-15', 'IR2',     'Forelæsning', 'Chr. Hansen Aud.'),
(NULL, 'Torsdag',  '15-17', 'Økonomi', 'Fagcafé',     'CSS 35-3-12'),
(NULL, 'Fredag',   '08-10', 'IR2',     'Hold',        'CSS 2-2-18'),
(NULL, 'Fredag',   '10-12', 'Økonomi', 'Hold',        'CSS 35-3-12');

-- Week 6 override (extra Økonomi erstatningstime)
INSERT INTO ku_schedule (week, day_of_week, time_slot, course, session_type, room) VALUES
(6, 'Tirsdag',  '08-10', 'IR2',     'Forelæsning',    'Chr. Hansen Aud.'),
(6, 'Tirsdag',  '13-15', 'Metode',  'Forelæsning',    'Chr. Hansen Aud.'),
(6, 'Tirsdag',  '15-17', 'Økonomi', 'Erstatningstime', 'Chr. Hansen Aud.'),
(6, 'Torsdag',  '08-10', 'Økonomi', 'Forelæsning',    'Chr. Hansen Aud.'),
(6, 'Torsdag',  '10-12', 'Metode',  'Hold',           'CSS 2-1-12'),
(6, 'Torsdag',  '13-15', 'IR2',     'Forelæsning',    'Chr. Hansen Aud.'),
(6, 'Torsdag',  '15-17', 'Økonomi', 'Fagcafé',        'CSS 35-3-12'),
(6, 'Fredag',   '08-10', 'IR2',     'Hold',           'CSS 2-2-18'),
(6, 'Fredag',   '10-12', 'Økonomi', 'Hold',           'CSS 35-3-12');

-- Week 7 = reading week (no classes)
-- (empty — no rows for week 7)

-- Week 10 override (IR2 workshop on Wednesday)
INSERT INTO ku_schedule (week, day_of_week, time_slot, course, session_type, room) VALUES
(10, 'Tirsdag',  '08-10',      'IR2',     'Forelæsning',  'Chr. Hansen Aud.'),
(10, 'Tirsdag',  '13-15',      'Metode',  'Forelæsning',  'Chr. Hansen Aud.'),
(10, 'Onsdag',   '09-09:45',   'IR2',     'Forelæsning',  'Chr. Hansen Aud.'),
(10, 'Onsdag',   '10-12',      'IR2',     'Workshop',     'CSS 2-2-24'),
(10, 'Onsdag',   '12:30-15:30','IR2',     'Workshop',     'CSS 2-2-24'),
(10, 'Torsdag',  '08-10',      'Økonomi', 'Forelæsning',  'Chr. Hansen Aud.'),
(10, 'Torsdag',  '10-12',      'Metode',  'Hold',         'CSS 2-1-12'),
(10, 'Torsdag',  '13-15',      'IR2',     'Forelæsning',  'Chr. Hansen Aud.'),
(10, 'Torsdag',  '15-17',      'Økonomi', 'Fagcafé',      'CSS 35-3-12'),
(10, 'Fredag',   '08-10',      'IR2',     'Hold',         'CSS 2-2-18'),
(10, 'Fredag',   '10-12',      'Økonomi', 'Hold',         'CSS 35-3-12');

-- Week 14 = Easter (no classes)
-- (empty — no rows for week 14)

-- Week 15 override (extra Økonomi erstatningstime)
INSERT INTO ku_schedule (week, day_of_week, time_slot, course, session_type, room) VALUES
(15, 'Tirsdag',  '08-10', 'IR2',     'Forelæsning',          'Chr. Hansen Aud.'),
(15, 'Tirsdag',  '13-15', 'Metode',  'Forelæsning',          'Chr. Hansen Aud.'),
(15, 'Tirsdag',  '15-17', 'Økonomi', 'Erstatningstime (FL)', 'Chr. Hansen Aud.'),
(15, 'Torsdag',  '08-10', 'Økonomi', 'Forelæsning',          'Chr. Hansen Aud.'),
(15, 'Torsdag',  '10-12', 'Metode',  'Hold',                 'CSS 2-1-12'),
(15, 'Torsdag',  '13-15', 'IR2',     'Forelæsning',          'Chr. Hansen Aud.'),
(15, 'Torsdag',  '15-17', 'Økonomi', 'Fagcafé',              'CSS 35-3-12'),
(15, 'Fredag',   '08-10', 'IR2',     'Hold',                 'CSS 2-2-18'),
(15, 'Fredag',   '10-12', 'Økonomi', 'Hold',                 'CSS 35-3-12');

-- Week 20 override (reduced schedule)
INSERT INTO ku_schedule (week, day_of_week, time_slot, course, session_type, room) VALUES
(20, 'Tirsdag',  '08-10', 'IR2',     'Forelæsning',          'Chr. Hansen Aud.'),
(20, 'Tirsdag',  '13-15', 'Metode',  'Forelæsning',          'Chr. Hansen Aud.'),
(20, 'Tirsdag',  '15-17', 'Økonomi', 'Erstatningstime (FL)', 'Chr. Hansen Aud.'),
(20, 'Torsdag',  '10-12', 'Metode',  'Hold',                 'CSS 2-1-12'),
(20, 'Torsdag',  '15-17', 'Økonomi', 'Fagcafé',              'CSS 35-3-12'),
(20, 'Fredag',   '08-10', 'IR2',     'Hold',                 'CSS 2-2-18'),
(20, 'Fredag',   '10-12', 'Økonomi', 'Hold',                 'CSS 35-3-12');


-- =============================================================================
-- LEARNING PROFILES — initial observations
-- =============================================================================
INSERT INTO learning_profiles (course, observation, evidence) VALUES
('IR2', 'Comparative tables across theorists produce better retention than linear notes', 'Used successfully for Three Images framework and constructivism vs. post-structuralism in IR2 exam prep'),
('IR2', 'Oral practice (explaining arguments aloud) is strong for exam prep', 'IR2 oral exam experience — synopsis + oral format favours this approach'),
('IR2', 'A specific, detailed synopsis keeps examiners engaged within chosen material', 'Identified during IR2 oral exam preparation'),
('Økonomi', 'Graphical models (IS-LM, Keynesian cross) need hands-on practice, not just reading', NULL),
('Økonomi', 'Problem sets and worked examples produce deeper understanding than textbook reading alone', NULL),
('Metode', 'Connecting methods to concrete research examples aids retention', 'MSSD/MDSD understanding improved when tied to Lieberson critique and real cases'),
('Metode', 'Compact prose notes with structural tables preferred over bullet-point summaries', 'Consistent across Obsidian note-taking patterns');


-- =============================================================================
-- GOALS — initial active goals
-- =============================================================================
INSERT INTO goals (domain, course, title, target_date, status, notes) VALUES
('school', 'IR2',     'Complete IR2 oral exam',                          '2026-03-22', 'active', 'Synopsis deadline uge 11, oral from uge 12'),
('school', 'Økonomi', 'Submit Økonomi skriveøvelse',                     '2026-04-22', 'active', 'Udleveres 8/4, afleveres 22/4'),
('school', 'Økonomi', 'Pass Økonomi 2 exam',                             '2026-06-09', 'active', '4-hour written exam'),
('school', 'Metode',  'Submit Metode 3 fri opgave',                      '2026-05-26', 'active', 'Free assignment, deadline kl. 12'),
('school', NULL,       'Clear catch-up backlog (weeks 6-7) across all courses', '2026-03-15', 'active', '22 catch-up texts remaining'),
('training', NULL,     'Increase VO2max from ~44-45 to 48+',            NULL, 'active', 'Polarized model: 80/20 easy/hard. Cap running at ~6/month for LBM preservation'),
('training', NULL,     'Hit 150g protein daily consistently',            NULL, 'active', 'Current vegetarian meal plan structured by training day type'),
('training', NULL,     'Improve volume compliance from ~50% to 80%+',   NULL, 'active', 'Back at 40%, legs at 31% of target volume — address imbalances'),
('general', NULL,      'Build personal AI system (Phase 2: Infrastructure)', '2026-04-15', 'active', 'Supabase + GitHub + Tailscale foundation');


-- =============================================================================
-- WEEK DATES — reference data
-- =============================================================================
-- Stored as a simple lookup; can also be computed from ISO week numbers
-- Week 6:  2/2 – 8/2   (2026)
-- Week 7:  9/2 – 15/2
-- Week 8:  16/2 – 22/2
-- Week 9:  23/2 – 1/3
-- Week 10: 2/3 – 8/3
-- Week 11: 9/3 – 15/3
-- Week 12: 16/3 – 22/3
-- Week 13: 23/3 – 29/3
-- Week 14: 30/3 – 5/4   (Easter)
-- Week 15: 6/4 – 12/4
-- Week 16: 13/4 – 19/4
-- Week 17: 20/4 – 26/4
-- Week 18: 27/4 – 3/5
-- Week 19: 4/5 – 10/5
-- Week 20: 11/5 – 17/5
-- Week 21: 18/5 – 24/5
