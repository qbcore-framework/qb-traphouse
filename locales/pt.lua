local Translations = {
    error = {
        not_enough = "Não tens dinheiro suficiente..",
        no_slots = "Não existem Slots disponíveis",
        occured = "Ocorreu Um Erro",
        have_keys = "Esta Pessoa Já Tem As Chaves",
        p_have_keys = "%{value} Esta Pessoa Já Tem As Chaves",
        not_owner = "Tu Não Possuis Uma Traphouse Ou Tu Não És O Dono",
        not_online = "Esta Pessoa Não Está Na cidade
    ",
        no_money = "Há Dinheiro Pendente No Armário",
        incorrect_code = "Este Código Está Incorreto",
        up_to_6 = "Podes Dar Acesso Da Traphouse A 6 Pessoas!",
        cancelled = "Aquisições Canceladas",
    },
    success = {
        added = "%{value} Foi Adicionado(a) à Traphouse!",
    },
    info = {
        enter = "Entrar Na Traphouse",
        give_keys = "Dar Chaves Da Traphouse",
        pincode = "Código Pin Da Traphouse: %{value}",
        taking_over = "Assumir o Controlo",
        pin_code_see = "~b~G~w~ - Ver Código Pin",
        pin_code = "Código Pin: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - Para Dar As Chaves",
        take_cash = "~b~E~w~ - Recolher Dinheiro (~g~%{value}€~w~)",
        inventory = "~b~H~w~ - Ver Inventário",
        take_over = "~b~E~w~ - Assumir (~g~5000€~w~)",
        leave = "~b~E~w~ - Sair",
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })    
end
