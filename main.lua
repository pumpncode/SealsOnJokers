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
    key = 'Sleeves',
    path = 'Sleeves.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Seals',
    path = 'Seals.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Exotics',
    path = 'Exotics.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Stakes',
    path = 'Stakes.png',
    px = 29,
    py = 29
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

function IsEligibleForSeal(card)
    if (not card.seal) or ((G.GAME.selected_sleeve == "sleeve_soe_seal" and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and not card.extraseal) or (#SMODS.find_card('j_soe_sealjoker') > 0) and card.config.center.key ~= 'j_soe_sealjoker' then
        return true
    end
    return false
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
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
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
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
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
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
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
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
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
                        highlighted:set_ability("j_soe_stonecardjoker")
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

SMODS.Consumable{
    key = 'eternal?',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Eternal?',
        text = {
            'Add {C:attention}Eternal{}',
            'to a random card in hand',
        }
    },
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.hand.cards) do
            if not v.ability.eternal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.hand.cards) do
            if not v.ability.eternal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('eternal'))
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
                        highlighted.ability.eternal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'dejavu??',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Deja Vu??',
        text = {
            'Add a {C:red}Red Seal{}',
            'to a random consumable',
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
        for k, v in pairs(G.consumeables.cards) do
            if not v.seal and v ~= card then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.consumeables.cards) do
            if not v.seal and v ~= card then
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

local oldstartdissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.ability and self.ability.eternal and self.ability.set ~= 'Joker' then return nil end
    return oldstartdissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

local oldshatter = Card.shatter
function Card:shatter()
    self.shattered = false
    self.dissolve = 0
    if self.ability and self.ability.eternal then return nil end
    return oldshatter(self)
end

SMODS.Enhancement:take_ownership('glass', 
    {
        calculate = function(self, card, context)
            if card.ability.eternal then
                return nil
            end
            if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('glass') < G.GAME.probabilities.normal/card.ability.extra then
                return { remove = true }
            end
        end,
    }, 
    true
)

local oldisface = Card.is_face
function Card:is_face()
    if SMODS.has_enhancement(self, 'm_prefix_facecard') then 
        return true
    end
    return oldisface(self)
end

function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end 

local oldsave = Card.save
function Card:save()
    cardTable = oldsave(self)
    cardTable.extrasealcount = self.extrasealcount
    cardTable.redsealcount = self.redsealcount
    cardTable.goldsealcount = self.goldsealcount
    cardTable.bluesealcount = self.bluesealcount
    cardTable.purplesealcount = self.purplesealcount
    cardTable.extraseals = self.extraseals
    return cardTable
end

local oldload = Card.load
function Card:load(cardTable, other_card)
    self.extrasealcount = cardTable.extrasealcount
    self.redsealcount = cardTable.redsealcount
    self.goldsealcount = cardTable.goldsealcount
    self.bluesealcount = cardTable.bluesealcount
    self.purplesealcount = cardTable.purplesealcount
    self.extraseals = cardTable.extraseals
    return oldload(self, cardTable, other_card)
end

local oldcalcseal = Card.calculate_seal
function Card:calculate_seal(context)
    if self.debuff then return nil end
    if self.ability and self.ability.set == 'Joker' then
        if self.seal == 'Red' and self.extraseals == nil and context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self then
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
        if self.seal == 'Purple' and context.selling_self then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
        end
        if self.seal == 'Gold' and context.post_trigger and context.other_card == self and not table.contains(self.extraseals, "Gold") then
            ease_dollars(3)
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
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
        if self.extraseals then
            if table.contains(self.extraseals, "Gold") and context.post_trigger and context.other_card == self then
                for i = 1, self.goldsealcount do
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.0,
                        func = (function()
                            ease_dollars(3)
                            card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                            return true
                        end)
                    }))
                end
            end
            if table.contains(self.extraseals, "Blue") and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == self.area then
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
                            for i = 1, self.bluesealcount do
                                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                else
                                    break
                                end
                            end
                            G.GAME.consumeable_buffer = 0
                        end
                        return true
                    end)}))
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = '+'..tostring(math.min(self.bluesealcount, G.consumeables.config.card_limit - #G.consumeables.cards - G.GAME.consumeable_buffer + 1))..' Planet'..(self.bluesealcount > 1 and 's' or ''), colour = G.C.SECONDARY_SET.Planet})
            end
            if table.contains(self.extraseals, "Purple") and context.selling_self then
                for i = 1, self.purplesealcount do
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
                end
            end
        end
        if (self.extraseals and table.contains(self.extraseals, "Red")) or self.seal == "Red" then
            if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self then
                return {
                    repetitions = self.redsealcount,
                    card = self
                }
            end
        end
    end
    if self.ability and (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then
        if self.extraseal == 'Red' then 
        end
        if self.extraseal == 'Gold' then
            return {
                dollars = 3,
                colour = G.C.MONEY,
                card = self
            }
        end
    end
    if (self.ability.set == 'Joker') or (self.seal == "Red") then return nil end
    return oldcalcseal(self, context)
end

function Card:set_sealbutbetter(var, _seal, silent, immediate)
    if _seal then
        self[var] = _seal
        if not silent then 
        G.CONTROLLER.locks.seal = true
            if immediate then 
                self:juice_up(0.3, 0.3)
                play_sound('gold_seal', 1.2, 0.4)
                G.CONTROLLER.locks.seal = false
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        self:juice_up(0.3, 0.3)
                        play_sound('gold_seal', 1.2, 0.4)
                    return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.CONTROLLER.locks.seal = false
                    return true
                    end
                }))
            end
        end
    end
