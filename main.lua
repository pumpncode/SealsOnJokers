SMODS.Atlas{
    key = 'What',
    path = 'What.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Enhancers',
    path = 'Enhancers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'modicon',
    path = 'modicon.png',
    px = 34,
    py = 34
}

SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true,
        post_trigger = true
    }
end

local cryptidyeohna = false
if next(SMODS.find_mod("Cryptid")) then
    cryptidyeohna = true
end

SMODS.Consumable{
    key = 'dejavu?',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Deja Vu?',
        text = {
            'Add a {C:red}Red Seal{}',
            'to a random joker',
        }
    },
    config = {mod_conv = "Red", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "red_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('dejavu'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Red")
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'trance?',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 1, y = 0},
    loc_txt = {
        name = 'Trance?',
        text = {
            'Add a {C:blue}Blue Seal{}',
            'to a random joker',
        }
    },
    config = {mod_conv = "Blue", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "blue_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('trance'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Blue")
                        highlighted.ability.legallygold = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'talisman?',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 2, y = 0},
    loc_txt = {
        name = 'Talisman?',
        text = {
            'Add a {C:gold}Gold Seal{}',
            'to a random joker',
        }
    },
    config = {mod_conv = "Gold", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "gold_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('talisman'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Gold")
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'medium?',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 3, y = 0},
    loc_txt = {
        name = 'Medium?',
        text = {
            'Add a {C:purple}Purple Seal{}',
            'to a random joker',
        }
    },
    config = {mod_conv = "Purple", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "purple_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.seal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('medium'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Purple")
                    end
                    return true
                end,
            }))
        end
    end
}

if cryptidyeohna then
    SMODS.Consumable{
        key = 'typhoon?',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 4, y = 0},
        loc_txt = {
            name = 'Typhoon?',
            text = {
                'Add a {C:cry_azure}Azure Seal{}',
                'to a random joker',
            }
        },
        config = {mod_conv = "cry_azure", cards = 1},
        loc_vars = function(self,info_queue,center)
            info_queue[#info_queue+1] = { key = "cry_azure_seal_joker", set = "Other"}
        end,
        unlocked = true,
        discovered = true,
        can_use = function(self,card)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            return #eligible > 0 and true or false
        end,
        use = function(self,card,area,copier)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            local highlighted = pseudorandom_element(eligible, pseudoseed('typhoon'))
            if highlighted then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        highlighted:juice_up(0.3, 0.5)
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        if highlighted then
                            highlighted:set_seal("cry_azure")
                        end
                        return true
                    end,
                }))
            end
        end
    }
    SMODS.Consumable{
        key = 'source?',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 5, y = 0},
        loc_txt = {
            name = 'Source?',
            text = {
                'Add a {C:cry_code}Green Seal{}',
                'to a random joker',
            }
        },
        config = {mod_conv = "cry_green", cards = 1},
        loc_vars = function(self,info_queue,center)
            info_queue[#info_queue+1] = { key = "cry_green_seal_joker", set = "Other"}
        end,
        unlocked = true,
        discovered = true,
        can_use = function(self,card)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            return #eligible > 0 and true or false
        end,
        use = function(self,card,area,copier)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            local highlighted = pseudorandom_element(eligible, pseudoseed('source'))
            if highlighted then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        highlighted:juice_up(0.3, 0.5)
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        if highlighted then
                            highlighted:set_seal("cry_green")
                        end
                        return true
                    end,
                }))
            end
        end
    }
end

SMODS.Consumable{
    key = 'devil?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 6, y = 0},
    loc_txt = {
        name = 'Devil?',
        text = {
            'Add the {C:attention}Gold{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('devil'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallygold = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'tower?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 7, y = 0},
    loc_txt = {
        name = 'Tower?',
        text = {
            'Add the {C:attention}Stone{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('tower'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_ability("j_soj_stonecardjoker")
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'chariot?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 8, y = 0},
    loc_txt = {
        name = 'Chariot?',
        text = {
            'Add the {C:attention}Steel{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('chariot'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallysteel = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'empress?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 9, y = 0},
    loc_txt = {
        name = 'Empress?',
        text = {
            'Add the {C:attention}Mult{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('empress'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallymult = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'hierophant?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 10, y = 0},
    loc_txt = {
        name = 'Hierophant?',
        text = {
            'Add the {C:attention}Bonus{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('hierophant'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallybonus = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'magician?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 11, y = 0},
    loc_txt = {
        name = 'Magician?',
        text = {
            'Add the {C:attention}Lucky{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('magician'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallylucky = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'justice?',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 12, y = 0},
    loc_txt = {
        name = 'Justice?',
        text = {
            'Add the {C:attention}Glass{} Enhancement',
            'to a random joker',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('justice'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallyglass = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

local oldcalcseal = Card.calculate_seal
function Card:calculate_seal(context)
    if self.debuff then return nil end
    if self.ability and (self.ability.set == 'Joker' or self.ability.set == 'Tarot') then
        if context.retrigger_joker_check and not context.retrigger_joker and self == context.other_card and self.seal == "Red" then
            return {
                repetitions = 1,
                card = self
            }
        end
        if self.seal == 'Blue' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == G.jokers then
            local card_type = 'Planet'
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)}))
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end
        if self.seal == 'Purple' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.selling_self then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                        local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, '8ba')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    return true
                end)}))
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
        end
        if self.seal == 'Gold' and context.post_trigger and context.other_card == self then
            return {
                dollars = 3,
                card = self,
                message_card = self,
            }
        end
        if cryptidyeohna then
            if self.seal == 'cry_azure' and context.after then
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.0,
                    func = function()
                        local card_type = "Planet"
                        local _planet = nil
                        if G.GAME.last_hand_played then
                            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == G.GAME.last_hand_played then
                                    _planet = v.key
                                    break
                                end
                            end
                        end
    
                        for i = 1, 3 do
                            local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, "cry_azure")
    
                            card:set_edition({ negative = true }, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        self:start_dissolve()
                        return true
                    end,
                }))
            end
            if self.seal == 'cry_green' then
                local scoredyeohna
                if context.before then
                    scoredyeohna = false
                end
                if context.post_trigger and context.other_card == self then
                    scoredyeohna = true
                end
                if not scoredyeohna and context.after then
                    G.E_MANAGER:add_event(Event({
						func = function()
							if G.consumeables.config.card_limit > #G.consumeables.cards then
								local c = create_card("Code", G.consumeables, nil, nil, nil, nil, nil, "cry_green_seal")
								c:add_to_deck()
								G.consumeables:emplace(c)
								self:juice_up()
							end
							return true
						end,
					}))
                end
            end
        end
    end
    if self.ability.set == 'Joker' or self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' then return nil end
    return oldcalcseal(self, context)
