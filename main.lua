SMODS.Atlas{
    key = 'What',
    path = 'What.png',
    px = 71,
    py = 95
}

local sge = SMODS.Atlas{
    key = 'Enhancers',
    path = 'Enhancers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'PlayingCards',
    path = 'PlayingCards.png',
    px = 71,
    py = 95
}

local je = SMODS.Atlas{
    key = 'JokerEnhancements',
    path = 'JokerEnhancements.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'ExtraLife',
    path = 'ExtraLife.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Tarots',
    path = 'Tarots.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Vouchers',
    path = 'Vouchers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Planets',
    path = 'Planets.png',
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
    key = 'Placeholders',
    path = 'Placeholders.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'DeckSeals',
    path = 'DeckSeals.png',
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
    key = 'SecondSeals',
    path = 'SecondSeals.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Charms',
    path = 'Charms.png',
    px = 68,
    py = 68
}

SMODS.Atlas{
    key = 'Boosters',
    path = 'Boosters.png',
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
    key = 'InfinitySeals',
    path = 'InfinitySeals.png',
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
        post_trigger = true,
    }
end

local cryptidyeohna = false
if next(SMODS.find_mod("Cryptid")) then
    cryptidyeohna = true
end

function IsEligibleForSeal(card)
    if ((not card.seal) or ((G.GAME.selected_sleeve and G.GAME.selected_sleeve == "sleeve_soe_seal" and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and not card.extraseal) or (#SMODS.find_card('j_soe_sealjoker') > 0)) and (card.config and card.config.center.key ~= 'j_soe_sealjoker') then
        return true
    end
    return false
end

function set_card_win()
    for k, v in pairs(G.playing_cards) do
        if (v.ability.set == 'Default' or v.ability.set == 'Enhanced') then
            G.PROFILES[G.SETTINGS.profile].card_stickers = G.PROFILES[G.SETTINGS.profile].card_stickers or {}
            G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)] = G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)] or {count = 1, wins = {}, losses = {}, wins_by_key = {}, losses_by_key = {}}
            if G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)] then
                G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins = G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins or {}
                G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins[G.GAME.stake] = (G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins[G.GAME.stake] or 0) + 1
                G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins_by_key[SMODS.stake_from_index(G.GAME.stake)] = (G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins_by_key[SMODS.stake_from_index(G.GAME.stake)] or 0) + 1
            end
        end
    end
    G:save_settings()
end

oldwingame = win_game
function win_game()
    if not G.GAME.seeded and not G.GAME.challenge then
        set_card_win()
    end
    return oldwingame()
end

SMODS.Consumable{
    key = 'dejavuq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
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
                        print(highlighted.redsealcount)
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'tranceq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 1, y = 0},
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
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'talismanq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 2, y = 0},
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
    key = 'mediumq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 3, y = 0},
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
        key = 'typhoonq',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 4, y = 0},
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
        key = 'sourceq',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 5, y = 0},
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
    key = 'devilq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 6, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Gold"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'towerq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 7, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted:set_ability(G.P_CENTERS.j_soe_stonecardjoker)
                        highlighted.ability.legallyenhanced = "Stone"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'chariotq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 8, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Steel"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'empressq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 9, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Mult"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'hierophantq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 10, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Bonus"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'magicianq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 11, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Lucky"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'justiceq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 12, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Glass"
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'eternalq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
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
    key = 'dejavuqq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
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

SMODS.Consumable{
    key = 'dejavuqqq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    config = {mod_conv = "Red", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "red_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        if G.GAME.blind.seal then
            return false
        elseif G.GAME.blind then
            return true
        end
    end,
    use = function(self,card,area,copier)
        G.GAME.blind.seal = "Red"
        if G.GAME.blind.config.blind.key == "bl_akyrs_final_periwinkle_pinecone" then
            G.GAME.blind.permasealdebuffha = true
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

SMODS.Enhancement:take_ownership('m_glass', 
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

SMODS.Consumable{
    key = 'murder',
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 3, y = 1},
    unlocked = true,
    discovered = true,
    config = {mod_conv = 'card', max_highlighted = 2, min_highlighted = 2},
    loc_txt = {
        name = 'Murder',
        text = {
            "Select {C:attention}#1#{} Jokers,",
            "convert the {C:attention}left{} Joker",
            "into the {C:attention}right{} Joker",
            "{C:inactive}(Drag to rearrange)",
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.max_highlighted}}
    end,
    can_use = function(self,card)
        if #G.jokers.highlighted == 2 then
            return true
        end
        return false
    end,
    use = function(self,card,area,copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.jokers.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.jokers.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.jokers.highlighted[i]:flip();play_sound('card1', percent);G.jokers.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local rightmost = G.jokers.highlighted[1]
        for i=1, #G.jokers.highlighted do if G.jokers.highlighted[i].T.x > rightmost.T.x then rightmost = G.jokers.highlighted[i] end end
        for i=1, #G.jokers.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= rightmost then
                    copy_card(rightmost, G.jokers.highlighted[i])
                end
                return true end }))
        end 
        for i=1, #G.jokers.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.jokers.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.jokers.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.jokers:unhighlight_all(); return true end }))
        delay(0.5)
    end
}

SMODS.Enhancement{
    key = "j_joker",
    loc_txt = {
        name = 'Joker',
        text = {
            '{C:red,s:1.1}+#1#{} Mult',
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.mult}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 0, y = 0},
    no_collection = true,
    config = {mult = 4},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end
}

SMODS.Enhancement{
    key = "j_jolly",
    loc_txt = {
        name="Jolly Joker",
        text={
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.extra.mult, self.config.extra.type}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 2, y = 0},
    no_collection = true,
    config = {extra = {mult = 8, type = 'Pair'}},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring and next(context.poker_hands[self.config.extra.type]) then
            return {mult = self.config.extra.mult}
        end
    end
}

SMODS.Enhancement{
    key = "j_zany",
    loc_txt = {
        name="Zany Joker",
        text={
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.extra.mult, self.config.extra.type}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 3, y = 0},
    no_collection = true,
    config = {extra = {mult = 12, type = 'Three of a Kind'}},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring and next(context.poker_hands[self.config.extra.type]) then
            return {mult = self.config.extra.mult}
        end
    end
}

