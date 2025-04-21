return {
    descriptions = {
        Back={
            b_soe_seal = {
                name = 'Seal Deck',
                text = {
                    "All cards in shop",
                    "have seals",
                }
            },
        },
        Blind={
            bl_soe_theseal = {
                name = 'The Seal',
                text = {
                    'Cards without seals are debuffed',
                }
            },
        },
        Edition={},
        Enhanced={},
        Joker={
            j_soe_stonecardjoker = {
                name = 'Stone Card Joker',
                text={
                    "{C:chips}+#1#{} Chips",
                },
            },
            j_soe_sealjoker = {
                name = 'Seal',
                text={
                    "Cards can have {s:3,C:dark_edition}infinite{}",
                    "seals"
                },
            },
            j_soe_infinityred = {
                name = 'Infinity Red',
                text={
                    "Every time a card triggers",
                    "put a {C:red}Red Seal{} on it",
                }
            },
            j_soe_infinitypurple = {
                name = 'Infinity Purple',
                text={
                    "Purple"
                }
            },
            j_soe_infinitygold = {
                name = 'Infinity Gold',
                text={
                    "Gold"
                }
            },
            j_soe_infinityblue = {
                name = 'Infinity Blue',
                text={
                    "Blue"
                }
            },
            j_soe_infinity = {
                name = 'The Infinity Seal',
                text={
                    ""
                }
            },
            j_soe_extralife = {
                name = 'Extra Life',
                text={
                    "Prevents a game over {C:attention}#1#{} times",
                }
            },
            j_soe_unorganizedjoker = {
                name = 'Unorganized Joker',
                text={
                    "If a card has a property that was not meant for that card,",
                    "it gives {X:mult,C:white}X#1#{} Mult",
                }
            },
            j_soe_seeder = {
                name = 'Seeder',
                text={
                    "Change the current runs {C:attention}seed{}",
                    "once per ante",
                    "{C:inactive}(#1#){}"
                }
            },
            j_soe_blankjoker = {
                name = 'Blank Joker',
                text={
                    "In #1# rounds, turn into",
                    "{C:dark_edition}Antimatter Joker{}",
                }
            },
            j_soe_antimatterjoker = {
                name = 'Antimatter Joker',
                text={
                    "{C:attention}ALL{} {C:dark_edition}Negative{} cards",
                    "give {X:mult,C:white}X#1#{} Mult",
                    "and {C:dark_edition}Negative is #2#X as often to appear"
                }
            },
            j_soe_jupiterjoker = {
                name = 'Jupiter Joker',
                text={
                    "If played {C:attention}poker hand{} is",
                    "{C:attention}Flush{}",
                    "Upgrade played hand",
                }
            },
        },
        Other={
            soe_sealseal_seal = {
                name = 'Seal Seal',
                text = {
                    'If this card has a second seal,',
                    'Spread it to adjacent cards before scoring',
                    'Otherwise, {C:mult}+#1#{} Mult'
                },
            },
            soe_rainbowseal_seal = {
                name = 'Rainbow Seal',
                text = {
                    '{C:inactive}(For Jokers){}',
                    'If this Joker has an edition,',
                    'Scored cards will give the edition mult/chips',
                    '{C:inactive}(For Playing Cards){}',
                    'If this card has an edition,',
                    '1 in 4 chance cards in hand will give the edition mult/chips',
                },
            },
            soe_reverseseal_seal = {
                name = 'Reverse Seal',
                text = {
                    'If this card is facing {C:attention}down{},',
                    '{X:mult,C:white}X#1#{} Mult',
                },
            },
            soe_negativeseal_seal = {
                name = 'Negative Seal',
                text = {
                    'This card {C:attention}ignores{} the selection limit,',
                },
            },
            soe_carmineseal_seal = {
                name = 'Carmine Seal',
                text = {
                    'If this card is played and not scored,',
                    'destroy this card',
                },
            },
            soe_aquaseal_seal = {
                name = 'Aqua Seal',
                text = {
                    'If this card is played and not scored,',
                    'destroy this card',
                },
            },
            red_seal_joker = {
                name="Red Seal",
                text={
                    "Retrigger this",
                    "Joker {C:attention}1{} time",
                },
            },
            purple_seal_joker = {
                name="Purple Seal",
                text={
                    "Creates a {C:tarot}Tarot{} card",
                    "when {C:attention}sold",
                    "{C:inactive}(Must have room)",
                },
            },
            gold_seal_joker = {
                name="Gold Seal",
                text={
                    "Earn {C:money}$3{} when this",
                    "Joker is scored",
                },
            },
            blue_seal_joker = {
                name="Blue Seal",
                text={
                    "Creates the {C:planet}Planet{} card",
                    "for final played {C:attention}poker hand{}",
                    "of round",
                    "{C:inactive}(Must have room)",
                },
            },
            cry_green_seal_joker = {
				name = "Green Seal",
				text = {
					"Creates a {C:cry_code}Code{} card",
					"when this Joker does not score",
					"{C:inactive}(Must have room)",
				},
			},
            cry_azure_seal_joker = {
				name = "Azure Seal",
				text = {
					"Create {C:attention}3{} {C:dark_edition}Negative{}",
					"{C:planet}Planets{} for played",
					"{C:attention}poker hand{}, then",
					"{C:red}destroy{} this Joker",
				},
			},
            legallygold = {
                name="Gold Card",
                text={
                    "{C:money}$#1#{} at",
                    "end of round",
                },
            },
            legallyplasmasleeve = {
                name = "Plasma Sleeve",
                text = G.localization.descriptions.Back["b_plasma"].text
            },
        },
        Planet={
            c_soe_demjoker={
                name="Dem Joker",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},	
            },
        },
        Spectral={
            c_soe_dejavuq = {
                name = 'Deja Vu?',
                text = {
                    'Add a {C:red}Red Seal{}',
                    'to a random joker',
                }
            },
            c_soe_tranceq = {
                name = 'Trance?',
                text = {
                    'Add a {C:blue}Blue Seal{}',
                    'to a random joker',
                }
            },
            c_soe_talismanq = {
                name = 'Talisman?',
                text = {
                    'Add a {C:gold}Gold Seal{}',
                    'to a random joker',
                }
            },
            c_soe_mediumq = {
                name = 'Medium?',
                text = {
                    'Add a {C:purple}Purple Seal{}',
                    'to a random joker',
                }
            },
            c_soe_typhoonq = {
                name = 'Typhoon?',
                text = {
                    'Add a {C:cry_azure}Azure Seal{}',
                    'to a random joker',
                }
            },
            c_soe_sourceq = {
                name = 'Source?',
                text = {
                    'Add a {C:cry_code}Green Seal{}',
                    'to a random joker',
                }
            },
            c_soe_eternalq = {
                name = 'Eternal?',
                text = {
                    'Add {C:attention}Eternal{}',
                    'to a random card in hand',
                }
            },
            c_soe_dejavuqq = {
                name = 'Deja Vu??',
                text = {
                    'Add a {C:red}Red Seal{}',
                    'to a random consumable',
                }
            },
            c_soe_dejavuqqq = {
                name = 'DEJA VU???',
                text = {
                    'Add a {C:red}Red Seal{}',
                    'to the blind',
                }
            },
        },
        Stake={},
        Tag={},
        Tarot={
            c_soe_devilq = {
                name = 'Devil?',
                text = {
                    'Add the {C:attention}Gold{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_towerq = {
                name = 'Tower?',
                text = {
                    'Add the {C:attention}Stone{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_chariotq = {
                name = 'Chariot?',
                text = {
                    'Add the {C:attention}Steel{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_empressq = {
                name = 'Empress?',
                text = {
                    'Add the {C:attention}Mult{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_hierophantq = {
                name = 'Hierophant?',
                text = {
                    'Add the {C:attention}Bonus{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_magicianq = {
                name = 'Magician?',
                text = {
                    'Add the {C:attention}Lucky{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_justiceq = {
                name = 'Justice?',
                text = {
                    'Add the {C:attention}Glass{} Enhancement',
                    'to a random joker',
                }
            },
        },
        Voucher={},
        Sleeve = {
            sleeve_soe_seal = {
                name = "Seal Sleeve",
                text = {
                    "All cards in shop",
                    "have seals",
                }
            },
            sleeve_soe_seal_extra = {
                name = "Seal Sleeve",
                text = {
                    "Cards can have {C:attention}2{} Seals",
                }
            },
            sleeve_soe_redseal = {
                name = "Red Seal",
                text = {
                    "Effects of this deck",
                    "happen twice",
                    "{C:inactive}(#1#){}"
                }
            },
            sleeve_soe_goldseal = {
                name = "Gold Seal",
                text = {
                    "First scoring card",
                    "each hand gives {C:money}$3{}",
                }
            },
        },
        BakeryCharm = {
			BakeryCharm_soe_sealcharm={
				name = "Seal Charm",
                text = {
                    "Vanilla seal effects are doubled"
                }
			},
		},
    },
    misc = {
        achievement_descriptions={
            ach_soe_completionist_plus_plus_plus = "Earn a Gold Sticker on every Playing Card",
        },
        achievement_names={
            ach_soe_completionist_plus_plus_plus = "Completionist+++",
        },
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_soe_infinity = "Infinity",

            soe_hand_joker_central = "Joker Central",
        },
        high_scores={},
        labels={
            soe_sealseal_seal = 'Seal Seal',
            soe_rainbowseal_seal = 'Rainbow Seal',
            soe_reverseseal_seal = 'Reverse Seal',
            soe_negativeseal_seal = 'Negative Seal',
            soe_carmineseal_seal = 'Carmine Seal',
            soe_aquaseal_seal = 'Aqua Seal',

            k_soe_infinity = "Infinity",
        },
        poker_hand_descriptions = {
            soe_joker_central = {"5 Jokers"}
        },
        poker_hands = {
            soe_joker_central = "Joker Central",
        },

        quips={
            again = {
                "Again!"
            }
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}