end

oldsetseal = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
    if #SMODS.find_card("j_soe_sealjoker") > 0 and _seal then
        if not self.seal then
            self:set_sealbutbetter('seal', _seal, silent, immediate)
            self[string.lower(_seal)..'sealcount'] = (self[string.lower(_seal)..'sealcount'] or 0) + 1
        elseif not self.extraseal then
            self:set_sealbutbetter('extraseal', _seal, silent, immediate)
            self.extraseals = self.extraseals or {}
            self.extraseals['extraseal'] = _seal
            self.extrasealcount = (self.extrasealcount or 0) + 1
            self[string.lower(_seal)..'sealcount'] = (self[string.lower(_seal)..'sealcount'] or 0) + 1
        else
            local random = '483959652912'
            while true do
                local random = tostring(math.random(1,999999999999999999999999))
                if not self['extraseal'..random] then break end
            end
            self:set_sealbutbetter('extraseal'..random, _seal, silent, immediate)
            self.extraseals = self.extraseals or {}
            self.extraseals['extraseal'..random] = _seal
            self.extrasealcount = (self.extrasealcount or 0) + 1
            self[string.lower(_seal)..'sealcount'] = (self[string.lower(_seal)..'sealcount'] or 0) + 1
            print(self[string.lower(_seal)..'sealcount'])
        end
        return nil
    end
    if (G.GAME.selected_sleeve == 'sleeve_soe_seal' and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and self.seal and not self.extraseal then
        self:set_sealbutbetter('extraseal', _seal, silent, immediate)
        if self.ability.name == 'Gold Card' and self.extraseal == 'Gold' and self.playing_card then 
            check_for_unlock({type = 'double_gold'})
        end
        self:set_cost()
        return nil
    end
    return oldsetseal(self, _seal, silent, immediate)
end

local oldunhighlightall = CardArea.unhighlight_all
function CardArea:unhighlight_all()
    if self == G.hand and G.GAME.modifiers.isred then return nil end
    return oldunhighlightall(self)
end

local olduseconsume = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if self.seal == 'Red' then
        G.GAME.modifiers.isred = true
    else
        G.GAME.modifiers.isred = false
    end
    local g = olduseconsume(self, area, copier)
    local used_tarot = copier or self
    if self.seal then
        if self.seal == 'Gold' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                used_tarot:juice_up(0.3, 0.5)
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
        if self.seal == 'Red' then
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_again_ex')})
            if self.ability.name == 'The Emperor' or self.ability.name == 'The High Priestess' then
                for i = 1, math.min((self.ability.consumeable.tarots or self.ability.consumeable.planets), G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local card = create_card((self.ability.name == 'The Emperor' and 'Tarot') or (self.ability.name == 'The High Priestess' and 'Planet'), G.consumeables, nil, nil, nil, nil, nil, (self.ability.name == 'The Emperor' and 'emp') or (self.ability.name == 'The High Priestess' and 'pri'))
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            used_tarot:juice_up(0.3, 0.5)
                        end
                        return true end }))
                end
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            for i=1, #G.hand.highlighted do
                local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            if self.ability.name == 'Strength' then
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        local card = G.hand.highlighted[i]
                        local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                        local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
                        if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                        elseif rank_suffix == 10 then rank_suffix = 'T'
                        elseif rank_suffix == 11 then rank_suffix = 'J'
                        elseif rank_suffix == 12 then rank_suffix = 'Q'
                        elseif rank_suffix == 13 then rank_suffix = 'K'
                        elseif rank_suffix == 14 then rank_suffix = 'A'
                        end
                        card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    return true end }))
                end  
            end
            for i=1, #G.hand.highlighted do
                local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            -- after this stays at the end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
                G.GAME.modifiers.isred = false
                G.hand:unhighlight_all(); return true
            end }))
        end
    end
    return g