SMODS.Enhancement{
    key = "j_burnt",
    loc_txt = {
        name="Burnt Joker",
        text={
            "Upgrade the level of",
            "the first {C:attention}discarded",
            "poker hand each round",
        },
    },
    atlas = 'JokerEnhancements',
    pos = {x = 3, y = 7},
    no_collection = true,
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook and context.cardarea ~= G.discard then
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
            level_up_hand(context.blueprint_card or card, text, nil, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
    end
}

SMODS.Enhancement{
    key = "j_perkeo",
    loc_txt = {
        name = 'Perkeo',
        text = {
            "Creates a {C:dark_edition}Negative{} copy of",
            "{C:attention}1{} random {C:attention}consumable{}",
            "card in your possession",
            "at the end of the {C:attention}shop",
        }
    },
    atlas = 'JokerEnhancements',
    pos = {x = 7, y = 8},
    no_collection = true,
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if G.consumeables.cards[1] and context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo')), nil)
                    card:set_edition({negative = true}, true)
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    card:juice_up()
                    return true
                end}))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
        end
    end
}

--[[
SMODS.DrawStep {
    key = 'perkeoenhance',
    order = 15,
    func = function(self)
        if SMODS.has_enhancement(self, 'm_soe_j_perkeo') then
            self.children.floating_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, je, {x = 7, y = 9})
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center)
            self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
}
]]

local abovehand
if cryptidyeohna then
    abovehand = "cry_WholeDeck"
else
    abovehand = "Flush Five"
end

local vanilla_jokers_as_enhanced = {"m_soe_j_joker", "m_soe_j_greedy_joker", "m_soe_j_lusty_joker", "m_soe_j_wrathful_joker", "m_soe_j_gluttenous_joker", "m_soe_j_jolly", "m_soe_j_zany", "m_soe_j_mad", "m_soe_j_crazy", "m_soe_j_droll", "m_soe_j_sly", "m_soe_j_wily", "m_soe_j_clever", "m_soe_j_devious", "m_soe_j_crafty", "m_soe_j_half", "m_soe_j_stencil", "m_soe_j_four_fingers", "m_soe_j_mime", "m_soe_j_credit_card", "m_soe_j_ceremonial", "m_soe_j_banner", "m_soe_j_mystic_summit", "m_soe_j_marble", "m_soe_j_loyalty_card", "m_soe_j_8_ball", "m_soe_j_misprint", "m_soe_j_dusk", "m_soe_j_raised_fist", "m_soe_j_chaos", "m_soe_j_fibonacci", "m_soe_j_steel_joker", "m_soe_j_scary_face", "m_soe_j_abstract", "m_soe_j_delayed_grat", "m_soe_j_hack", "m_soe_j_pareidolia", "m_soe_j_gros_michel", "m_soe_j_even_steven", "m_soe_j_odd_todd", "m_soe_j_scholar", "m_soe_j_business", "m_soe_j_supernova", "m_soe_j_ride_the_bus", "m_soe_j_space", "m_soe_j_egg", "m_soe_j_burglar", "m_soe_j_blackboard", "m_soe_j_runner", "m_soe_j_ice_cream", "m_soe_j_dna", "m_soe_j_splash", "m_soe_j_blue_joker", "m_soe_j_sixth_sense", "m_soe_j_constellation", "m_soe_j_hiker", "m_soe_j_faceless", "m_soe_j_green_joker", "m_soe_j_superposition", "m_soe_j_todo_list", "m_soe_j_cavendish", "m_soe_j_card_sharp", "m_soe_j_red_card", "m_soe_j_madness", "m_soe_j_square", "m_soe_j_seance", "m_soe_j_riff_raff", "m_soe_j_vampire", "m_soe_j_shortcut", "m_soe_j_hologram", "m_soe_j_vagabond", "m_soe_j_baron", "m_soe_j_cloud_9", "m_soe_j_rocket", "m_soe_j_obelisk", "m_soe_j_midas_mask", "m_soe_j_luchador", "m_soe_j_photograph", "m_soe_j_gift", "m_soe_j_turtle_bean", "m_soe_j_erosion", "m_soe_j_reserved_parking", "m_soe_j_mail", "m_soe_j_to_the_moon", "m_soe_j_hallucination", "m_soe_j_fortune_teller", "m_soe_j_juggler", "m_soe_j_drunkard", "m_soe_j_stone", "m_soe_j_golden", "m_soe_j_lucky_cat", "m_soe_j_baseball", "m_soe_j_bull", "m_soe_j_diet_cola", "m_soe_j_trading", "m_soe_j_flash", "m_soe_j_popcorn", "m_soe_j_trousers", "m_soe_j_ancient", "m_soe_j_ramen", "m_soe_j_walkie_talkie", "m_soe_j_selzer", "m_soe_j_castle", "m_soe_j_smiley", "m_soe_j_campfire", "m_soe_j_ticket", "m_soe_j_mr_bones", "m_soe_j_acrobat", "m_soe_j_sock_and_buskin", "m_soe_j_swashbuckler", "m_soe_j_troubadour", "m_soe_j_certificate", "m_soe_j_smeared", "m_soe_j_throwback", "m_soe_j_hanging_chad", "m_soe_j_rough_gem", "m_soe_j_bloodstone", "m_soe_j_arrowhead", "m_soe_j_onyx_agate", "m_soe_j_glass", "m_soe_j_ring_master", "m_soe_j_flower_pot", "m_soe_j_blueprint", "m_soe_j_wee", "m_soe_j_merry_andy", "m_soe_j_oops", "m_soe_j_idol", "m_soe_j_seeing_double", "m_soe_j_matador", "m_soe_j_hit_the_road", "m_soe_j_duo", "m_soe_j_trio", "m_soe_j_family", "m_soe_j_order", "m_soe_j_tribe", "m_soe_j_stuntman", "m_soe_j_invisible", "m_soe_j_brainstorm", "m_soe_j_satellite", "m_soe_j_shoot_the_moon", "m_soe_j_drivers_license", "m_soe_j_cartomancer", "m_soe_j_astronomer", "m_soe_j_burnt", "m_soe_j_bootstraps", "m_soe_j_caino", "m_soe_j_triboulet", "m_soe_j_yorick", "m_soe_j_chicot", "m_soe_j_perkeo"}
SMODS.PokerHand {
    key = "joker_central",
    name = "Joker Central",
    above_hand = abovehand,
    visible = false,
    chips = 250,
    mult = 250,
    l_chips = 25,
    l_mult = 10,
    example = {
        { "S_2", true, enhancement = "m_soe_j_joker" },
        { "S_2", true, enhancement = "m_soe_j_perkeo" },
        { "S_2", true, enhancement = "m_soe_j_joker" },
        { "S_2", true, enhancement = "m_soe_j_perkeo" },
        { "S_2", true, enhancement = "m_soe_j_perkeo" },
    },
    evaluate = function(parts)
    return parts.soe_jc_orig
    end,
  }
  