end

local oldcalcjoker = Card.calculate_joker
function Card:calculate_joker(context)
    local g = oldcalcjoker(self, context)
    if context.end_of_round and context.cardarea == G.jokers then
        if self.ability.legallygold then
            return {
                dollars = 3,
                colour = G.C.MONEY,
                card = self,
                message_card = self
            }
        end
    end
    if context.before then
        self.ability.triggered = false
    end
    if context.post_trigger and context.other_card == self then
        self.ability.triggered = true
        if self.ability.legallymult then
            return {
                mult = 4,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallybonus then
            return {
                chips = 30,
                colour = G.C.CHIPS,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallylucky then
            local smult, money
            if pseudorandom('lucky') < G.GAME.probabilities.normal / 5 then
                smult = 20
            end
            if pseudorandom('luckymoney') < G.GAME.probabilities.normal / 15 then
                money = 20
            end
            return {
                mult = smult,
                colour = G.C.MULT,
                card = self,
                message_card = self,
                extra = {
                    dollars = money,
                    colour = G.C.MONEY,
                    card = self,
                    message_card = self
                }
            }
        end
        if self.ability.legallyglass then
            return {
                xmult = 2,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
    end
    if context.after then
        if self.ability.legallyglass then
            if pseudorandom('glass') < G.GAME.probabilities.normal / 4 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        self:shatter()
                        return true
                    end
                }))
            end
        end
    end
    if context.joker_main and context.cardarea == G.jokers then
        if self.ability.legallysteel then
            return {
                xmult = 1.5,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if not true then
            if self.ability.legallymult then
                return {
                    mult = 4,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallybonus then
                return {
                    chips = 30,
                    colour = G.C.CHIPS,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallylucky then
                local smult, money
                if pseudorandom('lucky') < G.GAME.probabilities.normal / 5 then
                    smult = 20
                end
                if pseudorandom('luckymoney') < G.GAME.probabilities.normal / 15 then
                    money = 20
                end
                return {
                    mult = smult,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self,
                    extra = {
                        dollars = money,
                        colour = G.C.MONEY,
                        card = self,
                        message_card = self
                    }
                }
            end
            if self.ability.legallyglass then
                return {
                    xmult = 2,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
        end
    end
    return g
end

SMODS.Joker{
    name = 'StoneCardJoker',
    key = 'stonecardjoker',
    loc_txt = {
        name = 'Stone Card Joker',
        text={
            "{C:chips}+#1#{} Chips",
        },
    },
    atlas = 'Enhancers',
    pos = {x = 5, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    config = {
        chips = 50
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker:take_ownership('j_mail',
    {
        calculate = function(self, card, context)
            if context.discard and not context.other_card.debuff and ((context.other_card:get_id() == G.GAME.current_round.mail_card.id)) then
                return {
                    dollars = card.ability.extra,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    },
    true
)

SMODS.Keybind{
    key_pressed = '-',
    held_keys = {'lshift'},
    event = 'pressed',
    action = function(self)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
            local joker = G.jokers.highlighted[1]
            if not joker.ability.legal then
                print('Highlighted joker is not enhanced')
            end
            if joker.ability.legallygold then
                print('Highlighted joker is enhanced with gold')
            end
            if joker.ability.legallysteel then
                print('Highlighted joker is enhanced with steel')
            end
            if joker.ability.legallymult then
                print('Highlighted joker is enhanced with mult')
            end
            if joker.ability.legallybonus then
                print('Highlighted joker is enhanced with bonus')
            end
            if joker.ability.legallylucky then
                print('Highlighted joker is enhanced with lucky')
            end
            if joker.ability.legallyglass then
                print('Highlighted joker is enhanced with glass')
            end
            if joker.ability.name == 'StoneCardJoker' then
                print('You cannot be serious right now, but this is a stone')
            end
        end
    end
}