end

local oldopen = Card.open
function Card:open()
    if self.ability.set == 'Booster' and self.seal then
        if self.seal == 'Gold' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                self:juice_up(0.3, 0.5)
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
    end
    return oldopen(self)
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
    if context.post_trigger and context.other_card == self and (context.other_context.joker_main or context.other_context.individual) then
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
        if self.ability.legallysteel then
            return {
                xmult = 1.5,
                colour = G.C.MULT,
                card = self,
                message_card = self
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
    if self.ability and (self.ability.set == 'Tarot' or self.ability.set == 'Spectral' or self.ability.set == 'Voucher' or self.ability.set == 'Planet  ') and self.seal then
        if self.seal == 'Blue' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == G.consumeables then
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
        if self.seal == 'Purple' and context.selling_self then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    end,
    in_pool = function(self)
        return false
    end
}

if cryptidyeohna then
    SMODS.Joker{
        name = 'SealJoker',
        key = 'sealjoker',
        loc_txt = {
            name = 'Seal',
            text={
                "Cards can have {s:3,C:dark_edition}infinite{}",
                "seals"
            },
        },
        atlas = 'Exotics',
        pos = {x = 0, y = 0},
        soul_pos = {x = 1, y = 0},
        rarity = 'cry_exotic',
        cost = 55,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = false,
    }
end

SMODS.Seal{
    key = 'sealseal',
    name = 'SealSeal',
    loc_txt = {
        name = 'Seal Seal',
        text = {
            'If this card has a second seal,',
            'Spread it to adjacent cards before scoring',
            'Otherwise, {C:mult}+#1#{} Mult'
        },
        label = 'Seal Seal'
    },
    badge_colour = HEX('E8463D'),
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {omult = 5},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {key = "sleeve_soe_seal_extra", set = "Sleeve"}
        return {vars = {self.config.omult}}
    end,
    calculate = function(self, card, context)
        if card.extraseal and context.before then
            local secondseal = card.extraseal
            local adjacentright, adjacentleft
            if context.cardarea == G.jokers or context.cardarea == G.hand or context.cardarea == G.consumeables or context.cardarea == G.play then
                for i=1, #card.area.cards do
                    if card.area.cards[i] == card then
                        if card.area.cards[i+1] then
                            adjacentright = card.area.cards[i+1]
                        end
                        if card.area.cards[i-1] then
                            adjacentleft = card.area.cards[i-1]
                        end
                    end
                end
                if adjacentright then
                    adjacentright:set_seal(card.extraseal)
                end
                if adjacentleft then
                    adjacentleft:set_seal(card.extraseal)
                end
            end
        end
        if not card.extraseal and context.main_scoring then
            return {
                mult = self.config.omult,
                colour = G.C.MULT,
                card = card
            }
        end 
    end
}

SMODS.Back{
    key = 'seal',
    name = 'AllSealsDeck',
    loc_txt = {
        name = 'Seal Deck',
        text = {
            "All cards in shop",
            "have seals",
        }
    },
    atlas = 'Enhancers',
    pos = {x = 5, y = 2},
}

if CardSleeves then
    CardSleeves.Sleeve {
        key = "seal",
        atlas = "Sleeves",
        pos = { x = 0, y = 0 },
        loc_txt = {
            name = "Seal Sleeve",
            text = {
                "All cards in shop",
                "have seals",
            }
        },
        loc_vars = function(self)
            local key
            if self.get_current_deck_key() == "b_soe_seal" then
                key = self.key .. "_extra"
            end
            return {key = key}
        end,
    }
end

SMODS.Stake{
    key = 'seal',
    applied_stakes = {'stake_gold'},
    loc_txt = {
        name = 'Seal Stake',
        text = {
            'I dont know',
        },
        sticker = {
            name = 'Seal Sticker',
            text = {
                'I dont know',
            }
        }
    },
    atlas = 'Stakes',
    pos = {x = 0, y = 0},
    colour = G.C.RED
}