SMODS.PokerHandPart {
    key = 'jc_orig',
    func = function(hand)
        if #hand < 5 then return {} end
        local ret = {}
        local jokers = 0
        for i = 1, #hand do
            local v = hand[i].base.value
            if v then
                if table.contains(vanilla_jokers_as_enhanced, hand[i].config.center.key) and jokers < 5 then
                jokers = jokers + 1
                table.insert(ret, hand[i])
                end
            end
        end
        if jokers >= 5 and #ret >= 5 then
            return { ret }
        else
            return {}
        end
    end
}

SMODS.Consumable {
	set = "Planet",
	key = "demjoker",
	config = {hand_type = "soe_joker_central", softlock = true},
	pos = {x = 0, y = 0},
	atlas = "Planets",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("soe_hand_joker_central"),
				G.GAME.hands["soe_joker_central"].level,
				G.GAME.hands["soe_joker_central"].l_mult,
				G.GAME.hands["soe_joker_central"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["soe_joker_central"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.hands["soe_joker_central"].level)):to_number()]
					),
				},
			},
		}
	end,
}

function string.starts(string, start)
    return string.sub(string, 1, string.len(start)) == start
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
        if self.seal == 'Gold' and self.extraseals == nil and context.post_trigger and context.other_card == self then
            return {
                dollars = 3,
                message_card = self,
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
        if self.seal == 'soe_rainbowseal' then
            if self.ability.set == 'Joker' then
                if self.edition and context.individual and context.cardarea == G.hand then
                    if self.edition.key == 'e_holo' then
                        SMODS.calculate_effect({
                            mult = 10,
                            colour = G.C.DARK_EDITION,
                            card = self,
                        })
                    elseif self.edition.key == 'e_polychrome' then
                        SMODS.calculate_effect({
                            x_mult = 1.5,
                            colour = G.C.DARK_EDITION,
                            card = self,
                        })
                    elseif self.edition.key == 'e_foil' then
                        SMODS.calculate_effect({
                            chips = 50,
                            colour = G.C.DARK_EDITION,
                            card = self,
                        })
                    end
                end
            end
        end
        if self.seal == 'soe_reverseseal' then
            if context.joker_main and context.cardarea == G.jokers and self.facing == 'back' then
                SMODS.calculate_effect({
                    x_mult = 3,
                    colour = G.C.MULT,
                    card = self
                })
            end
        end
        if self.seal == 'soe_carmineseal' then
            if context.before then
                self.oymatearyescored = false
            end
            if context.post_trigger and context.other_card == self then
                self.oymatearyescored = true
            end
            if context.after and not self.oymatearyescored then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        self:start_dissolve()
                        return true
                    end,
                }))
            end
        end
        if self.seal == 'soe_limeseal' then
            if context.before then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.75,
                    func = function() --"borrowed" from Wheel Of Fortune
                        local found_index = 1
                        if self.edition then 	
                            for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
                                if v.key == self.edition.key then
                                    found_index = i
                                    break
                                end
                            end
                        end
                        found_index = found_index + 1
                        if found_index > #G.P_CENTER_POOLS.Edition then
                            found_index = found_index - #G.P_CENTER_POOLS.Edition
                        end
                        
                        local edition_apply = G.P_CENTER_POOLS.Edition[found_index].key
                        self:set_edition((edition_apply or "e_foil"), true)
                        
                        return true
                    end,
                }))
            end
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
                if context.before then
                    self.oymatearyescored = false
                end
                if context.post_trigger and context.other_card == self then
                    self.oymatearyescored = true
                end
                if not self.oymatearyescored and context.after then
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
        if next(SMODS.find_mod('RevosVault')) then
            if self.seal == 'crv_ps' then
                if context.post_trigger and context.other_card == self then
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.0,
                        func = function()
                            local card = copy_card(self, nil)
