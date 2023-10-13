local Translations = {
    error = {
        not_enough = "Você não possui dinheiro suficiente..",
        no_slots = "Não há mais slots disponíveis",
        occured = "Ocorreu um erro",
        have_keys = "Essa pessoa já possui as chaves",
        p_have_keys = "%{value} Essa pessoa já possui as chaves",
        not_owner = "Você não é o dono de um ponto de venda ou não é o proprietário",
        not_online = "Essa pessoa não está na cidade",
        no_money = "Não há dinheiro no armário",
        incorrect_code = "Este código está incorreto",
        up_to_6 = "Você pode dar acesso a até 6 pessoas ao ponto de venda!",
        cancelled = "Aquisições canceladas",
    },
    success = {
        added = "%{value} foi adicionado ao ponto de venda!",
    },
    info = {
        enter = "Entrar no ponto de venda",
        give_keys = "Dar chaves do ponto de venda",
        pincode = "Código PIN do ponto de venda: %{value}",
        taking_over = "Assumindo o controle",
        pin_code_see = "~b~G~w~ - Ver código PIN",
        pin_code = "Código PIN: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - Para dar chaves",
        take_cash = "~b~E~w~ - Pegar dinheiro (~g~$%{value}~w~)",
        inventory = "~b~H~w~ - Ver inventário",
        take_over = "~b~E~w~ - Assumir o controle (~g~$5000~w~)",
        leave = "~b~E~w~ - Sair do ponto de venda",
    },
    targetInfo = {
        options = "Opções do ponto de venda",
        enter = "Entrar no ponto de venda",
        give_keys = "Dar chaves do ponto de venda",
        pincode = "Código PIN do ponto de venda: %{value}",
        taking_over = "Assumindo o controle",
        pin_code_see = "Ver código PIN",
        pin_code = "Código PIN: %{value}",
        multikeys = "Dar chaves (use /multikey [id])",
        take_cash = "Pegar dinheiro ($%{value})",
        inventory = "Ver inventário",
        take_over = "Assumir o controle ($5000)",
        leave = "Sair do ponto de venda",
        close_menu = "⬅ Fechar Menu",
    }
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