local oldupdate = Card.update
function Card:update(dt)
    if (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal') or (G.GAME.selected_sleeve == 'sleeve_soe_seal') then
        local seals = {'Red', 'Blue', 'Gold', 'Purple'}
        if cryptidyeohna then
            table.insert(seals, {'cry_azure', 'cry_green'})
        end
        if G.shop_jokers and G.shop_jokers.cards and G.shop_jokers.cards[1] then
            for k, v in ipairs(G.shop_jokers.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
        if G.shop_booster and G.shop_booster.cards and G.shop_booster.cards[1] then
            for k, v in ipairs(G.shop_booster.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
        if G.shop_vouchers and G.shop_vouchers.cards and G.shop_vouchers.cards[1] then
            for k, v in ipairs(G.shop_vouchers.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
        if G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] then
            for k, v in ipairs(G.pack_cards.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
    end
    return oldupdate(self, dt)
end

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

SMODS.Joker:take_ownership('j_burglar',
    {
        calculate = function(self, card, context)
            if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
                return {
                    G.E_MANAGER:add_event(Event({func = function()
                        ease_discard(-G.GAME.current_round.discards_left, nil, true)
                        ease_hands_played(card.ability.extra)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra}}})
                    return true end }))
                }
            end
        end
    },
    true
)

SMODS.DrawStep{
    key = 'sealsforall',
    order = 10,
    func = function(self)
        if (self.ability.set ~= 'Joker' and (self.ability.set ~= 'Default' and self.ability.set ~= 'Enhanced')) and self.seal then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
        end
    end
}

SMODS.DrawStep{
    key = 'secondsealsforall',
    order = 11,
    func = function(self, card)
        if self.extraseal and not (#SMODS.find_card("j_soe_sealjoker") > 0) then
            G.shared_seals[self.extraseal].role.draw_major = self
            G.shared_seals[self.extraseal]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, 1)
            if self.extraseal == 'Gold' then G.shared_seals[self.extraseal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, nil, nil, nil, 1) end
        end
    end
}

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end
  

SMODS.DrawStep{
    key = 'foursealstoshow',
    order = 12,
    func = function(self, card)
        if self.extraseals and (#SMODS.find_card("j_soe_sealjoker") > 0) then
            if table.contains(self.extraseals, "Red") then
                G.shared_seals["Red"].role.draw_major = self
                G.shared_seals["Red"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, nil)
            end
            if table.contains(self.extraseals, "Gold") then
                G.shared_seals["Gold"].role.draw_major = self
                G.shared_seals["Gold"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, 1)
                G.shared_seals["Gold"]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, nil, nil, nil, 1)
            end
            if table.contains(self.extraseals, "Blue") then
                G.shared_seals["Blue"].role.draw_major = self
                G.shared_seals["Blue"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 0.5)
            end
            if table.contains(self.extraseals, "Purple") then
                G.shared_seals["Purple"].role.draw_major = self
                G.shared_seals["Purple"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 0.5, 1)
            end
        end
    end
}

SMODS.Atlas{
    key = 'Blinds',
    path = 'Blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Blind{
    key = 'theseal',
    loc_txt = {
        name = 'The Seal',
        text = {
            'Cards without seals are debuffed',
        }
    },
    atlas = 'Blinds',
    discovered = true,
    pos = {x = 0, y = 0},
    boss = {min = 1, max = 10, showdown = true},
    boss_colour = HEX('E8463D'),
    set_blind = function(self)
        for i, v in ipairs(G.playing_cards) do
            if not v.seal then
                SMODS.debuff_card(v, true, 'redseal1'..tostring(i))
            end
        end
        for i, v in ipairs(G.jokers.cards) do
            if not v.seal then
                SMODS.debuff_card(v, true,'redseal2'..tostring(i))
            end
        end
        for i, v in ipairs(G.consumeables.cards) do
            if not v.seal then
                SMODS.debuff_card(v, true,'redseal3'..tostring(i))
            end
        end
    end,
    disable = function(self)
        for i, v in ipairs(G.playing_cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal1'..tostring(i))
            end
        end
        for i, v in ipairs(G.jokers.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal2'..tostring(i))
            end
        end
        for i, v in ipairs(G.consumeables.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal3'..tostring(i))
            end
        end
    end,
    defeat = function(self)
        for i, v in ipairs(G.playing_cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal1'..tostring(i))
            end
        end
        for i, v in ipairs(G.jokers.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal2'..tostring(i))
            end
        end
        for i, v in ipairs(G.consumeables.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal3'..tostring(i))
            end
        end
    end
}

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