----                            if not SMODS.find_card('j_soe_sealjoker') and ((not G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal' and G.GAME.selected_sleeve == 'sleeve_soe_seal') and not self.extraseal) then
                                card:set_seal()
----                            end
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            card_eval_status_text(self, 'extra', nil, nil, nil, {message = 'Printed!'})
                            return true
                        end
                    }))
                end
            end
        end
        if next(SMODS.find_mod('aikoyorisshenanigans')) then
            if self.seal == 'akyrs_debuff' then
                self.debuff = true
            else
                self.debuff = false
            end
        end
        if next(SMODS.find_mod("familiar")) then
            if self.seal == "fam_maroon_seal" then
                if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == G.jokers.cards[1] then
                    return {
                        repetitions = 1,
                        card = G.jokers.cards[1]
                    }
                end
            end
            if self.seal == "fam_sapphire_seal" then
                if context.end_of_round and context.main_eval then
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        SMODS.add_card({set = 'Spectral', area = G.consumeables})
                        SMODS.calculate_effect({message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral, card = self}, self)
                    end
                end
            end
            if self.seal == "fam_gilded_seal" then
                if context.post_trigger and context.other_card == self then
                    if pseudorandom('gilded_seal') < G.GAME.probabilities.normal/4 then
                        SMODS.calculate_effect({dollars = -5, card = self}, self)
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 5
                        G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    else
                        SMODS.calculate_effect({dollars = 5, card = self}, self)
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 5
                        G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    end
                end
            end
            if self.seal == "fam_familiar_seal" then
                if context.selling_self and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    SMODS.add_card({set = 'Familiar_Tarots', area = G.consumeables})
                    SMODS.calculate_effect({message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot, card = self}, self)
                end
            end
        end
        if self.extraseals then
            if table.contains(self.extraseals, "Gold") and context.post_trigger and context.other_card == self then
                for i = 1, self.goldsealcount do
                    ease_dollars(3)
                    card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
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
        if self.seal == 'soe_reverseseal' then
            if context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) and self.facing == 'back' then
                return {
                    x_mult = 3,
                    colour = G.C.MULT,
                    card = self
                }
            end
        end
        if self.seal == 'soe_rainbowseal' then
        end
        if self.seal == 'soe_carmineseal' then
            if context.cardarea == 'unscored' and context.destroy_card and context.destroy_card == self then
                return {
                    remove = true,
                }
            end
        end
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
    if not (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then return nil end
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
    if G.jokers and G.jokers.cards and G.jokers.cards[1] and _seal then
        for k, joker in pairs(G.jokers.cards) do
            if joker.config.center.key == 'j_soe_infinity' then
                joker.ability.extra.EXmult = joker.ability.extra.EXmult + 1
            end
        end
    end
    if _seal then
        self[string.lower(_seal)..'sealcount'] = (self[string.lower(_seal)..'sealcount'] or 0) + 1
    end
    if #SMODS.find_card("j_soe_sealjoker") > 0 and _seal then
        if not self.seal then
            self:set_sealbutbetter('seal', _seal, silent, immediate)
        elseif not self.extraseal then
            self:set_sealbutbetter('extraseal', _seal, silent, immediate)
            self.extraseals = self.extraseals or {}
            self.extraseals['extraseal'] = _seal
            self.extrasealcount = (self.extrasealcount or 0) + 1
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
            print(self[string.lower(_seal)..'sealcount'])
        end
        return nil
    end
    if ((G.GAME.selected_sleeve == 'sleeve_soe_seal' and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and self.seal and not self.extraseal) and _seal then
        self:set_sealbutbetter('extraseal', _seal, silent, immediate)
        self.extraseals = self.extraseals or {}
        self.extraseals['extraseal'] = _seal
        self.extrasealcount = (self.extrasealcount or 0) + 1
        print(self[string.lower(_seal)..'sealcount'])
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
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
    end
    return oldopen(self)
end

local oldredeem = Card.redeem
function Card:redeem()
    if self.ability.set == 'Voucher' and self.seal then
        if self.seal == 'Gold' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
    end
    return oldredeem(self)
end

local smodsoldcalccontext = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    local g = smodsoldcalccontext(context, return_table)
    if context.individual and context.cardarea == G.play then
        print(context.other_card.legallysleeve)
        if context.other_card.legallysleeve == 'Plasma' then
            local tot = hand_chips + mult
            if not tot.array or #tot.array < 2 or tot.array[2] < 2 then --below eXeY notation
				hand_chips = mod_chips(math.floor(tot / 2))
				mult = mod_mult(math.floor(tot / 2))
			else
				if hand_chips > mult then
					tot = hand_chips
				else
					tot = mult
				end
				hand_chips = mod_chips(tot)
				mult = mod_chips(tot)
			end
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
    
            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('k_balanced')
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  4.3,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  6.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
        end
    end
    if context.individual and context.cardarea == G.hand then
        for k, v in pairs(context.scoring_hand) do
            if v.seal == 'soe_rainbowseal' then
                if pseudorandom('rainbowseal') < G.GAME.probabilities.normal / 4 then
                    if v.edition and v.edition.key == 'e_foil' then
                        return {
                            chips = 50,
                            colour = G.C.DARK_EDITION,
                            card = context.other_card,
                        }
                    end
                    if v.edition and v.edition.key == 'e_holo' then
                        return {
                            mult = 10,
                            colour = G.C.DARK_EDITION,
                            card = context.other_card,
                        }
                    end
                    if v.edition and v.edition.key == 'e_polychrome' then
                        return {
                            x_mult = 1.5,
                            colour = G.C.DARK_EDITION,
                            card = context.other_card,
                        }
                    end
                end
            end
        end
    end
    return g
end

local oldcalcjoker = Card.calculate_joker
function Card:calculate_joker(context)
    local g = oldcalcjoker(self, context)
    if context.end_of_round and context.cardarea == G.jokers then
        if self.ability.legallyenhanced == "Gold" then
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
        if self.ability.legallyenhanced == "Mult" then
            return {
                mult = 4,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyenhanced == "Bonus" then
            return {
                chips = 30,
                colour = G.C.CHIPS,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyenhanced == "Lucky" then
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
        if self.ability.legallyenhanced == "Steel" then
            return {
                xmult = 1.5,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyenhanced == "Glass" then
            return {
                xmult = 2,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
    end
    if context.after then
        if self.ability.legallyenhanced == "Glass" then
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
            if self.ability.legallyenhanced == "Mult" then
                return {
                    mult = 4,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallyenhanced == "Bonus" then
                return {
                    chips = 30,
                    colour = G.C.CHIPS,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallyenhanced == "Lucky" then
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
            if self.ability.legallyenhanced == "Steel" then
                return {
                    xmult = 1.5,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallyenhanced == "Glass" then
                return {
                    xmult = 2,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
        end
    end
    if self.ability and (self.ability.set == 'Tarot' or self.ability.set == 'Spectral' or self.ability.set == 'Voucher' or self.ability.set == 'Planet') and self.seal then
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
    if (context.joker_main and context.cardarea == G.jokers and self.ability.legallyplasmasleeve) or (context.individual and context.cardarea == G.play and context.other_card.ability.legallyplasmasleeve) then
        local tot = hand_chips + mult
        if not tot.array or #tot.array < 2 or tot.array[2] < 2 then --below eXeY notation
            hand_chips = mod_chips(math.floor(tot / 2))
            mult = mod_mult(math.floor(tot / 2))
        else
            if hand_chips > mult then
                tot = hand_chips
            else
                tot = mult
            end
            hand_chips = mod_chips(tot)
            mult = mod_chips(tot)
        end
        update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})

        G.E_MANAGER:add_event(Event({
            func = (function()
                local text = localize('k_balanced')
                play_sound('gong', 0.94, 0.3)
                play_sound('gong', 0.94*1.5, 0.2)
                play_sound('tarot1', 1.5)
                ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                attention_text({
                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    delay =  4.3,
                    func = (function() 
                            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                            ease_colour(G.C.UI_MULT, G.C.RED, 2)
                        return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    no_delete = true,
                    delay =  6.3,
                    func = (function() 
                        G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                        G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                        return true
                    end)
                }))
                return true
            end)
        }))
    end
    return g
end

SMODS.Joker{
    name = 'StoneCardJoker',
    key = 'stonecardjoker',
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

--[[
SMODS.Joker{
    name = 'Seeder',
    key = 'seeder',
    atlas = 'Placeholders',
    pos = {x = 2, y = 0},
    rarity = 3,
    cost = 15,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            seed = "2K9H9HN",
            runnable = true
        }
    },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.seed}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
            if not card.ability.extra.runnable then
                card.ability.extra.runnable = true
                return {
                    message = localize('k_reset'),
                }
            end
        end
        if context.using_consumeable and card.ability.extra.runnable then
            G.ENTERED_SEED = ""
            G.E_MANAGER:add_event(Event({
				blockable = false,
				func = function()
					G.REFRESH_ALERTS = true
					return true
				end,
			}))
			G.UIBOXGENERICOPTIONSREALLYSEED = create_UIBox_generic_options({
				no_back = true,
				colour = HEX("04200c"),
				outline_colour = G.C.SECONDARY_SET.Code,
				contents = {
					{
						n = G.UIT.R,
						nodes = {
							create_text_input({
								colour = G.C.SET.Code,
								hooked_colour = darken(copy_table(G.C.SET.Code), 0.3),
								w = 4.5,
								h = 1,
								max_length = 8,
								extended_corpus = true,
								prompt_text = "ENTER A SEED",
								ref_table = G,
								ref_value = "ENTERED_SEED",
								keyboard_offset = 1,
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = G.C.SET.Code,
								button = "seed_apply",
								label = {"SEED"},
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
				},
			})
            G.UIBOXFORSEED = UIBox({
                definition = G.UIBOXGENERICOPTIONSREALLYSEED,
                config = {
                    align = "cm",
                    offset = { x = 0, y = 10 },
                    major = G.ROOM_ATTACH,
                    bond = "Weak",
                    instance_type = "POPUP",
                },
            })
            G.UIBOXFORSEED.alignment.offset.y = 0
            G.ROOM.jiggle = G.ROOM.jiggle + 1
            G.UIBOXFORSEED:align_to_major()
            G.FUNCS.seed_apply = function()
                G.ENTERED_SEED = string.upper(G.ENTERED_SEED) or "r"
                card.ability.extra.runnable = false
                card.ability.extra.seed = G.ENTERED_SEED
                G.GAME.pseudorandom.seed = G.ENTERED_SEED
                G.GAME.pseudorandom.hashed_seed = pseudohash(G.GAME.pseudorandom.seed)
                G.UIBOXFORSEED:remove()
            end
        end
    end,
    in_pool = function(self)
        return false
    end
}
]]

--[[
if Bakery_API and Bakery_API.Charm then
    Bakery_API.Charm {
        key = 'sealcharm',
        atlas = 'Charms',
        pos = {x = 0, y = 0},
        config = {},
        loc_vars = function(self, info_queue, card) end,
        calculate = function(self, card, context) end, -- Works just like a Joker
        check_for_unlock = function(self, args) end,
        equip = function(self, card) 
            G.GAME.red_seal_number = 2
            G.GAME.gold_seal_dollar = 6
        end, -- Called when the charm is purchased
        unequip = function(self, card)
            G.GAME.red_seal_number = 1
            G.GAME.gold_seal_dollar = 3
        end, -- Called when a new charm is purchased that replaces this one
    }
end
]]

SMODS.Joker{
    name = 'JupiterJoker',
    key = 'jupiterjoker',
    atlas = 'Tarots',
    pos = {x = 4, y = 3},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Flush" then
            return {
                level_up = 1,
                card = card,
                message = localize('k_level_up_ex'),
            }
        end
    end,
}

SMODS.Joker{
    name = 'TalismanJoker',
    key = 'talismanjoker',
    atlas = 'Tarots',
    pos = {x = 3, y = 4},
    rarity = 3,
    cost = 10,
    boostershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        local free = false
        if context.before then
            for k, v in pairs(context.scoring_hand) do
                if IsEligibleForSeal(v) then
                    free = true
                    break
                end
            end
            if not free then
                return {
                    message = localize('k_nope_ex'),
                    card = card,
                }
            end
            local randomcard = {}
            while not IsEligibleForSeal(randomcard) do
                randomcard = pseudorandom_element(context.scoring_hand, pseudoseed('talisman'))
            end
            if randomcard then
                return {
                    message = 'Talisman!',
                    card = card,
                    randomcard:set_seal('Gold')
                }
            end
        end
    end,
}

SMODS.Joker{
    name = 'TheSoulJoker',
    key = 'thesouljoker',
    atlas = 'Tarots',
    pos = {x = 2, y = 2},
    rarity = 3,
    cost = 10,
    boostershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before then
            return {
                message = localize('k_nope_ex'),
                card = card,
            }
        end
    end,
}

SMODS.DrawStep{
    key = 'thesoulpos',
    order = 20,
    func = function(self)
        if self.config.center.key == 'thesouljoker' then
            local scale_mod = 0.05 + 0.05*math.sin(1.8*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
            
            local sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["soe_Enhancers"], {x = 0, y = 1})
            sprite.role.draw_major = self
            sprite:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
            sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
        end
    end
}

SMODS.Joker{
    name = 'BlankJoker',
    key = 'blankjoker',
    atlas = 'Vouchers',
    pos = {x = 7, y = 0},
    rarity = 3,
    cost = 10,
    vouchershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            roundsleft = 20
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.ability.extra.roundsleft}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra.roundsleft = card.ability.extra.roundsleft - 1
            if card.ability.extra.roundsleft <= 0 then
                card:set_ability(G.P_CENTERS.j_soe_antimatterjoker)
            else
                return {
                    message = 'Doing nothing...',
                    sound = 'holo1'
                }
            end
        end
    end,
}

SMODS.Joker{
    name = 'AntimatterJoker',
    key = 'antimatterjoker',
    atlas = 'Vouchers',
    pos = {x = 7, y = 1},
    rarity = 4,
    cost = 10,
    negativeshader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            weightmult = 305,
            xmult = 1.2
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if (context.other_joker and context.other_joker.edition and context.other_joker.edition.key == 'e_negative') or (context.other_consumeable and context.other_consumeable.edition and context.other_consumeable.edition.key == 'e_negative') or (context.individual and context.other_card.edition and context.other_card.edition.key == 'e_negative' and not context.end_of_round) then
            return {
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT,
                message = 'Negative!!',
                card = card,
            }
        end
    end,
}

local oldenegativegetweight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership('e_negative', {
    get_weight = function(self)
        local weight = oldenegativegetweight(self)
        if #SMODS.find_card('j_soe_antimatterjoker') > 0 then
            weight = weight * G.P_CENTERS.j_soe_antimatterjoker.config.extra.weightmult * #SMODS.find_card('j_soe_antimatterjoker')
        end
        return weight
    end
}, true)

SMODS.DrawStep{
    key = 'boostershader',
    order = 20,
    func = function(self)
        if self.config.center.boostershader then
            self.children.center:draw_shader('booster',nil, self.ARGS.send_to_shader)
        end
    end
}

SMODS.DrawStep{
    key = 'vouchershader',
    order = 20,
    func = function(self)
        if self.config.center.vouchershader then
            self.children.center:draw_shader('voucher',nil, self.ARGS.send_to_shader)
        end
    end
}

local unorganizedrarity
if cryptidyeohna then
    unorganizedxmult = 2.2
    unorganizedrarity = 'cry_epic'
else
    unorganizedrarity = 3
    unorganizedxmult = 1.5
end

SMODS.Joker{
    name = 'UnorganizedJoker',
    key = 'unorganizedjoker',
    atlas = 'Placeholders',
    pos = {x = 3, y = 0},
    rarity = unorganizedrarity,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = unorganizedxmult
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if (context.other_joker and (context.other_joker.seal or context.other_joker.ability.legal)) or (context.other_consumeable and context.other_consumeable.seal) then
            return {
                x_mult = card.ability.extra.xmult,
                colour = G.C.MULT,
                card = context.other_joker or context.other_consumeable
            }
        end
        if context.individual then
            for k, v in pairs(SMODS.Stickers) do
                if context.other_card.ability[v] then
                    return {
                        x_mult = card.ability.extra.xmult,
                        colour = G.C.MULT,
                        card = context.other_card
                    }
                end
            end
            if context.other_card.ability.eternal or context.other_card.ability.perishable or context.other_card.ability.rental then
                return {
                    x_mult = card.ability.extra.xmult,
                    colour = G.C.MULT,
                    card = context.other_card
                }
            end
        end
    end,
}

SMODS.Joker{
    name = 'KingofHeartsCardJoker',
    key = 'kingofheartscardjoker',
    atlas = 'PlayingCards',
    pos = {x = 11, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    add_to_deck = function (self, card, from_debuff)
        card.base = {
            nominal = 10,
            suit_nominal = 0,
            face_nominal = 0,
            value = 'King',
            id = 13,
            suit = 'Hearts',
            times_played = 0
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.base.nominal
            }
        end
    end,
    in_pool = function(self)
        return true
    end
}

SMODS.Joker:take_ownership('j_triboulet',
    {
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and ((context.other_card:get_id() == 12 or context.other_card:get_id() == 13) or next(find_joker("GodJoker"))) and not context.end_of_round then
                return {
                    x_mult = card.ability.extra,
                    colour = G.C.RED,
                    card = card
                }
            end
            if context.other_joker and context.other_joker.base and (context.other_joker:get_id() == 12 or context.other_joker:get_id() == 13) then
                return {
                    x_mult = card.ability.extra,
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    },
    true
)

SMODS.Joker{
    name = 'ExtraLife',
    key = 'extralife',
    atlas = 'ExtraLife',
    pos = {x = 0, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    config = {
        lives = 1
    },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.lives}}
    end,
    calculate = function(self, card, context)
        if context.game_over then
            card.ability.lives = card.ability.lives - 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    if card.ability.lives < 1 then
                        card:start_dissolve()
                    end
                    return true
                end
            })) 
            return {
                message = localize('k_saved_ex'),
                saved = true,
                colour = G.C.RED
            }
        end
    end,
    in_pool = function(self)
        return false
    end,
    add_to_deck = function (self, card, from_debuff)
        if #SMODS.find_card('j_soe_extralife') > 0 then
            for k, v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_soe_extralife' then
                    v.ability.lives = (v.ability.lives or 0) + 1
                    break
                end
            end
            card:start_dissolve()
        end
        if cryptidyeohna then
            card.ability.cry_absolute = true
        else
            card.ability.eternal = true
        end
    end
}

local exoticrarity
if cryptidyeohna then
    exoticrarity = 'cry_exotic'
else
    exoticrarity = 'soe_infinity'
end

SMODS.Joker{
    name = 'SealJoker',
    key = 'sealjoker',
    atlas = 'Exotics',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = exoticrarity,
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
}

local sealoverlords = SMODS.Gradient{
        key = 'seal_gradient',
        colours = {
            HEX('E8463D'),
            HEX('009CFD'),
            HEX('A267E4'),
            HEX('F7AF38'),
        }
}

SMODS.Rarity{
    key = 'infinity',
    badge_colour = sealoverlords,
}

SMODS.Consumable{
    key = 'infinityfuser',
    name = 'InfinityFuser',
    atlas = 'Placeholders',
    set = 'Spectral',
    pos = {x = 2, y = 2},
    can_use = function (self, card) 
        local g = {}
        if (#SMODS.find_card("j_soe_infinityred") > 0 and #SMODS.find_card("j_soe_infinitygold") > 0 and #SMODS.find_card("j_soe_infinityblue") > 0 and #SMODS.find_card("j_soe_infinitypurple") > 0) and #G.jokers.highlighted == 4 then
            for k, v in pairs(G.jokers.highlighted) do
                if v.config.center.key == 'j_soe_infinityred' or v.config.center.key == 'j_soe_infinitygold' or v.config.center.key == 'j_soe_infinityblue' or v.config.center.key == 'j_soe_infinitypurple' then
                    table.insert(g, v)
                else
                    return false
                end
            end
            return true
        else
            return false
        end
    end,
    use = function (self, card, area, copier)
        for k, v in pairs(G.jokers.highlighted) do
            v:start_dissolve()
        end
        play_sound('explosion_release1')
        SMODS.add_card({set = 'Joker', area = G.jokers, key = 'j_soe_infinity'})
    end
}

local infinityrarity
if next(SMODS.find_mod('jen')) then
    infinityrarity = 'jen_omegatranscendent'
else
    infinityrarity = 'soe_infinity'
end

SMODS.Joker{
    name = 'Infinity',
    key = 'infinity',
    atlas = 'Placeholders',
    pos = {x = 0, y = 1},
    soul_pos = {x = 5, y = 0,},
    rarity = infinityrarity,
    cost = 2147483647,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
    end,
    update = function (self, card, dt)
    end
}

SMODS.Joker{
    name = 'InfinityRed',
    key = 'infinityred',
    atlas = 'InfinitySeals',
    pos = {x = 0, y = 0},
    soul_pos = {x = 4, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
		if context.post_trigger and context.other_card.config.center.rarity ~= 'soe_infinity' then
            context.other_card:set_seal('Red', true, true)
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                card = card,
                message_card = card
            }
		end
        if context.individual and context.cardarea == G.play then
            context.other_card:set_seal('Red')
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                card = card,
                message_card = card
            }
        end
    end

}

SMODS.Joker{
    name = 'InfinityPurple',
    key = 'infinitypurple',
    atlas = 'InfinitySeals',
    pos = {x = 1, y = 0},
    soul_pos = {x = 5, y = 0,},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
}

SMODS.Joker{
    name = 'InfinityGold',
    key = 'infinitygold',
    atlas = 'InfinitySeals',
    pos = {x = 2, y = 0},
    soul_pos = {x = 6, y = 0,
    draw = function(card, scale_mod, rotate_mod)
        card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end
},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.individual then
            return {
                dollar_message = 'Gold!!!',
                message = 'Gold!!!',
                dollars = 3,
                colour = G.C.GOLD,
                card = card,
                message_card = card
            }
        end
        if context.post_trigger and context.other_card.config.center.rarity ~= 'soe_infinity' then
            return {
                dollar_message = 'Gold!!!',
                message = 'Gold!!!',
                dollars = 3,
                card = card,
                message_card = card,
                colour = G.C.GOLD
            }
        end
    end
}

SMODS.Joker{
    name = 'InfinityBlue',
    key = 'infinityblue',
    atlas = 'InfinitySeals',
    pos = {x = 3, y = 0},
    soul_pos = {x = 7, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
}

if cryptidyeohna then
    local oldadvanced = Cryptid.advanced_find_joker
    function Cryptid.advanced_find_joker(name, rarity, edition, ability, non_debuff, area)
        local e = oldadvanced(name, rarity, edition, ability, non_debuff, area)
        if (name == nil and rarity == "cry_exotic" and edition ==  nil and ability == nil and non_debuff == true) and #oldadvanced(nil, 'soe_infinity', nil, nil, true) > 0 then
            table.insert(e, "e")
        end
        return e
    end
end

SMODS.Seal{
    key = 'sealseal',
    name = 'SealSeal',
    badge_colour = HEX('E8463D'),
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {omult = 5},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.omult}}
    end,
    calculate = function(self, card, context)
        if card.extraseal and context.before then
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

SMODS.Seal{
    key = 'rainbowseal',
    name = 'RainbowSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    draw = function(self, card, layer)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('polychrome', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

SMODS.Seal{
    key = 'reverseseal',
    name = 'ReverseSeal',
    badge_colour = G.C.UI.TEXT_DARK,
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {extra = {downxmult = 3}},
    loc_vars = function (self, info_queue, card)
        return {vars = {self.config.extra.downxmult}}
    end
}

SMODS.Seal{
    key = 'negativeseal',
    name = 'NegativeSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = { x = 6, y = 4 },
    draw = function(self, card, layer)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('negative', nil, card.ARGS.send_to_shader, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('negative_shine', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

SMODS.Seal{
    key = 'carmineseal',
    name = 'CarmineSeal',
    badge_colour = HEX('FF0040'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
}

SMODS.Seal{
    key = 'aquaseal',
    name = 'AquaSeal',
    badge_colour = HEX('00FFFF'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
}

SMODS.Seal{
    key = 'limeseal',
    name = 'LimeSeal',
    badge_colour = HEX('00FFFF'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    loc_txt = {
        name = 'Lime Seal',
        text = {
            'Upgrade edition',
        }
    }
}

local oldhighlight = Card.highlight
function Card:highlight(highlighted)
    local g = oldhighlight(self, highlighted)
    if self.seal == "soe_negativeseal" then
        if not highlighted and self.config.negative_enabled then
            self.config.negative_enabled = false
            G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1 
        end
    end
    return g
end

local oldaddhighlighted = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if card.seal == "soe_negativeseal" and not card.config.negative_enabled then
        card.config.negative_enabled = true
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 1 
    end
    return oldaddhighlighted(self, card, silent)
end

local ancientupdate = EventManager.update

function EventManager:update(dt, forced)
    if G.STATE == G.STATES.SELECTING_HAND then
        if G.GAME and G.GAME.blind and G.GAME.blind.seal and G.GAME.blind.debuff.akyrs_all_seals_perma_debuff and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
        end
        if G.GAME and G.GAME.blind and G.GAME.blind.permasealdebuffha and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
        end
    end
    return ancientupdate(self, dt, forced)
end

SMODS.Back{
    key = 'seal',
    name = 'AllSealsDeck',
    atlas = 'Enhancers',
    pos = {x = 5, y = 2},
}

if CardSleeves then
    CardSleeves.Sleeve {
        key = "seal",
        atlas = "Sleeves",
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key
            if self.get_current_deck_key() == "b_soe_seal" then
                key = self.key .. "_extra"
            end
            return {key = key}
        end,
    }
    CardSleeves.Sleeve {
        key = "redseal",
        atlas = "DeckSeals",
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key
            local deckkey = self.get_current_deck_key()
            key = self.key
            self.config = G.P_CENTERS[deckkey].config
            local tempstring = ""
            for k, v in pairs(G.localization.descriptions.Back[deckkey].text) do
                tempstring = tempstring .. v
            end
            return {vars = {tempstring}, key = key}
        end,
    }
    CardSleeves.Sleeve {
        key = "goldseal",
        atlas = "DeckSeals",
        pos = { x = 3, y = 0 },
        calculate = function(self, sleeve, context)
            if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
                return {
                    dollars = 3,
                    colour = G.C.MONEY,
                    card = context.other_card,
                    message_card = context.other_card,  
                }
            end
        end
    }
end

--[[
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
]]

--[[
SMODS.Achievement{
    key = 'completionist_plus_plus_plus',
    unlock_condition = function(self, args)
        return G.PROGRESS.card_stickers.tally/G.PROGRESS.card_stickers.of >= 1 
    end
}

local oldsetprofileprog = set_profile_progress
function set_profile_progress()
    local g = oldsetprofileprog()
    G.PROGRESS.card_stickers = {tally = 0, of = 0}
    for _, v in pairs(G.P_CARDS) do
        G.PROGRESS.card_stickers.of = G.PROGRESS.card_stickers.of + #G.P_CENTER_POOLS.Stake
        G.PROGRESS.card_stickers.tally = G.PROGRESS.card_stickers.tally + get_card_win_sticker(v, true, true)
    end
    return g
end
]]

function get_card_win_sticker(_card, index, proprog)
    local suit, rank
    if proprog then
        suit = _card.suit
        if _card.value == 'King' then
            rank = 13
        elseif _card.value == 'Queen' then
            rank = 12
        elseif _card.value == 'Jack' then
            rank = 11
        else
            rank = tonumber(_card.value)
        end
    else
        suit = _card.base.suit
        rank = _card.base.id
    end

    G.PROFILES[G.SETTINGS.profile].card_stickers = G.PROFILES[G.SETTINGS.profile].card_stickers or {}
	local card_usage = G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(rank)..tostring(suit)] or {}
	if card_usage.wins then
		local applied = {}
		local _count = 0
		local _stake = nil
		for k, v in pairs(card_usage.wins_by_key) do
			SMODS.build_stake_chain(G.P_STAKES[k], applied)
		end
		for i, v in ipairs(G.P_CENTER_POOLS.Stake) do
			if applied[v.order] then
				_count = _count+1
				if (v.stake_level or 0) > (_stake and G.P_STAKES[_stake].stake_level or 0) then
					_stake = v.key
				end
			end
		end
		if index then return _count end
		if _count > 0 then return G.sticker_map[_stake] end
	end
	if index then return 0 end
end

--[[
oldcheckforunlock = check_for_unlock
function check_for_unlock(args)
    if args.type == 'win_stake' then 
        G.PROGRESS.card_stickers = G.PROGRESS.card_stickers or {tally = 0, of = 0}
        if G.PROGRESS.card_stickers.tally/G.PROGRESS.card_stickers.of >= 1 then
            unlock_achievement('completionist_plus_plus_plus')
        end
    end
    return oldcheckforunlock(args)
end
]]

local oldupdate = Card.update
function Card:update(dt)
    if (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal') or (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_soe_seal') then
        local seals = {}
        for k, v in pairs(G.P_SEALS) do
            table.insert(seals, k)
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
    if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and not self.sticker_run then 
        self.sticker_run = get_card_win_sticker(self) or 'NONE'
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

to_big = to_big or function(x) return x end

SMODS.Joker:take_ownership('j_mr_bones',
    {
        calculate = function(self, card, context)
            if context.game_over and G.GAME.chips/G.GAME.blind.chips >= to_big(0.25) and not context.retrigger_joker then
                local g
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        if card.seal == 'Red' then
                            g = 'Extra Life!'
                            local f = SMODS.add_card({set = 'Joker', area = G.jokers, key = 'j_soe_extralife', edition = 'e_negative'})
                            f.ability.lives = 0
                        end
                        return true
                    end
                }))
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED,
                    extra = {
                        message = g,
                        colour = G.C.RED
                    }
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

--[[
local secondsealsprite 
SMODS.DrawStep{
    key = 'secondsealsforall',
    order = 11,
    func = function(self, card)
        if self.extraseal == 'Red' and not (#SMODS.find_card("j_soe_sealjoker") > 0) then
            secondsealsprite = secondsealsprite or Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['soe_SecondSeals'], { x = 5, y = 4 })
            secondsealsprite.role.draw_major = self
            secondsealsprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

local bonussprite, multsprite, wildsprite
SMODS.DrawStep{
    key = 'threeenhancementsforjokers',
    order = 10,
    func = function(self, card)
        if self.ability.legallyenhanced == 'Bonus' then
            bonussprite = bonussprite or Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['soe_Enhancers'], { x = 1, y = 1})
            bonussprite.role.draw_major = self
            bonussprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
        if self.ability.legallyenhanced == 'Mult' then
            local sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['soe_Enhancers'], { x = 2, y = 1})
            sprite.role.draw_major = self
            sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
        if self.ability.legallyenhanced == 'Wild' then
            local sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['soe_Enhancers'], { x = 3, y = 1})
            sprite.role.draw_major = self
            sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}
]]

function table.contains(table, element)
    if table and type(table) == "table" then
        for _, value in pairs(table) do
            if value == element then
                return true
            end
        end
        return false
    end
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

SMODS.DrawStep{
    key = 'stickersforplayingcards',
    order = 13,
    func = function(self, card)
        if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and G.playing_cards and self.facing == 'front' then
            if self.sticker and G.shared_stickers[self.sticker] then
                G.shared_stickers[self.sticker].role.draw_major = self
                G.shared_stickers[self.sticker]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                G.shared_stickers[self.sticker]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
            elseif (self.sticker_run and G.shared_stickers[self.sticker_run]) and G.SETTINGS.run_stake_stickers then
                G.shared_stickers[self.sticker_run].role.draw_major = self
                G.shared_stickers[self.sticker_run]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                G.shared_stickers[self.sticker_run]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
            end
        end
    end
}

SMODS.DrawStep{
    key = 'reversesealonback',
    order = 14,
    func = function(self, card)
        if self.seal == 'soe_reverseseal' and self.facing == 'back' then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
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
            if not joker.ability.legallyenhanced then
                print('Highlighted joker is not enhanced')
            end
            if joker.ability.legallyenhanced == "Gold" then
                print('Highlighted joker is enhanced with gold')
            end
            if joker.ability.legallyenhanced == "Steel" then
                print('Highlighted joker is enhanced with steel')
            end
            if joker.ability.legallyenhanced == "Mult" then
                print('Highlighted joker is enhanced with mult')
            end
            if joker.ability.legallyenhanced == "Bonus" then
                print('Highlighted joker is enhanced with bonus')
            end
            if joker.ability.legallyenhanced == "Lucky" then
                print('Highlighted joker is enhanced with lucky')
            end
            if joker.ability.legallyenhanced == "Glass" then
                print('Highlighted joker is enhanced with glass')
            end
            if joker.ability.name == 'StoneCardJoker' then
                print('You cannot be serious right now, but this is a stone')
            end
        end
    end
}